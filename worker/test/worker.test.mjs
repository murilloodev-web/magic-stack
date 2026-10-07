// Run with:  lua build.lua && node --test worker/test/
// Uses the real docs/forms.json produced by the build, and a fake fetch for
// Turnstile, forms.json and the GitHub API.

import { test, beforeEach } from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import worker, { _resetCache, luaDraft, validate } from "../src/index.js";

const FORMS = JSON.parse(readFileSync(fileURLToPath(new URL("../../docs/forms.json", import.meta.url)), "utf8"));
FORMS.books["mist-over-the-funicular"].open = true;

const ORIGIN = "https://murilloodev-web.github.io";
const env = {
  ALLOWED_ORIGINS: ORIGIN,
  FORMS_URL: "https://forms.test/forms.json",
  SITE_URL: "https://murilloodev-web.github.io/magic-stack/",
  GITHUB_REPO: "murilloodev-web/magic-stack-contribuicoes",
  GITHUB_TOKEN: "test-token",
  TURNSTILE_SECRET: "test-secret",
};

let calls, turnstileOk;
beforeEach(() => {
  calls = []; turnstileOk = true; _resetCache();
  globalThis.fetch = async (url, init = {}) => {
    calls.push({ url: String(url), init });
    if (String(url).includes("turnstile")) return Response.json({ success: turnstileOk });
    if (String(url) === env.FORMS_URL) return Response.json(FORMS);
    if (String(url).includes("api.github.com")) return Response.json({ number: 42 }, { status: 201 });
    throw new Error("unexpected fetch " + url);
  };
});

function sub(over = {}) {
  return {
    book: "mist-over-the-funicular", page: "ending-sea", segment: "", template: "ending", lang: "pt",
    fields: {
      name: "The Long Tide", relation: "variant", summary: "The sea takes the Seed, and the village with it.",
      trigger: "Carry the Seed to Santos before the festival ends.", climax: "Waves climb the Serra.\nThe mist sings.",
      cost: "1D10 SAN; Contact +2", aftermath: "Paranapiacaba is a ghost town by 1975. Ask @someone #12",
    },
    contributor: { name: "Ana Souza", email: "Ana@Example.com", credit_mode: "pseudonym", credit_name: "Maré" },
    consent: { terms_version: FORMS.site.terms_version, terms: true, original: true, adult: true, future: true, data: true },
    turnstile: "tok", website: "",
    ...over,
  };
}

const post = (body, origin = ORIGIN) =>
  worker.fetch(new Request("https://w.test/submit", {
    method: "POST", headers: { origin, "content-type": "application/json" }, body: JSON.stringify(body),
  }), env);

test("a valid submission opens one issue and returns its number", async () => {
  const res = await post(sub());
  const out = await res.json();
  assert.equal(res.status, 200);
  assert.deepEqual(out, { ok: true, ref: "42" });
  const gh = calls.find((c) => c.url.includes("api.github.com"));
  assert.equal(gh.url, "https://api.github.com/repos/murilloodev-web/magic-stack-contribuicoes/issues");
  assert.equal(gh.init.headers.authorization, "Bearer test-token");
  const issue = JSON.parse(gh.init.body);
  assert.match(issue.title, /^\[A Névoa sobre o Funicular\] Final A — De Volta ao Mar — Final: uma variação ou um novo: The Long Tide/);
  assert.match(issue.body, /mist-over-the-funicular\/pt\/endings\.html#ending-sea/);
  assert.deepEqual(issue.labels, ["contribuição", "aguardando-revisão", "livro:mist-over-the-funicular", "tipo:ending"]);
  assert.match(issue.body, /Pseudônimo: \*\*Maré\*\*/);
  assert.match(issue.body, /ana@example\.com/);               // email normalised
  assert.match(issue.body, /@​someone/);                  // mentions neutralised
  assert.match(issue.body, /#​12/);                       // issue refs neutralised
  assert.match(issue.body, /```lua\n-- new entry for data\/pages\.lua; add its id to chapter "endings"/);
  assert.match(issue.body, /id = "the-long-tide", kind = "fiction"/);
  assert.match(issue.body, /Termo de Contribuição \*\*v1\.0\*\*/);
  assert.match(issue.body, /<!-- magic-stack-submission \{.*"accepted_at"/);
});

test("rejects other origins, failed captcha, honeypot and bad consent", async () => {
  assert.equal((await post(sub(), "https://evil.test")).status, 403);
  turnstileOk = false;
  assert.equal((await post(sub())).status, 403);
  turnstileOk = true;
  const hp = await post(sub({ website: "spam" }));
  assert.deepEqual(await hp.json(), { ok: true, ref: "0" });
  assert.ok(!calls.some((c) => c.url.includes("api.github.com")), "honeypot must not open an issue");
  const noConsent = await post(sub({ consent: { ...sub().consent, future: false } }));
  assert.equal(noConsent.status, 400);
  const oldTerms = await post(sub({ consent: { ...sub().consent, terms_version: "0.9" } }));
  assert.equal(oldTerms.status, 400);
});

test("validates fields against the template", async () => {
  const missing = await post(sub({ fields: { ...sub().fields, climax: "  " } }));
  assert.equal(missing.status, 400);
  assert.equal((await missing.json()).field, "climax");
  const badOpt = await post(sub({ fields: { ...sub().fields, relation: "nope" } }));
  assert.equal((await badOpt.json()).field, "relation");
  const long = await post(sub({ fields: { ...sub().fields, name: "x".repeat(81) } }));
  assert.equal((await long.json()).field, "name");
  const wrongTpl = await post(sub({ template: "npc" }));     // endings only take "ending"
  assert.equal(wrongTpl.status, 400);
  const badSeg = await post(sub({ segment: "nope" }));
  assert.equal(badSeg.status, 400);
  const pseudo = await post(sub({ contributor: { ...sub().contributor, credit_name: "" } }));
  assert.equal((await pseudo.json()).field, "c_credit_name");
  const email = await post(sub({ contributor: { ...sub().contributor, email: "nope" } }));
  assert.equal((await email.json()).field, "c_email");
});

test("history timeline events need a source", () => {
  const base = sub({ page: "timeline", template: "timeline-event",
    fields: { year: "1974", kind: "history", text: "The rack line opens." } });
  assert.equal(validate(base, FORMS).field, "source");
  const ok = validate({ ...base, fields: { ...base.fields, source: "https://example.org/x" } }, FORMS);
  assert.ok(!ok.error);
  const draft = luaDraft(ok, new Date("2026-10-06T12:00:00Z"));
  assert.match(draft, /kind = "history", source = "TODO", -- https:\/\/example\.org\/x/);
});

test("investigator drafts parse characteristics and compute HP/SAN", () => {
  const v = validate(sub({ page: "dudu", template: "investigator", fields: {
    name: "Iara Bento", role: "The Heir", occupation: "Nurse", quote: "Breathe through the cloth.",
    motivation: "Find her grandfather's grave.", hook: "Descends from Bento Arruda.",
    characteristics: "FOR 40, CON 70, TAM 50, DES 60, APA 55, INT 70, POD 65, EDU 60",
    skills: "First Aid 70\nMedicine: 45%\nListen 55", gear: "Nurse's bag" } }), FORMS);
  assert.ok(!v.error, v.error);
  const draft = luaDraft(v, new Date("2026-10-06T12:00:00Z"));
  assert.match(draft, /characteristics = \{ STR = 40, CON = 70, SIZ = 50, DEX = 60, APP = 55, INT = 70, POW = 65, EDU = 60 \}/);
  assert.match(draft, /declared = \{ HP = 12, SAN = 65 \}/);
  assert.match(draft, /\{ "Medicine", 45 \}/);
});

test("segment drafts keep long-bracket-safe Lua and note the target page", () => {
  const v = validate(sub({ page: "the-mist", template: "mythos", fields: {
    name: "Salt Lines", type: "ritual", summary: "x", what: "Contains ]==] on purpose", play: "y" } }), FORMS);
  assert.ok(!v.error, v.error);
  const draft = luaDraft(v, new Date());
  assert.match(draft, /body = \[===\[/);
});

test("segments are accepted in either language", async () => {
  const segs = FORMS.books["mist-over-the-funicular"].pages["the-mist"].segments;
  const ok = (seg, lang) => validate(sub({ page: "the-mist", template: "mythos", segment: seg, lang,
    fields: { name: "Salt", type: "ritual", summary: "x", what: "y", play: "z" } }), FORMS);
  assert.ok(!ok(segs.pt[0].id, "pt").error);
  assert.ok(!ok(segs.en[0].id, "en").error);
  assert.equal(ok("nope", "pt").error, "unknown section");
});

test("a new book idea opens an issue with a starter book draft", async () => {
  const res = await post(sub({ book: "_new", page: "", template: "book-idea", fields: {
    title: "O Farol de Queimada Grande", system: "coc7", genre: "horror", pitch: "Uma ilha de cobras e um farol que acende sozinho.",
    premise: "Em 1909 o faroleiro desaparece.", place: "Ilha da Queimada Grande, SP", period: "1909", fact: "mixed",
    threat: "Algo nas cobras.", truth: "O farol chama.", endings: "Apagar o farol ou mantê-lo aceso.",
    places: "O Farol — a torre de ferro\nA Enseada — onde os barcos não voltam", characters: "Zé Faroleiro — some na primeira noite",
    role: "idea" } }));
  assert.equal(res.status, 200, JSON.stringify(await res.clone().json()));
  const issue = JSON.parse(calls.find((c) => c.url.includes("api.github.com")).init.body);
  assert.equal(issue.title, "[Ideia de livro novo] O Farol de Queimada Grande");
  assert.ok(issue.labels.includes("livro:novo") && issue.labels.includes("tipo:book-idea"));
  assert.match(issue.body, /## O mistério/);
  assert.match(issue.body, /books\/o-farol-de-queimada-grande\/book\.lua/);
  assert.match(issue.body, /id = "a-enseada", section = "Places"/);
  assert.match(issue.body, /system = "Call of Cthulhu 7e"/);
  const missing = await post(sub({ book: "_new", page: "", template: "book-idea", fields: { title: "x" } }));
  assert.equal(missing.status, 400);
  const wrongTpl = await post(sub({ book: "_new", template: "npc" }));
  assert.equal(wrongTpl.status, 400);
});

test("CORS preflight and health check", async () => {
  const pre = await worker.fetch(new Request("https://w.test/submit", { method: "OPTIONS", headers: { origin: ORIGIN } }), env);
  assert.equal(pre.status, 204);
  assert.equal(pre.headers.get("access-control-allow-origin"), ORIGIN);
  const health = await worker.fetch(new Request("https://w.test/"), env);
  assert.equal(await health.text(), "Magic Stack contributions: OK");
});

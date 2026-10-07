// "Sua história aqui": pick a book and a part of it, then open its form.
// Books and pages come from forms.json, in the site's current language.
(function () {
  "use strict";
  const book = document.getElementById("pk-book"), page = document.getElementById("pk-page"), go = document.getElementById("pk-go");
  if (!book) return;
  let F = null;
  const lang = () => (window.msLang ? window.msLang() : "pt");
  const tx = (o) => (o && typeof o === "object" ? o[lang()] || o.pt || o.en : o || "");
  const SECTIONS = {
    pt: { "The Scenario": "O Cenário", "Places": "Locais", "The Mythos": "O Mythos", "Factions": "Facções", "Investigators": "Investigadores", "Endings": "Finais", "Reference": "Referência" },
    en: {},
  };
  const option = (value, text) => { const o = document.createElement("option"); o.value = value; o.textContent = text; return o; };

  function fillBooks() {
    const keep = book.value;
    book.replaceChildren(...Object.entries(F.books).filter(([, b]) => b.open).map(([id, b]) => option(id, tx(b.title))));
    if (keep && F.books[keep]) book.value = keep;
    fillPages();
  }
  function fillPages() {
    const b = F.books[book.value]; if (!b) return;
    const keep = page.value;
    const groups = {};
    for (const id of b.order || Object.keys(b.pages)) {
      const p = b.pages[id];
      if (!p.templates.length) continue;
      (groups[p.section] = groups[p.section] || []).push(option(id, tx(p.title)));
    }
    page.replaceChildren(...(b.sections || Object.keys(groups)).filter((s) => groups[s]).map((s) => {
      const g = document.createElement("optgroup"); g.label = SECTIONS[lang()][s] || s; g.append(...groups[s]); return g;
    }));
    if (keep && b.pages[keep]) page.value = keep;
    link();
  }
  function link() {
    go.href = `contribute.html?book=${encodeURIComponent(book.value)}&page=${encodeURIComponent(page.value)}&lang=${lang()}`;
  }
  book.addEventListener("change", fillPages);
  page.addEventListener("change", link);
  document.addEventListener("ms:lang", () => F && fillBooks());
  fetch("forms.json", { cache: "no-cache" }).then((r) => r.json()).then((d) => { F = d; fillBooks(); })
    .catch(() => { document.getElementById("picker").hidden = true; });
})();

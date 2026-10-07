# Contribution Worker

A small Cloudflare Worker between the contribution form and GitHub. It receives a form submission, checks it and opens an issue in the **private** repository `magic-stack-contribuicoes`, where it waits for review.

```
reader → contribute.html → POST /submit → Worker ─┬─ Turnstile (anti-spam)
                                                  ├─ forms.json (same rules as the form)
                                                  └─ GitHub issue in magic-stack-contribuicoes
```

Each issue has:

- the page and section the reader was on, with a link to it;
- the contribution, one heading per form field;
- a **Lua draft** ready to paste into `books/<id>/data/` after editing;
- a review checklist, including the credit level (`crédito:1-contribuidor`, `crédito:2-colaborador`, `crédito:3-coautor`);
- the consent record: terms version, time, and the five boxes ticked.

Labels: `contribuição`, `aguardando-revisão`, `livro:<book>`, `tipo:<form>`.

## One-time setup

1. **Contributions repository.** On GitHub, create a **private** repository named `magic-stack-contribuicoes`. Contributors' names and emails go there, so it must stay private.
2. **GitHub token.** Under *Settings → Developer settings → Fine-grained tokens*, create a token with access to **only** `magic-stack-contribuicoes` and the permission **Issues: Read and write**. Nothing else.
3. **Turnstile.** In the Cloudflare dashboard, go to *Turnstile → Add widget*, add the hostname `murilloodev-web.github.io` and choose *Managed*. You get a **site key** (public) and a **secret key**.
4. **Deploy the Worker.** From this folder:
   ```
   npx wrangler login
   npx wrangler deploy
   npx wrangler secret put GITHUB_TOKEN
   npx wrangler secret put TURNSTILE_SECRET
   ```
   Wrangler prints the Worker address, for example `https://magic-stack-contrib.<you>.workers.dev`.
5. **Switch the form on.** In `site.lua`, set `worker_url` to `<Worker address>/submit`, set `turnstile_sitekey` to the site key, and set `contact`. Commit, and the site rebuilds itself.

While `worker_url` is empty the forms still open but say that contributions are not open yet.

## Tests

```
lua build.lua            # from the repository root: generates docs/forms.json
cd worker && npm test
```

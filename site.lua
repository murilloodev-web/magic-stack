-- Magic Stack — site-wide settings.
--
-- worker_url and turnstile_sitekey stay empty until the contribution Worker
-- is deployed (see worker/README.md). While they are empty the site still
-- builds and the "Contribute" buttons still open the forms, but the forms say
-- that contributions are not open yet instead of sending.

return {
  title    = "Magic Stack",
  tagline  = "A shelf of tabletop RPG stories you can read, play and add to.",
  owner    = "Murillo França M. da Silva",
  base_url = "https://murilloodev-web.github.io/magic-stack/",
  repo_url = "https://github.com/murilloodev-web/magic-stack",

  -- contribution pipeline
  worker_url        = "",   -- e.g. "https://magic-stack-contrib.<you>.workers.dev/submit"
  turnstile_sitekey = "",   -- public Turnstile site key (the secret lives only in the Worker)

  -- consent terms shown and recorded with every contribution
  terms_version = "1.0",
  terms_date    = "2026-10-06",
  -- how contributors reach the maintainer for credit changes, removal or
  -- data requests (LGPD). Fill in before opening contributions.
  contact = "",

  default_lang = "en",
  langs = { "en", "pt" },
}

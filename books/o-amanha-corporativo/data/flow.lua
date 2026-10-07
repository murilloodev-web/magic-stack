-- O grafo da aventura de abertura. Cada cena aponta para um artigo; `open`
-- marca uma cena em aberto (a aventura escrita termina ali). O build
-- confere que toda cena pode ser alcançada a partir de `start` e que de
-- toda cena se chega a uma cena em aberto.

return {
  start = "night-shift",
  nodes = {
    { id = "night-shift", title = "1. O Turno da Noite", page = "scene-night-shift",
      next = { { to = "cleanup", when = "Zuleide convoca a célula para preparar a estação." } } },
    { id = "cleanup", title = "2. A Faxina", page = "scene-cleanup",
      next = { { to = "auditor", when = "Às 08h00 o carro da OmniTerra para no portão." } } },
    { id = "auditor", title = "3. A Auditora", page = "scene-auditor",
      next = { { to = "meter", when = "A Suspeita chega a 3, ou a visita passa pela Adutora Velha." },
               { to = "dinner", when = "O dia de auditoria termina sem desastre." } } },
    { id = "meter", title = "4. O Medidor 14", page = "scene-meter",
      next = { { to = "dinner", when = "A calibração passa." },
               { to = "valve", when = "A fraude é descoberta, ou a Suspeita chega a 6." } } },
    { id = "dinner", title = "5. Jantar de Faca", page = "scene-dinner",
      next = { { to = "news", when = "Na manhã seguinte, Celeste reúne os funcionários." },
               { to = "valve", when = "A Suspeita chega a 6, ou a célula decide agir antes." } } },
    { id = "news", title = "6. A Notícia", page = "scene-news", open = true },
    { id = "valve", title = "7. A Válvula", page = "scene-valve", open = true },
  },
}

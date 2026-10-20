-- The campaign's stages, as a graph. Each node points to an article in
-- data/pages.lua. build.lua checks that every stage can be reached from the
-- start and that every path arrives at an open stage (the campaign has no
-- written ending yet). `row` and `x` (0–1, across)
-- place a stage on the diagram so the arrows do not cross the boxes.

return {
  start = "opening",
  nodes = {
    { id = "opening", page = "opening-adventure", title = "Aventura inicial", row = 0, x = 0.5,
      next = {
        { to = "knight", when = "A mesa segue o arco do cavaleiro" },
        { to = "child",  when = "A mesa segue o arco da criança" },
      } },
    { id = "knight", page = "knight-route", title = "Rota do cavaleiro", row = 1, x = 0.3,
      next = {
        { to = "sacrifice", when = "Sir Cael fica tempo demais em Avernus" },
        { to = "defeat",    when = "Um infernal de alto escalão derrota Sir Cael no plano material" },
      } },
    { id = "child", page = "child-route", title = "Rota da criança", row = 1, x = 0.75,
      next = {
        { to = "child-avernus", when = "Os jogadores matam a criança, fazem um exorcismo ou quebram o feitiço do pai" },
      } },
    { id = "sacrifice", page = "ending-sacrifice", title = "Final 1: o sacrifício", row = 2, x = 0.16,
      next = { { to = "knight-avernus", when = "Liberto, o diabo passa a dominar forças de Avernus" } } },
    { id = "defeat", page = "ending-defeat", title = "Final 2: a derrota", row = 2, x = 0.46,
      next = { { to = "knight-avernus", when = "O diabo volta para Avernus" } } },
    { id = "knight-avernus", page = "knight-avernus", title = "Avernus: sequestros", row = 3, x = 0.3,
      next = { { to = "threat", when = "O avanço do FiendFlayer vira a ameaça final" } } },
    { id = "child-avernus", page = "child-avernus", title = "Avernus: heróis coletados", row = 3, x = 0.75,
      next = { { to = "threat", when = "O avanço do FiendFlayer vira a ameaça final" } } },
    { id = "threat", page = "final-threat", title = "Ameaça final", row = 4, x = 0.5, open = true },
  },
}

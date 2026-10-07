-- Tradução de data/flow.lua. Por cena: título, texto e as condições das
-- saídas (`when`), na mesma ordem das saídas do original.
return {
  ["arrival"] = {
    title = "Chegada ao Alto da Serra",
    text = "Os três investigadores chegam à vila de trem e de carro numa noite de inverno, enquanto a vila prepara um festival de que ninguém de fora ouviu falar. A névoa já está errada.",
    when = { "Dudu começa sua auditoria", "Lenita entra no protesto na estação", "Arthur vai atrás do seu negativo" },
  },
  ["yard"] = {
    title = "O Pátio Ferroviário",
    text = "Um vagão-tanque abandonado, com ferrugem em linhas de maré. Livros-caixa cheios de \"água de lastro\".",
    when = { "Contabilidade ou Encontrar revela os códigos do telégrafo", "Consertos Mecânicos segue os canos de drenagem" },
  },
  ["festivities"] = {
    title = "O Festival de Inverno",
    text = "Um festival particular da vila: fogueiras no nevoeiro, sal jogado nos bueiros, nomes lidos em voz alta. Um velho ferroviário fala do vagão que nunca aparece nos horários.",
    when = { "Persuadir o velho ferroviário", "O engenheiro-chefe convida os \"encrenqueiros\" para jantar" },
  },
  ["tunnel"] = {
    title = "O Túnel",
    text = "A velha foto de Arthur, tirada de novo. A névoa tem rostos. Alguém observa do Castelinho.",
    when = { "Seguir o observador morro acima", "Seguir o som de água sob a rocha" },
  },
  ["castelinho"] = {
    title = "Jantar no Castelinho",
    text = "O engenheiro-chefe oferece um acordo. O escritório guarda o esboço do geodo e as cartas do século 19.",
    when = { "Aceitar o acordo, ou roubar a chave do escritório", "O próprio engenheiro-chefe os leva lá para baixo" },
  },
  ["landing"] = {
    title = "O Quarto Patamar",
    text = "A casa de máquinas e o bueiro de tijolos que engole água do mar.",
    when = { "Rastejar pelo bueiro" },
  },
  ["grota"] = {
    title = "Sob a Grota Funda",
    text = "Uma câmara de cristal violeta crescido da rocha, a Semente selada no centro, cultistas carregando salmoura à mão enquanto a névoa moribunda grita em todas as cabeças. A escolha.",
    when = { "Libertar a criatura no oceano", "Estilhaçar a ametista", "Devagar demais: a névoa de julho chega antes" },
  },
  ["ending-sea"]     = { title = "Final A — De Volta ao Mar" },
  ["ending-shatter"] = { title = "Final B — Estilhaçar a Pedra" },
  ["ending-lost"]    = { title = "Final C — A Névoa Guarda os Seus" },
}

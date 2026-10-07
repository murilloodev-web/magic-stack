-- Personagens prontos (Cyberpunk RED, Pacote Completo). O build confere:
-- atributos de 2 a 8 somando 62, perícias de nível 1 a 6 e no máximo 86
-- pontos (x2 = perícia de custo dobrado), PV, Gravemente Ferido, Teste de
-- Morte e Humanidade (EMP × 10 menos a perda fixa de cada implante).
--
-- skills:   { nome, atributo, nível [, x2 = true] }
-- implants: { id em data/implants.lua [, owner = dono, se não for o padrão] }
-- weapons:  { nome, dano, cadência de tiro [, note = "…"] }

return {
  {
    id = "marta", name = "Marta “Sopa” Quirino", role = "tech",
    occupation = "Operadora de comportas, 44 anos",
    origin = "Nasceu em Águas Lindas, do lado da OmniTerra, filha de operários da represa. Perdeu o braço direito numa comporta aos 29 anos; a empresa pagou a prótese, e o braço passou a ser da empresa.",
    quote = "O braço é deles. A mão que abre a comporta é minha.",
    motivation = "Os sobrinhos dela moram em Ceilândia, do outro lado da divisa. Cada litro a mais no Medidor 14 é um banho a mais para eles.",
    hook = "Se a estação for realocada, a prótese vai junto para Alcântara, com ou sem ela. E se ela for demitida, o braço é recolhido.",
    stats = { INT = 7, REF = 5, DEX = 6, TECH = 8, COOL = 6, WILL = 6, LUCK = 6, MOVE = 5, BODY = 5, EMP = 8 },
    skills = {
      { "Tecnologia Básica", "TECH", 6 }, { "Eletrônica/Segurança Técnica", "TECH", 4 },
      { "Conhecimento Local (Descoberto)", "INT", 5 }, { "Percepção", "INT", 4 }, { "Burocracia", "INT", 4 },
      { "Concentração", "WILL", 3 }, { "Persuasão", "COOL", 3 }, { "Primeiros Socorros", "TECH", 2 },
      { "Briga", "DEX", 2 }, { "Educação", "INT", 2 },
    },
    implants = { { "chip-biometrico", owner = "omniterra" }, { "braco-industrial", owner = "omniterra" } },
    weapons = { { "Chave de comporta", "3d6", 1, note = "Arma corpo a corpo pesada; o braço industrial aguenta." } },
    armor = { head = 0, body = 4 },
    gear = "Macacão reforçado, rádio da estação, kit de ferramentas, a chave mestra das comportas, uma colher de aço escondida no forro da bota.",
    links = { "scene-meter", "ownership", "brasilia" },
  },
  {
    id = "davi", name = "Davi Otoni", role = "medtech",
    occupation = "Enfermeiro da estação, 31 anos",
    origin = "Paramédico da Aegis-Med em Lisboa, demitido por desviar Tolerina para um paciente que tinha perdido o plano. Em quarentena, cruzou o Atlântico com um chip clonado e virou “Davi Rezende”, enfermeiro contratado da OmniTerra.",
    quote = "Ninguém aqui está doente. Está todo mundo sem plano.",
    motivation = "Ele contrabandeia Tolerina para os funcionários da estação e para quem precisa em Brasília. Se a estação cair, a rede dele cai junto.",
    hook = "O inventário de implantes da auditora vai ler o chip dele. Um chip clonado engana uma portaria; uma auditoria, talvez não.",
    stats = { INT = 7, REF = 5, DEX = 6, TECH = 7, COOL = 6, WILL = 7, LUCK = 5, MOVE = 6, BODY = 5, EMP = 8 },
    skills = {
      { "Primeiros Socorros", "TECH", 6 }, { "Paramédico", "TECH", 4, x2 = true }, { "Ciência (Farmacologia)", "INT", 4 },
      { "Percepção", "INT", 4 }, { "Enganação", "COOL", 5 }, { "Conversação", "EMP", 4 },
      { "Burocracia", "INT", 3 }, { "Pistola", "REF", 3 }, { "Evasão", "DEX", 3 },
    },
    implants = { { "chip-clonado" } },
    weapons = { { "Pistola leve", "1d6", 2, note = "Registrada no nome falso." } },
    armor = { head = 0, body = 7 },
    gear = "Maleta de primeiros socorros, doze doses de Tolerina (seis delas sem nota fiscal), um crachá com o nome Davi Rezende, uma foto de Lisboa.",
    links = { "quarantine", "ownership", "aegis-med" },
  },
  {
    id = "rui", name = "Rui “Calibre” Saldanha", role = "solo",
    occupation = "Chefe da vigilância da estação, 52 anos",
    origin = "Segurança contratado a vida inteira. Em 2111 estava a serviço da Great Rift do lado continental de Jibuti, quando o mar entrou. Cumpriu as ordens. Comprou o filtro pulmonar com o próprio dinheiro depois, e entrou para a AntiFaCa dois anos mais tarde.",
    quote = "Já vi uma empresa resolver um problema. Não quero ver de novo.",
    motivation = "Ele protege a célula porque não protegeu ninguém em 2111.",
    hook = "O Sargento Takeda, que comanda a escolta da auditora, estava com ele em Jibuti. Os dois sabem o que o outro fez.",
    stats = { INT = 5, REF = 8, DEX = 7, TECH = 4, COOL = 7, WILL = 6, LUCK = 5, MOVE = 7, BODY = 8, EMP = 5 },
    skills = {
      { "Pistola", "REF", 6 }, { "Armas de Ombro", "REF", 5 }, { "Briga", "DEX", 5 }, { "Evasão", "DEX", 5 },
      { "Percepção", "INT", 5 }, { "Tática", "INT", 4 }, { "Resistência", "WILL", 4 }, { "Interrogatório", "COOL", 3 },
    },
    implants = { { "chip-biometrico", owner = "omniterra" }, { "olho-reticula", owner = "kuro-tech" }, { "filtro-pulmonar", owner = "none" } },
    weapons = {
      { "Pistola pesada", "3d6", 2 },
      { "Escopeta da guarita", "5d6", 1, note = "Fica trancada na guarita; a chave está com ele." },
    },
    armor = { head = 0, body = 11 },
    gear = "Colete leve, rádio, lanterna, a chave da guarita, um pacote de Tolerina que Davi deixa para ele toda semana por causa do olho.",
    links = { "great-dismissal", "kuro-tech", "scene-valve" },
  },
  {
    id = "lia", name = "Lia Matsumoto-Freitas", role = "nomad",
    occupation = "Motorista do caminhão-pipa, 27 anos",
    origin = "Nasceu em Taguatinga, no REGEST de Brasília, e nunca teve chip. Trabalha para a estação com uma credencial de fornecedora: oficialmente leva lodo de decantação para um aterro; na prática, leva água limpa para a cidade.",
    quote = "Do lado de lá tem água. Do lado de cá tem gente. Eu só dirijo.",
    motivation = "A mãe dela é enfermeira no Hospital de Base. Lia sabe exatamente quantos dias de reserva o hospital tem.",
    hook = "Ela é a única da célula que cruza o Posto 4 todos os dias, e a primeira que a segurança vai revistar se algo der errado.",
    stats = { INT = 6, REF = 7, DEX = 6, TECH = 6, COOL = 7, WILL = 6, LUCK = 7, MOVE = 6, BODY = 6, EMP = 5 },
    skills = {
      { "Dirigir Veículo Terrestre", "REF", 6 }, { "Conhecimento Local (Brasília)", "INT", 5 }, { "Malandragem", "COOL", 5 },
      { "Pistola", "REF", 4 }, { "Evasão", "DEX", 4 }, { "Comércio", "COOL", 4 },
      { "Tecnologia de Veículos Terrestres", "TECH", 4 }, { "Arma Branca", "DEX", 3 }, { "Percepção", "INT", 3 },
    },
    implants = {},
    weapons = {
      { "Pistola média", "2d6", 2 },
      { "Faca de cozinha", "1d6", 2, note = "Ela acha graça de andar com uma faca." },
    },
    armor = { head = 4, body = 7 },
    gear = "O caminhão-pipa (12 mil litros, placa de fornecedora), rádio com canal codificado, credencial de fornecedora, mapa das estradas de terra em volta do Posto 4.",
    links = { "brasilia", "nomads", "scene-night-shift" },
  },
}

-- Personagens do Mestre (Cyberpunk RED). Atributos de 2 a 10. O build
-- calcula PV, Gravemente Ferido e Teste de Morte, confere os implantes, e
-- falha se algum personagem não aparecer num artigo (@npc:<id>).
--
-- skills:  { nome, valor base (atributo + nível) }
-- weapons: { nome, dano, cadência de tiro [, note = "…"] }

return {
  {
    id = "celeste", name = "Celeste Prado-Vasconcelos", label = "Auditora sênior de Conformidade, OmniTerra",
    stats = { INT = 8, REF = 4, DEX = 4, TECH = 5, COOL = 7, WILL = 7, LUCK = 5, MOVE = 5, BODY = 4, EMP = 6 },
    armor = { head = 0, body = 4 },
    weapons = { { "Pistola leve de bolsa", "1d6", 2, note = "Nunca disparou fora do estande." } },
    skills = { { "Burocracia", 14 }, { "Contabilidade", 15 }, { "Percepção", 13 }, { "Persuasão", 13 },
               { "Etiqueta", 13 }, { "Interrogatório", 12 }, { "Concentração", 12 } },
    implants = { { "chip-biometrico", owner = "omniterra" }, { "memoria-conformidade", owner = "omniterra" } },
    notes = "Tudo o que ela vê fica gravado na Memória de Conformidade. Leva no bolso do paletó uma colher pequena de alumínio, da avó.",
  },
  {
    id = "zuleide", name = "Dona Zuleide Batista", label = "Supervisora da Estação Descoberto-7 e líder da Célula Concha",
    stats = { INT = 7, REF = 3, DEX = 4, TECH = 7, COOL = 8, WILL = 8, LUCK = 6, MOVE = 3, BODY = 4, EMP = 8 },
    armor = { head = 0, body = 0 },
    weapons = { { "Chave de válvula", "2d6", 1 } },
    skills = { { "Tecnologia Básica", 13 }, { "Liderança", 15 }, { "Burocracia", 13 }, { "Enganação", 14 },
               { "Conhecimento Local (Descoberto)", 13 }, { "Percepção", 11 } },
    implants = { { "chip-biometrico", owner = "omniterra" } },
    notes = "Sabe o nome, o turno e o segredo de cada um dos 41 funcionários. Não acredita em grandes vitórias; acredita em litros.",
  },
  {
    id = "takeda", name = "Sargento Edson Takeda", label = "Comandante da escolta terceirizada, Kuro-Tech",
    stats = { INT = 5, REF = 7, DEX = 6, TECH = 4, COOL = 7, WILL = 6, LUCK = 4, MOVE = 6, BODY = 7, EMP = 4 },
    armor = { head = 11, body = 11 },
    weapons = { { "Pistola pesada", "3d6", 2 }, { "Fuzil de pacificação", "5d6", 1, note = "Munição de contenção: em vez de dano, o alvo faz um Teste de Morte ou fica atordoado por uma rodada." } },
    skills = { { "Pistola", 13 }, { "Armas de Ombro", 13 }, { "Tática", 11 }, { "Percepção", 10 }, { "Briga", 11 }, { "Liderança", 10 } },
    implants = { { "chip-biometrico", owner = "kuro-tech" }, { "audicao-ampliada", owner = "kuro-tech" } },
    notes = "Esteve com Rui Saldanha em Jibuti, em 2111. Cumpre ordens; quer chegar vivo à aposentadoria.",
  },
  {
    id = "guard", name = "Segurança terceirizado (×3)", label = "Unidade de pacificação, Kuro-Tech",
    stats = { INT = 4, REF = 6, DEX = 5, TECH = 3, COOL = 5, WILL = 4, LUCK = 3, MOVE = 5, BODY = 5, EMP = 4 },
    armor = { head = 7, body = 11 },
    weapons = { { "Bastão de choque", "2d6", 2 }, { "Pistola média", "2d6", 2 } },
    skills = { { "Pistola", 10 }, { "Briga", 9 }, { "Percepção", 8 } },
    implants = { { "chip-biometrico", owner = "kuro-tech" } },
    notes = "Contratados por trimestre. Não ganham para morrer e sabem disso.",
  },
}

-- Tradução de data/npcs.lua. Números vêm do original; aqui ficam os textos,
-- os nomes dos ataques e das perícias, na mesma ordem.
return {
  ["ashworth"] = {
    name = "Henrique Ashworth",
    label = "Engenheiro-chefe e Grão-Mestre da Companhia, 58 anos",
    attacks = {
      { "Lutar (Briga)", "1D3 + BD" },
      { "Armas de Fogo (Pistolas) — revólver .32", "1D8" },
    },
    skills = { "Crédito", "Ciência (Engenharia)", "Persuasão", "Psicologia", "Encontrar", "Ocultismo", "Mitos de Cthulhu" },
    armor = "Nenhuma.",
    spells = "**Chamar o Nevoeiro** (4 PM, 1D4 SAN para quem conjura): a névoa se adensa em volta de uma pessoa à vista; ela faz na hora um teste de Contato com um dado de penalidade.",
    notes = "Chupa pastilhas de sal o dia inteiro. Fala os sinais de mão silenciosos da Companhia. Com Contato 8, a criatura pede algo a ele uma vez por cena; ele resiste com um teste resistido de POD, e perde mais a cada noite.",
  },
  ["cultist"] = {
    name = "Cultista da Companhia",
    label = "Capataz, escriturário ou guarda-freios de dia; perfil típico",
    attacks = {
      { "Lutar (Briga)", "1D3 + BD" },
      { "Lutar (Briga) — pé de cabra ou cravo de trilho", "1D8 + BD" },
    },
    skills = { "Escalar", "Escutar", "Furtividade", "Consertos Mecânicos", "Intimidação" },
    armor = "Nenhuma.",
    notes = "Levam sal nos bolsos e um cantil de salmoura. Na névoa, lutam em silêncio, combinando-se por sinais de mão; dois ou mais juntos ganham um dado de bônus para cercar ou agarrar.",
  },
  ["tonico"] = {
    name = "Antônio “Tonico” Castro",
    label = "Irmão mais novo de Lenita, limpador de vagões-tanque, 19 anos",
    attacks = {
      { "Lutar (Briga)", "1D3 + BD" },
      { "O abraço afogado (agarrar)", "água do mar brota da boca dele para a da vítima: teste de CON ou 1D3 de dano por rodada" },
    },
    skills = { "Escalar", "Escutar", "Furtividade", "Natação" },
    armor = "Nenhuma.",
    notes = "Uma **Voz da Salmoura**: quando a névoa está densa, a criatura fala por ele, com a voz dele, e sabe tudo o que ele sabe sobre a irmã. Ele não pode ficar abaixo de Contato 9 enquanto a Semente estiver na serra. Se ela chegar ao mar (Final A), o Contato dele cai para 4 e ele pode voltar para casa.",
  },
  ["ditinho"] = {
    name = "Benedito “Seu Ditinho” Ramos",
    label = "Maquinista de locobreque aposentado, 78 anos",
    attacks = { { "Lutar (Briga)", "1D3 + BD" } },
    skills = { "Operar Maquinário Pesado (Locobreque)", "Consertos Mecânicos", "Escutar", "História (Ferrovia)" },
    armor = "Nenhuma.",
    notes = "Mantém o Contato baixo com sal e teimosia. Sabe acender a caldeira de uma locobreque, o que faz diferença no [[ending-sea]].",
  },
}

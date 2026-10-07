-- O catálogo pé no chão (capítulo VIII). Só existem estes implantes.
--   hl      Perda de Humanidade fixa (o build usa este número nas fichas)
--   owner   titular padrão: employer (o empregador), none, aegis, kuro-tech, omniterra
--   tolerin true = exige uma dose semanal de Tolerina (veja "ownership")

return {
  { id = "chip-biometrico", name = "Chip Biométrico Corporativo", hl = 1, cost = "0¢", owner = "employer", tolerin = false,
    text = "Instalado na contratação, no pulso. Abre portas, paga contas, registra o ponto e serve de passaporte. Na demissão, é bloqueado." },
  { id = "chip-clonado", name = "Chip Biométrico Clonado", hl = 2, cost = "1.000¢", owner = "none", tolerin = false,
    text = "A cópia de uma identidade que não é sua. Passa em portarias; numa auditoria de implantes, o leitor faz um teste de DV 17 contra o trabalho de quem clonou." },
  { id = "braco-industrial", name = "Prótese de Braço Industrial", hl = 7, cost = "1.000¢", owner = "employer", tolerin = true,
    text = "Braço com mão de ferramenta embutida (chave, alicate, torquímetro). Conta como ferramenta para Tecnologia Básica e aperta como uma prensa." },
  { id = "olho-reticula", name = "Olho Cibernético com Retícula", hl = 7, cost = "1.000¢", owner = "employer", tolerin = true,
    text = "Substitui um olho. A retícula dá +1 em ataques mirados com armas à distância. Padrão nas unidades de segurança." },
  { id = "filtro-pulmonar", name = "Filtro Pulmonar", hl = 2, cost = "500¢", owner = "aegis", tolerin = false,
    text = "Filtra toxinas e gases do ar. Vantagem contra venenos inalados. Comum entre quem trabalhou perto de zonas de contenção." },
  { id = "marca-passo", name = "Marca-passo de Vigília", hl = 4, cost = "500¢", owner = "employer", tolerin = true,
    text = "Reduz a necessidade de sono para quatro horas por noite. Se o firmware da empresa não for atualizado no mês, −1 em todas as ações até a atualização." },
  { id = "audicao-ampliada", name = "Audição Ampliada", hl = 3, cost = "500¢", owner = "employer", tolerin = false,
    text = "+2 em Percepção para ouvir. Conversas em voz baixa a até dez metros deixam de ser privadas." },
  { id = "memoria-conformidade", name = "Memória de Conformidade", hl = 5, cost = "1.000¢", owner = "employer", tolerin = true,
    text = "Grava tudo o que o portador vê e ouve, com carimbo de tempo, como prova jurídica. Usada por auditores. Desligá-la exige acesso físico e Eletrônica/Segurança Técnica DV 17." },
}

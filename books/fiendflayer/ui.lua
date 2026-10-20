-- Interface text that belongs to this book only (D&D labels, the boxes, the
-- campaign map). Generic book-page text comes from lib/book_strings.lua.

return {
  pt = {
    footer = "<em>%s</em> — uma campanha original para Dungeons &amp; Dragons 5e por %s. Gerado a partir de dados em Lua com <code>build.lua</code>. Dungeons &amp; Dragons, Forgotten Realms e os nomes do lore oficial pertencem à Wizards of the Coast; este é um material de fã, não oficial.",
    title_suffix = " — uma campanha de D&D 5e",
    kinds = { history = "Lore oficial", fiction = "Criação", mixed = "Lore + Criação" },
    legend = '<span class="tag tag-history">Lore oficial</span> vem dos livros de D&amp;D · <span class="tag tag-fiction">Criação</span> inventado para esta campanha · <span class="tag tag-mixed">Lore + Criação</span> criação construída sobre o lore',
    boxes = { gm = "Nota do Mestre", lore = "No lore oficial", open = "Em aberto" },
    glance = {
      { "Sistema", "Dungeons &amp; Dragons 5e" },
      { "Planos", "O plano material e Avernus, a primeira camada dos Nove Infernos" },
      { "Formato", "Campanha em construção: premissa, vilão, dois arcos de abertura e a ameaça final, ainda sem cenas escritas" },
      { "Vilão", "O FiendFlayer, um diabo com características de mind flayer" },
    },
    start = "Começar a ler", play = "Ver o mapa da campanha",
    open_scene = "Em aberto",
    flow_lede = "%d etapas. A campanha ainda não tem final escrito: a etapa marcada <strong>Em aberto</strong> é onde o livro para por enquanto. O build confere que toda etapa pode ser alcançada e que todo caminho chega a uma etapa em aberto.",
    flow_caption = "Cada caixa é uma etapa da campanha; clique para ir até ela. A caixa vermelha está em aberto.",
    open_text = "Aqui termina o que já está escrito. As cenas desta etapa ainda não existem.",
    exits = "Para onde esta etapa leva",
    scenes = "As etapas",
    concept_alt = "Concept sheet do FiendFlayer em sete painéis: corpo inteiro de frente e de costas, busto frontal, cabeça de perfil, rosto de boca fechada, rosto de boca aberta com tentáculos e estudo das mãos. A pele é vermelho rubro, com manchas roxas que avançam das extremidades para o peito.",
    concept_caption = "O concept sheet do FiendFlayer. Clique para abrir em tamanho real.",
    pager = "Navegação entre capítulos",
  },

  en = {
    footer = "<em>%s</em> — an original Dungeons &amp; Dragons 5e campaign by %s. Built from Lua data with <code>build.lua</code>. Dungeons &amp; Dragons, Forgotten Realms and the names from the official lore belong to Wizards of the Coast; this is unofficial fan content.",
    title_suffix = " — a D&D 5e campaign",
    kinds = { history = "Official lore", fiction = "Original", mixed = "Lore + Original" },
    legend = '<span class="tag tag-history">Official lore</span> from the D&amp;D books · <span class="tag tag-fiction">Original</span> invented for this campaign · <span class="tag tag-mixed">Lore + Original</span> built on top of the lore',
    boxes = { gm = "DM note", lore = "In the official lore", open = "Open" },
    glance = {
      { "System", "Dungeons &amp; Dragons 5e" },
      { "Planes", "The Material Plane and Avernus, the first layer of the Nine Hells" },
      { "Format", "A campaign in progress: premise, villain, two opening arcs and the final threat, with no scenes written yet" },
      { "Villain", "The FiendFlayer, a devil with mind flayer traits" },
    },
    start = "Start reading", play = "See the campaign map",
    open_scene = "Open",
    flow_lede = "%d stages. The campaign has no written ending yet: the stage marked <strong>Open</strong> is where the book stops for now. The build checks that every stage can be reached and that every path arrives at an open stage.",
    flow_caption = "Each box is a stage of the campaign; click one to jump to it. The red box is open.",
    open_text = "This is where the written part ends. The scenes of this stage do not exist yet.",
    exits = "Where this stage leads",
    scenes = "The stages",
    concept_alt = "FiendFlayer concept sheet in seven panels: full body front and back, front bust, head in profile, face with the mouth closed, face with the mouth open and tentacles, and a study of the hands. The skin is ruby red, with purple patches spreading from the extremities toward the chest.",
    concept_caption = "The FiendFlayer concept sheet. Click to open it full size.",
    pager = "Chapter navigation",
  },
}

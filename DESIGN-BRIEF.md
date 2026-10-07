# Design Brief — Magic Stack

Brief para redesenhar o Magic Stack no Claude Design. São duas frentes:

1. **A estante e a mesa**: a página inicial, onde a pessoa pega um livro, coloca na mesa e o abre.
2. **O leitor do livro**: como cada livro aparece por dentro, começando pelo *The Mist over the Funicular*, junto com os pontos de entrada das contribuições.

## Material para levar junto

| Arquivo | Para quê |
|---|---|
| `DESIGN-BRIEF.md` (este) | O que desenhar e como deve se comportar. |
| `books/mist-over-the-funicular/REFERENCE.md` | Todo o texto do primeiro livro, com estrutura, fichas, linha do tempo, fluxo e fontes. É o material-fonte. |
| `books/mist-over-the-funicular/DESIGN-BRIEF.md` | Direção de arte do Mist: paleta, pixel art, ilustrações pendentes e regras (violeta só para a entidade). |
| Prints do site atual | O ponto de partida, para mostrar o que existe hoje. |

---

## 1. Conceito

**Uma biblioteca particular à noite.** Quem chega ao Magic Stack entra no escritório de quem mestra: uma estante de livros de aventura, uma mesa de madeira pesada sob a luz de um lampião e névoa do lado de fora da janela. Cada livro é uma história jogável. Você pega o livro na estante, coloca na mesa, ele abre e você entra na história.

A estante não é só um menu. Ela também diz que **o acervo cresce**: há espaço para novos livros, e cada livro aceita contribuições de quem lê.

**Estilo:** pixel art 16-bit em clima de fantasia sombria, o mesmo do Mist. Pedra, madeira, céu de brasa e índigo, luz de lua e névoa. A estante é neutra e serve a todos os livros. Cada livro traz a sua cor e a sua arte, então a estante não deve usar o violeta reservado à entidade do Mist.

### Regras da direção de arte (valem para tudo)

- **Pixels de verdade:** desenhar na resolução nativa e ampliar ×3 ou ×4 por vizinho mais próximo, sem anti-aliasing. Degradês só com pontilhado (dithering).
- **Uma única luz quente por cena**, que aqui é o lampião sobre a mesa, contra azuis e roxos frios.
- **Silhueta primeiro:** estante, mesa e livros precisam ser legíveis em silhueta.
- **Paleta base** (a do site atual): Void `#0b0b14`, Night `#15162a`, Dusk blue `#1f1f3d`, Plum `#4a2a55`, Wine `#7a2f45`, Ember `#b8433e`, Glow `#e27a3f`, Lamp `#f3b04a`, Moon `#dfe7d9`, Stone `#8e8aae`, Fog `#8a86a8` / `#3b3860`. Para a madeira, acrescentar no máximo 4 cores, por exemplo `#2a1d17`, `#3a2a22`, `#5a4232` e `#7a5a3e`.
- **Tipografia:** pixel (tipo Silkscreen) para rótulos e interface, blackletter legível (tipo Pirata One) para títulos e serifa de livro (tipo EB Garamond) para o texto corrido. Nenhum logotipo ou fonte de jogo real.
- **Obra original:** nada de personagens, sprites ou logotipos de jogos existentes.

---

## 2. A estante e a mesa (página inicial)

### 2.1 Composição — desktop (a partir de 1024 px)

A cena é vista de frente, levemente de cima:

- **A estante**, nos dois terços superiores ou à esquerda: duas ou três prateleiras de madeira escura, com lombadas em pé. Alguns objetos de RPG entre os livros (dados, uma vela, um mapa enrolado) dão vida à cena sem competir com os livros.
- **A mesa**, no terço inferior ou à direita: tampo de madeira com veios em pixel e um lampião aceso, que cria um círculo de luz quente no centro. Esse círculo é a **zona onde o livro pousa**.
- **A janela** ao fundo, opcional: névoa passando devagar. É a única animação ambiente, além da chama do lampião.
- **O título "Magic Stack"** fica numa plaqueta de latão na estante ou entalhado no tampo da mesa, sem cabeçalho de site convencional.
- **Uma frase curta de apoio:** "Uma estante de histórias de RPG para ler, jogar e continuar."

### 2.2 Composição — celular (até 600 px)

- A estante vira **uma fileira horizontal de lombadas** que rola para o lado, com scroll-snap.
- A mesa fica **embaixo**, ocupando a largura toda, com o círculo de luz no centro.
- Tocar numa lombada leva o livro até a mesa. Arrastar não é necessário no celular.
- Margem lateral de 16 px e nenhuma rolagem horizontal da página. Só a fileira de livros rola.

### 2.3 O livro como objeto

Cada livro tem três vistas desenhadas a partir dos dados de `book.lua` (título, sistema, subtítulo, autor, status e cores):

| Vista | Tamanho nativo sugerido | Conteúdo |
|---|---|---|
| **Lombada** (na estante) | 16–24 × 96–128 px | Cor-base do livro, duas faixas de detalhe e o título na vertical. A altura e a espessura variam por livro, para a estante não parecer um gráfico de barras. |
| **Capa** (na mesa) | 96 × 128 px | A arte do livro, título, sistema e autor. No Mist, um recorte da arte-chave: o funicular, o Castelinho e a névoa. |
| **Livro aberto** (transição) | 192 × 128 px | Página dupla com o sumário do livro em letra pequena, usada no instante em que ele abre. |

Marcas de status na lombada:

- **Completo:** lombada inteira.
- **Em andamento:** uma fita marcadora pendurada no alto.
- **Rascunho:** lombada mais clara, com papéis soltos saindo de dentro.

E um **espaço vazio** na prateleira, desenhado como o contorno de um livro na poeira, com o texto "Sua história aqui". Ele leva ao guia de como propor um livro novo, que é feito pelo GitHub.

### 2.4 A interação, passo a passo

| # | Estado | O que acontece | Tempo |
|---|---|---|---|
| 1 | **Parado** | Livros na estante, chama do lampião tremulando (2–3 quadros) e névoa lenta na janela. | Em loop |
| 2 | **Hover ou foco na lombada** | O livro desliza 8–12 px para fora da prateleira e uma plaquinha aparece com título, sistema e status. O cursor vira uma mão aberta. | 120 ms |
| 3 | **Pegar** (apertar e arrastar) | O livro sai da estante e segue o ponteiro, inclinado uns 6° e com sombra. Na estante fica o vão. O círculo de luz da mesa pulsa de leve e aparece a dica "Coloque na mesa". | Contínuo |
| 4 | **Soltar fora da mesa** | O livro volta sozinho para o lugar. | 250 ms |
| 5 | **Soltar na mesa** (ou clicar ou tocar na lombada) | O livro gira e pousa deitado, de capa para cima, no círculo de luz. Ao lado surge o **cartão do livro**. | 300–400 ms |
| 6 | **Livro na mesa** | Cartão com sinopse curta, sistema, período e lugar, autor, número de contribuidores e três ações: **Abrir**, **Contribuir** (leva a uma página do livro escolhida para receber contribuições) e **Devolver à estante**. | — |
| 7 | **Abrir** (botão, duplo clique na capa ou Enter) | A capa vira como página (3–4 quadros de pixel art), o livro aberto cresce até ocupar a tela e a página do livro carrega. | 600–900 ms |
| 8 | **Trocar de livro** | Pegar outro livro com um já na mesa devolve o primeiro à estante. | 250 ms |

**Lembrar o último livro:** quem volta à estante encontra na mesa o último livro aberto, guardado só no navegador da pessoa.

### 2.5 Acessibilidade (obrigatório)

- **Teclado:** Tab percorre as lombadas na ordem da estante. Enter ou Espaço coloca o livro na mesa, Enter de novo abre e Esc devolve. Todos os estados precisam de foco visível, como o contorno âmbar do site atual.
- **Arrastar nunca é o único caminho:** clique e toque fazem tudo.
- **Leitores de tela:** a estante é uma lista de links. Cada lombada tem nome acessível, como "The Mist over the Funicular, Call of Cthulhu 7e, completo". Pousar o livro na mesa é anunciado.
- **`prefers-reduced-motion`:** sem inclinação, sem virada de página e sem névoa animada. Os estados trocam por fade de 150 ms.
- **Contraste:** texto da interface com pelo menos 4,5:1 sobre o fundo. As plaquinhas e o cartão do livro usam a cor Moon sobre Night.
- **Sem JavaScript**, a página continua sendo uma estante de links que abrem os livros direto.

### 2.6 O que precisa sair do Claude Design (estante)

1. Desktop: estados 1, 2, 3, 5/6 e 7, em telas separadas.
2. Celular: fileira de lombadas, livro na mesa com cartão aberto, e foco por teclado.
3. Sprites: lombada genérica parametrizável (cor-base, faixa e título), capa do Mist, livro aberto, lampião (3 quadros), névoa da janela (loop) e espaço vazio "Sua história aqui".
4. Um protótipo HTML/CSS/JS **sem framework** que rode estático no GitHub Pages. Imagens em PNG com `image-rendering: pixelated`.

---

## 3. O leitor do livro — *The Mist over the Funicular*

O livro já existe e funciona (veja os prints). O redesenho mantém toda a estrutura e o texto de `REFERENCE.md` e melhora a experiência de leitura e de jogo. O texto não muda nessa etapa.

### 3.1 Estrutura que precisa continuar existindo

- **Capa do livro** (index): arte-chave, título, linha de apoio ("A Call of Cthulhu 7th Edition scenario · Paranapiacaba, Brazil · May–July 1974"), botões "Abrir o grimório" e "Ver o fluxo do cenário", legenda das três etiquetas e sumário por seção.
- **Sete seções:** The Scenario, Places, The Mythos, Factions, Investigators, Endings, Reference.
- **Etiquetas** em toda página: History (verde-musgo), Fiction (vermelho-sangue) e History + Fiction (brasa). Elas são parte da proposta do livro, porque separam o fato da invenção.
- **Citações numeradas** [n], que levam à lista de fontes, e a caixa "References on this page" no fim da página.
- **"Referenced from":** as páginas que apontam para esta.
- **Navegação** anterior e próxima, sumário lateral (no celular, botão "Contents") e "On this page".
- **Um link de volta à estante**, que hoje é "← Shelf" no topo. No redesenho pode ser um marcador de página ou um ícone de estante.

### 3.2 Páginas especiais (cada uma pede um layout próprio)

| Página | O que é | Ideia de design |
|---|---|---|
| **Investigadores** (3) | Fichas de CoC 7e: características com valores Regular / Difícil / Extremo, derivados (PV, SAN, PM, Mov, Bônus de Dano, Corpo), perícias e equipamento. | Ficha de personagem como documento de 1974: papel datilografado e retrato em pixel numa moldura de pedra. Precisa ser legível e fácil de imprimir. |
| **Timeline** | 1859–2001, com história e ficção lado a lado. | Linha vertical com anos grandes e cada evento marcado History ou Fiction. Dá para usar duas colunas no desktop (fato à esquerda, ficção à direita). |
| **Scenario Flow** | Grafo de 10 cenas, com saídas condicionadas e 3 finais. | Mapa clicável no estilo de mapa de masmorra 16-bit. Cada cena é um cartão, e os finais ficam destacados. |
| **Mist Contact** | Escala de 0 a 10 com 7 níveis, de Clear a Drowned. | Medidor em pixel que escurece e fica violeta a cada nível, com os ícones da escala (item 4.5 do brief de arte do Mist). |
| **Endings** (3) | Três finais, nenhum limpo. | Cabeçalho com a ilustração do final e um "custo" em destaque. |
| **Sources** | 14 referências reais. | Lista sóbria, de bibliografia. |

### 3.3 Leitura

- Texto corrido com 60–75 caracteres por linha, serifa de livro e corpo em torno de 18–19 px.
- A ilustração de cada local entra no topo da página (os itens 3.x do brief de arte).
- Os handouts dos jogadores (telegrama, carta, aviso de fechamento, foto, caderno do Bento) aparecem como cartões ampliáveis.
- Estilo de impressão: fundo claro, sem menus, com as citações mantidas.

---

## 4. Contribuições (dentro de todo livro)

A colaboração acontece pelo formulário, não pelo GitHub. O design precisa deixar claro que **cada parte do livro aceita acréscimos**, sem atrapalhar a leitura.

### 4.1 Pontos de entrada

1. **Por seção:** cada título de seção (`##`) dentro de uma página tem um botão discreto, hoje "+ contribute", que fica forte no hover e no foco e sempre visível no toque. A ideia é trocar o texto por um **ícone de pena** com rótulo para leitores de tela.
2. **Por página:** no fim de toda página que aceita contribuições há um bloco "Add to this page" com uma frase e o botão "Contribute to '<página>'".
3. **Na mesa da estante:** o botão "Contribuir" do cartão do livro.

O link sempre leva ao formulário daquela página e daquela seção:
`contribute.html?book=<livro>&page=<página>&seg=<seção>`.

### 4.2 O formulário

Hoje ele é gerado a partir de `forms.json`, então os campos mudam conforme o tipo de página. O design precisa cobrir:

- **Cabeçalho:** "Contribuir com · <livro>", o título da página, um seletor da seção ("A página inteira" ou uma seção), o link "← Voltar para a página" e a troca de idioma EN/PT.
- **Escolha do tipo**, quando a página aceita mais de um. Por exemplo, em The Mist: "Elemento do Mythos" ou "Novo personagem", em cartões grandes.
- **Os campos**, de 4 a 10 por tipo: textos curtos, áreas de texto longas com contador de caracteres, seletores e links. Os obrigatórios são marcados.
- **Sobre você:** nome, e-mail e a forma de crédito (nome, pseudônimo ou anônimo).
- **Consentimento:** cinco caixas obrigatórias e o link para o termo.
- **Anti-spam** da Cloudflare (Turnstile), um bloco de cerca de 300 × 65 px.
- **Estados:** vazio, com erro (mensagens por campo e geral), enviando, enviado (com o número do protocolo), contribuições fechadas (aviso) e link quebrado.
- **Rascunho guardado** no aparelho, com um aviso discreto.

**Ideia visual:** uma **carta ao autor** escrita à luz do lampião, num pergaminho escuro e com cabeçalho de lacre. Os campos continuam sendo campos normais e legíveis, sem caligrafia.

### 4.3 Termo de Contribuição (`terms.html`)

Texto jurídico em PT (versão que vale) e EN, com uma tabela de **níveis de crédito**: 1 Contribuidor(a), 2 Colaborador(a) de seção e 3 Coautor(a). O design precisa ser sóbrio e legível, com um índice das 12 seções.

### 4.4 Créditos no livro (novo)

Contribuições aceitas geram créditos. Isso precisa de lugar no design:

- **Nível 2:** "Escrito com <nome>" no rodapé da página ou da seção.
- **Nível 1 e acima:** uma página "Contributors" em cada livro, com a lista de nomes por nível.
- **Nível 3:** o nome na capa do livro ("por Murillo França M. da Silva e <nome>") e na lombada, se couber.

---

## 5. Restrições técnicas (para o protótipo poder virar código)

- O site é **estático** e gerado por `build.lua` a partir de dados em Lua, publicado no GitHub Pages. Nada de servidor nem framework obrigatório.
- A estante é gerada a partir de `library.lua` e de cada `books/<id>/book.lua`. O design precisa funcionar com **1 livro hoje e 20 amanhã**, com títulos curtos e longos.
- O leitor de cada livro usa as classes atuais (`.prose`, `.tag-history`, `.contrib-seg`, `.contrib` e outras), que podem mudar, mas a estrutura de dados não.
- As fontes vêm do Google Fonts e as imagens de `books/<id>/assets/art/`.
- O site precisa funcionar em 375 px de largura e em temas escuros. O claro fica só para impressão.

## 6. Ordem sugerida no Claude Design

1. A estante e a mesa, desktop, estados 1 → 7.
2. A mesma coisa no celular.
3. Lombada, capa e livro aberto do Mist.
4. O modelo de página do leitor, mais a ficha de investigador.
5. O formulário de contribuição e o estado "enviado".
6. Os créditos no livro.

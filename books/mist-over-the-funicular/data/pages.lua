-- Grimoire pages.
--
-- Markup understood by build.lua:
--   [[page-id]] or [[page-id|label]]  internal link (checked at build time)
--   {{source-id}}                     numbered citation to data/sources.lua
--   **bold**   *italic*
--   ## Heading     - list item     > quotation
--
-- Which chapter an article belongs to is set in data/chapters.lua.
-- Boxes: a line "::: read" (boxed text to read aloud), "::: keeper" (Keeper
-- note) or "::: history" (historical note) opens a box, ":::" closes it.
-- "| a | b |" lines make a table; "@npc:<id>" shows a profile from data/npcs.lua.
--
-- kind: "history" = documented fact, "fiction" = invented for the scenario,
--       "mixed"   = fiction built directly on documented fact.

return {

  ---------------------------------------------------------------- SCENARIO
  {
    id = "synopsis", kind = "mixed",
    title = "Synopsis",
    summary = "What the government thinks it is closing, and what it is really setting loose.",
    body = [==[
In 1974 the Brazilian federal railway network opens a modern rack line down the Serra do Mar and begins winding down the old cable-hauled funicular that had carried coffee from the plateau to the port of Santos since 1867 {{spr-wiki}} {{funicular-wiki}}. On paper it is a cost-cutting modernisation.

What no ministry in Brasília knows is that the funicular was never only a railway. Every train that climbed from the coast hauled one more wagon than the timetable admitted: a sealed tank car of seawater thick with iron filings and crushed stone, bound for [[fourth-landing|the Fourth Landing]] and the tunnels below [[grota-funda|Grota Funda]]. The seawater keeps a pre-human sea-thing drowsy. The iron and stone feed its body of [[amethyst-heart|amethyst]], grown for a century until it is too vast to ever leave the mountain.

The creature was captured here in 1866, carried up from the south by [[the-fugitive|a man it had taken over]], a few kilometres short of the sea it was fleeing toward. Since then it has had only one way to reach anyone: [[the-mist|the mist]]. Everyone who breathes it hears it, a little more each night.

As the funicular slows, the tank cars stop coming. The mist turns cold, heavy and insistent. The [[company-of-shadows|Company of Shadows]], whose members have breathed it for generations, is losing control, and three strangers who came up the mountain for very different reasons start to hear their own names in the fog.

## The dilemma at the bottom of the tunnel
The investigators must choose between two bad endings: [[ending-sea|cut the creature's heart free and return it to the ocean]], or [[ending-shatter|shatter it with railway dynamite]] and bind the mist to the village forever. There is no clean victory. That is the point.
]==],
  },
  {
    id = "fact-and-fiction", kind = "mixed",
    title = "Fact & Fiction",
    summary = "Where the history ends and the Mythos begins, and the liberties this scenario takes.",
    body = [==[
This scenario is built on real places and real machines. Every historical claim in the grimoire carries a numbered citation; everything tagged *Fiction* is invented. The [[timeline]] shows both side by side.

## Liberties taken, on purpose
- **The Serra Nova as the dying line.** Historically the older Serra Velha funicular stopped in 1970 and its track bed became the 1974 rack line; the Serra Nova funicular kept running into the early 1980s {{funicular-wiki}} {{museu-funicular}}. The scenario sets the "threat of closure" on the Serra Nova, which is where the [[locobreques]] actually worked.
- **The tank wagon never existed.** The heavy cable haulage was built for coffee, freight and a 796 m climb {{unesco}}, not for seawater.
- **Amethyst is not native to the Serra do Mar.** Brazil's great amethyst geodes form in the volcanic rocks of the far south {{amethyst-wiki}} {{amethyst-usp}}. In the fiction, that is exactly what makes the stone wrong: [[the-fugitive|someone carried it here]].
- **Amethyst really is quartz coloured by iron.** Its violet comes from iron impurities in the crystal, activated by radiation {{amethyst-wiki}}. The fiction takes that literally: the Company grew the creature's body by feeding it silica and iron from the railway itself.
- **The Winter Festival is older than the record.** Officially, Paranapiacaba's Winter Festival began in July 2001 {{festival-origins}}. In the scenario it has been held every winter since the 19th century as a private village rite of the [[company-of-shadows|Company of Shadows]]. 2001 is only the year outsiders were first invited: see [[winter-festival]].

## Respect for a living place
Paranapiacaba is a real, inhabited, heritage-listed village {{unesco}}. The cult and its crimes are fiction and are not meant to describe any real person, family or institution.
]==],
  },
  {
    id = "timeline", kind = "mixed",
    title = "Timeline",
    summary = "1859 to 2001, with documented history and scenario fiction side by side.",
    body = "@timeline",  -- rendered from data/timeline.lua
  },
  {
    id = "scenario-flow", kind = "fiction",
    title = "Scenario Flow",
    summary = "The branching structure of the investigation, from arrival to the three endings.",
    body = "@flow",  -- rendered from data/flow.lua
  },

  ---------------------------------------------------------------- PLACES
  {
    id = "paranapiacaba", kind = "history",
    title = "Paranapiacaba",
    summary = "The British railway village at the top of the Serra do Mar, and the fog it lives in.",
    body = [==[
In Tupi, *Paranapiacaba* means "the place from which one sees the sea" {{paranapiacaba-wiki}}. It is a cruel name: most days the sea is invisible behind the fog.

The São Paulo Railway called the site **Alto da Serra** and raised a company village there. It began as a camp for construction workers and grew into a planned town of wooden houses of Baltic pine on masonry bases, with the planned district of Vila Martin Smith laid out beside it {{vitruvius}}. Around 450 buildings housed about 1,100 people {{unesco}}.

## The fog
Dense fog rolls over the village at dusk, fed by the forest, the altitude and the nearby Atlantic {{unesco}} {{paranapiacaba-wiki}}. Locals say footballers here learned to play by ear. In this scenario the fog is something more: see [[the-mist]].

## In 1974
The investigators find a village already in decline. The railway that built it is modernising without it, and the old British order survives only in the houses and at the [[castelinho]].
]==],
  },
  {
    id = "castelinho", kind = "mixed",
    title = "The Castelinho",
    summary = "The chief engineer's Victorian house, set above the yard so he could watch every move.",
    body = [==[
The "Little Castle" was built by the British in 1897 as the home of the railway's chief engineer. It stands on raised ground so that its occupant could watch the rail yard, the station clock and the workers' homes at every hour {{castelinho-folha}}. It is a two-storey Victorian house of 507 m² with 33 windows and six fireplaces, roofed in tiles from Marseille. Today it is a museum {{museu-castelo}}.

## In the scenario *(Fiction)*
Whoever holds the post of chief engineer is, by ritual right, Grand Master of the [[company-of-shadows|Company of Shadows]]. The panoramic windows are for more than watching workers: from here the [[chief-engineer]] reads the density of [[the-mist|the mist]] like a barometer.

## What the investigators can find here
- Telegraph logs where "ballast water" figures do not match any cargo manifest.
- A locked study with 19th-century correspondence in English and a geological sketch of an amethyst geode.
- A barometer-like instrument with a violet crystal needle that points downhill, towards [[grota-funda]].
- Bento Arruda's water-stained notebook from 1866 (see [[the-fugitive]]).
]==],
  },
  {
    id = "funicular", kind = "history",
    title = "The Funicular",
    summary = "Two cable railways that hauled trains up an 800-metre wall of forest.",
    body = [==[
The São Paulo Railway opened on 16 February 1867, linking the port of Santos to the coffee plateau across the Serra do Mar, a climb that ordinary locomotives could not make {{spr-wiki}}.

## Serra Velha (1867–1970)
The first system climbed in **four inclined planes**, with a fixed steam engine at each landing hauling the wagons up by cable. It could lift about 60 tonnes per trip {{funicular-wiki}}.

## Serra Nova (1900–1980s)
The second system doubled capacity with **five inclined planes and five landings** and an "endless rope" running continuously along the track {{funicular-wiki}}. Trains were driven by [[locobreques]] that gripped the moving cable. It ran commercially until 1983 {{museu-funicular}}.

## 1974: the rack line
With the railway nationalised in 1946 {{spr-wiki}}, the federal network replaced the old Serra Velha bed with an Abt rack-and-adhesion line in 1974, built by Marubeni with electric locomotives {{spr-wiki}} {{funicular-wiki}}. From then on the funicular's days were numbered.

## In the scenario *(Fiction)*
Every up-train from Santos carried one extra, unlisted car: see [[company-car]]. The rack line cannot carry it, and the Serra Nova is being wound down. That is how the story starts.
]==],
  },
  {
    id = "locobreques", kind = "history",
    title = "The Locobreques",
    summary = "British 'brake locomotives' that gripped a moving steel cable.",
    body = [==[
A *locobreque* is a small steam locomotive with a claw that clamps onto the steel cable running between the rails {{locobreque-wiki}}. Twenty were built in Britain around 1900–1901 by Kerr, Stewart & Co. and Robert Stephenson & Co., and they served the Serra Nova from 1901 to 1976, pushing and braking trains across its five inclined planes {{locobreque-wiki}}.

Locobreque nº 14, built in 1902, was the last one fired up, on 22 October 1994, for visiting railway enthusiasts. It survives at the Museu do Funicular {{museu-funicular}}.

## In the scenario *(Fiction)*
Old drivers say the locobreques "pulled heavier going up than the scales said". A locobreque in steam is also the only way to move the [[amethyst-heart|amethyst]] in [[ending-sea]].
]==],
  },
  {
    id = "fourth-landing", kind = "mixed",
    title = "The Fourth Landing",
    summary = "A machine house halfway up the Serra Nova, and the drain beneath it.",
    body = [==[
Each of the Serra Nova's five landings (*patamares*) housed a fixed steam engine that drove the cable for the plane below it {{funicular-wiki}}.

## In the scenario *(Fiction)*
Beneath the Fourth Landing's machine house, a brick culvert runs away from the track and into the rock. At each stop, the [[company-car]] opened a valve and drained its seawater, iron and crushed stone there. Beside every landing's engine stood a bin where the filings from the worn cables were swept. The culvert ends in the tunnels under [[grota-funda]].

Eduardo Fonseca's father helped assemble these engines. His madness began here: see [[dudu]].
]==],
  },
  {
    id = "grota-funda", kind = "mixed",
    title = "Grota Funda",
    summary = "A 60-metre-deep gorge, a famous viaduct, and something sleeping under it.",
    body = [==[
Grota Funda ("Deep Hollow") is a gorge about 60 m deep and 200 m wide. The viaduct that carries the railway across it is counted among the great engineering feats of the São Paulo Railway {{unesco}}.

## In the scenario *(Fiction)*
Under the gorge, abandoned construction tunnels open into a flooded chamber that is no longer made of stone: walls, floor and ceiling are violet crystal, the Body of the [[amethyst-heart]], grown for a century around the Seed at its centre. By July 1974 the seawater pools are drying up and the salt ringing the altar is cracking. The desperate members of the [[company-of-shadows|cult]] haul buckets of brine down by hand.

This is where the scenario ends: [[ending-sea]] or [[ending-shatter]].
]==],
  },

  ---------------------------------------------------------------- MYTHOS
  {
    id = "the-mist", kind = "fiction",
    title = "The Mist",
    summary = "The creature's voice: breathe it and you are in contact with the thing under the mountain.",
    body = [==[
The entity has two halves. Its **body** is a mass of violet crystal grown into the rock under [[grota-funda]] (see [[amethyst-heart]]). Its **voice** is the mist. It cannot move, so it speaks, and it speaks the only way it can: through the air people breathe.

The real fog of [[paranapiacaba]] {{unesco}} gives it the perfect disguise.

## Breathing is listening
Every lungful of the mist is a moment of contact with the creature. Villagers have breathed it lightly for a century and hear no more than a murmur, blunted by the salt they throw into the drains at the [[winter-festival]]. The [[company-of-shadows|cult]] breathes it on purpose, and its members are deep in contact. The investigators are exposed from their first night in the village.

This is the heart of the scenario's horror: the players are **constantly being infected**. The deeper they go, the more they understand, and the more they are understood. Rules: [[mist-contact]].

## What the mist wants
It wants to go home to the sea, the way it almost did in 1866 (see [[the-fugitive]]). Everything it whispers bends that way: it shows people the path to Grota Funda, asks them to open the drains, to "bring the sea up" or "carry me down".

## The drying
As the [[company-car]] stops arriving, the creature dehydrates and grows frantic, and its voice gets louder:
- **May:** thicker than usual; metal rusts overnight; dogs refuse to go out.
- **June:** cold enough to fog the inside of closed rooms. Voices call people by name.
- **July:** toxic and relentless. Contact rolls every hour outdoors after dusk, and exposure costs 1D2 HP per hour.

## Using it at the table
Treat the mist as a clock and as a temptation. Every wasted scene it thickens (see the Mist Clock in [[running]]); every deep breath gives a true clue at a price. Describe it tightening rather than announcing rules.
]==],
  },
  {
    id = "mist-contact", kind = "fiction",
    title = "Mist Contact",
    summary = "Rules for the slow infection of everyone who breathes the mist, investigators and cultists alike.",
    body = [==[
Breathing the [[the-mist|mist]] puts a person in contact with the entity. Contact is tracked from 0 to 10 for every investigator and every important NPC.

## Gaining Contact
- **Exposure.** Each scene outdoors after dusk, or any scene in the tunnels: roll POW. On a failure, gain 1 Contact (1D3 in July).
- **Breathing deep.** An investigator may choose to breathe the mist on purpose: gain 1D2 Contact and receive one true clue from the Keeper as a vision.
- **Touch.** Touching the crystal body or the Seed of the [[amethyst-heart]]: gain 2 Contact.
- **Carrying the Seed.** Gain 1 Contact every hour. This is how [[the-fugitive]] was taken.

## Losing Contact
- **Salt.** A pinch of salt on the tongue before entering the mist gives a bonus die on the POW roll. This is the cult's oldest secret, and the reason salt is thrown into the drains at the [[winter-festival]].
- **The coast.** A full night below the Serra, near the sea at Santos, removes 1D3 Contact.
- Contact 9 or higher can never be reduced.

## The track
@contact

## Who is where
- Villagers: 1–2, kept low by salt and habit.
- Ordinary cultists of the [[company-of-shadows|Company]]: 5–7, stabilised with brine and salt.
- The [[chief-engineer]]: 8, and holding on with difficulty.
- [[dudu|Eduardo's]] father reached 10 in the 1950s. [[lenita|Lenita's]] brother is at 9 somewhere in the tunnels.

## Keeper note
Contact is a curse and a gift. The visions are true clues, and the Pull always points the right way. Let the players *choose* to breathe.
]==],
  },
  {
    id = "the-fugitive", kind = "fiction",
    title = "The Fugitive",
    summary = "The man who carried the creature to the edge of the sea in 1866, and why it never arrived.",
    body = [==[
In 1866, while the São Paulo Railway was still cutting its way up the Serra {{spr-wiki}}, a man walked into the construction camp at Alto da Serra from the interior. He was starving, barefoot, and carried on his back a geode the size of a child's head, wrapped in wet sacking. He gave his name as **Bento Arruda**, a prospector from the amethyst country of the far south {{amethyst-wiki}}, and said he had been walking for months.

He said he was running. He never said from what.

## The truth
Bento was not running with the stone. **The stone was running, and he was its legs.** It had filled his lungs with mist in a flooded cave in the south and steered him east, always east, toward the sea it had been cut off from. Alto da Serra was the last ridge before the coast: Paranapiacaba, "the place from which one sees the sea" {{paranapiacaba-wiki}}. It could finally see the ocean.

It never reached it.

## The capture
The British engineers noticed that the fog followed Bento, that crews working near him never tired, and that they woke with solutions to engineering problems they had not been able to solve. They took the stone from him. That night Bento tried to carry it down the mountain in the dark. He was found at dawn at the foot of the first incline, **drowned on dry land, his lungs full of seawater.**

## Why they fed it
The engineers understood something quickly: a stone that can be carried will always find new legs. So they made sure no one could ever carry it again. They began to feed it, with seawater to keep it drowsy and with iron and stone to make it grow, until its body filled the tunnels under [[grota-funda]] and fused with the mountain. See [[amethyst-heart]] and [[company-car]].

Those engineers became the first [[company-of-shadows|Company of Shadows]].

## What the investigators can find
- In the [[castelinho]] study: Bento's water-stained notebook in Portuguese. The entries grow shorter as they near the coast. The last line reads: *"Daqui se vê o mar"*, "From here you can see the sea."
- In the camp register of 1866: a burial with the cause of death given as "drowning", on a mountain 800 m above the sea.
]==],
  },
  {
    id = "amethyst-heart", kind = "mixed",
    title = "The Amethyst Heart",
    summary = "A seed of crystal carried here in 1866, fed for a century until its body became part of the mountain.",
    body = [==[
The creature has a heart and a body, and they are no longer the same size.

## The Seed
The original geode that [[the-fugitive|Bento Arruda]] carried up the mountain in 1866: about the size of a child's head, violet crystal inside, and on the outside a surface of coiled, finned shapes that no human hand carved. This is the creature's true core.

## The Body
For more than a century the [[company-of-shadows|Company]] fed the Seed, and it grew. Today a cathedral of violet crystal fills the chamber under [[grota-funda]], with veins running deep into the rock of the Serra. It weighs hundreds of tonnes and is part of the mountain. **It can never be moved.** That was the whole point. The Seed is still at its centre, sealed inside the crystal.

## Why amethyst, and what it eats *(History → Fiction)*
Amethyst is quartz, which is silica, coloured violet by iron impurities activated by radiation {{amethyst-wiki}}. Brazil's giant geodes form in the volcanic rocks of the far south, not in the granite of the Serra do Mar {{amethyst-usp}}.

The fiction takes this literally. The Company feeds the creature exactly what amethyst is made of:
- **Silica**: crushed granite ballast from the railway bed.
- **Iron**: filings from the worn steel cables, brake shoes and wheel tyres of the funicular, swept up at every landing.
- **Seawater**: the medium the crystals grow in, and the sedative that keeps the creature drowsy.

The creature supplies the radiance itself. The railway literally built its body. See [[company-car]].

## Game notes
- Touching the Body or the Seed: SAN 1/1D6, +2 [[mist-contact|Contact]], and a vision of the ocean floor.
- Cutting the Seed free takes an hour with railway tools and a successful Science (Geology) or Mechanical Repair roll. The noise draws the cult.
- The freed Seed weighs about 20 kg and can be carried, but its carrier gains 1 Contact every hour, which is how Bento died.
- Industrial dynamite from the railway stores can shatter the Seed: see [[ending-shatter]].
]==],
  },
  {
    id = "winter-festival", kind = "mixed",
    title = "The Winter Festival",
    summary = "A tourist festival since 2001. A secret rite for more than a century before that.",
    body = [==[
## The public record *(History)*
Paranapiacaba's Winter Festival held its first public edition in July 2001: modest, spread over two weekends, and visited by about 11,000 people {{festival-origins}}. Today it is one of the village's best-known events.

## What the village knows *(Fiction)*
The festival did not begin in 2001. **That was the year the rest of São Paulo found out about it.**

Since the first [[company-car]] climbed the mountain, the [[company-of-shadows|Company of Shadows]] has held a festival every winter, on the coldest nights, when [[the-mist|the mist]] is thickest. To the railway families it was simply *the Festival*: bonfires in the fog, music, hot drinks, and nobody from outside. It was never advertised, never printed in a newspaper, and strangers who arrived during it were politely put on the next train down.

Underneath the celebration is the rite:
- Salt is thrown into the drains of the village. It keeps the villagers' [[mist-contact|contact]] shallow for another year.
- The brick culvert at the [[fourth-landing]] is "fed" by hand with brine and iron filings.
- The names of the year's dead and missing are read aloud at the [[castelinho]] by the [[chief-engineer]].
- At midnight every lamp goes out, and the village listens to the fog breathe.

## In 1974
With the tank car runs cut, the 1974 festival is desperate. The rite is bigger, louder and less careful, and for the first time outsiders are in the village to see it. The investigators arrive as it is being prepared.

## In 2001 *(Fiction)*
After the events of 1974, what was left of the Company could no longer keep the festival secret, so they did the opposite: they opened it to the public. Tourists now dance in the same fog, and nobody asks why the locals still throw salt into the drains.
]==],
  },
  {
    id = "company-car", kind = "fiction",
    title = "The Company Car",
    summary = "The unlisted tank wagon of seawater, iron and stone that rode every up-train for a century.",
    body = [==[
Every train that climbed from Santos to the plateau was required to carry one extra car: a modified tank wagon listed in the books as "ballast", or not listed at all.

## The cargo
The tank held tons of seawater, and in it, a slurry of **crushed granite and iron filings**: the dust of the railway itself, collected from worn cables, brake shoes and wheels at every landing. At the [[fourth-landing]] the car drained its load underground towards [[grota-funda]].

The seawater kept the creature drowsy. The iron and stone fed the crystal body that keeps it chained to the mountain. See [[amethyst-heart]].

## The mechanical secret
In the fiction, the dead weight of this car is the hidden reason the railway needed such powerful fixed engines, steel cables and [[locobreques]]. The real reason was freight and a 796 m climb {{unesco}}, which makes the lie easy to believe.

## Clues
- Rust stains shaped like tide lines inside an abandoned tank car in the yard.
- Sealed barrels labelled "FILINGS — 4th LANDING" stacked behind the engine shed.
- Accounts showing "ballast water" costs no auditor has ever questioned (see [[dudu]]).
- A missing worker's last letter about "something alive at the bottom of the tank" (see [[lenita]]).
]==],
  },

  ---------------------------------------------------------------- FACTIONS
  {
    id = "company-of-shadows", kind = "fiction",
    title = "The Company of Shadows",
    summary = "The old British shareholders' secret order, and the local families that serve it.",
    body = [==[
A secret order founded by the British engineers who captured [[the-fugitive|Bento Arruda's]] stone in 1866, later joined by the railway's shareholders and a handful of local families. They serve the entity for prosperity and for the engineering and alchemical secrets it whispers. The impossible railway was their first miracle.

After nationalisation in 1946 {{spr-wiki}}, the shareholders lost the railway but kept the cult. Its members stayed on as engineers, foremen and clerks, and kept the [[company-car]] running under a new flag.

## Infected by devotion
Every member of the Company breathes the mist on purpose, and every one of them is deep in [[mist-contact|Contact]]. They keep themselves from drowning in it with salt on the tongue and brine in their tea. Their silent hand-signs are something they learned from the creature, not from each other.

Every winter since 1868 the Company has hidden its rite inside a private village celebration, which the public only discovered in 2001: see [[winter-festival]].

## In 1974
The order is frightened and split. Without the tank cars the mist is louder in their heads every night. Some want to drag the creature to the new rack line; others plan a sacrifice large enough to buy time. All of them want the RFFSA auditors gone. They are led by the [[chief-engineer]]. Its working members are in [[cultists]].
]==],
  },
  {
    id = "chief-engineer", kind = "fiction",
    title = "The Chief Engineer",
    summary = "Grand Master of the cult, resident of the Castelinho, keeper of the telegraphs.",
    body = [==[
Whoever holds the post of chief engineer and lives in the [[castelinho]] is, by ritual right, Grand Master of the [[company-of-shadows|Company of Shadows]]. Every appointee since the 19th century has been recruited, one way or another. The office passes on when a chief engineer finally "drowns".

The current chief engineer, **Henrique Ashworth**, was born in São Paulo to a family that came out with the São Paulo Railway, and has held the post since 1958. He uses the railway's telegraphs and logbooks to arrange sacrifices and hide the enormous consumption of seawater and iron. He is courteous, tired and very afraid. He is at [[mist-contact|Contact]] 8, sucks salt pastilles constantly, and hears the creature every waking minute. He knows better than anyone what happens when the water runs out.

## Playing him
He does not want the investigators dead at first. He wants them to *understand*, and then to help. Offer them a deal before offering them a knife. If an investigator is Tide-touched, he will speak to them in the cult's silent signs, and they will understand. His dinner and his deal are in [[scene-castelinho]].

@npc:ashworth
]==],
  },

  ---------------------------------------------------------------- ENDINGS
  {
    id = "ending-sea", kind = "fiction",
    title = "Ending A — Return to the Sea",
    summary = "Cut the Seed free and carry it down to the ocean it was fleeing toward.",
    body = [==[
**Action.** The investigators cut the Seed free from the crystal Body of the [[amethyst-heart]] and carry it down to the sea at Santos, on the last funicular train pulled by a [[locobreques|locobreque]] in steam, or through the old drainage culverts. Every hour the carrier gains 1 [[mist-contact|Contact]], and the creature sings the whole way down. Someone has to make the trip Bento Arruda never finished.

**Consequence.** Without its Seed, the crystal Body under the mountain goes dark, and the deadly mist lifts from [[paranapiacaba|Paranapiacaba]]. But the horror returns to its element. Strange events, mysterious shipwrecks and sightings of a maelstrom return to the São Paulo coast.

**For the table.** A bittersweet ending that sets up a sequel on the coast. Surviving investigators each lose 1D6 SAN as they watch the sea "breathe", and their Contact never quite falls back to zero.
]==],
  },
  {
    id = "ending-shatter", kind = "fiction",
    title = "Ending B — Shatter the Stone",
    summary = "Break the amethyst with railway dynamite, and pay for it with the village.",
    body = [==[
**Action.** The investigators shatter the Seed at the centre of the [[amethyst-heart]] with industrial dynamite from the railway stores.

**Consequence.** The entity is "killed", but a century of energy stored in its crystal Body is released at once in a pneumatic blast. [[the-mist|The mist]] settles on the village for good, now voiceless and endless, leaving Paranapiacaba forever inside a timeless fog, maddened and cut off from the rest of Brazil.

**For the table.** A pyrrhic victory. The coast is safe; the village is lost. Anyone in the chamber makes a CON roll or loses 2D6 HP, and a SAN roll or loses 1D10. Everyone at Contact 7 or higher hears the creature's last scream, and loses an extra 1D6 SAN.
]==],
  },
  {
    id = "ending-lost", kind = "fiction",
    title = "Ending C — The Mist Keeps Its Own",
    summary = "Optional failure state: the investigators run out of time.",
    body = [==[
*Optional ending, for tables that like real stakes.*

If the [[running|Mist Clock]] fills before the investigators reach [[grota-funda]], the mist wins. The creature does not wake; it simply *spreads*. The cult is found drowned in a dry tunnel. The investigators wake in Santos with no memory of the last week, and a lingering taste of salt.

The same ending applies to any investigator who reaches [[mist-contact|Contact]] 10: they are simply not there when the others wake.

This ending exists so that the [[running|Mist Clock]] actually matters.
]==],
  },

  ---------------------------------------------------------------- REFERENCE
  {
    id = "sources", kind = "history",
    title = "Sources",
    summary = "Every real-world reference cited in this grimoire.",
    body = "@sources",
  },
  {
    id = "about", kind = "mixed",
    title = "About this Book",
    summary = "Who wrote it, how it is built, and how to use it.",
    body = [==[
*The Mist over the Funicular* is an original investigation scenario for [[sources|Call of Cthulhu 7th Edition]] {{coc7}}, written by **Murillo França M. da Silva**, a game master for over ten years (D&D, Tormenta and others).

## How it is built
The whole book is plain **Lua** data: chapters, articles, investigators, Keeper characters, handouts, sources, a timeline and a scenario graph. A small Lua build script turns them into this website. At build time the script:
- checks that every internal link and every citation points to something real;
- recomputes the derived stats (HP, MP, Sanity, Move, Damage Bonus, Build) of every investigator and Keeper character from the Call of Cthulhu 7e rules and fails if a sheet disagrees;
- checks that every article, investigator and handout sits in exactly one chapter;
- walks the [[scenario-flow]] graph and fails if any scene is unreachable or any path dead-ends before an ending;
- generates the backlinks ("Referenced from") shown at the bottom of each page.

Treat it as content and scripting practice together: narrative written as data, then checked by code.

## Contributing
Every article ends with a way to send your own ideas: a character, a clue, a scene, a correction. Contributions are reviewed by the author, and accepted ones are credited in the book.
]==],
  },

  ---------------------------------------------------------------- RUNNING THE SCENARIO
  {
    id = "running", kind = "fiction",
    title = "Running the Scenario",
    summary = "Tone, the Mist Clock, a plan for three sessions and how to keep the table safe.",
    body = [==[
*The Mist over the Funicular* is a slow-burn investigation for **three investigators**, played in **two or three sessions** of about four hours. It works as a one-shot if you cut the [[scene-tunnel|Tunnel]] and start the investigators already together at the [[scene-festival|Festival]].

## The tone
Cold, wet and sad rather than gory. The horror is that the investigators are being changed by the air they breathe, and that both ways out cost something real. Keep the people of the village human: most of them are frightened, not evil, and they throw salt into the drains because their grandparents did.

## The Mist Clock
The mist is the scenario's timer. Keep a track of **10 boxes** where the players can see it, and mark one box:
- every night that passes;
- every scene the investigators spend without moving closer to [[grota-funda|Grota Funda]] (repeating a search, arguing in their rooms, going back down to Santos).

| Boxes | Stage | What changes |
|---|---|---|
| 1–5 | June | Contact rolls every scene outdoors after dusk. The fog fogs the inside of closed rooms and calls people by name. |
| 6–9 | July | Contact rolls **every hour** outdoors after dusk, with 1D3 Contact on a failure; exposure costs 1D2 HP per hour. |
| 10 | — | The mist takes the village: [[ending-lost]]. |

::: keeper
Never announce the clock's rules as a threat. Describe it: the dew on the inside of the windows, the dogs that will not go out, the landlady salting the pillows. The players will understand.
:::

## A plan for three sessions
- **Session 1.** [[scene-arrival]], then one or two of the [[scene-yard|Yard]], the [[scene-festival|Festival]] or the [[scene-tunnel|Tunnel]]. End on the dinner invitation from the chief engineer.
- **Session 2.** [[scene-castelinho|Dinner at the Castelinho]] and the study, then the walk or the locobreque ride up to the [[scene-landing|Fourth Landing]]. End at the mouth of the culvert.
- **Session 3.** [[scene-grota|Beneath Grota Funda]], the choice, and one of the endings.

## Safety at the table
The scenario touches drowning, a missing brother and a real, living village. Agree on lines and veils before you start. If someone at the table has lost a relative, Lenita's thread can end with Tonico found alive, see [[tonico]].

## The political backdrop
The scenario is set under Brazil's military government {{dictatorship-wiki}}. Censorship, a state-run railway and an activist on the train give the table real pressure without needing a villain in uniform: a policeman at the station who takes Lenita's leaflets, a newspaper editor who will not print Arthur's photos, an auditor who answers to Brasília.
]==],
  },

  ---------------------------------------------------------------- INVESTIGATORS
  {
    id = "investigators-intro", kind = "fiction",
    title = "Bringing Them Together",
    summary = "How the three investigators meet, and how to use your own instead.",
    body = [==[
The three pre-generated investigators arrive on the same winter evening, for three different reasons, and end up under the same roof: the **Pensão da Dona Ercília**, the only boarding house in the village that takes outsiders during the [[winter-festival|festival]].

- **Eduardo "Dudu" Fonseca** comes up on the last train from Santos with a briefcase of RFFSA cost reports.
- **Helena "Lenita" Castro** is on the same train, in third class, with a box of protest leaflets and her brother's letter (see [[h-letter]]).
- **Arthur Mendes** drives up the old road in a borrowed Beetle and arrives as the others are carrying their bags in.

Dona Ercília gives them supper together, because there is only one table. Let the players introduce their investigators there. Before they go to bed, she puts a pinch of salt on each of their pillows and will not say why.

## Each one holds a thread
| Investigator | Pulls toward | Personal stake |
|---|---|---|
| [[dudu]] | the money: the [[company-car]] and the [[scene-yard|Yard]] | his father's madness at the [[fourth-landing]] |
| [[lenita]] | the people: the [[scene-festival|Festival]] and the cult | her brother [[tonico]], missing in the tunnels |
| [[arthur]] | the image: the [[scene-tunnel|Tunnel]] and the [[castelinho]] | the negative the old board took from him |

## Using your own investigators
Any 1970s investigators will do. Give each player one of the three threads above as their reason to be on the mountain: someone checking the accounts, someone looking for a missing relative who worked on the tank cars, someone who once saw something in a photograph of the Serra. Keep the Contact track for each of them from the first night.

::: keeper
Write each investigator's **Contact** on a card in front of them, starting at 0. It is the most important number in this scenario, and it should be visible.
:::
]==],
  },

  ---------------------------------------------------------------- THE INVESTIGATION
  {
    id = "scene-arrival", kind = "mixed",
    title = "1. Arrival at Alto da Serra",
    summary = "A winter evening, the last train up, a village preparing a festival nobody outside has heard of.",
    body = [==[
::: read
The train climbs out of Santos in daylight and into the cloud. Somewhere on the incline the windows go white and stay white. When you step down at Alto da Serra the station clock reads ten past six, but the light has already gone; the fog is so thick that the lamps on the platform are only smudges of orange.

The village is busy. Men are stacking firewood in the square. Women carry trays covered with cloths. Nobody looks at you for long. Under your shoes, on the station steps, something crunches like sand. It is salt.
:::

## What is here
The **station** of Alto da Serra and its British clock tower, the square in front of it, and the steep lanes of wooden houses running down to the yard. The village is preparing the [[winter-festival|Winter Festival]], which no outsider has been invited to in a hundred years. A policeman at the station takes the names of everyone getting off the train. The investigators lodge at the **Pensão da Dona Ercília** (see [[investigators-intro]]).

## Clues
- **Spot Hidden.** Lines of salt on every threshold, including the boarding house's. Fresh, not old.
- **Psychology** on the villagers: they are not hostile. They are afraid *for* the strangers.
- **Persuade or Charm** with Dona Ercília: "You should have come next month. Or never. The festival is for us." She will say nothing about the salt.
- **Listen**, outside after dark: someone in the fog calls an investigator by their first name. Nobody is there.

## The first night
This is the first **Contact** roll of the scenario: each investigator who goes out after dusk rolls POW (see [[mist-contact]]). Lenita reads her brother's letter again in her room ([[h-letter]]).

::: keeper
Do not explain the mist. Describe that it is colder than it should be, that it smells faintly of the beach, that the dew on the window is on the *inside*.
:::
]==],
  },
  {
    id = "scene-yard", kind = "mixed",
    title = "2. The Rail Yard",
    summary = "Dudu's audit: ledgers full of 'ballast water' and a tank car with tide lines inside.",
    body = [==[
::: read
The yard is a field of wet iron. Rows of wagons wait under the fog, their wheels beaded with water. Beyond them the engine shed breathes steam, and behind it, half sunk in weeds, stands a tank wagon with no number on its side. Its hatch is open. It smells of the sea.
:::

## What is here
The yard office, where Dudu has an appointment with the section clerk; the engine shed; the abandoned **tank wagon** of the [[company-car]]; a stack of sealed barrels behind the shed. The foreman, **Moacir**, a [[cultists|cultist]], watches the investigators all morning and makes no secret of it.

## Clues
- **Accounting (Dudu).** The "ballast water" line has cost the railway more than coal every year since 1946. No auditor has ever questioned it. The RFFSA order suspending the service is pinned above the clerk's desk: [[h-memo]].
- **Spot Hidden.** Inside the tank: rust stains in rings, like tide lines on a pier. Behind the shed: barrels stencilled **"FILINGS — 4th LANDING"**.
- **Science (Geology)** on the sediment at the bottom of the tank: crushed granite, iron filings, and a violet grit that can only be amethyst. Amethyst does not belong in this mountain {{amethyst-usp}}.
- **Mechanical Repair.** Drain pipes run from the tank siding uphill, along the incline, toward the [[fourth-landing]].

::: history
The railway really did depend on heavy fixed engines and steel cable to climb the 796 m of the Serra {{unesco}}. The tank wagon is the scenario's invention.
:::

## Complications
If the investigators linger at night, Moacir and two cultists siphon brine from the barrels into buckets and carry it up the incline by hand. Following them leads to the [[scene-landing|Fourth Landing]].
]==],
  },
  {
    id = "scene-festival", kind = "mixed",
    title = "3. The Winter Festival",
    summary = "Bonfires in the fog, salt in the drains, names read aloud, and an old driver who remembers.",
    body = [==[
::: read
By nightfall the square is full. Bonfires burn in iron drums and the fog turns their light into great soft globes. Someone plays an accordion. There is quentão in tin cups, sweet with ginger and cachaça. Children run between the legs of the grown-ups throwing handfuls of something white into the drains, and the grown-ups let them.
:::

## What is here
The private festival of the railway families, the night before the rite (see [[winter-festival]]). Most villagers are warm to strangers once they have a cup in their hand. **Seu Ditinho** ([[old-railwayman]]), who drove locobreques for fifty years, sits by the biggest fire and talks to anyone who will listen.

## Clues
- **Persuade or Charm** with Seu Ditinho: "The machines pulled heavier going up than the scales said. Always one car more. A car that was never on the timetable."
- **History (Local Folklore) (Lenita).** There is no record of this festival anywhere: not in newspapers, not in the railway's own bulletins.
- **Spot Hidden.** The drains are not being cleaned. They are being **salted**.
- **Listen**, at midnight: every lamp in the village goes out at once, and in the silence the fog *breathes*. Everyone present makes a Contact roll.

## The names
At the end of the night the chief engineer reads the names of the year's dead and missing from the steps of the [[castelinho]]. One of them is **Antônio Castro**. Lenita loses 0/1D3 SAN.

## Developments
The chief engineer notices the strangers. Before the night is over, a boy brings a folded card to the boarding house: an invitation to dinner at the Castelinho, tomorrow, for "the gentlemen from the RFFSA and the press, and the young lady from Santos".
]==],
  },
  {
    id = "scene-tunnel", kind = "fiction",
    title = "4. The Tunnel",
    summary = "Arthur's old photograph, retaken: the mist has faces, and someone is watching from the hill.",
    body = [==[
::: read
The tunnel mouth is exactly as you remember it from the print: a black arch in the forest, half a kilometre down the incline, with the cable running into it between the rails. The mist is pouring out of it like breath on a cold morning. It is very quiet. Then, somewhere under your feet, you hear water.
:::

## What is here
A disused tunnel on the Serra Nova incline, a long scramble below the village. Reaching it means walking the track (a **Climb** roll on the steep stretch; a failure costs 1D6 HP from a fall). The mist here is thick in daylight.

## Clues
- **Art/Craft (Photography) (Arthur).** A new photograph of the tunnel, developed that night in the boarding house bathroom, shows the same faces as the old one, and one more: a young man in a railway cap. SAN 0/1D4. Lenita recognises her brother.
- **Spot Hidden.** Footprints on the sleepers, wet with seawater, going in and coming out. A railway cap with a crust of salt inside, with *A. CASTRO* inked on the band.
- **Listen.** Water runs under the rock, downhill, toward [[grota-funda|Grota Funda]].
- **Spot Hidden**, looking back up the hill: the glint of binoculars in the windows of the [[castelinho]].

## Complications
Every hour spent here is a Contact roll, day or night. An investigator who breathes deep on purpose (see [[mist-contact]]) sees the inside of the mountain for a moment: violet light, and something very large, asleep.
]==],
  },
  {
    id = "scene-castelinho", kind = "mixed",
    title = "5. Dinner at the Castelinho",
    summary = "The chief engineer offers a deal; his study holds a century of secrets.",
    body = [==[
::: read
The Castelinho sits above the village like a captain on a bridge. Every one of its thirty-three windows is lit. Inside it is warm for the first time since you arrived: six fireplaces, all burning. The chief engineer meets you at the door himself. He is a tall, tired man of about sixty, polite in the old British way, and he smells faintly of salt.
:::

## What is here
The chief engineer's house (see [[castelinho]]), and **Henrique Ashworth** ([[chief-engineer]]). Dinner is roast beef and boiled potatoes, served by a silent housekeeper. On the wall of the dining room hangs an instrument like a barometer, with a violet crystal needle that points downhill.

## The deal
Ashworth wants the investigators to understand, and then to help. He offers each of them what they came for:
- to **Dudu**, one more year of "ballast water" signed off in his audit, and the truth about his father;
- to **Arthur**, his negative, returned that night;
- to **Lenita**, the place where her brother is.

In return, he asks them to leave on the first train after the festival and say nothing. **Psychology:** he is terrified, and he is telling the truth about the negative and the brother.

## The study
The study is locked (**Locksmith**, or **Stealth** to take the key from the housekeeper's apron). It holds:
- the telegraph log: [[h-telegrams]];
- Bento Arruda's notebook: [[h-notebook]];
- the camp register of 1866: [[h-register]];
- Arthur's confiscated print, with the board's label: [[h-photo]], and the negative in an envelope;
- a geological sketch of a geode, in English, signed by an engineer in 1867.

Reading everything takes an hour and a **Library Use** roll; it costs 1D3 SAN and gives +2% Cthulhu Mythos.

::: keeper
If any investigator is at Contact 7 or more, Ashworth speaks to them in the cult's silent hand-signs during dinner, and they understand. Use it: it is the most frightening thing in the scene.
:::

## Developments
If they accept the deal, Ashworth leads them down to the [[scene-grota|chamber]] himself the next night, to "show them why". If they refuse or are caught in the study, he lets them go, and the cult starts watching the boarding house.
]==],
  },
  {
    id = "scene-landing", kind = "mixed",
    title = "6. The Fourth Landing",
    summary = "A machine house halfway up the mountain, a bin of iron filings, and a culvert that swallows the sea.",
    body = [==[
::: read
The machine house of the Fourth Landing is a brick hall built around a winding drum the size of a carousel. The engine is cold. On the floor, beside it, a wooden bin is heaped with grey iron dust, swept up from the cables. In the corner, a round iron hatch sits in the floor with a valve wheel on it. It is wet around the edges, and it is warm.
:::

## What is here
The fourth of the Serra Nova's five landings (see [[fourth-landing]]). The way in is a long, steep walk up the incline, or a ride on a [[locobreques|locobreque]] if Seu Ditinho can be persuaded to raise steam. Two to four [[cultists]] are here at night, pouring brine and filings through the hatch by hand.

## Clues
- **Mechanical Repair.** The valve opens the **culvert**, a brick tunnel just wide enough to crawl along, sloping down into the rock.
- **Science (Geology).** The rock walls of the culvert turn from grey granite to faint violet the deeper they go.
- **Spot Hidden.** In the store room: a crate of **railway dynamite**, used for clearing rock falls, with fuses and detonators. It matters in [[ending-shatter]].
- **Dudu**, if present: a plate on the winding drum bears his father's name among the fitters who assembled it.

## The culvert
Crawling the culvert to [[grota-funda|Grota Funda]] takes about forty minutes in the dark and the water. Each investigator makes a **CON** roll or loses 1 HP to the cold, and a Contact roll for the tunnels.

::: keeper
If the cultists see the investigators, they do not shout: they sign to one another and come in silence. Two or more together get a bonus die to grapple. They want the intruders in the culvert, not dead.
:::
]==],
  },
  {
    id = "scene-grota", kind = "fiction",
    title = "7. Beneath Grota Funda",
    summary = "The chamber of violet crystal, the Seed at its heart, and the choice.",
    body = [==[
::: read
The culvert opens into a space so large your lamps do not reach its far side. Every surface is crystal: violet, faintly glowing, grown in great ribbed columns from floor to ceiling like the inside of a cathedral made of geode. Pools of seawater have dried to white rings on the floor. In the middle of the chamber, sealed inside a column of crystal, something the size of a child's head pulses slowly with light.

And the mist, which has followed you all the way down, begins to sing.
:::

**SAN 1/1D6** on entering the chamber. Everyone makes a Contact roll at once.

## What is here
The Body of the [[amethyst-heart|Amethyst Heart]], and the **Seed** at its centre. Cultists carry buckets of brine down from the culvert, desperately, while the creature screams in all of their heads. Among them is **Tonico Castro** ([[tonico]]), at Contact 9, who speaks with the creature's voice. If Ashworth is here, he begs the investigators to help keep it asleep.

## What can be done
- **Cut the Seed free:** an hour of work with railway tools and a successful **Science (Geology)** or **Mechanical Repair** roll. The noise draws 1D3 more cultists every fifteen minutes. Touching the Seed costs SAN 1/1D6 and +2 Contact. Then: [[ending-sea]].
- **Shatter it:** the dynamite from the [[scene-landing|Fourth Landing]], set against the column. Lighting it takes one round and a nerve: a POW roll if the lighter is at Contact 5 or more. Then: [[ending-shatter]].
- **Help the cult:** the investigators can carry brine with them. It buys one more year, at the price of their silence, and the Mist Clock goes back to 0. Next winter it starts again.

If the Mist Clock fills before the investigators get here, the scenario ends in [[ending-lost]].

::: keeper
This is the moment the scenario has been building to. Let the players argue. Let Tonico speak to Lenita in a voice that is almost his. Do not rush the choice; the mist is already doing that.
:::
]==],
  },

  ---------------------------------------------------------------- KEEPER CHARACTERS
  {
    id = "cultists", kind = "fiction",
    title = "The Cultists",
    summary = "Foremen, clerks and brakemen by day; brine-carriers in the tunnels by night.",
    body = [==[
The working members of the [[company-of-shadows|Company of Shadows]] are railway people: the yard foreman **Moacir**, the section clerk, a handful of brakemen and their wives. They are not monsters. They have breathed the mist on purpose for years, they hear it every night, and they are terrified of what happens if it wakes.

## How they act
- By day they watch, report to the [[castelinho]] by telegraph, and make sure the investigators see that they are being watched.
- By night they carry brine and filings to the [[fourth-landing]] by hand, and they will not let anyone stop them.
- In a fight they say nothing. They sign to each other with their hands, a language the creature taught them.

@npc:cultist
]==],
  },
  {
    id = "tonico", kind = "fiction",
    title = "Tonico Castro",
    summary = "Lenita's brother, nineteen, a Brine-speaker in the tunnels.",
    body = [==[
Antônio Castro cleaned the [[company-car|company's tank cars]] in Santos until the creature started calling him by name. The cult brought him up the mountain to "help with the festival": in truth, Ashworth hoped a fresh voice would calm it. It did the opposite. Tonico went down the culvert on 16 June ([[h-telegrams]]) and has not come up.

He is at **Contact 9**. When the mist is thick, the creature speaks through him, and it knows everything he knows about his sister.

## Playing him
He is not a villain and not quite a victim. He carries brine with the cultists, hums the creature's song, and speaks of the sea as *home*. When Lenita reaches him, give him a moment of himself: a childhood nickname, a joke, her name said right. Then let the mist take the voice back.

@npc:tonico
]==],
  },
  {
    id = "old-railwayman", kind = "mixed",
    title = "Seu Ditinho",
    summary = "A retired locobreque driver who remembers the car that was never on the timetable.",
    body = [==[
Benedito Ramos drove [[locobreques]] on the Serra Nova for fifty years and has spent the last ten at the biggest bonfire of every festival, talking. Everyone calls him **Seu Ditinho**. He is not in the cult, and he has always suspected it; he keeps his Contact low with salt in his pockets and a stubbornness the whole village respects.

## What he knows
- The machines "pulled heavier going up than the scales said. Always one car more."
- The extra car stopped at the Fourth Landing every night and came back light.
- Eduardo Fonseca's father was a good man, and "what they did to him was a sin".

## What he can do
He can raise steam in a locobreque and drive it, if the investigators can find one that still works, which matters for carrying the Seed down in [[ending-sea]]. He will not go into the tunnels.

::: history
Locobreque nº 14, built in 1902, was the last one fired up, in 1994, and survives at the Museu do Funicular {{museu-funicular}}. Seu Ditinho is fiction; the machine he drove was real.
:::

@npc:ditinho
]==],
  },

  ---------------------------------------------------------------- ENDINGS
  {
    id = "aftermath", kind = "mixed",
    title = "Aftermath and Rewards",
    summary = "Sanity rewards, what Contact leaves behind, and where the story can go next.",
    body = [==[
## Sanity rewards
| Outcome | Reward |
|---|---|
| The Seed reaches the sea ([[ending-sea]]) | +1D10 SAN to each survivor |
| Tonico comes home with Lenita | +1D6 SAN to Lenita |
| The Seed is destroyed ([[ending-shatter]]) | +1D6 SAN to each survivor |
| Dudu learns what happened to his father | +1D4 SAN to Dudu |
| Arthur recovers his negative | +1D4 SAN to Arthur |
| The investigators help the cult | No reward. Each one keeps their Contact, and it never falls below 3 again. |

## What Contact leaves behind
Contact falls by 1 every month spent away from the Serra, but never below 1: every investigator who breathed the mist will hear their name in a fog for the rest of their life. Anyone who ended at 7 or more keeps a craving for salt and still understands the silent signs.

## History moves on
The Serra Nova funicular ran commercially until 1983 {{museu-funicular}}, and Paranapiacaba's Winter Festival opened to the public in 2001 {{festival-origins}}. In the fiction, both dates belong to what the investigators did: see [[winter-festival]].

## Sequel hooks
- **The Santos Tide** (after [[ending-sea]]): shipwrecks off the coast, a maelstrom seen from the beach at night, and a fisherman who says the sea is singing.
- **The Fog That Stayed** (after [[ending-shatter]]): years later, someone tries to drive into a village that the maps say is there.
- **The Next Winter** (if they helped the cult): Ashworth is dead, and the post of chief engineer is offered to Dudu.
]==],
  },

  ---------------------------------------------------------------- APPENDIX
  {
    id = "handouts", kind = "fiction",
    title = "Player Handouts",
    summary = "Letters, logs and records the investigators can find, ready to print or show on screen.",
    body = "@handouts",
  },
}

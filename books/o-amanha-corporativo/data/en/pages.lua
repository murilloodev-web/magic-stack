-- English edition of data/pages.lua. Same markup; links and citations use
-- the same ids. Articles whose body is generated (@timeline, @flow…) only
-- need a title and a summary.

return {
  ["about-book"] = {
    title = "What this book is",
    summary = "A whole world in 2126 and the start of an adventure, for Cyberpunk RED.",
    body = [==[
*The Corporate Tomorrow* is a near-future cyberpunk setting for **Cyberpunk RED**. It takes place in **2126**, a hundred years from now, on a planet divided between the **ESTEMPs** (corporate states), corporations so large they became sovereign countries, and the **REGESTs** (state regimes), what is left of the traditional governments.

The book has two parts:

- **The world** (chapters II to VIII): the [[timeline]] from 2026 to 2126, the [[board|world map]], every ESTEMP and every REGEST, the life of those who work for a corporation, the spoon taboo, the resistance and the rules.
- **The start of an adventure** (chapters IX and X): four pre-generated characters and [[adventure-overview|Audit at Descoberto]], a campaign opening at the reservoir that supplies Brasília. It has no written ending: it stops at two open scenes, so every table can carry on its own way.

## What you need
- The Cyberpunk RED core book, by R. Talsorian Games. Only what changes is here (chapter VIII).
- Three to five players and someone to run the game.
- A taste for stories where nobody wins cleanly.
]==],
  },
  ["tone"] = {
    title = "The tone: grounded cyberpunk",
    summary = "Lethal bureaucracy, scarcity and lost sovereignty, with no magic neon.",
    body = [==[
Here cyberpunk is **grounded**. There is no uploading of minds, no floating cities, no immersive virtual reality. Technology is industrial, bureaucratic, and aimed at two things: maximising profit and controlling people.

Implants exist, but they are expensive, bureaucratic and take a toll on the body. Almost always they **legally belong to the company that paid for them**: the person carries the arm, the company holds the deed (see [[ownership]]).

The danger of this world is not a mystic hacker but a form. Nobody here is killed by a rogue artificial intelligence; people are relocated, blocked, dismissed, and sometimes dismissed seconds before they die (see [[great-dismissal]]).

## Three words for the table
- **Grey.** The world is not dark and shiny: it is grey, the grey of reports and concrete.
- **Scarcity.** Water, medicine, real food and free time are luxuries.
- **Instalments.** Everything was sold off bit by bit: sovereignty, the body, hope.
]==],
  },
  ["how-to-use"] = {
    title = "How to use this book",
    summary = "Where to start reading, what to show the players and how to agree the table's limits.",
    body = [==[
To play soon, read [[tone]], [[board]], [[collaborator]], [[spoon-origin]] and [[antifaca]], then the whole adventure, from the [[adventure-overview|overview]] to [[what-next]]. The rest of the book is reference material.

## What the players can read
Chapters I to IX are common knowledge inside the world: every collaborator knows what the quarantine is, everyone has seen a [[colony-dream|Colony Dream]] ad. The **GM note** boxes and chapter X are for whoever runs the game.

## Agree the limits first
The setting deals with mass murder treated as procedure, forced labour, disposable people and victories that cost innocents (see [[grey-morality]]). Before the first session, talk about what stays off the table and what can only happen off screen. Simple tools, like Lines and Veils or an X-card, cover most cases.

::: gm
The satire works best when nobody at the table laughs at it. The characters in the world take spoonless etiquette, targets and the Colony Dream seriously. Noticing the absurdity is the players' job.
:::
]==],
  },
  ["fact-and-fiction"] = {
    title = "Fact and fiction",
    summary = "The real places and precedents the setting stands on.",
    body = [==[
The future is invented, but the ground under it is real. Every present-day fact used in the book has a numbered citation; the rest is marked *Fiction*.

## What is real
- **Companies have had armies and territory before.** The East India Company kept its own armies and ruled much of the Indian subcontinent {{east-india}}. The ESTEMPs invented nothing.
- **The Afar Triangle lies below sea level.** Lake Assal, in Djibouti, is 155 metres below sea level, the lowest point in Africa {{lake-assal}}. In the fiction, that is what made it possible to [[great-dismissal|sink the region]] by opening a canal.
- **Alcântara is one of the best launch sites in the world**, because it is closer to the equator than any other {{alcantara}}. In the fiction, it is the prize of the [[first-corporate-war]].
- **The Descoberto reservoir has nearly run dry before.** The Federal District lived through about a year and a half of water rationing in 2017 and 2018 {{df-rationing}}, with the Descoberto at its lowest level on record {{descoberto-record}}. The adventure starts from there.
- **The Ogallala Aquifer is being drained** by irrigation since the middle of the 20th century {{ogallala}}. **Jakarta is sinking**, and Indonesia decided to move its capital {{jakarta}}. **France has a nearly empty inland band** {{empty-diagonal}}. These places became REGESTs (see [[regests]]).
- **Asteroid mining** has been studied for decades as a source of metals outside the Earth {{asteroid-mining}}.

## What is invented
Everything that happens after 2026: the corporations, the wars, the people, the spoon. No real company or person is described here.
]==],
  },
  ["timeline"] = { title = "Timeline", summary = "From a 17th-century precedent to the campaign's present, in 2126." },
  ["first-asteroid"] = {
    title = "The First Asteroid",
    summary = "2046: the first wealth no government controlled.",
    body = [==[
In 2046, **[[omniterra|OmniTerra]]** robots launched from Alcântara brought a metallic asteroid into Earth orbit and began mining it at a profit. Nobody lived in space, and nobody does to this day; but for the first time a company had a source of wealth beyond the reach of any government. The idea was old {{asteroid-mining}}; what changed was who paid for it.

## The Inversion
Over the next twenty years, companies with space operations came to hold more cash than the countries that hosted them. First they financed governments, then they bought their debt, then they bought the governments. Corporate historians call the period the **Inversion**; the REGESTs call it the **Pawning**.

## Why the Earth still matters
Space has metal, but it has no people. Living up there is still expensive and hard. Refineries, launch sites, water, food and above all labour are still down here. That is why corporations still fight over territory, and why the [[colony-dream|Colony Dream]] is such a useful promise.
]==],
  },
  ["first-corporate-war"] = {
    title = "The First Corporate War",
    summary = "2068–2074: a spat over espionage that ended with all of Brazil sold.",
    body = [==[
The first war between companies had no ideology. It started with a theft and escalated one retaliation at a time.

## How it started
1. **The espionage.** **Halcyon Orbital**, the second miner to reach the asteroids, got there too fast. In 2068 OmniTerra found out it had stolen the orbital capture system used on the [[first-asteroid|First Asteroid]].
2. **The sanction.** OmniTerra announced: *whoever works with Halcyon does not work with me*. Suppliers, banks and clients had to pick a side, and the market split into two blocs. That split is the first sketch of a world divided into ESTEMPs.
3. **The sabotage.** Diverted cargo, downed systems, accidents on building sites.
4. **The advance.** Mining space means launching rockets, and the best places to do it are near the equator {{alcantara}}. Halcyon secretly bought land around **Alcântara**, in Maranhão, and sabotaged OmniTerra launches.
5. **The escalation.** When that came out, the two companies' private security forces clashed in northern Brazil. Each answer was bigger than the last.

## How it ended
In 2074 Halcyon went bust, and OmniTerra bought the wreckage, Alcântara included. Brazil, in debt and too weak to refuse, became OmniTerra territory. Only the Federal District was left out, because it had nothing anyone wanted (see [[brasilia]]).

[[kuro-tech|Kuro-Tech]] sold weapons to both sides throughout the war. The "pacification weapons" it is known for were born there.

## What the war left behind
- The **[[quarantine|Corporate Quarantine]]**: after the war, hiring someone from the other side meant importing a spy.
- The idea that a company can have an army, a border and an enemy, like a country.
]==],
  },
  ["corruption-gold-rush"] = {
    title = "The Corruption Gold Rush",
    summary = "2080–2100: when the civil service sold whatever was left.",
    body = [==[
When it became clear that the states were going to shrink, the people working in them did the maths. Between 2080 and 2100, ministers, judges, inspectors and directors of state companies used the chaos to sell deals, licences, land and data to the corporations, and earned a place inside them in return.

Many of today's senior executives descend from those officials. That is why the bureaucracy of the ESTEMPs looks like a government office: it was built by people who came from one.

## What it left behind
- **The REGESTs got the worst.** Whatever made a profit was sold; what was left is what nobody wanted to buy (see [[regests]]).
- **Corruption became company culture.** In the ESTEMPs, rules apply to everyone except those important enough (see [[pyramid]]).
- **Forgotten files.** Contracts from that era, like the one that gives Brasília its water (see [[brasilia]]), are still in force because nobody bothered to cancel them.
]==],
  },
  ["great-dismissal"] = {
    title = "The Great Dismissal of the Djibouti Triangle",
    summary = "2111: the century's greatest trauma, with the name of a procedure.",
    body = [==[
The Afar Triangle, at the mouth of the Red Sea, is one of the lowest regions on the planet: Lake Assal lies 155 metres below sea level {{lake-assal}}. Next to it runs the Bab-el-Mandeb strait, one of the most important shipping lanes in the world {{bab-el-mandeb}}. In 2111, the two met.

## The trigger
The region was home to [[great-rift|Great Rift Holdings]] collaborators, with ports run by [[thalassa|Thalassa Corp]]. After a structural collapse in the ports, Thalassa calculated that it was cheaper to **sink the region** than to rebuild it. It opened a canal and let the sea into the depression. The sums had an extra benefit: flooded land becomes sea, and the sea is Thalassa's.

## The cascade
To protect their own markets from the crisis, the two neighbours responded. [[petro-vanguard|Petro-Vanguard]] poisoned the coast across the strait; Great Rift levelled and poisoned the inland side. Millions of people died, recorded as "acceptable collateral damage".

## The name
Seconds before the flood, every resident received a termination notice. Technically they were **dismissed** before they died, so no ESTEMP answers for homicide. The flooded region appears on corporate maps as the **Gulf of the Dismissal**.

::: gm
Proof of what happened at Djibouti (the spreadsheets that compared the cost of rebuilding with the cost of sinking) is the biggest prize the [[antifaca|AntiFaCa]] could win. It is the kind of thing a star executive carries around in their head (see [[hooks]]).
:::
]==],
  },
  ["board"] = {
    title = "The world map",
    summary = "The board in 2126: who owns each piece, and how many army pieces they have.",
    body = [==[
@board

Five conglomerates rule the planet and work like shareholder monarchies. Around them, lesser corporate states fill the leftover space. The whole sea belongs to a single company.

@estemps

The pieces on the map are a joke with a point: they show, roughly, how much private security each ESTEMP keeps on its territory. Borders between ESTEMPs are not open wars; they are trade treaties, tolls, quarantines and, now and then, an act of sabotage.
]==],
  },
  ["omniterra"] = {
    title = "OmniTerra",
    summary = "The Americas: logistics, extraction, synthetic farming and space.",
    body = [==[
**Territory:** the Americas, from Alaska to Tierra del Fuego, plus Greenland. **Headquarters:** Chicago. **Space base:** Alcântara.

OmniTerra is the largest company in the world and the first to become a country. It moves cargo, tears out ore, grows synthetic food on a continental scale and, since the [[first-asteroid|First Asteroid]], mines space.

## What living there is like
It is famous for how rigidly it [[relocation|relocates]] labour: nobody has a fixed career, and an accountant can wake up as a harvester operator three thousand kilometres from home. In exchange, its propaganda is the most upbeat on the planet.

## Its sin
It started the [[first-corporate-war]] and lies about the colonies. Its slogan, *Work for the Colony Dream*, promises a paradise in space that does not exist and never will (see [[colony-dream]]).

::: ad
OmniTerra. From here, to the stars. Together.
:::
]==],
  },
  ["kuro-tech"] = {
    title = "Kuro-Tech",
    summary = "Asia-Pacific: cables, chips, utilitarian biotech and pacification weapons.",
    body = [==[
**Territory:** East Asia, Southeast Asia and Oceania. **Headquarters:** Osaka.

Kuro-Tech makes the floor of technology: cables, chips, industrial implants, practical biotech. Nothing is pretty; everything works. It also makes **internal pacification weapons**: batons, containment ammunition, gas, riot vehicles.

## Security as a service
Kuro-Tech hires out security to other corporations. An ESTEMP that does not want to keep troops hires a Kuro-Tech unit by the quarter, in grey uniforms with the black logo on the shoulder. They appear in [[adventure-overview|Audit at Descoberto]].

## Its sin
It sold weapons to both sides of the [[first-corporate-war]] and profited from every death. To this day, every war between companies is a good quarter for Kuro-Tech.
]==],
  },
  ["aegis-med"] = {
    title = "Aegis-Med",
    summary = "Europe and Mediterranean Africa: medicine, life insurance and the illusion of wellbeing.",
    body = [==[
**Territory:** Europe and the Mediterranean coast of Africa. **Headquarters:** Basel.

Aegis-Med is a pharmaceutical and insurance empire. It sells the feeling of being looked after: corporate health plans, mood apps, wellness campaigns and, for those who can pay, longevity.

## Its sin: Tolerin
Nearly every implant in the world needs an anti-rejection drug so the body does not attack it. Aegis-Med holds the patent on the most used one, **Tolerin**, and sells it to every other corporation. The price is calibrated to fit a collaborator's salary. Whoever is dismissed loses their health plan, and with it their Tolerin (see [[ownership]]).

::: ad
Aegis-Med. Because you deserve to feel good. Terms of your plan apply.
:::
]==],
  },
  ["petro-vanguard"] = {
    title = "Petro-Vanguard",
    summary = "Middle East and Central Asia: synthetic fuels and crisis containment.",
    body = [==[
**Territory:** the Middle East, Anatolia, the Caucasus and Central Asia. **Headquarters:** Doha.

Petro-Vanguard controls the synthetic fuels that still drive ships, planes and rockets. It pioneered the harshest **crisis containment** policies: when something goes wrong in a territory, it isolates, fences and waits.

## Its sin
It took part in the [[great-dismissal|Great Dismissal]] by poisoning the Arabian coast of the Bab-el-Mandeb strait. Its containment manuals are still used by other ESTEMPs.
]==],
  },
  ["thalassa"] = {
    title = "Thalassa Corp",
    summary = "The oceans: shipping lanes, automated fishing and desalination. Every new inch of sea is hers.",
    body = [==[
**Territory:** every international water on the planet. **Headquarters:** a platform in the North Atlantic that moves around.

Thalassa owns the shipping lanes, the automated fishing platforms and the desalination plants. In a thirsty world, that makes it the water supplier for half of the planet's coasts.

## The law of the sea
Under corporate law, salt water belongs to Thalassa. When the sea rises, its territory grows. Its red pieces sit in every ocean on the [[board|map]].

## Its sin
It sank the Djibouti Triangle in 2111 (see [[great-dismissal]]). In the Netherlands, the polders left to the Dutch REGEST live in fear of being next.
]==],
  },
  ["severa"] = {
    title = "Severa Combine",
    summary = "Russia and the Arctic: the thaw as a business.",
    body = [==[
**Territory:** Russia and the Arctic coast. **Headquarters:** Murmansk.

Severa lives off the thaw: Arctic sea lanes opening up, ores the permafrost used to hide, gas. It is locked in a legal question with [[thalassa|Thalassa]] that has no answer: **is melting ice land or sea?**

## Its sin
It works dismissed people in quarantine in its northern mines, on contracts they sign because nowhere else will take them.
]==],
  },
  ["monsoon"] = {
    title = "Monsoon Workforce Solutions",
    summary = "South Asia: the largest legal market for renting people.",
    body = [==[
**Territory:** the Indian subcontinent. **Headquarters:** Mumbai.

Monsoon makes nothing: it **rents out collaborators**. Call-centre shifts, accounting, data triage, nursing, construction: any ESTEMP can hire a batch of Monsoon workers by the quarter.

## The loophole
The [[quarantine]] stops a dismissed worker from being hired by another corporation. But a worker leased out by Monsoon is never hired by anyone: they stay Monsoon's. It is the most used loophole in the world, and Monsoon charges for it.
]==],
  },
  ["great-rift"] = {
    title = "Great Rift Holdings",
    summary = "East, Central and Southern Africa: geothermal power, cobalt and lithium.",
    body = [==[
**Territory:** from the Horn of Africa to the Cape, including the Congo basin. **Headquarters:** Nairobi.

Great Rift sells geothermal energy from the Rift Valley and the ores in the world's batteries: cobalt, lithium, copper.

## Its sin
In the [[great-dismissal|Great Dismissal]], it levelled and poisoned the inland side of the Afar Triangle to contain the crisis. The residents were its own collaborators.
]==],
  },
  ["sahel-solar"] = {
    title = "Sahel Solar Trust",
    summary = "West Africa and the Sahara: sunlight sold by cable to Europe.",
    body = [==[
**Territory:** the Sahara and West Africa. **Headquarters:** Dakar.

Sahel Solar covers the desert in panels and sells the power through undersea cables to [[aegis-med|Aegis-Med]]. It is the youngest ESTEMP and the fastest-growing.

## Its sin
The panels need water to be cleaned, and the Sahel has little. Whole wells have been fenced off, and herding routes that are centuries old now end at a fence with the sun logo.
]==],
  },
  ["regests"] = {
    title = "The twenty REGESTs",
    summary = "What is left of each of the twenty largest countries, and why.",
    body = [==[
The REGESTs are the remains of the democratic governments. They survive by pawning what is left of their sovereignty to the corporations. They offer a precarious "economic and personal freedom", amid poverty, missing infrastructure and failed public security.

## The rule
**A REGEST keeps whatever no corporation wanted to buy.** There is no fixed shape: each country kept the part of itself that made no profit. For the twenty largest countries of 2026, this is what happened:

@regests

Some of these places are already in trouble today: the Ogallala Aquifer is being drained by irrigation {{ogallala}}, Jakarta is sinking {{jakarta}} and France has a nearly empty inland band {{empty-diagonal}}. The setting just let the trend continue.

## Why they still exist
Because it is useful that they do. A REGEST is where the dismissed go, the market where corporations sell their leftovers, and the proof that the alternative to the companies is worse.
]==],
  },
  ["brasilia"] = {
    title = "The Brasília REGEST",
    summary = "A capital without a country, depending on the water of a reservoir that is no longer its own.",
    body = [==[
Of Brazil, the **Federal District** is what is left. When OmniTerra bought the country after the [[first-corporate-war]], the DF was left out: a seat of government, far from the coast, with no port and no heavy industry. Nobody wanted to buy it.

Brasília still has ministries, a Congress, embassies from other REGESTs and four million people. It also has a problem: **water**.

## The Sale of the Strip
The Federal District has always depended on the Descoberto reservoir, on the border with Goiás. Back in 2017 and 2018 it nearly ran dry, and the city spent about a year and a half under rationing {{df-rationing}} {{descoberto-record}}. In 2097, in debt, the REGEST sold the reservoir strip to OmniTerra. In return it got the **Humanitarian Contract of 2097**, which guarantees Brasília a water quota through the Old Main.

The quota shrank at every renewal. Today most of the Descoberto goes to the **Planalto Core**, an OmniTerra data centre that processes telemetry from the space-mining fleet. The city lives under permanent rationing.

## Brasília in 2126
- The Plano Piloto still stands, with cracked public buildings and dry lawns.
- The towns around it (Taguatinga, Ceilândia, Samambaia) live off water trucks.
- Post 4, on the border with OmniTerra, is the busiest border in the Centre-West.

Brasília is the setting of the opening adventure, [[adventure-overview|Audit at Descoberto]].
]==],
  },
  ["regest-life"] = {
    title = "Life in a REGEST",
    summary = "Freedom, poverty and the trade only nomads will do.",
    body = [==[
In a REGEST nobody is relocated or dismissed, because almost nobody is hired. There are elections, a press that may criticise a corporation, churches, unions and spoons in the drawers. There is no running water every day, no medicine, no jobs and no police who come when called.

## What goes in and what comes out
The laws of the ESTEMPs do not protect those outside them. So carrying cargo into a REGEST is risky, and those who do it charge a lot. The [[nomads]] run that trade.

## Who lives there
- **Those who always did.** Families who never worked for a corporation.
- **The dismissed.** Blocked by the [[quarantine]], this is where they come.
- **Those who came back.** People who left an ESTEMP on purpose. They are few, and the corporations love to show them on the news, thin and regretful.
]==],
  },
  ["collaborator"] = {
    title = "Goodbye, patriots",
    summary = "Inside an ESTEMP, nobody fights for a flag: they fight for a target.",
    body = [==[
Inside an ESTEMP, citizens are not citizens: they are **collaborators**. They do not fight for flags but for targets. They receive propaganda 24 hours a day asking for total engagement with the brand that pays for their living.

## An ordinary day
- Wake up in company housing, the day's target panel already lit on the wall.
- Coffee from a suction sachet, because spoons are not a good look (see [[spoonless-etiquette]]).
- Shift. Compulsory break for the motivational video.
- Shift.
- At night, the team scoreboard, the relocation notifications and the [[colony-dream|Colony Dream]] campaign.

## The chip
Every collaborator has a **Corporate Biometric Chip** implanted when hired. It opens doors, pays bills, clocks hours and serves as a passport. When the person is dismissed, the chip is blocked, and so is their whole life (see [[quarantine]] and [[implants]]).
]==],
  },
  ["relocation"] = {
    title = "Flexible Relocation",
    summary = "Neo-feudalism: you do not have a career, you are an allocatable resource.",
    body = [==[
There are no fixed careers. You are an **allocatable resource**. If the footwear sector stalls, tomorrow the advertising copywriter may be cleaning sewer ducts, in another city, in another dormitory.

Refusing relocation means summary dismissal.

## How it works
- The notice arrives through the chip, with a 72-hour deadline.
- The family may or may not come along, depending on the role's "mobility package".
- Work history does not count. Relocation follows the company's needs that quarter.

::: gm
Relocation is the most common way for a corporation to get rid of someone without dismissing them. An awkward collaborator can be sent to a [[severa|Severa]] mine in the Arctic without anyone having to sign anything ugly.
:::
]==],
  },
  ["quarantine"] = {
    title = "The Corporate Quarantine",
    summary = "Dismissed, you spend ten years unable to work for anyone.",
    body = [==[
Officially it is called the **Human Capital Lockout Law**. When a collaborator is dismissed, their biometric and tax record is blocked, and they are barred from being hired by any other megacorporation for at least **ten years**. The stated aim is to prevent industrial espionage.

## Whose law?
There is no signed treaty. The quarantine was born as an OmniTerra contract clause right after the [[first-corporate-war]], when hiring someone from the other side came to mean importing a spy. The other companies copied it. Today it is **market practice**: some companies apply it for longer, others for less, but all of them apply it, and those who do not are frowned upon.

## In practice
The dismissed become pariahs. Without a chip they cannot open a door, pay a bill or buy medicine. They are pushed into the poverty of the [[regest-life|REGESTs]] or into nomad life. The only legal ways out are the [[monsoon|Monsoon]] loophole and the Severa mines.
]==],
  },
  ["pyramid"] = {
    title = "The pyramid",
    summary = "Nobody escapes relocation, unless they are important enough.",
    body = [==[
In theory, the rules apply to everyone. In practice, the higher the post, the more privileges, and corporate society is corrupt to the bone. A director can be on the relocation list and simply not go.

| Layer | Who they are | What they get |
|---|---|---|
| Shareholders | the families in charge | sovereignty |
| Star executives | the faces of the brand | de facto immunity |
| Management | those who apply the rules | exceptions to the rules |
| Collaborators | almost everyone | targets and housing |
| Contractors | leased from Monsoon or Kuro-Tech | one contract a quarter |
| The dismissed | those who fell | the [[quarantine]] |

The **star executives** deserve a note: executives treated as celebrities, with fans, campaigns and scandals. Kidnapping one is one of the AntiFaCa's classic [[hooks]].
]==],
  },
  ["colony-dream"] = {
    title = "The Colony Dream",
    summary = "OmniTerra's signature propaganda: a paradise in space that does not exist.",
    body = [==[
Today, space is only for mining. Nobody lives there, and the colonies do not exist. Even so, since 2120 [[omniterra|OmniTerra]] has been repeating one campaign:

::: ad
**Work for the Colony Dream.** If everyone cooperates, one day we will all leave this place. Together, for somewhere better.
:::

The campaign works because it is **collective and vague**. Nobody wins an individual place, there is never a date, and any complaint becomes "you are holding everyone back". It pairs with the spoon campaign: one mocks those who disagree, the other promises paradise to those who obey.

It is a lie. There is no colony project under way, and no budget for one. OmniTerra knows; most collaborators suspect; almost nobody says it out loud.
]==],
  },
  ["spoon-origin"] = {
    title = "How the nickname was born",
    summary = "The media mocked it, the resistance adopted it, society made it taboo.",
    body = [==[
The resistance is called the **AntiFaCa**, short for Anti-Fasci-Capitalists (in Portuguese, *faca* means knife). The corporate media saw a ready-made joke: if they are against the knife, they are spoons. Harmless, childish, useless next to the corporations' sharp knives.

## The cycle
1. **The mockery.** Cartoons, commercials and comedy shows started calling the rebels "spoons".
2. **The adoption.** The resistance embraced the word. A spoon is easy to own, easy to show and easy to recognise in any kitchen in the world. Codes appeared: "asking for soup" means asking whether someone is in the resistance.
3. **The campaign.** The press offices doubled down. In commercials, street holo-videos and internal networks, the spoon came to mean weakness, mental stagnation and subversion.
4. **The taboo.** People who are not in the war began avoiding spoons so as not to look sympathetic to the resistance. Nobody banned them by law; people gave up the spoon of their own free will.

::: ad
Whoever uses a spoon is accepting the cold soup of state failure. Whoever uses a knife cuts their own path to success.
:::

"Soup-eater" became an insult among executives and the corporate middle class, aimed at any employee with low output or reformist ideas.
]==],
  },
  ["spoonless-etiquette"] = {
    title = "The Cutlery Revolution",
    summary = "Soup bars, cream in sachets and cutlery with a laser-etched logo.",
    body = [==[
To prove their loyalty to the [[capi-fascists|Capi-Fascists]] and avoid being investigated for sympathy with the resistance, the upper middle class created a new etiquette with no utensil that looks like a spoon.

## The food
The food industry reformulated everything that called for a spoon. Soups and broths became **solid bars**; creamy desserts became **quick-suction sachets** or **chewable capsules**. In the upper ranks, soup is drunk through a straw.

## The cutlery
Precision knives and forks, modular, with the company logo laser-etched on them, became compulsory fashion accessories. Each ESTEMP's "patented multifunction cutlery" avoids any concave surface.

## The business dinner
Business dinners became loyalty rituals. Guests compete over who has the most expensive, sharpest and most high-tech cutlery, showing off their "love of the corporate cut". The adventure has one such dinner: [[scene-dinner]].
]==],
  },
  ["moral-panic"] = {
    title = "The moral panic",
    summary = "Nobody was banned. Everybody was convinced.",
    body = [==[
The most frightening thing about the spoonless culture is not a ban, because there is no ban. It is that people were **convinced** to give up the spoon, and are proud of it.

People look at any concave object with fear and disgust. If someone finds an old spoon forgotten at the back of a drawer in a corporate residential zone, the reflex is not to keep it but to **report it to company security** for "advocating subversive terrorism".

## A crime or not?
The law says nothing about spoons. But each company's security can file the holder under "conduct incompatible with corporate culture", and that is enough for an investigation, a relocation or a dismissal. It is a grey zone, and the grey zone is the tool.

## The portrait
Citizens highly educated to produce profit and completely infantilised, unable to see that they changed their eating habits and their own dignity over a meme invented by a press office. They turned a kitchen utensil into an ideological battlefield and feel proud of their own submission.
]==],
  },
  ["capi-fascists"] = {
    title = "The Capi-Fascists",
    summary = "The upper middle class that swapped nationalism for love of the brand.",
    body = [==[
The **Capi-Fascists** are the corporate upper middle class that developed a blind, fervent love for the company that pays them. They swapped nationalist fascism for brand corporatism: the logo in place of the flag, the jingle in place of the anthem.

They are the ones who report spoons, who cry at annual conventions and who tattoo their staff number. They are not comic-book villains: they are neighbours, bosses and relatives. Many player characters will have a Capi-Fascist in the family.

::: gm
A Capi-Fascist is almost never an enemy in combat. They are the person who sees too much and calls company security. Use them as pressure, not as a target.
:::
]==],
  },
  ["antifaca"] = {
    title = "The AntiFaCa",
    summary = "A network of cells with no centre, which knows it will not bring the system down.",
    body = [==[
The AntiFaCa (Anti-Fasci-Capitalists) has no headquarters, no leader and no single programme. It is a network of **cells** that recognise each other by codes and cooperate when it suits them. Its symbol is the spoon; its password is "asking for soup".

## What it wants
Not to bring the global system down at once, which is impossible. The AntiFaCa attacks the flanks: it exposes rot, tears resources from the corporations and passes them to the REGESTs, and sets off domino effects.

## How it is organised
- **Nomad cells**, living in the cracks of the world (see [[nomads]]).
- **Infiltrated cells**, living inside the ESTEMPs (see [[infiltration]]).
- **Contacts in the REGESTs**: hospitals, unions, newspapers and churches that receive what the network manages to get out.

## The disagreements
Not every cell agrees with the others. Some accept killing innocents for a big win and some refuse; some want to bargain with one ESTEMP against another. These internal fights are a good source of stories.
]==],
  },
  ["nomads"] = {
    title = "The nomads",
    summary = "Freight to where the law protects nobody.",
    body = [==[
Nomad rebels live off **freight and commercial transport to the REGESTs**. Since the laws of the ESTEMPs do not protect those outside them, taking cargo into a REGEST is dangerous, and those who do it have a valuable commodity: the willingness to go.

Convoys carry medicine, parts, food, water, people and, hidden in between, whatever the resistance needs to move. Many nomads are dismissed people in quarantine; others never had a chip.

In the opening adventure, [[lia]] drives the water truck that crosses Post 4 between the station and Brasília.
]==],
  },
  ["infiltration"] = {
    title = "Deep infiltration",
    summary = "The most dangerous cells are inside the companies, and live in fear of the auditor.",
    body = [==[
The resistance's most dangerous cells do not hide in caves: they are inside the ESTEMPs themselves. Whole subdivisions, like an isolated water treatment plant, can be staffed entirely by infiltrators.

They live under the constant strain of being found out. The worst enemy of an infiltrated cell is not a soldier: it is an **auditor**, someone who checks spreadsheets, counts parts and asks polite questions.

That is exactly the situation of the opening adventure: [[adventure-overview|Audit at Descoberto]].
]==],
  },
  ["grey-morality"] = {
    title = "Grey morality",
    summary = "Victories are never clean.",
    body = [==[
To force a megacorporation to give a vital resource (say, the clean water of a data centre) to a REGEST without triggering open war, the characters will need heavy blackmail, lies, calculated sabotage and, sometimes, sacrificing innocents or betraying allies.

The setting does not ask the players to do this. It asks that the choice exists and weighs. An AntiFaCa victory nearly always costs something to someone who did not ask to be in the story.

::: gm
When a hard choice comes up, show who pays the price, with a name and a face. An abstract consequence ("output falls 3%") weighs nothing; a whole shift of collaborators relocated to the Arctic does.
:::
]==],
  },
  ["hooks"] = {
    title = "Campaign hooks",
    summary = "Three ways to start a campaign, besides this book's adventure.",
    body = [==[
## The Collective Screw-It
Every employee of a subdivision is unfairly dismissed at once. Barred by the [[quarantine]] from working anywhere else, they have nothing left to lose and decide to set fire to the system that threw them out.

## The Commissioned Kidnapping
A cell has to capture a star executive to extract passwords or proof about [[great-dismissal|Djibouti]]. The executive has fans, [[kuro-tech|Kuro-Tech]] guards and a memory implant that may be the proof, or the trap.

## The Rescued Escape
The characters survived a failed attempt to flee an ESTEMP and were taken in by a nomad cell. Now they owe a favour, and do not know to whom.

## Audit at Descoberto
This book's adventure: [[adventure-overview]].
]==],
  },
  ["grounded-rules"] = {
    title = "What changes in the rules",
    summary = "Cyberpunk RED with no immersive net and no outlandish chrome.",
    body = [==[
Use the Cyberpunk RED rules as they are, with these changes.

::: rule
**No immersive NET.** There are no NET Architectures, cyberdecks or attack programs. Digital systems exist, but can only be broken into with physical access to a terminal or a cable, using Electronics/Security Tech. The Netrunner role is replaced by the [[roles|Systems Operator]].
:::

::: rule
**Catalogue implants.** Only the implants in the [[implants|grounded catalogue]] exist. Each one's Humanity Loss is **fixed** (not rolled), so that sheets can be checked.
:::

::: rule
**Every implant has an owner.** Each implant has a titleholder, nearly always the company that paid for it. See [[ownership]] for the Asset Trace, Repossession and Tolerin.
:::

::: rule
**Character creation.** Use the Complete Package: 62 stat points, 2 to 8 each, and 86 skill points, with levels from 1 to 6 at creation.
:::

## Money
Money is the **corporate credit** (¢), issued by the ESTEMPs and accepted, at a discount, in the REGESTs. Use the Cyberpunk RED prices as if they were credits.
]==],
  },
  ["roles"] = {
    title = "The roles",
    summary = "The Cyberpunk RED roles in this world, and the three that change name.",
    body = [==[
| Role | In this world |
|---|---|
| Solo | Contract security, corporate-war veteran, bodyguard |
| Tech | Industrial maintenance, sluice operator, convoy mechanic |
| Medtech | Health-plan nurse, dismissed paramedic, Tolerin smuggler |
| Media | REGEST journalist, repentant propaganda writer |
| Exec | Subdivision manager, auditor, falling star executive |
| Fixer | Border broker, seller of cloned chips |
| Nomad | Convoy driver for the REGESTs |
| **Corporate Security** (was Lawman) | The company watchman who reports spoons |
| **Agitator** (was Rockerboy) | Whoever makes the counter-propaganda: graffiti artist, musician, street preacher |
| **Systems Operator** (was Netrunner) | Whoever breaks into systems with their hands on the terminal |

::: rule
**Systems Operator.** Uses the Tech rules for the Role Ability, but applied to digital systems: with physical access, they can read records, wipe trails and open doors. Without physical access, they can do nothing.
:::

::: rule
**Agitator.** Uses the Rockerboy Role Ability, swapping the gig for the campaign: a painted wall, a pirate radio, a street sermon.
:::
]==],
  },
  ["implants"] = {
    title = "The grounded catalogue",
    summary = "The implants that exist in 2126, with fixed Humanity Loss.",
    body = [==[
These are the implants that exist. There are no retractable blades, cinema-camera eyes or superhuman reflexes: the technology is industrial and serves work.

@implants

## Humanity
Humanity starts at **EMP × 10** and loses the fixed value of each implant. Current EMP is Humanity divided by 10, rounded down. The build checks this sum on every sheet in the book.
]==],
  },
  ["ownership"] = {
    title = "The implant is yours, the title is the company's",
    summary = "Asset Trace, Repossession and Tolerin: the price of having chrome.",
    body = [==[
Nearly every implant is financed by the employer, and the contract says it remains **company property** while there is a balance owed. The balance never runs out.

::: rule
**Asset Trace.** Every implant with a corporate titleholder broadcasts its asset number to the readers at gates and border posts. Masking the signal for a scene takes an Electronics/Security Tech check against DV 15. Failing flags the person as an "asset out of place".
:::

::: rule
**Repossession.** When someone is dismissed, the company may repossess the implants that are its property. In practice this almost never happens in a clinic: it happens when the person is found. A dismissed character with corporate chrome is, to all intents, a lost asset.
:::

::: rule
**Tolerin.** Implants marked in the catalogue need one dose of Tolerin a week, sold by [[aegis-med|Aegis-Med]] through corporate health plans. Without it, the implant gives −2 to every action that depends on it, and after a month it stops working. On the black market, a dose costs 100¢ and may be fake.
:::

## Roadside clinics
In the REGESTs there are clinics that remove chips, change asset numbers and fit implants repossessed from other people. Nobody asks where the arm came from.
]==],
  },
  ["characters-intro"] = {
    title = "The Ladle Cell",
    summary = "The four pre-generated characters and the cell they belong to.",
    body = [==[
The **Ladle Cell** (*Célula Concha*) is the [[antifaca|AntiFaCa]] cell that took over the Descoberto-7 Station without firing a shot. Over three years, supervisor Zuleide Batista replaced, one vacancy at a time, all 41 of the station's employees with resistance members. Since then, the station has secretly sent Brasília more water than the contract allows.

The pre-generated characters are four members of the cell:

| Character | Role | At the station |
|---|---|---|
| [[marta]] | Tech | The sluice operator, with an arm that belongs to the company |
| [[davi]] | Medtech | The nurse, who lives on a cloned chip |
| [[rui]] | Solo | The head of the watch, who saw Djibouti |
| [[lia]] | Nomad | The water-truck driver who crosses the border |

## Using your own characters
Any character works, as long as they belong to the cell or work with it. A good start is to ask each player: what does the company have of yours (an arm, a name, a family) that it can take back?
]==],
  },
  ["adventure-overview"] = {
    title = "Overview for the GM",
    summary = "What is really happening at the Descoberto-7 Station.",
    body = [==[
The **Descoberto-7 Station** treats water from Lake Descoberto, on the border between OmniTerra territory and the [[brasilia|Brasília REGEST]]. The reservoir is real and has nearly run dry once {{descoberto-record}}; the station, the village and the data centre are fiction.

@localmap

## The situation
- **92%** of the treated water goes through the Planalto Main to the **Planalto Core**, OmniTerra's data centre.
- **6%** goes to Brasília through the Old Main, as the Humanitarian Contract of 2097 requires.
- For three years, the [[characters-intro|Ladle Cell]] has been tampering with **Meter 14** and sending an extra **9%** to Brasília. In the city, that water goes to the hospitals.

## What the auditor came to do
Auditor [[adventure-npcs|Celeste Prado-Vasconcelos]] did not come for the fraud. She came to **prepare the end of the contract**: in 30 days the Old Main will be shut for the Planalto II Expansion, and the station's staff will be relocated to Alcântara, or dismissed. The audit is the inventory of everything the company is going to move: pipes, pumps, people and implants.

The problem is that, if she looks closely, she will find Meter 14.

::: rule
**Suspicion (0 to 6).** The GM tracks the auditor's Suspicion during the visit. Each mistake by the characters (a record that does not match, a spoon in sight, a nervous answer) adds 1; a serious mistake adds 2. At 3, Celeste asks to see Meter 14 in person. At 6, she calls security and orders the station sealed.
:::

## How the adventure ends
It does not. The scenes [[scene-news]] and [[scene-valve]] are left **open**. [[what-next]] lists paths for the table to follow.
]==],
  },
  ["scenario-flow"] = { title = "Adventure flow", summary = "The scenes, the loose order between them and the two that stay open." },
  ["scene-night-shift"] = {
    title = "1. The Night Shift",
    summary = "Two messages on the same night: the hospital is out of water and the audit arrives at eight.",
    body = [==[
::: read
It is three in the morning at the Descoberto-7 Station. The lake outside has no light at all; the only thing lit is the target panel on the control-room wall, showing 104% in green tonight. The coffee is gone. Somewhere in the pipework, the Old Main makes its usual noise, like someone taking a deep breath.
:::

The characters are on the night shift. Two messages arrive half an hour apart.

## The first: the notice
A notice from OmniTerra arrives on the supervisor's terminal: a **Routine Water Asset Audit** at 08:00 (see [[aviso-auditoria]]). It does not say who is coming or why.

## The second: the hospital
[[lia|Lia]] gets a coded message on the truck radio from the Hospital de Base in Brasília: the hospital's water tanks hold one day of reserve (see [[mensagem-hospital]]).

## What to do
The characters can wake the supervisor, [[adventure-npcs|Zuleide Batista]], who will call the cell together to prepare the station. And they have to decide: do they send the extra water to the hospital today, with the audit arriving, or wait?

::: gm
If they send the water today, Meter 14 will show a bigger discrepancy in the morning log: start the audit at Suspicion 1. If they do not, the hospital collapses by the end of the day, and Lia will know.
:::
]==],
  },
  ["scene-cleanup"] = {
    title = "2. The Clean-Up",
    summary = "Five hours to hide three years of resistance.",
    body = [==[
Zuleide gathers the cell in the canteen and hands out tasks. They have five hours to make the station look like an ordinary station.

| Task | Check | On a failure |
|---|---|---|
| Collect the spoons from every dormitory and the kitchen | Perception DV 13 | A spoon is left somewhere: Suspicion +1 when it is found |
| Adjust Meter 14's records for the last 90 days | Bureaucracy DV 15 | The records do not match the lake's flow |
| Rehearse the answers with all 41 employees | Persuasion DV 13 | Someone will stammer in the interview |
| Wipe the messages from Lia's radio | Electronics/Security Tech DV 13 | The hospital message is still there |

::: read
Dona Zuleide opens the kitchen cupboard and takes out, one by one, forty-one steel spoons. She puts them all in a bin bag, ties a knot and stares at the bag for a while. — Where do we hide this? — someone asks. She does not answer straight away.
:::

::: gm
Where to hide the spoons is a good decision for the players. At the bottom of the settling tank, inside a pipe, buried on the lakeshore, or carried in Lia's truck to Brasília. Each choice carries a different risk in the scene [[scene-auditor]].
:::
]==],
  },
  ["scene-auditor"] = {
    title = "3. The Auditor",
    summary = "Celeste arrives at eight sharp, with four Kuro-Tech guards.",
    body = [==[
::: read
The car arrives at eight sharp, white, with OmniTerra's blue logo on the door. Behind it comes a grey Kuro-Tech van. First out is a woman in her early thirties, in a suit, with a folder under her arm and a silver knife clipped to her jacket pocket like a pen. — Good morning. Celeste Prado-Vasconcelos, Compliance. Do you have coffee?
:::

[[adventure-npcs|Celeste]] is polite, quick and observant. She has a **Compliance Memory** implant: everything she sees is recorded as legal evidence (see [[implants]]). The four Kuro-Tech guards, led by **Sergeant Takeda**, stay in the yard.

## The auditor's schedule
1. A tour of the facilities, with one character as guide.
2. Inventory check: pumps, tanks, meters and **the employees' implants**, one by one.
3. Short interviews with each section.
4. In the evening, a dinner with the supervisors (see [[scene-dinner]]).

In her folder is OmniTerra's [[carta-objetivo|objective card]] for the quarter. An observant character (Perception DV 15) can read its title at a glance.

::: gm
The implant inventory is the most dangerous point for [[davi|Davi]], whose chip is cloned, and for [[marta|Marta]], whose arm belongs to OmniTerra. Celeste writes everything down. Sergeant Takeda recognises [[rui|Rui]] from across the yard, but says nothing yet.
:::
]==],
  },
  ["scene-meter"] = {
    title = "4. Meter 14",
    summary = "The auditor wants to watch the calibration of the one meter nobody may see.",
    body = [==[
Sooner or later (at the latest when Suspicion reaches 3), Celeste asks to watch the **calibration of Meter 14**, the Old Main's meter.

::: read
Meter 14 sits in a brick pump house, older than the rest of the station. Celeste stops at the door, looks at the asset plate dated 2097 and smiles, like someone finding an antique in a new house. — This is the one that goes to Brasília, isn't it?
:::

## How to fool her
- **Swap the reading on the spot**: Basic Tech DV 15, by whoever is at the panel while someone distracts the auditor.
- **Distract her**: Persuasion or Conversation DV 13 against her attention. On a failure, she looks at the panel at the wrong moment.
- **Switch off the Compliance Memory** for a few minutes: Electronics/Security Tech DV 17, with physical access to the implant. A serious crime if discovered.
- **Tell her the truth**: only works if the characters already know Celeste's secret (see [[scene-dinner]]).

::: gm
If the fraud is discovered, Celeste does not shout: she takes notes, says thank you and has Takeda seal the pump house. That leads straight to the scene [[scene-valve]].
:::
]==],
  },
  ["scene-dinner"] = {
    title = "5. Knife Dinner",
    summary = "A compliance dinner, with soup in a bar and a spoon that should not be there.",
    body = [==[
Celeste invites the supervisors to a **compliance dinner** in the station canteen, with the menu she brought (see [[cardapio]]). It is a loyalty ritual: everyone uses their own corporate cutlery, and everyone watches everyone.

::: read
The soup comes as a bar on a little porcelain plate, with OmniTerra's logo embossed on it. Celeste cuts hers into perfect squares with a silver knife and eats slowly. Outside, one of the Kuro-Tech guards laughs loudly at something. She looks up from her plate. — Do you still eat like country folk out here?
:::

## Etiquette checks
Each character at the table makes an Etiquette check (or Acting, to fake it) DV 13. A failure adds 1 to Suspicion: someone held the fork as if it were a spoon.

## Celeste's secret
Celeste was born in Taguatinga, in the Brasília REGEST, and joined OmniTerra at nineteen on a Monsoon contract. Her family still lives there. In her jacket's inside pocket she carries **a small aluminium spoon that was her grandmother's**.

A character can notice it (Perception DV 17) or draw the revelation out (Persuasion or Interrogation DV 17, with a good approach). If the secret comes out, Celeste becomes a possible ally, frightened and expensive.

::: gm
Celeste tells the real plan (the end of the contract in 30 days) to whoever wins her trust. If nobody does, she announces it anyway the next morning: go to [[scene-news]].
:::
]==],
  },
  ["scene-news"] = {
    title = "6. The News",
    summary = "The contract with Brasília ends in 30 days, and the station will be emptied.",
    body = [==[
::: read
Celeste gathers all 41 employees in the yard at seven in the morning. She speaks without a microphone, in the voice of someone who has done this many times. — I have good news. In thirty days the Descoberto-7 Station becomes part of the Planalto II Expansion. The Old Main will be decommissioned. You will be relocated to Alcântara, with a mobility package, as part of the effort for the Colony Dream. Any questions?
:::

Nobody asks anything. In thirty days, Brasília loses the 6% of its water it gets by contract and the 9% the cell sent off the books. The employees go to Alcântara, or, those with something to hide, into quarantine.

## Open
The written adventure stops here. The cell has thirty days and many options, and none of them is clean. See [[what-next]].
]==],
  },
  ["scene-valve"] = {
    title = "7. The Valve",
    summary = "The fraud was found, or the cell decided to act first. The station is sealed.",
    body = [==[
This scene happens if Suspicion reaches 6, if the Meter 14 fraud is discovered, or if the cell decides to open the Old Main all the way at once, with the auditor still inside.

::: read
Sergeant Takeda shuts the station gate and puts two men in the pump house. From the yard you can see the target panel through the control-room window: still green, still 104%. Celeste is on the phone, her back to everyone, speaking quietly.
:::

The station holds 41 resistance members, four armed Kuro-Tech guards, an auditor with a recording that could condemn everyone, and a valve that could send Brasília, for a few hours, all the water in the Descoberto.

@npc:takeda
@npc:guard

## Open
What happens next belongs to the table. Kuro-Tech sends reinforcements within four hours; OmniTerra treats the station as a "compromised asset". See [[what-next]].
]==],
  },
  ["adventure-npcs"] = {
    title = "GM characters",
    summary = "The auditor, the supervisor and who else is at the station.",
    body = [==[
## Celeste Prado-Vasconcelos
Senior Compliance auditor at OmniTerra, 34. Polite, quick, tired. Born in Taguatinga, she joined the company as a Monsoon contractor and rose by being the best at doing what she was told. She carries her grandmother's spoon in her jacket pocket and a recording of everything she sees inside her head.

**What she wants:** to close the audit without trouble and not think about her family in Taguatinga.

@npc:celeste

## Dona Zuleide Batista
Supervisor of the Descoberto-7 Station and leader of the Ladle Cell, 58. A hydraulic engineer, grandmother of five who live in Ceilândia. She replaced all 41 employees one by one, over three years, without anyone noticing. She does not believe in great victories; she believes in litres.

@npc:zuleide

## Sergeant Edson Takeda
Commander of the Kuro-Tech contract unit. He and [[rui|Rui]] worked together as Great Rift contract security in 2111, on the inland side of Djibouti. Takeda has never talked about it with anyone. His profile is in [[scene-valve]].
]==],
  },
  ["what-next"] = {
    title = "Where the story can go",
    summary = "Paths for the next thirty days, with no written ending.",
    body = [==[
The adventure has no ending. These are paths the cell can try, each with its price.

- **Leak the recording.** If Celeste becomes an ally, her Compliance Memory has everything: the Planalto II Expansion plan, the orders, the numbers. A REGEST newspaper would publish it. OmniTerra would know exactly where it came from.
- **Sabotage the Planalto Core.** Without water for cooling, the data centre stops. So does the space fleet's telemetry, and OmniTerra responds the way it responded to Halcyon.
- **Bargain with another ESTEMP.** [[thalassa|Thalassa]] sells desalinated water and would love a contract in Brasília. Is swapping one corporation for another a victory?
- **Kidnap the auditor.** She is worth a lot to OmniTerra, and she knows a lot.
- **Empty the station.** Take all 41 to Brasília before the relocation, chips, arms and all, and become a nomad cell.
- **Open the valve.** Send all the water at once, for a few hours. It fills the hospitals' tanks and gives away the whole cell.

## Loose threads
- What Takeda will do with what he knows about Rui.
- Who inside the AntiFaCa will want to use the station for something bigger, and bloodier.
- What Lia will find out about the hospital when the water stops.
]==],
  },
  ["handouts"] = { title = "Handouts", summary = "Documents to hand to the players." },
  ["sources"] = { title = "Sources", summary = "The real-world references used in the book." },
  ["about"] = {
    title = "About this book",
    summary = "Credits, licence and how to contribute.",
    body = [==[
*The Corporate Tomorrow* is a Magic Stack book, written by Murillo França M. da Silva. The content is licensed **CC BY-NC-SA 4.0**. The original is in Portuguese (*O Amanhã Corporativo*).

## Cyberpunk RED
Cyberpunk and Cyberpunk RED are trademarks of R. Talsorian Games. This is free, unofficial fan content, published under R. Talsorian's homebrew content policy. To play, use the Cyberpunk RED core book.

## The map
The board is generated from Natural Earth country outlines, in the public domain, rasterised into two-degree pixels. The division between the ESTEMPs is fiction.

## Contribute
This world is open. Lesser corporations, REGESTs, hooks, characters and new scenes can be proposed with each article's **Contribute** button. Every contribution is reviewed by the author and credited according to the contribution terms.
]==],
  },
}

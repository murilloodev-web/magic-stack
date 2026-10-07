-- Player handouts, numbered in the order they are usually found. Each one
-- can be linked as [[<id>]] and is printed in the appendix. `found` is the
-- scene where it turns up; `style` picks the paper it is printed on:
-- notebook, letter, memo, telegram, register or photo.
-- Text uses the page markup; a line break inside a paragraph is kept.

return {
  {
    id = "h-letter", style = "letter", found = "scene-arrival",
    title = "Tonico's last letter",
    text = [==[
Santos, 2 June 1974

Lenita,

Don't tell Mãe I wrote this. They moved me to the company tanks, the ones that go up the Serra at night. Good money, nobody says why.

The tanks smell of the beach even when they are empty. At the bottom there is a mud that shines purple when you shine the lamp on it, and it is warm, Lenita, warm like something breathing.

Last night I was inside one, scraping, and I heard my name. Not from outside. From the mud.

There is something alive at the bottom of the company tank. And it calls me by name.

They're sending me up to Alto da Serra on Friday to "help with the festival". I'll write from there.

Your brother,
Tonico
]==],
  },
  {
    id = "h-memo", style = "memo", found = "scene-yard",
    title = "The RFFSA order",
    text = [==[
**REDE FERROVIÁRIA FEDERAL S.A. — RFFSA**
**Superintendência Regional — São Paulo**
**Internal memorandum nº 114/74 · 20 May 1974**

To: Engineering, Serra Nova Section (Alto da Serra)

1. With the rack-and-adhesion line in service, the Serra Nova cable system is to be **progressively wound down** from 1 June.
2. Night freight is reduced to essential cargo. The **"special ballast service"** (tank wagons, night runs, Santos → 4th Landing) is **suspended** pending audit.
3. An auditor from the General Directorate will visit the section in June. Accounts for "ballast water" since 1946 are to be made available.

*Handwritten in the margin, in a different ink:* **"They cannot. Not before winter. — H.A."**
]==],
  },
  {
    id = "h-telegrams", style = "telegram", found = "scene-castelinho",
    title = "Telegraph log, Castelinho",
    text = [==[
**EFSJ · ALTO DA SERRA · LOG OF OUTGOING MESSAGES**

03 JUN 74 · TO SANTOS YARD · BALLAST WATER URGENT STOP SEND BY HAND IF CARS REFUSED STOP
07 JUN 74 · TO SANTOS YARD · CASTRO BOY ARRIVED STOP HE HEARS IT ALREADY STOP
11 JUN 74 · TO 4TH LANDING · FEED DOUBLE FILINGS STOP SALT ALL DRAINS STOP
14 JUN 74 · TO SANTOS YARD · AUDITOR ON TRAIN STOP JOURNALIST ALSO STOP
16 JUN 74 · TO 4TH LANDING · CASTRO BOY GONE DOWN STOP DO NOT FOLLOW STOP
]==],
  },
  {
    id = "h-notebook", style = "notebook", found = "scene-castelinho",
    title = "Bento Arruda's notebook",
    text = [==[
*The pages are warped with water and smell of the sea. The handwriting is a prospector's, in Portuguese. The entries get shorter.*

**March.** The stone was in the flooded cave below the hill. I only wanted it for the price. Since I carried it out I do not get hungry.

**May.** East. It wants east. When I turn west my chest fills with water and I cough salt.

**July.** I walked through the night again. My feet bleed and I do not feel them. It sings. The song is of a place without light, very wide, very cold. Home.

**September.** The English are building a road of iron up the mountain. The fog came with me. They look at me strangely.

**Last entry.** Daqui se vê o mar.
]==],
  },
  {
    id = "h-register", style = "register", found = "scene-castelinho",
    title = "Camp register, 1866",
    text = [==[
**SÃO PAULO RAILWAY · ALTO DA SERRA CONSTRUCTION CAMP · BURIALS**

| Date | Name | Age | Cause of death |
|---|---|---|---|
| 14 Oct 1866 | J. Pereira (labourer) | 31 | Fall from the incline |
| 2 Nov 1866 | Unknown (child) | — | Fever |
| 19 Nov 1866 | **Bento Arruda (prospector)** | **c. 40** | **Drowning** |
| 3 Dec 1866 | T. Hughes (fitter) | 27 | Crushed by wagon |

*Beside the third entry, in the same clerk's hand:* "Found at foot of first incline. Lungs full of sea water. Dr M. says impossible."
]==],
  },
  {
    id = "h-photo", style = "photo", found = "scene-castelinho",
    title = "Arthur's confiscated print",
    text = [==[
*A black-and-white print, 18 × 24 cm. A railway tunnel on the Serra Nova, mist pouring out of it. In the mist, if you look long enough, there are faces: a dozen of them, mouths open, stretched toward the camera as if under water.*

*On the back, typed on a label:*
**SÃO PAULO RAILWAY — OLD BOARD (LIQUIDATION).**
**Not for publication. Negative retained at Alto da Serra.**
**By order of the Chief Engineer.**
]==],
  },
}

-- The book's chapters, in reading order. Each chapter is one page of the
-- site (<id>.html) and gathers the articles listed in `pages`, in order.
-- build.lua checks that every article in data/pages.lua, every investigator
-- and every handout sits in exactly one chapter.
--
-- `n` is the chapter number as printed ("I", "II"… or "A" for appendices).
-- `epigraph` and `intro` open the chapter; they use the same markup as pages.

return {
  {
    id = "intro", n = "I",
    title = "Introduction for the Keeper",
    epigraph = "In Tupi, *Paranapiacaba* means “the place from which one sees the sea”. Most nights, you cannot.",
    intro = [==[
This chapter is for the Keeper's eyes only. It tells you what is really happening on the mountain, how the investigation is built, where the history ends and the invention begins, and how to run the whole thing in two or three sessions.
]==],
    pages = { "synopsis", "scenario-flow", "running", "fact-and-fiction" },
  },
  {
    id = "setting", n = "II",
    title = "The Mountain and the Village",
    epigraph = "On the Serra, the train goes up pulled and comes down held. — a saying of the railwaymen",
    intro = [==[
Everything in this chapter is a real place, and most of it can still be visited. Each article starts with what is documented, with numbered citations, and then marks what the scenario adds on top *(Fiction)*. Read it to describe the village with confidence; hand the history to your players freely.
]==],
    pages = { "paranapiacaba", "funicular", "locobreques", "castelinho", "fourth-landing", "grota-funda", "timeline" },
  },
  {
    id = "mythos", n = "III",
    title = "The Secrets of the Serra",
    epigraph = "“Daqui se vê o mar.” From here you can see the sea. — the last line in Bento Arruda's notebook, 1866",
    intro = [==[
The truth behind the fog, in the order it happened: a man who walked out of the south carrying something alive, the stone that the railway fed for a century, the wagon that fed it, and the mist that is its only voice. The rules for **Mist Contact**, the scenario's central mechanic, are here too.
]==],
    pages = { "the-fugitive", "amethyst-heart", "company-car", "the-mist", "mist-contact", "winter-festival" },
  },
  {
    id = "investigators", n = "IV",
    title = "The Investigators",
    epigraph = "“There is something alive at the bottom of the company tank, Lenita. And it calls me by name.”",
    intro = [==[
Three pre-generated investigators, each brought up the mountain by a different thread of the same mystery. Every sheet is checked against the Call of Cthulhu 7th Edition rules when the book is built. You can also play with your own investigators: see the first article.
]==],
    pages = { "investigators-intro", "dudu", "lenita", "arthur" },
  },
  {
    id = "investigation", n = "V",
    title = "The Investigation",
    epigraph = "Nobody from outside at the Festival. That was the rule, for a hundred years.",
    intro = [==[
Seven scenes, from the first night in the fog to the crystal chamber under Grota Funda. They are not a corridor: after the arrival, the investigators can take them in almost any order, and each scene lists where it leads and what opens the way. Boxed text is meant to be read aloud. Skill rolls name the investigator best placed to make them, but anyone can try.
]==],
    pages = { "scene-arrival", "scene-yard", "scene-festival", "scene-tunnel", "scene-castelinho", "scene-landing", "scene-grota" },
  },
  {
    id = "npcs", n = "VI",
    title = "Keeper Characters",
    epigraph = "“I do not want you dead. I want you to understand.” — Henrique Ashworth, chief engineer",
    intro = [==[
The people of the mountain, and what they will do as the mist gets louder. Each one who might come to blows has a full Call of Cthulhu 7e profile; derived values are checked by the build like the investigators'.
]==],
    pages = { "company-of-shadows", "chief-engineer", "cultists", "tonico", "old-railwayman" },
  },
  {
    id = "endings", n = "VII",
    title = "Endings",
    epigraph = "There is no clean victory. That is the point.",
    intro = [==[
Two bad choices and one way to lose. Read all three before the last session: the investigators can only make the choice if they reach the chamber in time, and the Mist Clock decides that.
]==],
    pages = { "ending-sea", "ending-shatter", "ending-lost", "aftermath" },
  },
  {
    id = "appendix", n = "A",
    title = "Appendices",
    intro = [==[
Handouts to print or show on screen, every real-world source cited in the book, and a note on how it was made.
]==],
    pages = { "handouts", "sources", "about" },
  },
}

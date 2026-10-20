-- English stage titles and exit conditions (the original is data/flow.lua).

return {
  ["opening"] = { title = "Opening adventure",
    when = { "The table follows the knight's arc", "The table follows the child's arc" } },
  ["knight"] = { title = "The knight's route",
    when = { "Sir Cael stays in Avernus too long", "A high-ranking fiend defeats Sir Cael on the Material Plane" } },
  ["child"] = { title = "The child's route",
    when = { "The players kill the child, perform an exorcism or break the father's spell" } },
  ["sacrifice"] = { title = "Ending 1: the sacrifice",
    when = { "Once free, the devil takes command of forces in Avernus" } },
  ["defeat"] = { title = "Ending 2: the defeat",
    when = { "The devil returns to Avernus" } },
  ["knight-avernus"] = { title = "Avernus: abductions",
    when = { "The FiendFlayer's advance becomes the final threat" } },
  ["child-avernus"] = { title = "Avernus: gathered heroes",
    when = { "The FiendFlayer's advance becomes the final threat" } },
  ["threat"] = { title = "Final threat" },
}

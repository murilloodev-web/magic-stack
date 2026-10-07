-- English text for data/flow.lua: scene titles and exit conditions, in order.
return {
  ["night-shift"] = { title = "1. The Night Shift", when = { "Zuleide calls the cell together to prepare the station." } },
  ["cleanup"] = { title = "2. The Clean-Up", when = { "At 08:00 the OmniTerra car stops at the gate." } },
  ["auditor"] = { title = "3. The Auditor", when = { "Suspicion reaches 3, or the tour reaches the Old Main.", "The audit day ends without disaster." } },
  ["meter"] = { title = "4. Meter 14", when = { "The calibration passes.", "The fraud is discovered, or Suspicion reaches 6." } },
  ["dinner"] = { title = "5. Knife Dinner", when = { "Next morning, Celeste gathers the employees.", "Suspicion reaches 6, or the cell decides to act first." } },
  ["news"] = { title = "6. The News" },
  ["valve"] = { title = "7. The Valve" },
}

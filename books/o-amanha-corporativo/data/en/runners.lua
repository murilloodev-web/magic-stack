-- English text for data/runners.lua. Stats, levels and implants stay in the
-- original; `skills` and `weapons` give the names in the same order
-- (a weapon may be { name, note }).
return {
  marta = {
    occupation = "Sluice operator, 44",
    origin = "Born in Águas Lindas, on the OmniTerra side, the daughter of reservoir workers. She lost her right arm in a sluice gate at 29; the company paid for the prosthesis, and the arm became the company's.",
    quote = "The arm is theirs. The hand that opens the gate is mine.",
    motivation = "Her nephews and nieces live in Ceilândia, across the border. Every extra litre through Meter 14 is one more bath for them.",
    hook = "If the station is relocated, the prosthesis goes to Alcântara, with or without her. And if she is dismissed, the arm is repossessed.",
    skills = { "Basic Tech", "Electronics/Security Tech", "Local Expert (Descoberto)", "Perception", "Bureaucracy",
               "Concentration", "Persuasion", "First Aid", "Brawling", "Education" },
    weapons = { { "Sluice wrench", "Heavy melee weapon; the industrial arm can take it." } },
    gear = "Reinforced overalls, station radio, toolkit, the master key to the sluice gates, a steel spoon hidden in the lining of her boot.",
  },
  davi = {
    occupation = "Station nurse, 31",
    origin = "An Aegis-Med paramedic in Lisbon, dismissed for diverting Tolerin to a patient who had lost their plan. In quarantine, he crossed the Atlantic on a cloned chip and became “Davi Rezende”, an OmniTerra contract nurse.",
    quote = "Nobody here is sick. Everybody's uninsured.",
    motivation = "He smuggles Tolerin to the station's staff and to whoever needs it in Brasília. If the station falls, his network falls with it.",
    hook = "The auditor's implant inventory will read his chip. A cloned chip fools a gate; an audit, maybe not.",
    skills = { "First Aid", "Paramedic", "Science (Pharmacology)", "Perception", "Deception", "Conversation",
               "Bureaucracy", "Handgun", "Evasion" },
    weapons = { { "Light pistol", "Registered under the fake name." } },
    gear = "First-aid bag, twelve doses of Tolerin (six of them without a receipt), a badge reading Davi Rezende, a photo of Lisbon.",
  },
  rui = {
    occupation = "Head of the station watch, 52",
    origin = "A contract guard all his life. In 2111 he was working for Great Rift on the inland side of Djibouti when the sea came in. He followed orders. He bought the lung filter with his own money afterwards, and joined the AntiFaCa two years later.",
    quote = "I've seen a company solve a problem. I don't want to see it again.",
    motivation = "He protects the cell because in 2111 he protected nobody.",
    hook = "Sergeant Takeda, who commands the auditor's escort, was with him at Djibouti. Each knows what the other did.",
    skills = { "Handgun", "Shoulder Arms", "Brawling", "Evasion", "Perception", "Tactics", "Endurance", "Interrogation" },
    weapons = { "Heavy pistol", { "Guardhouse shotgun", "Kept locked in the guardhouse; he has the key." } },
    gear = "Light vest, radio, torch, the guardhouse key, a pack of Tolerin Davi leaves for him every week because of the eye.",
  },
  lia = {
    occupation = "Water-truck driver, 27",
    origin = "Born in Taguatinga, in the Brasília REGEST, she never had a chip. She works for the station on a supplier's pass: officially she hauls settling sludge to a landfill; in practice, she hauls clean water to the city.",
    quote = "Over there they've got water. Over here they've got people. I just drive.",
    motivation = "Her mother is a nurse at the Hospital de Base. Lia knows exactly how many days of reserve the hospital has.",
    hook = "She is the only one in the cell who crosses Post 4 every day, and the first that security will search if something goes wrong.",
    skills = { "Drive Land Vehicle", "Local Expert (Brasília)", "Streetwise", "Handgun", "Evasion", "Trading",
               "Land Vehicle Tech", "Melee Weapon", "Perception" },
    weapons = { "Medium pistol", { "Kitchen knife", "She finds it funny to carry a knife." } },
    gear = "The water truck (12,000 litres, supplier plates), radio with a coded channel, supplier's pass, map of the dirt roads around Post 4.",
  },
}

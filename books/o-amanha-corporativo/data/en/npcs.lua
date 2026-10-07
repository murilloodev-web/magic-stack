-- English text for data/npcs.lua (names of skills and weapons in the same order).
return {
  celeste = {
    name = "Celeste Prado-Vasconcelos", label = "Senior Compliance auditor, OmniTerra",
    weapons = { { "Light handbag pistol", "Has never fired it outside the range." } },
    skills = { "Bureaucracy", "Accounting", "Perception", "Persuasion", "Etiquette", "Interrogation", "Concentration" },
    notes = "Everything she sees is recorded in her Compliance Memory. She carries a small aluminium spoon in her jacket pocket that was her grandmother's.",
  },
  zuleide = {
    name = "Dona Zuleide Batista", label = "Supervisor of the Descoberto-7 Station and leader of the Ladle Cell",
    weapons = { "Valve wrench" },
    skills = { "Basic Tech", "Leadership", "Bureaucracy", "Deception", "Local Expert (Descoberto)", "Perception" },
    notes = "She knows the name, shift and secret of each of the 41 employees. She does not believe in great victories; she believes in litres.",
  },
  takeda = {
    name = "Sergeant Edson Takeda", label = "Commander of the contract escort, Kuro-Tech",
    weapons = { "Heavy pistol", { "Pacification rifle", "Containment rounds: instead of damage, the target makes a Death Save or is stunned for a round." } },
    skills = { "Handgun", "Shoulder Arms", "Tactics", "Perception", "Brawling", "Leadership" },
    notes = "He was with Rui Saldanha at Djibouti in 2111. He follows orders; he wants to reach retirement alive.",
  },
  guard = {
    name = "Contract guard (×3)", label = "Pacification unit, Kuro-Tech",
    weapons = { "Shock baton", "Medium pistol" },
    skills = { "Handgun", "Brawling", "Perception" },
    notes = "Hired by the quarter. They are not paid to die, and they know it.",
  },
}

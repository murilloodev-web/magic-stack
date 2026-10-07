-- The board: who owns the world in 2126. The map (tools/map.lua) and the
-- territory tables in the book are drawn from this file; the build checks
-- that every letter in data/worldgrid.lua has an owner here, that every
-- REGEST and landmark sits inside the map, and that every owner has a page.
--
-- Map labels are short and live here in both languages ({ pt =, en = }).
-- Longer descriptions are articles in data/pages.lua (`page`).
--
-- armies: the War-style army pieces drawn on the map. They are a joke with a
-- point: roughly how much private security each ESTEMP keeps on its land.

return {
  -- ESTEMPs. `code` is the letter used in data/worldgrid.lua.
  estemps = {
    { code = "O", id = "omniterra", name = "OmniTerra", tier = "major", page = "omniterra",
      color = "#3b6fc4", light = "#6a98e0", dark = "#24477f", armies = 38,
      label = { lon = -103, lat = 44 }, region = { pt = "As Américas", en = "The Americas" } },
    { code = "K", id = "kuro-tech", name = "Kuro-Tech", tier = "major", page = "kuro-tech",
      color = "#5d5d72", light = "#8a8aa3", dark = "#38384a", armies = 31,
      label = { lon = 112, lat = 30 }, region = { pt = "Ásia-Pacífico", en = "Asia-Pacific" } },
    { code = "A", id = "aegis-med", name = "Aegis-Med", tier = "major", page = "aegis-med",
      color = "#d9d3c4", light = "#f5f0e4", dark = "#a49d8c", armies = 24,
      label = { lon = 18, lat = 29 }, region = { pt = "Europa e África mediterrânea", en = "Europe and Mediterranean Africa" } },
    { code = "P", id = "petro-vanguard", name = "Petro-Vanguard", tier = "major", page = "petro-vanguard",
      color = "#d8a933", light = "#f2cd62", dark = "#9c7619", armies = 22,
      label = { lon = 52, lat = 36 }, region = { pt = "Oriente Médio e Ásia Central", en = "Middle East and Central Asia" } },
    { code = "V", id = "severa", name = "Severa Combine", tier = "minor", page = "severa",
      color = "#4c8a4a", light = "#76b26f", dark = "#2f5d2e", armies = 12,
      label = { lon = 98, lat = 62 }, region = { pt = "Rússia e o Ártico", en = "Russia and the Arctic" } },
    { code = "M", id = "monsoon", name = "Monsoon Workforce", tier = "minor", page = "monsoon",
      color = "#3c9f96", light = "#6ccac0", dark = "#246b65", armies = 18,
      label = { lon = 78, lat = 20 }, region = { pt = "Sul da Ásia", en = "South Asia" } },
    { code = "R", id = "great-rift", name = "Great Rift Holdings", tier = "minor", page = "great-rift",
      color = "#cf7433", light = "#eda066", dark = "#8f4a1c", armies = 14,
      label = { lon = 27, lat = -12 }, region = { pt = "África Oriental, Central e Austral", en = "East, Central and Southern Africa" } },
    { code = "S", id = "sahel-solar", name = "Sahel Solar Trust", tier = "minor", page = "sahel-solar",
      color = "#8a5aa8", light = "#b487d1", dark = "#5c3a73", armies = 10,
      label = { lon = 4, lat = 17 }, region = { pt = "África Ocidental e o Saara", en = "West Africa and the Sahara" } },
  },

  -- The sea is Thalassa's. Its pieces are the red ones, and they are everywhere.
  sea = { id = "thalassa", name = "Thalassa Corp", tier = "major", page = "thalassa",
          color = "#c8322e", light = "#ec5d55", dark = "#7f1a18", armies = 30,
          water = "#10283c", water2 = "#15334c",
          labels = { { lon = -140, lat = 8 }, { lon = -28, lat = 28 }, { lon = 80, lat = -32 } },
          region = { pt = "Todos os oceanos", en = "Every ocean" } },

  -- What is left of the 20 largest states: each REGEST keeps the part of its
  -- country that no corporation wanted to buy. `n` is the number on the map;
  -- dx/dy nudge the number (in map pixels) where markers crowd.
  regests = {
    { n = 1,  id = "brasilia",   country = { pt = "Brasil", en = "Brazil" },               lon = -47.9, lat = -15.8,
      place = { pt = "Distrito Federal (Brasília)", en = "Federal District (Brasília)" } },
    { n = 2,  id = "plains",     country = { pt = "Estados Unidos", en = "United States" }, lon = -100,  lat = 38.5,
      place = { pt = "Grandes Planícies, sobre o Aquífero Ogallala esgotado", en = "The Great Plains, over the spent Ogallala Aquifer" } },
    { n = 3,  id = "cdmx",       country = { pt = "México", en = "Mexico" },               lon = -99.1, lat = 19.4,
      place = { pt = "Cidade do México, afundando e sem água", en = "Mexico City, sinking and dry" } },
    { n = 4,  id = "shield",     country = { pt = "Canadá", en = "Canada" },               lon = -86,   lat = 51,
      place = { pt = "Escudo Canadense, florestas queimadas", en = "The Canadian Shield, burnt forest" } },
    { n = 5,  id = "loess",      country = { pt = "China", en = "China" },                lon = 105,   lat = 36,
      place = { pt = "Planalto de Loess, terra erodida", en = "The Loess Plateau, eroded land" } },
    { n = 6,  id = "tohoku",     country = { pt = "Japão", en = "Japan" },                lon = 141,   lat = 40, dx = 3,
      place = { pt = "Interior de Tōhoku, vilas vazias", en = "Inland Tōhoku, empty villages" } },
    { n = 7,  id = "gangwon",    country = { pt = "Coreia do Sul", en = "South Korea" },  lon = 128.2, lat = 37.8, dx = -3, dy = -3,
      place = { pt = "Gangwon, encostada na zona desmilitarizada", en = "Gangwon, against the demilitarised zone" } },
    { n = 8,  id = "thar",       country = { pt = "Índia", en = "India" },                lon = 71,    lat = 27,
      place = { pt = "Deserto de Thar", en = "The Thar Desert" } },
    { n = 9,  id = "jakarta",    country = { pt = "Indonésia", en = "Indonesia" },         lon = 106.8, lat = -6.1,
      place = { pt = "Jacarta Norte, abaixo do nível do mar", en = "North Jakarta, below sea level" } },
    { n = 10, id = "outback",    country = { pt = "Austrália", en = "Australia" },         lon = 133.9, lat = -23.7,
      place = { pt = "O interior árido, em volta de Alice Springs", en = "The arid interior, around Alice Springs" } },
    { n = 11, id = "lusatia", inset = true,    country = { pt = "Alemanha", en = "Germany" },            lon = 14.3,  lat = 51.6, dx = 3,
      place = { pt = "Lusácia, crateras de minas de linhito", en = "Lusatia, craters of old lignite mines" } },
    { n = 12, id = "fens", inset = true,       country = { pt = "Reino Unido", en = "United Kingdom" },  lon = 0.1,   lat = 52.5, dx = -4,
      place = { pt = "Os Fens, alagados", en = "The Fens, flooded" } },
    { n = 13, id = "diagonal", inset = true,   country = { pt = "França", en = "France" },               lon = 2.5,   lat = 45.5, dx = -4,
      place = { pt = "A diagonal do vazio, no Maciço Central", en = "The empty diagonal, in the Massif Central" } },
    { n = 14, id = "basilicata", inset = true, country = { pt = "Itália", en = "Italy" },                lon = 16,    lat = 40.5, dx = 3, dy = 2,
      place = { pt = "Basilicata, o interior do sul", en = "Basilicata, the inland south" } },
    { n = 15, id = "soria", inset = true,      country = { pt = "Espanha", en = "Spain" },               lon = -2.5,  lat = 41.8, dx = -4, dy = 2,
      place = { pt = "A Espanha esvaziada, em volta de Soria", en = "Emptied Spain, around Soria" } },
    { n = 16, id = "polders", inset = true,    country = { pt = "Países Baixos", en = "Netherlands" },   lon = 5,     lat = 52.5, dy = -4,
      place = { pt = "Os pólderes que a Thalassa ainda não alagou", en = "The polders Thalassa has not flooded yet" } },
    { n = 17, id = "valais", inset = true,     country = { pt = "Suíça", en = "Switzerland" },           lon = 7.6,   lat = 46.2, dy = 3,
      place = { pt = "Valais, vales sem geleira", en = "Valais, valleys without glaciers" } },
    { n = 18, id = "kalmykia",   country = { pt = "Rússia", en = "Russia" },               lon = 44.3,  lat = 46.3,
      place = { pt = "Calmúquia, estepe virando deserto", en = "Kalmykia, steppe turning to desert" } },
    { n = 19, id = "empty-quarter", country = { pt = "Arábia Saudita", en = "Saudi Arabia" }, lon = 48, lat = 19.5,
      place = { pt = "A borda do Rub' al-Khali", en = "The edge of the Rub' al-Khali" } },
    { n = 20, id = "konya",      country = { pt = "Turquia", en = "Türkiye" },             lon = 32.5,  lat = 37.9,
      place = { pt = "Bacia de Konya, chão afundando sobre o aquífero seco", en = "The Konya basin, ground sinking over a dry aquifer" } },
  },

  -- Western Europe is too crowded at 2° a pixel: its REGESTs are numbered in
  -- an inset at double scale, in the empty South Pacific corner of the board.
  inset = { lon0 = -10, lon1 = 22, lat0 = 58, lat1 = 36, zoom = 2, x = 8, y = 8,
            label = { pt = "EUROPA OCIDENTAL ×2", en = "WESTERN EUROPE ×2" } },

  -- Landmarks drawn on the map with an icon.
  marks = {
    { id = "djibouti",  icon = "skull",  lon = 42.5, lat = 12, page = "great-dismissal",
      label = { pt = "Golfo da Demissão (2111)", en = "Gulf of the Dismissal (2111)" } },
    { id = "alcantara", icon = "rocket", lon = -44.4, lat = -2.4, page = "first-corporate-war",
      label = { pt = "Alcântara · 1ª Guerra Corporativa", en = "Alcântara · First Corporate War" } },
  },
}

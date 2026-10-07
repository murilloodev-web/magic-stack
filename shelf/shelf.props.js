// Magic Stack — the movable objects (dice, potion, books, scroll, candle,
// crystal ball, lamp) as pixel-art sprites at the room's resolution: one
// sprite pixel = one scene pixel = PX (4) CSS pixels, outlined and shaded
// with the same palette as the canvas. Flames are separate sprites so they
// can flicker. The app dims each object by its distance from the lamp.

const SPRITE_PAL = {
  k: '#0b0b14', K: '#2a1d17',
  // red die, white die
  R: '#e0566d', r: '#b8433e', d: '#7a2f45', W: '#f2f5ec', w: '#dfe7d9', g: '#9fa8a6', G: '#6f7684',
  // potion glass and liquid
  b: '#8a88ac', L: '#c6e08a', l: '#9dbb6a', m: '#4a6232',
  // wood and brass
  C: '#ab8654', c: '#7a5a3e', o: '#4a3524', Y: '#fbe598', y: '#e6a83c', x: '#9a6420',
  // book covers and pages
  P: '#b65266', p: '#7a2f45', N: '#83a04e', n: '#3e4a2c', U: '#474766', u: '#1f1f3d',
  E: '#efe0b8', e: '#e0cc9c', f: '#b39462',
  // crystal ball and lamp metal
  H: '#b4b0cc', h: '#61618a', S: '#3b3860', s: '#262543', i: '#8a88ac', q: '#15162a',
  M: '#8e8aae', j: '#3b3860', J: '#262543',
  // lamp glass glow and flames
  z: '#954028', a: '#e27a3f', A: '#f3b04a', B: '#fbe598', F: '#ffffff',
};

const SPRITES = {
  Dice: [
    'kkkkkkk....',
    'kRRRRdk....',
    'krwrrdkkkkk',
    'krrwrdkWWgk',
    'krrrwdkWkgk',
    'kdddddkgggk',
    'kkkkkkkkkkk',
  ],
  Potion: [
    '..kk..',
    '.kCck.',
    '.kcok.',
    '.kbbk.',
    '.kwbk.',
    'kbwbbk',
    'kLllmk',
    'kLlllk',
    'klllmk',
    'kmlmmk',
    '.kkkk.',
  ],
  Stack: [
    '.kkkkkkkkkkkkkk.',
    '.kUyUUUUUUUfEEk.',
    '.kuyuuuuuuufeek.',
    'kkkkkkkkkkkkkkk.',
    'kNYNNNNNNNfEEEk.',
    'knynnnnnnnfeeek.',
    'kkkkkkkkkkkkkkkk',
    'kPPPPyPPPPPfEEEk',
    'kppppypppppfeeek',
    'kkkkkkkkkkkkkkkk',
  ],
  Scroll: [
    '.kkkkkkkkkkkkkkk.',
    'kCEEEEEEpEEEEEECk',
    'kceeeeeepeeeeeeck',
    'kcffffffpffffffck',
    '.kkkkkkkkkkkkkkk.',
  ],
  Candle: [
    '......',
    '......',
    '......',
    '......',
    '..k...',
    '.kWWk.',
    '.kWwk.',
    '.kWgk.',
    '.kwgk.',
    '.kWgk.',
    '.kwgk.',
    '.kwgk.',
    'kkkkkk',
    'kYyyxk',
    'kxxxxk',
    '.kkkk.',
  ],
  Orb: [
    '..kkkkk..',
    '.kShHSsk.',
    'kShHSsssk',
    'kSSssiqsk',
    'kSssissqk',
    '.ksssqqk.',
    '..kkkkk..',
    '..kCCck..',
    '.kCccook.',
    'kCccccook',
    'kkkkkkkkk',
  ],
  Lamp: [
    '......kkkk......',
    '.....k....k.....',
    '....kMkkkkMk....',
    '...kMMMMMMMMk...',
    '..kMhhhhhhhhMk..',
    '.kjjjjjjjjjjjjk.',
    '.kkkkkkkkkkkkkk.',
    '.kMkzaaAAaazkMk.',
    '.kMkzaAAAAazkMk.',
    '.kMkzaABBAazkMk.',
    '.kMkzaABBAazkMk.',
    '.kMkzaABBAazkMk.',
    '.kMkzaABBAazkMk.',
    '.kMkzaAAAAazkMk.',
    '.kMkzaaAAaazkMk.',
    '.kMkzaaaaaazkMk.',
    '.kMkzzaaaazzkMk.',
    '.kMkzzzzzzzzkMk.',
    '.kkkkkkkkkkkkkk.',
    '.kjMMMMMMMMMMjk.',
    '.kjjjjjjjjjjjjk.',
    'kkkkkkkkkkkkkkkk',
    'kJJJJJJJJJJJJJJk',
    '.kkkkkkkkkkkkkk.',
  ],
};
// flames: sprite, position inside the object (in sprite pixels)
const FLAMES = {
  Lamp: { x: 6, y: 8, rows: ['..A.', '.AA.', '.AB.', 'ABBA', 'ABFA', 'ABBA', '.AA.'] },
  Candle: { x: 1, y: 0, rows: ['.A.', 'ABA', 'AFA', '.A.'] },
};

function spriteCanvas(rows) {
  const h = rows.length, w = rows[0].length;
  const cv = document.createElement('canvas');
  cv.width = w; cv.height = h;
  cv.style.width = (w * PX) + 'px'; cv.style.height = (h * PX) + 'px';
  cv.className = 'ms-sprite';
  const ctx = cv.getContext('2d');
  rows.forEach((row, y) => {
    if (row.length !== w) console.warn('sprite row width', row);
    for (let x = 0; x < w; x++) {
      const c = SPRITE_PAL[row[x]];
      if (c) { ctx.fillStyle = c; ctx.fillRect(x, y, 1, 1); }
    }
  });
  return cv;
}

// the DOM for one object: drop shadow, sprite, and its flame if it has one
function propArt(k) {
  const frag = document.createDocumentFragment();
  const shadow = document.createElement('span');
  shadow.className = 'ms-prop-shadow';
  if (k === 'Candle') {   // a small warm halo, much smaller than the lamp's light
    const glow = document.createElement('span');
    glow.className = 'ms-cglow';
    frag.append(glow);
  }
  frag.append(shadow, spriteCanvas(SPRITES[k]));
  const fl = FLAMES[k];
  if (fl) {
    const f = spriteCanvas(fl.rows);
    f.classList.add(k === 'Lamp' ? 'ms-flame' : 'ms-cflame');
    Object.assign(f.style, { left: (fl.x * PX) + 'px', top: (fl.y * PX) + 'px', transformOrigin: '50% 100%' });
    frag.append(f);
  }
  return frag;
}

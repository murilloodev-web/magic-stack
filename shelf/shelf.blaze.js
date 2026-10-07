// Magic Stack — easter egg: put the lamp inside the magic circle and the
// circle bursts into a tall pixel-art blaze, far higher than the light a book
// raises. It does nothing else, and it dies down when the lamp is taken away.
//
// Two layers give depth: flames from the back half of the ring are drawn
// behind the lamp and the book, flames from the front half in front of them.
// Both layers sit in front of the shelf. Neither takes clicks.
//
// Styles (pick one in BLAZE_STYLE, or preview with ?fire=<style>):
//   cartoon  rounded 16-bit flame tongues in four flat colours, gently swaying
//   magic    the cartoon flames with sparks drifting up
//   soft     the fire simulation, posterised into big soft blocks
//   real     the fire simulation at full detail

const BLAZE_STYLE = 'soft';
const BLAZE_STYLES = ['cartoon', 'magic', 'soft', 'real'];
const BLAZE_REAL = ['#2a120e', '#4a1e16', '#6e2c1e', '#954028', '#b85636', '#e27a3f', '#f3b04a', '#f6cc62', '#fbe598', '#ffffff'].map(hx);
const BLAZE_SOFT = ['#b8433e', '#e27a3f', '#f3b04a', '#fbe598'].map(hx);
const TOON = { line: hx('#7a2f45'), outer: hx('#e0566d'), mid: hx('#f0874a'), inner: hx('#f3b04a'), core: hx('#fbe598') };
const BLAZE_MAX = 60;

// a fire in the colour of the circle: dark ember, body, the colour itself, a pale core
function mixc(a, b, t) { return a.map((v, i) => Math.round(v + (b[i] - v) * t)); }
function blazePalette(hex) {
  if (!hex) return { soft: BLAZE_SOFT, real: BLAZE_REAL, toon: TOON };
  const c = hx(hex), K = [11, 11, 20], W = [255, 255, 255];
  const stops = [mixc(c, K, 0.8), mixc(c, K, 0.5), mixc(c, K, 0.2), c, mixc(c, W, 0.45), mixc(c, W, 0.8), W];
  const real = BLAZE_REAL.map((_, i) => {
    const f = (i / (BLAZE_REAL.length - 1)) * (stops.length - 1), j = Math.min(stops.length - 2, Math.floor(f));
    return mixc(stops[j], stops[j + 1], f - j);
  });
  return {
    soft: [mixc(c, K, 0.35), mixc(c, K, 0.1), mixc(c, W, 0.3), mixc(c, W, 0.7)],
    real,
    toon: { line: mixc(c, K, 0.6), outer: mixc(c, K, 0.15), mid: c, inner: mixc(c, W, 0.4), core: mixc(c, W, 0.75) },
  };
}

function blazeStyle() {
  const q = new URLSearchParams(location.search).get('fire');
  return BLAZE_STYLES.indexOf(q) >= 0 ? q : BLAZE_STYLE;
}

function makeBlaze(backHost, frontHost, opts) {
  const scale = (opts && opts.scale) || 1;   // the candle's fire is a tiny one
  const style = (opts && opts.style) || blazeStyle();
  const sim = style === 'real' || style === 'soft';
  const cell = style === 'soft' && scale >= 1 ? 2 : 1;   // soft: twice as chunky (the candle's stays fine)
  const layers = [backHost, frontHost].map((host, i) => {
    const cv = document.createElement('canvas');
    cv.className = 'ms-blaze ' + (i ? 'ms-blaze-front' : 'ms-blaze-back');
    cv.setAttribute('aria-hidden', 'true');
    cv.hidden = true;
    host.append(cv);
    return { cv, ctx: null, img: null, heat: null, ring: [], front: i === 1 };
  });
  let pal = blazePalette(null), gw = 0, gh = 0, box = null, fuel = false, timer = null, tick = 0, sparks = [], emitters = [], grow = 0;
  const U = PX * cell;   // CSS px per grid cell

  // b: circle centre and radii in CSS px (in the back layer's coordinates);
  // origin.front: where that space starts inside the front layer's host
  function layout(b, origin) {
    box = b;
    const w = Math.ceil((b.rx * 3.2) / U), h = Math.ceil((b.height * scale + b.ry * 1.2) / U);
    const resized = w !== gw || h !== gh;
    gw = w; gh = h;
    const left = Math.round(b.cx - (gw * U) / 2), top = Math.round(b.cy + b.ry * 1.1 - gh * U);
    const cx = gw / 2, cy = gh - 1 - (b.ry * 1.1) / U, rx = b.rx / U, ry = b.ry / U;
    layers.forEach((L, li) => {
      const o = li ? origin.front : { x: 0, y: 0 };
      if (resized || !L.img) {
        L.cv.width = gw; L.cv.height = gh;
        L.ctx = L.cv.getContext('2d'); L.img = L.ctx.createImageData(gw, gh);
        L.heat = new Uint8Array(gw * gh);
      }
      Object.assign(L.cv.style, { width: (gw * U) + 'px', height: (gh * U) + 'px', left: (left + o.x) + 'px', top: (top + o.y) + 'px' });
      // the near flames have a ceiling per column, a little above the near rim,
      // so the book and the lamp standing in the circle stay readable
      L.ceil = new Int16Array(gw); L.soft = new Int16Array(gw);
      const H = Math.max(3, ry * 1.5);   // a little above the lamp's head
      for (let x = 0; x < gw; x++) {
        const u = (x + 0.5 - cx) / rx, rim = Math.abs(u) < 1 ? cy + ry * Math.sqrt(1 - u * u) : cy;
        L.ceil[x] = Math.round(rim - H); L.soft[x] = Math.round(rim - H * 0.55);
      }
      // fuel: the back layer burns the far half of the ellipse, the front layer the near half
      L.ring = [];
      for (let k = 0; k < 220; k++) {
        const t = (k / 220) * Math.PI * 2, front = Math.sin(t) >= 0;
        if (front !== !!li) continue;
        const x = Math.round(cx + Math.cos(t) * rx), y = Math.round(cy + Math.sin(t) * ry);
        if (x >= 0 && x < gw && y > 0 && y < gh) L.ring.push(y * gw + x);
      }
    });
    // cartoon flames: tongues spaced along the ring, bigger in front
    emitters = [];
    const n = Math.max(scale < 1 ? 14 : 10, Math.round((rx + ry) * 0.55));
    for (let k = 0; k < n; k++) {
      const t = (k / n) * Math.PI * 2 + 0.2;
      const depth = (Math.sin(t) + 1) / 2;   // 0 far … 1 near
      // far flames tall, near flames short: the fire rises high behind and
      // whatever stands in the circle stays visible in front
      emitters.push({ x: cx + Math.cos(t) * rx, y: cy + Math.sin(t) * ry, front: Math.sin(t) >= 0,
        hs: (2.4 - depth * 1.75) * scale, ws: (0.8 + depth * 0.3) * scale, phase: (k * 7) % 11, seed: (k * 37) % 17 });
    }
    emitters.sort((a, c) => a.y - c.y);   // far ones first
  }

  // ---- fire simulation (real, soft) ----
  function simStep(L) {
    const heat = L.heat;
    const top = Math.round(BLAZE_MAX * Math.max(0.45, scale));
    // near flames start cooler, so they stay low in front of what stands in the circle
    const peak = top, dense = scale < 1 ? 0.85 : L.front ? 0.5 : 0.55;
    if (fuel) for (const i of L.ring) heat[i] = Math.random() < dense ? peak - ((Math.random() * 6) | 0) : (Math.random() * 20 * scale) | 0;
    let alive = false;
    for (let y = 1; y < gh; y++) for (let x = 0; x < gw; x++) {
      const src = y * gw + x, h = heat[src];
      if (!h) { heat[src - gw] = 0; continue; }
      alive = true;
      const r = (Math.random() * 3) | 0;                     // drift -1, 0 or +1
      const dst = src - gw - r + 1;
      const cool = (Math.random() < (scale < 1 ? 0.9 : 0.6) ? 1 : 0) + (Math.random() < 0.14 ? 1 : 0);
      // near flames burn lower, so whatever stands in the circle stays visible
      let k = cool * cell;
      if (L.front) {
        const cx2 = dst % gw, cy2 = (dst / gw) | 0;
        if (cy2 < L.ceil[cx2]) k = 255;                    // above the ceiling: gone
        else if (cy2 < L.soft[cx2]) k += 2 * cell;         // near it: dying fast, so the tips stay ragged
      }
      if (dst >= 0 && dst < heat.length) heat[dst] = Math.max(0, h - k);
    }
    return alive;
  }
  function simDraw(L) {
    const d = L.img.data, heat = L.heat, soft = style === 'soft';
    const ramp = soft ? pal.soft : pal.real;
    for (let y = 0; y < gh; y++) for (let x = 0; x < gw; x++) {
      const i = y * gw + x, h = heat[i], o = i * 4;
      const b = soft ? 0.5 : BAY[(y & 3) * 4 + (x & 3)];
      if (h + b * 6 < (soft ? 16 : 12)) { d[o + 3] = 0; continue; }   // cool air shows through
      const k = Math.min(ramp.length - 1, Math.max(0, Math.floor((h / BLAZE_MAX) * ramp.length + (b - 0.5) * 0.9)));
      const c = ramp[k];
      d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255;
    }
    L.ctx.putImageData(L.img, 0, 0);
  }

  // ---- cartoon flames (cartoon, magic) ----
  // a tongue: a rounded teardrop that sways and bobs, outlined, with flat bands
  // of colour from the rim to a bright core near its base
  function drawTongue(d, e, g) {
    const T = pal.toon;
    const f = (tick + e.phase) % 8;
    const bob = [0, 1, 2, 1, 0, -1, -2, -1][f] * 0.05;
    const H = Math.max(2, (16 + (e.seed % 6)) * e.hs * (1 + bob) * g), W = (4.5 + (e.seed % 3) * 0.7) * e.ws * g;
    const sway = [0, 1, 1, 0, 0, -1, -1, 0][f];
    const top = Math.floor(e.y - H), bot = Math.ceil(e.y + 1);
    for (let y = top; y <= bot; y++) {
      if (y < 0 || y >= gh) continue;
      const t = (e.y + 1 - y) / (H + 1);                       // 0 at the base, 1 at the tip
      const half = W * Math.pow(Math.sin(Math.PI * Math.min(1, t * 0.95 + 0.05)), 0.7) * (1 - t * 0.35);
      const cxr = e.x + sway * t * t * 2.5;
      for (let x = Math.floor(cxr - half - 1); x <= Math.ceil(cxr + half + 1); x++) {
        if (x < 0 || x >= gw) continue;
        const dx = Math.abs(x + 0.5 - cxr), o = (y * gw + x) * 4;
        let c = null;
        if (dx <= half) {
          const v = (dx / Math.max(0.5, half)) * 0.65 + t * 0.55;
          c = v < 0.42 ? T.core : v < 0.62 ? T.inner : v < 0.85 ? T.mid : T.outer;
        } else if (dx <= half + 1) c = T.line;
        if (c && (c !== T.line || d[o + 3] === 0)) { d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255; }
      }
    }
  }
  function toonDraw(g) {
    layers.forEach((L) => L.img.data.fill(0));
    for (const e of emitters) drawTongue(layers[e.front ? 1 : 0].img.data, e, g);
    if (style === 'magic') {
      if (fuel && Math.random() < 0.7 * scale) {
        const e = emitters[(Math.random() * emitters.length) | 0];
        sparks.push({ x: e.x + (Math.random() - 0.5) * 4, y: e.y - 10, v: 0.6 + Math.random() * 0.7, life: 40 + ((Math.random() * 30) | 0), front: e.front });
      }
      sparks = sparks.filter((s) => (s.life -= 1) > 0 && s.y > 2);
      for (const s of sparks) {
        s.y -= s.v; s.x += Math.sin((tick + s.life) * 0.3) * 0.3;
        const d = layers[s.front ? 1 : 0].img.data, x = Math.round(s.x), y = Math.round(s.y);
        if (x < 1 || x >= gw - 1 || y < 2 || y >= gh - 1) continue;
        const c = s.life % 6 < 3 ? pal.toon.core : pal.toon.inner;
        const pts = s.life < 12 ? [[0, 0]] : [[0, 0], [1, 0], [-1, 0], [0, 1], [0, -1]];   // a twinkle that shrinks
        for (const [dx, dy] of pts) {
          const o = ((y + dy) * gw + x + dx) * 4;
          d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255;
        }
      }
    }
    layers.forEach((L) => L.ctx.putImageData(L.img, 0, 0));
  }

  // ---- loop ----
  function frame() {
    tick += 1;
    if (sim) {
      let more = false;
      layers.forEach((L) => { for (let n = 0; n < 3; n++) more = simStep(L) || more; simDraw(L); });
      if (!more && !fuel) end();
    } else {
      grow = Math.max(0, Math.min(1, grow + (fuel ? 0.12 : -0.08)));   // tongues grow in and shrink out
      toonDraw(grow);
      if (!fuel && grow === 0 && !sparks.length) end();
    }
  }
  function end() { clearInterval(timer); timer = null; layers.forEach((L) => { L.cv.hidden = true; if (L.heat) L.heat.fill(0); }); }

  return {
    layout,
    set(on, reduced) {
      if (on === fuel && (timer || !on)) return;
      fuel = on;
      if (!box) return;
      if (on) {
        layers.forEach((L) => { L.cv.hidden = false; });
        if (reduced) {   // a still frame, no motion
          if (sim) layers.forEach((L) => { for (let n = 0; n < 160; n++) simStep(L); simDraw(L); });
          else { grow = 1; toonDraw(1); }
          return;
        }
        if (sim) layers.forEach((L) => { for (let n = 0; n < 12; n++) simStep(L); });
        if (!timer) timer = setInterval(frame, sim ? 60 : 90);
      } else if (reduced) end();
      else if (!timer) timer = setInterval(frame, sim ? 60 : 90);
    },
    // the circle's colour, or null for plain fire
    tint(hex) {
      const key = hex || '';
      if (key === (pal.key || '')) return;
      pal = blazePalette(hex); pal.key = key;
      if (timer === null && fuel && sim) layers.forEach(simDraw);   // a still frame (reduced motion)
      else if (timer === null && fuel) toonDraw(1);
    },
    get on() { return fuel; },
    style,
  };
}

// The easter egg of the easter egg: all seven objects around the circle in
// the right order summon a portrait in a frame of fire. The photo sits in
// the middle; fuel runs round its edge, so flames lick up its sides and rise
// above it.
function makeFrameFire(host, src, caption) {
  const C = 4;                                   // CSS px per fire cell
  const P = 54, SIDE = 9, TOP = 26, BOT = 6;    // photo size and margins, in cells
  const gw = P + SIDE * 2, gh = P + TOP + BOT;
  const wrap = document.createElement('div');
  wrap.className = 'ms-egg'; wrap.hidden = true; wrap.setAttribute('aria-hidden', 'true');
  const cv = document.createElement('canvas');
  cv.width = gw; cv.height = gh; cv.className = 'ms-egg-fire';
  Object.assign(cv.style, { width: gw * C + 'px', height: gh * C + 'px' });
  const img = document.createElement('img');
  img.src = src; img.alt = ''; img.className = 'ms-egg-dog';
  Object.assign(img.style, { left: SIDE * C + 'px', top: TOP * C + 'px', width: P * C + 'px', height: P * C + 'px' });
  const txt = document.createElement('p');
  txt.className = 'ms-egg-text'; txt.textContent = caption;
  wrap.append(cv, img, txt);
  host.append(wrap);
  const ctx = cv.getContext('2d'), im = ctx.createImageData(gw, gh), heat = new Uint8Array(gw * gh);
  const ramp = BLAZE_SOFT, ring = [];
  for (let x = SIDE - 1; x <= SIDE + P; x++) { ring.push((TOP - 1) * gw + x); ring.push((TOP + P) * gw + x); }
  for (let y = TOP; y < TOP + P; y++) for (const dx of [1, 2, 3]) { ring.push(y * gw + SIDE - dx); ring.push(y * gw + SIDE + P - 1 + dx); }
  let timer = null, fuel = false;
  function step() {
    if (fuel) for (const i of ring) heat[i] = Math.random() < 0.6 ? 44 - ((Math.random() * 8) | 0) : (Math.random() * 14) | 0;
    let alive = false;
    for (let y = 1; y < gh; y++) for (let x = 0; x < gw; x++) {
      const src = y * gw + x, h = heat[src];
      if (!h) { heat[src - gw] = 0; continue; }
      alive = true;
      const dst = src - gw - ((Math.random() * 3) | 0) + 1;
      const k = (Math.random() < 0.7 ? 2 : 0) + (Math.random() < 0.2 ? 2 : 0);
      if (dst >= 0 && dst < heat.length) heat[dst] = Math.max(0, h - k);
    }
    return alive;
  }
  function draw() {
    const d = im.data;
    for (let i = 0; i < heat.length; i++) {
      const h = heat[i], o = i * 4;
      if (h < 12) { d[o + 3] = 0; continue; }
      const c = ramp[Math.min(ramp.length - 1, Math.floor(((h - 12) / 32) * ramp.length))];
      d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255;
    }
    ctx.putImageData(im, 0, 0);
  }
  function frame() {
    let more = false;
    for (let n = 0; n < 2; n++) more = step() || more;
    draw();
    if (!more && !fuel) { clearInterval(timer); timer = null; wrap.hidden = true; }
  }
  return {
    width: gw * C, height: gh * C,
    place(x, y) { Object.assign(wrap.style, { left: Math.round(x) + 'px', top: Math.round(y) + 'px' }); },
    set(on, reduced) {
      if (on === fuel) return;
      fuel = on;
      wrap.classList.toggle('is-on', on);
      if (on) {
        wrap.hidden = false;
        if (reduced) { for (let n = 0; n < 80; n++) step(); draw(); return; }
        for (let n = 0; n < 20; n++) step();
        if (!timer) timer = setInterval(frame, 60);
      } else if (reduced) { heat.fill(0); wrap.hidden = true; }
      else if (!timer) timer = setInterval(frame, 60);
    },
    get on() { return fuel; },
  };
}

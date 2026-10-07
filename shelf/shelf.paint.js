// Magic Stack — painting the room (canvas pixel art), the magic circle and
// the window fog. Taken from the Claude Design file "Estante e Mesa v2";
// the only change is a smaller magic circle on phones; shelf.app.js drives it. build.lua joins both files
// into docs/shelf.js inside one function scope.

const STATUS = { completo: 'Completo', andamento: 'Em andamento', rascunho: 'Rascunho' };
const STATUS_BG = { completo: '#9dbb6a', andamento: '#f3b04a', rascunho: '#8e8aae' };
const KEY = 'magicstack.lastBook';
const PKEY = 'magicstack.props';
const PROPS = [
  { id: 'dice', k: 'Dice', w: 44, h: 28, def: { surf: 'shelf', row: 0, fx: 0.72 } },
  { id: 'potion', k: 'Potion', w: 24, h: 44, def: { surf: 'shelf', row: 0, fx: 0.84 } },
  { id: 'stack', k: 'Stack', w: 64, h: 40, def: { surf: 'shelf', row: 1, fx: 0.5 } },
  { id: 'scroll', k: 'Scroll', w: 68, h: 18, def: { surf: 'shelf', row: 1, fx: 0.66 } },
  { id: 'candle', k: 'Candle', w: 24, h: 52, def: { surf: 'shelf', row: 1, fx: 0.78 } },
  { id: 'orb', k: 'Orb', w: 36, h: 42, def: { surf: 'shelf', row: 1, fx: 0.88 } },
  { id: 'lamp', k: 'Lamp', w: 64, h: 96, def: { surf: 'table', fx: null } }
];
const SYS_COLOR = { 'Call of Cthulhu 7e': '#5fd3b0', 'Tormenta20': '#ff5a4e', 'D&D 5e': '#f3b04a', 'Old Dragon 2e': '#9dbb6a', 'Ordem Paranormal': '#ff6fae', 'Savage Worlds': '#e27a3f', 'GURPS': '#6fb4ff' };
const MAGIC = ['#5fd3b0', '#ff5a4e', '#f3b04a', '#9dbb6a', '#ff6fae', '#e27a3f', '#6fb4ff'];

const PX = 4;
function hx(h) { return [parseInt(h.slice(1, 3), 16), parseInt(h.slice(3, 5), 16), parseInt(h.slice(5, 7), 16)]; }
const RAMPS = [
  ['#07070e', '#0d0e1b', '#141528', '#1c1d35', '#262742', '#33324f', '#463f57', '#5f505b', '#82695d', '#a3825f'],
  ['#040408', '#08080f', '#0d0d18', '#131325', '#1b1a30', '#272236', '#382d38', '#4d3d3c', '#66503f'],
  ['#0b0705', '#160f0b', '#221812', '#32241b', '#432f22', '#56402c', '#6e5236', '#8a6a44', '#ab8654', '#cfa468'],
  ['#0a100b', '#121c13', '#1b2a1a', '#263a20', '#344a28', '#4a6232', '#64803e', '#83a04e', '#a6c264'],
  ['#07070d', '#10101c', '#1a1a2b', '#26263c', '#34344f', '#474766', '#61618a', '#8a88ac', '#b4b0cc'],
  ['#2a1d14', '#4a3524', '#6e5234', '#94754c', '#b39462', '#ccb17e', '#e0cc9c', '#efe0b8'],
  ['#14070d', '#230b17', '#380f22', '#4f162f', '#68203d', '#7f2c48', '#9a3c55', '#b65266', '#d06e78'],
  ['#2a1a0a', '#4a2e10', '#6e4616', '#9a6420', '#c6862c', '#e6a83c', '#f6cc62', '#fbe598'],
  ['#05050d', '#0a0b19', '#101127', '#171836', '#202046', '#2a2b57', '#36386a'],
  ['#2a120e', '#4a1e16', '#6e2c1e', '#954028', '#b85636', '#d47448', '#e8955e']
];
const RAMP_RGB = RAMPS.map(r => r.map(hx));
RAMPS.push(['#2e2b27', '#45413b', '#5e5a52', '#7c786d', '#9c978a', '#bab5a6', '#d6d1c0', '#ebe7d8']);
RAMP_RGB.push(RAMPS[10].map(hx));
const M = { stone: 0, mortar: 1, wood: 2, moss: 3, iron: 4, parch: 5, fabric: 6, gold: 7, sky: 8, clay: 9, chalk: 10 };
const MOON = ['#6f7684', '#9fa8a6', '#c8d0c3', '#dfe7d9', '#f2f5ec'].map(hx);
const FOG = ['#3b3860', '#5a5680', '#8a86a8', '#a9a6c2'].map(hx);
const BAY = [0, 8, 2, 10, 12, 4, 14, 6, 3, 11, 1, 9, 15, 7, 13, 5].map(v => v / 16);
function hs(x, y, s) { let h = Math.imul(x | 0, 374761393) ^ Math.imul(y | 0, 668265263) ^ Math.imul(s | 0, 1442695041); h = Math.imul(h ^ (h >>> 13), 1274126177); return ((h ^ (h >>> 16)) >>> 0) / 4294967296; }
function vn(x, y, s) { const xi = Math.floor(x), yi = Math.floor(y), xf = x - xi, yf = y - yi; const u = xf * xf * (3 - 2 * xf), v = yf * yf * (3 - 2 * yf); const a = hs(xi, yi, s), b = hs(xi + 1, yi, s), c = hs(xi, yi + 1, s), d = hs(xi + 1, yi + 1, s); return a + (b - a) * u + (c - a) * v + (a - b - c + d) * u * v; }

function circlePixels(cx, cy, rx, ry) {
  const out = [];
  const put = (x, y, k) => { const s = hs(x, y, 201); if (s < 0.07) return; out.push([x, y, 0.5 + hs(x, y, 202) * 0.5]); };
  const line = (x0, y0, x1, y1) => { const n = Math.max(1, Math.ceil(Math.max(Math.abs(x1 - x0), Math.abs(y1 - y0)))); for (let i = 0; i <= n; i++) put(Math.round(x0 + (x1 - x0) * i / n), Math.round(y0 + (y1 - y0) * i / n)); };
  const wob = (t, r, s) => r * (1 + 0.012 * Math.sin(3 * t + s) + 0.006 * Math.sin(7 * t + s * 2.1));
  const P = (t, r, s) => [cx + Math.cos(t) * wob(t, r, s) * rx, cy + Math.sin(t) * wob(t, r, s) * ry];
  const ring = (r, s, ox = 0, oy = 0, sx = rx, sy = ry) => { const N = Math.max(12, Math.round(6.3 * r * sx * 1.1)); let prev = null; for (let k = 0; k <= N; k++) { const t = k / N * Math.PI * 2; const p = [cx + ox + Math.cos(t) * r * (1 + 0.012 * Math.sin(3 * t + s)) * sx, cy + oy + Math.sin(t) * r * (1 + 0.012 * Math.sin(3 * t + s)) * sy]; if (prev && hs(k, s * 10, 203) > 0.012) line(prev[0], prev[1], p[0], p[1]); prev = p; } };
  ring(1, 0.3); ring(0.88, 1.7); ring(0.4, 2.4);
  const pts = []; for (let k = 0; k < 7; k++) pts.push(P(-Math.PI / 2 + k * Math.PI * 2 / 7 + (hs(k, 1, 204) - 0.5) * 0.02, 0.86, 0.9));
  for (let k = 0; k < 7; k++) { const a = pts[k], b = pts[(k + 3) % 7]; line(a[0], a[1], b[0], b[1]); }
  const tri = [0, 1, 2].map(k => P(-Math.PI / 2 + k * Math.PI * 2 / 3, 0.3, 0.2));
  for (let k = 0; k < 3; k++) line(tri[k][0], tri[k][1], tri[(k + 1) % 3][0], tri[(k + 1) % 3][1]);
  [0, 1, 2, 3].forEach(k => { const t = -Math.PI / 2 + k * Math.PI / 2 + 0.4; const c = P(t, 0.94, 0.3); ring(0.12, k + 3, c[0] - cx, c[1] - cy, rx * 0.95, rx * 0.5); });
  for (let g = 0; g < 16; g++) {
    const t = g / 16 * Math.PI * 2 + 0.2; const c = P(t, 0.94, 0.3); const gx = Math.round(c[0]), gy = Math.round(c[1]);
    const n = 2 + Math.floor(hs(g, 1, 205) * 3);
    for (let j = 0; j < n; j++) { const ax = gx + Math.round((hs(g, j, 206) - 0.5) * 4), ay = gy + Math.round((hs(g, j, 207) - 0.5) * 2), bx = gx + Math.round((hs(g, j, 208) - 0.5) * 4), by = gy + Math.round((hs(g, j, 209) - 0.5) * 2); line(ax, ay, bx, by); }
  }
  put(Math.round(cx), Math.round(cy)); put(Math.round(cx) + 1, Math.round(cy)); put(Math.round(cx), Math.round(cy) + 1);
  return out;
}
function drawGlow(cv, S, color) {
  if (!cv || !S || !S.circle) return;
  const t = S.tableBox; cv.width = t.w; cv.height = t.h; cv.style.width = (t.w * PX) + 'px'; cv.style.height = (t.h * PX) + 'px';
  const ctx = cv.getContext('2d'); ctx.clearRect(0, 0, t.w, t.h);
  S.circle.forEach(([x, y, s]) => { ctx.fillStyle = s > 0.82 ? '#ffffff' : color; ctx.fillRect(x - t.x, y - t.y, 1, 1); });
}
function paintSceneInto(cv, R, opts) {
  const W = R.W, H = R.H;
  cv.width = W; cv.height = H; cv.style.width = (W * PX) + 'px'; cv.style.height = (H * PX) + 'px';
  const mat = new Uint8Array(W * H), sh = new Float32Array(W * H), em = new Uint8Array(W * H);
  const set = (x, y, m, s) => { if (x < 0 || y < 0 || x >= W || y >= H) return; const i = y * W + x; mat[i] = m; sh[i] = s; };
  const add = (x, y, d) => { if (x < 0 || y < 0 || x >= W || y >= H) return; sh[y * W + x] += d; };
  const get = (x, y) => (x < 0 || y < 0 || x >= W || y >= H) ? -1 : mat[y * W + x];
  const tb = R.table || { x: 0, y: H, w: W, h: 0 };
  const wallB = tb.y;
  const CEIL = 20;

  // stone wall
  let y = 0;
  while (y < wallB) {
    const h = 7 + Math.floor(hs(1, y, 7) * 3);
    let x = -Math.floor(hs(2, y, 7) * 14);
    while (x < W) {
      const w = 12 + Math.floor(hs(x + 3, y, 7) * 12);
      const base = 2.4 + hs(x, y + 5, 7) * 0.9;
      const chip = hs(x + 9, y + 9, 7);
      for (let yy = 0; yy < h; yy++) for (let xx = 0; xx < w; xx++) {
        const px = x + xx, py = y + yy; if (px < 0 || px >= W || py >= wallB) continue;
        if (yy === h - 1 || xx === w - 1) { set(px, py, M.mortar, 2.4); continue; }
        if ((xx === 0 || xx === w - 2) && (yy === 0 || yy === h - 2) && chip < 0.65) { set(px, py, M.mortar, 1.8); continue; }
        let s = base + (vn(px * 0.25, py * 0.25, 11) - 0.5) * 0.45;
        if (yy === 0) s += 1.1; else if (xx === 0) s += 0.6;
        if (yy === h - 2) s -= 0.9; else if (xx === w - 2) s -= 0.5;
        set(px, py, M.stone, s);
      }
      if (hs(x, y, 21) < 0.05) { let cx = x + 2 + Math.floor(hs(x, y, 22) * Math.max(1, w - 4)); for (let k = 0; k < h - 1; k++) { add(cx, y + k, -1.7); if (hs(cx, k, 23) < 0.45) cx += hs(cx, k, 24) < 0.5 ? -1 : 1; } }
      const mossP = 0.02 + (y > wallB * 0.6 ? 0.03 : 0);
      if (hs(x, y, 31) < mossP) for (let k = 0; k < 9; k++) { const mx = x + Math.floor(hs(x, k, 32) * w), my = y + h - 2 - Math.floor(hs(k, y, 33) * 3); set(mx, my, M.moss, 2.5 + hs(mx, my, 34) * 2.5); }
      x += w;
    }
    y += h;
  }
  for (let py = 0; py < wallB; py++) for (let px = 0; px < W; px++) { const i = py * W + px; if (mat[i] <= 1) sh[i] += (vn(px * 0.03, py * 0.04, 41) - 0.5) * 0.5; }

  // wainscot
  const wy0 = wallB - 26;
  for (let py = Math.max(CEIL, wy0); py < wallB; py++) for (let px = 0; px < W; px++) {
    const r = py - wy0, pw = 30, lx = ((px + 7) % pw + pw) % pw;
    let s;
    if (r === 0) s = 6.3; else if (r === 1) s = 5; else if (r === 2) s = 1.6;
    else if (r >= 23) s = r === 23 ? 4.6 : 3;
    else if (lx < 3) s = lx === 0 ? 1.8 : (lx === 1 ? 4.8 : 4);
    else if (r === 4 || lx === 4) s = 2;
    else if (r === 21 || lx === pw - 2) s = 5;
    else s = 3.3 + (vn(px * 0.5, py * 0.05, 51) - 0.5) * 0.7;
    set(px, py, M.wood, s);
  }

  // timber posts + braces
  const post = (x0, dir) => {
    for (let py = 0; py < wallB; py++) for (let k = 0; k < 6; k++) {
      const px = x0 + k * dir; const edge = k === 0 ? 1.2 : (k === 1 ? 5.6 : (k === 5 ? 1.6 : 3.8));
      set(px, py, M.wood, edge + (vn(px * 2, py * 0.06, 61) - 0.5) * 0.5);
    }
    for (let k = 0; k < 16; k++) for (let t = 0; t < 3; t++) {
      const px = x0 + (6 + k) * dir, py = CEIL + 15 - k + t; set(px, py, M.wood, t === 0 ? 5.2 : (t === 2 ? 1.6 : 3.6));
    }
  };
  post(0, 1); post(W - 1, -1);

  // ceiling + beam + joists + hanging herbs
  for (let py = 0; py < CEIL; py++) for (let px = 0; px < W; px++) {
    let s;
    if (py < 12) s = (py % 4 === 3) ? 0.8 : 1.6;
    else if (py === 12) s = 1.4; else if (py === 19) s = 1; else if (py === 18) s = 2.6;
    else s = 4 + (vn(px * 0.04, py * 0.9, 72) - 0.5) * 0.8 + (py === 13 ? 1.2 : 0);
    set(px, py, M.wood, s);
  }
  for (let jx = 18; jx < W - 12; jx += 38) for (let yy = 4; yy < 11; yy++) for (let xx = 0; xx < 7; xx++) {
    const d = Math.abs(xx - 3) + Math.abs(yy - 7);
    set(jx + xx, yy, M.wood, (xx === 0 || yy === 4) ? 5 : (xx === 6 || yy === 10) ? 1.4 : 3.2 + ((d % 2) ? 0.8 : -0.4));
  }
  for (let py = CEIL; py < CEIL + 4; py++) for (let px = 0; px < W; px++) add(px, py, -1.8 + (py - CEIL) * 0.45);
  const herbs = (hx0) => {
    for (let k = 0; k < 7; k++) set(hx0, CEIL + k, M.wood, 2);
    set(hx0 - 1, CEIL + 7, M.fabric, 5); set(hx0, CEIL + 7, M.fabric, 6); set(hx0 + 1, CEIL + 7, M.fabric, 4);
    for (let r = 0; r < 12; r++) { const half = Math.max(0, 3 - Math.floor(r / 4)) + (r < 4 ? 0 : 0); for (let c = -half - 1; c <= half + 1; c++) if (hs(c, r, hx0) < 0.85) set(hx0 + c, CEIL + 8 + r, M.moss, 2 + hs(c, r, hx0 + 1) * 4 - (c > 0 ? 0.8 : 0)); }
  };
  const peppers = (hx0) => {
    for (let k = 0; k < 4; k++) set(hx0, CEIL + k, M.wood, 2);
    for (let r = 0; r < 14; r++) { const off = (r % 2) ? 1 : -1; set(hx0 + off, CEIL + 4 + r, M.fabric, 5 + (off > 0 ? -1 : 0.6)); set(hx0, CEIL + 4 + r, M.fabric, 6.5); if (r % 3 === 0) set(hx0, CEIL + 4 + r, M.moss, 5); }
  };
  herbs(Math.round(W * 0.2)); peppers(Math.round(W * 0.47)); herbs(Math.round(W * 0.9));

  // bookcase
  if (R.nav && R.crown) {
    const n = R.nav, c = R.crown, bx0 = n.x, bx1 = n.x + n.w, by0 = c.y + c.h, by1 = wallB;
    for (let py = by0; py < by1; py++) for (let px = bx0 + 4; px < bx1 - 4; px++) {
      const lx = (px - bx0 - 4) % 9;
      let s = lx === 0 ? 0.7 : 1.6 + (vn(px * 1.3, py * 0.04, 81) - 0.5) * 0.45;
      set(px, py, M.wood, s);
    }
    (R.rows || []).forEach(u => {
      for (let k = 0; k < 6; k++) for (let px = bx0 + 4; px < bx1 - 4; px++) add(px, u.y + k, -2.4 * (1 - k / 6));
      const py0 = u.y + u.h;
      for (let k = 0; k < 4; k++) for (let px = bx0 + 1; px < bx1 - 1; px++) {
        const s = k === 0 ? 6.2 : (k === 3 ? 1.8 : 4.4);
        set(px, py0 + k, M.wood, s);
      }
    });
    for (let py = c.y; py < by1; py++) for (let k = 0; k < 4; k++) {
      const g = 0;
      set(bx0 + k, py, M.wood, [1.2, 5.8, 4.4, 2.8][k] + g);
      set(bx1 - 1 - k, py, M.wood, [0.8, 2.2, 3.6, 4.6][k] + g);
    }
    for (let py = c.y; py < c.y + c.h + 2; py++) for (let px = c.x; px < c.x + c.w; px++) {
      const r = py - c.y; let s;
      if (r === 0) s = 1; else if (r === 1) s = 6.6; else if (r < 4) s = 5 + (vn(px * 0.1, r, 84) - 0.5); else if (r === 4) s = 2.6; else if (r === 5) s = 6;
      else if (r < 8) s = (px % 3 === 2) ? 1.6 : 4.8 - (r - 6) * 0.6; else s = r === 8 ? 2 : 1;
      set(px, py, M.wood, s);
    }
    (R.spines || []).forEach(sp => { for (let py = sp.y + 2; py < sp.y + sp.h; py++) { add(sp.x + sp.w, py, -1.6); add(sp.x + sp.w + 1, py, -0.8); } });
  }

  // window: stone arch, curtains, sill, plant
  let glass = null;
  if (R.win) {
    const ox = R.win.x + 7, oy = R.win.y + 8, ow = 44, oh = 60, r0 = ow / 2, t = 4, cx = ox + ow / 2 - 0.5, top = oy + r0;
    const inA = (px, py, ins) => { if (py < top) { const dx = px - cx, dy = py - top; return dx * dx + dy * dy <= (r0 - ins) * (r0 - ins); } return px >= ox + ins && px < ox + ow - ins && py < oy + oh; };
    glass = [];
    for (let py = oy; py < oy + oh; py++) for (let px = ox; px < ox + ow; px++) {
      if (!inA(px, py, 0)) continue;
      if (!inA(px, py, t)) {
        let seg;
        if (py < top) seg = Math.floor((Math.atan2(py - top, px - cx) + Math.PI) / (Math.PI / 9));
        else seg = 20 + Math.floor((py - top) / 6) * 2 + (px < cx ? 0 : 1);
        const edge = (py >= top && (py - top) % 6 === 5) || (py < top && (Math.atan2(py - top, px - cx) + Math.PI) % (Math.PI / 9) < 0.06);
        set(px, py, edge ? M.mortar : M.stone, edge ? 2 : 4.4 + hs(seg, 1, 91) * 0.6 + (inA(px, py, 1) ? 0 : 1));
        continue;
      }
      const gx = px - ox, gy = py - oy;
      const came = Math.abs(px - cx) < 1 || py === oy + Math.round(oh * 0.52) || (py > top && (py - oy) % 15 === 0);
      if (came) set(px, py, M.iron, 2.6); else { mat[py * W + px] = M.sky; em[py * W + px] = 1; glass.push(py * W + px); }
    }
    for (let py = oy + oh; py < oy + oh + 5; py++) for (let px = ox - 4; px < ox + ow + 4; px++) set(px, py, M.stone, py === oy + oh ? 6.4 : (py === oy + oh + 4 ? 1.2 : 4.6));
    for (let py = oy + oh + 5; py < oy + oh + 8; py++) for (let px = ox - 3; px < ox + ow + 3; px++) add(px, py, -1.4);
    const drape = (x0, dir) => {
      for (let py = oy - 4; py < oy + oh + 4; py++) {
        const tie = oy + Math.round(oh * 0.62);
        let wd = py < tie ? 12 - Math.floor((py - oy) / 9) : 5 + Math.floor((py - tie) / 3);
        wd = Math.max(4, Math.min(13, wd));
        for (let k = 0; k < wd; k++) {
          const px = x0 + k * dir; const fold = Math.sin(k * 1.5 + (py * 0.05));
          set(px, py, M.fabric, 3.8 + (fold > 0.3 ? 1 : (fold < -0.5 ? -1 : 0)) - (k === wd - 1 ? 1.4 : 0));
        }
        if (Math.abs(py - tie) <= 1) for (let k = 0; k < wd + 1; k++) set(x0 + k * dir, py, M.gold, py === tie ? 5.5 : 3.8);
      }
    };
    drape(ox - 8, 1); drape(ox + ow + 7, -1);
    for (let px = ox - 11; px < ox + ow + 11; px++) { set(px, oy - 6, M.iron, 5); set(px, oy - 5, M.iron, 2.4); }
    for (let k = 0; k < 3; k++) for (let j = 0; j < 3; j++) { set(ox - 13 + k, oy - 7 + j, M.iron, 4 + (k === 0 ? 1.5 : 0)); set(ox + ow + 10 + k, oy - 7 + j, M.iron, 4); }
    const pxp = ox + ow - 14, pyp = oy + oh - 1;
    for (let r = 0; r < 8; r++) for (let k = 0; k < 10 - (r > 5 ? 2 : 0); k++) set(pxp + k + (r > 5 ? 1 : 0), pyp - r, M.clay, r === 7 ? 5.5 : (k === 0 ? 4.5 : (k > 6 ? 1.6 : 3.2)));
    for (let k = 0; k < 26; k++) { const lx = pxp + 5 + Math.round((hs(k, 1, 95) - 0.5) * 12), ly = pyp - 8 - Math.floor(hs(k, 2, 95) * 10); set(lx, ly, M.moss, 2.5 + hs(k, 3, 95) * 4); }
    glass.box = { ox, oy, ow, oh, r0, cx, top };
  }

  // table
  if (R.table) {
    const ty0 = tb.y, ty1 = tb.y + tb.h, ap = 10;
    for (let py = ty0; py < ty1 - ap; py++) for (let px = 0; px < W; px++) {
      const r = py - ty0, pi = Math.floor(r / 12), ry = r % 12, off = Math.floor(hs(pi, 0, 61) * 120), lx = (px + off) % 120;
      let s = 4.0 + (hs(pi, 1, 61) - 0.5) * 0.6 + (vn(px * 0.03, py * 0.9 + pi * 7, 62) - 0.5) * 0.7;
      if (vn(px * 0.02 + pi * 3, py * 1.7, 63) > 0.84) s -= 0.9;
      if (ry === 0) s = 1.2; else if (ry === 1) s = 5.7; else if (ry === 11) s = 2.8;
      if (lx === 0) s = 1.5; else if (lx === 1) s = 5;
      set(px, py, M.wood, s);
      if (lx === 4 && (ry === 3 || ry === 8)) { set(px, py, M.iron, 5.4); }
    }
    for (let pi = 0; pi * 12 < tb.h - ap; pi++) for (let k = 0; k < 2; k++) {
      if (hs(pi, k, 64) < 0.75) continue;
      const kx = Math.floor(hs(pi, k + 5, 64) * W), ky = ty0 + pi * 12 + 4 + Math.floor(hs(pi, k + 9, 64) * 4);
      for (let dy = -2; dy <= 2; dy++) for (let dx = -5; dx <= 5; dx++) { const e = (dx * dx) / 25 + (dy * dy) / 4; if (e <= 1) add(kx + dx, ky + dy, e > 0.55 ? -1.3 : (e < 0.15 ? -2.4 : -0.2)); }
    }
    for (let k = 0; k < Math.floor(W / 60); k++) { let sx = Math.floor(hs(k, 1, 65) * W), sy = ty0 + 3 + Math.floor(hs(k, 2, 65) * (tb.h - ap - 6)); const len = 3 + Math.floor(hs(k, 3, 65) * 6); for (let j = 0; j < len; j++) add(sx + j, sy + (j % 3 === 2 ? 1 : 0), 1.1); }
    for (let py = ty0 - 3; py < ty0; py++) for (let px = 0; px < W; px++) add(px, py, -1.8 + (ty0 - py - 1) * 0.6);
    for (let py = ty1 - ap; py < ty1; py++) for (let px = 0; px < W; px++) {
      const r = py - (ty1 - ap); let s;
      if (r === 0) s = 6.4; else if (r === 1) s = 4.2; else if (r === 2) s = 1.2; else if (r === ap - 1) s = 0.4;
      else s = 2.6 + ((px % 40 === 0) ? -0.8 : 0);
      set(px, py, M.wood, s);
      const sx = (px + 20) % 96;
      if (r > 2 && r < ap - 1 && sx < 4) { set(px, py, M.iron, sx === 0 ? 4.8 : 2.8); if ((r === 4 || r === 7) && sx === 1) set(px, py, M.iron, 6.4); }
    }
  }

  let circle = null;
  if (R.zone && R.table) {
    const ccx = R.zone.x + R.zone.w / 2, ccy = R.zone.y + R.zone.h * 0.62;
    // phone: the circle at the design's mobile scale (.62 × .6) so it fits the screen
    const mob = W * PX < 600;
    circle = circlePixels(ccx, ccy, mob ? 29 : 46, mob ? 13 : 22);
    circle.forEach(([x, y, s]) => { if (y >= tb.y && y < tb.y + tb.h - 10) set(x, y, M.chalk, 2.2 + s * 1.8); });
  }
  // table props (wide only)
  if (opts.wide && R.lamp && R.cardSlot && R.table) {
    const mw = 44, mh = 26, mx = (R.zone ? R.zone.x : R.cardSlot.x) - 110, my = tb.y + 12;
    for (let py = my + 2; py < my + mh + 2; py++) for (let px = mx + 2; px < mx + mw + 2; px++) add(px, py, -1.6);
    for (let py = my; py < my + mh; py++) for (let px = mx; px < mx + mw; px++) {
      const lx = px - mx, ly = py - my;
      if (lx < 3 || lx >= mw - 3) { set(px, py, M.parch, (lx === 0 || lx === mw - 1) ? 1.6 : 4.4 - (lx === 2 || lx === mw - 3 ? 1.4 : 0)); continue; }
      let s = 4.4 + (ly === 0 ? 1 : 0) - (ly === mh - 1 ? 1.4 : 0);
      if (lx === Math.floor(mw / 2) || ly === Math.floor(mh / 2)) s -= 0.6;
      const coast = Math.abs(vn(px * 0.12, py * 0.12, 102) - 0.5) < 0.04;
      set(px, py, coast ? M.parch : M.parch, coast ? 1.4 : s);
    }
    for (let k = 0; k < 9; k++) { const px = mx + 8 + k * 3, py = my + 18 - Math.round(Math.sin(k * 0.7) * 5); if (k % 2 === 0) set(px, py, M.fabric, 5); }
    set(mx + 35, my + 7, M.fabric, 6); set(mx + 36, my + 8, M.fabric, 6); set(mx + 35, my + 8 + 1, M.fabric, 6); set(mx + 36, my + 7, M.fabric, 6);
    for (let k = -3; k <= 3; k++) { set(mx + 10 + k, my + 7, M.parch, 1.2); set(mx + 10, my + 7 + k, M.parch, 1.2); }
    const ix = R.cardSlot.x + R.cardSlot.w + 14, iy = tb.y + 26;
    if (ix + 30 < W) {
      for (let py = iy; py < iy + 9; py++) for (let px = ix; px < ix + 10; px++) set(px, py, M.iron, (px === ix + 2 && py < iy + 6) ? 6 : (px > ix + 7 ? 1.4 : 2.6) + (py === iy ? 1.6 : 0));
      for (let py = iy - 2; py < iy; py++) for (let px = ix + 3; px < ix + 7; px++) set(px, py, M.iron, 4);
      for (let k = 0; k < 20; k++) { const px = ix + 5 - Math.round(k * 0.6), py = iy - 2 - k; set(px, py, M.parch, 6.5); if (k > 5) { set(px - 1, py, M.parch, 5); set(px - 2, py + 1, M.parch, 3.5); set(px + 1, py, M.parch, 4.4); } }
      for (let py = iy + 9; py < iy + 11; py++) for (let px = ix + 1; px < ix + 12; px++) add(px, py, -1.6);
      const coin = (cx0, cy0, n) => { for (let j = 0; j < n; j++) for (let dx = 0; dx < 6; dx++) { set(cx0 + dx, cy0 - j * 2, M.gold, dx === 0 ? 6 : (dx === 5 ? 2.4 : 4.4)); set(cx0 + dx, cy0 - j * 2 + 1, M.gold, 2.2); } for (let dx = 1; dx < 7; dx++) add(cx0 + dx, cy0 + 2, -1.4); };
      coin(ix + 18, iy + 8, 4); coin(ix + 26, iy + 10, 2); coin(ix + 21, iy + 14, 1);
    }
  }

  // light
  const lx = R.lamp ? R.lamp.x + R.lamp.w / 2 : W * 0.4, ly = R.lamp ? R.lamp.y + R.lamp.h * 0.42 : wallB;
  const wx = glass && glass.box ? glass.box.cx : -999, wy = glass && glass.box ? glass.box.top + 20 : -999;
  const ctx = cv.getContext('2d');
  const img = ctx.createImageData(W, H), d = img.data;
  for (let py = 0; py < H; py++) for (let px = 0; px < W; px++) {
    const i = py * W + px, m = mat[i];
    if (em[i]) continue;
    const dx = px - lx, dy = py - ly, onT = py >= tb.y;
    const dist = onT ? Math.sqrt(dx * dx + dy * dy * 4.4) : Math.sqrt(dx * dx * 0.8 + dy * dy * 0.95);
    let L = 5.2 * Math.pow(Math.max(0, 1 - dist / (onT ? 150 : 200)), 1.7);
    const wd = Math.hypot(px - wx, (py - wy) * 0.8); L += 0.9 * Math.max(0, 1 - wd / 55);
    const vx = px / W - 0.5, vy = py / H - 0.45; L -= 1.1 * Math.min(1, vx * vx * 2.4 + vy * vy * 1.8);
    const ramp = RAMP_RGB[m];
    let idx = Math.floor(sh[i] + L + 0.5 + (BAY[(py & 3) * 4 + (px & 3)] - 0.5) * 0.4);
    idx = idx < 0 ? 0 : (idx >= ramp.length ? ramp.length - 1 : idx);
    const c = ramp[idx], o = i * 4; d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255;
  }
  ctx.putImageData(img, 0, 0);
  return { ctx, img, glass, W, H, circle, tableBox: R.table };
}

function paintGlass(S, t) {
  const g = S.glass; if (!g || !g.box) return;
  const { ox, oy, ow, oh, r0, cx } = g.box, d = S.img.data, W = S.W, sky = RAMP_RGB[M.sky];
  const mcx = ox + ow * 0.68, mcy = oy + r0 * 0.75, gb = oy + oh;
  let minX = 1e9, minY = 1e9, maxX = 0, maxY = 0;
  for (let k = 0; k < g.length; k++) {
    const i = g[k], px = i % W, py = (i - px) / W, b = BAY[(py & 3) * 4 + (px & 3)];
    if (px < minX) minX = px; if (py < minY) minY = py; if (px > maxX) maxX = px; if (py > maxY) maxY = py;
    let c;
    const ridge = gb - 16 - vn(px * 0.09, 3, 111) * 12, trees = gb - 6 - ((px * 7) % 5 < 2 ? 3 : 0) - vn(px * 0.3, 5, 112) * 3;
    const md = Math.hypot(px - mcx, py - mcy);
    if (py > trees) c = [10, 10, 20];
    else if (py > ridge) c = py < ridge + 1.2 ? [43, 44, 82] : [20, 21, 46];
    else if (md < 4.6) { const sh = Math.floor((px - mcx + 4) / 2.6 + b) ; c = MOON[Math.max(0, Math.min(4, sh + (hs(px, py, 113) < 0.15 ? -1 : 0)))]; }
    else if (hs(px, py, 114) < 0.035) c = hs(px, py, 115) < 0.5 ? MOON[3] : MOON[1];
    else { let si = Math.floor((py - oy) / oh * 5.5 + b - (md < 9 ? 1.2 : 0) * 0 + (md < 9 ? 1 : 0)); si = Math.max(0, Math.min(sky.length - 1, si)); c = sky[si]; }
    const fz = (py - (gb - 22)) / 22;
    if (fz > 0) {
      const den = vn((px + t * 0.5) * 0.13, py * 0.22, 116) * 0.8 + vn((px - t * 0.3) * 0.07, py * 0.12, 117) * 0.6 + fz * 0.5;
      if (den + (b - 0.5) * 0.35 > 1.05) c = FOG[Math.min(3, Math.floor((den - 1.05) * 6 + b * 1.5))];
    }
    const o = i * 4; d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255;
  }
  S.ctx.putImageData(S.img, 0, 0, minX, minY, maxX - minX + 1, maxY - minY + 1);
}

// Magic Stack — easter egg: put the lamp inside the magic circle and the
// circle bursts into a tall pixel-art blaze, far higher than the light a book
// raises. It does nothing else, and it dies down when the lamp is taken away.
//
// Classic "fire spread" at the room's resolution (1 cell = PX CSS pixels):
// the circle's ring is the fuel, heat climbs, drifts and cools row by row.

const BLAZE_RAMP = ['#2a120e', '#4a1e16', '#6e2c1e', '#954028', '#b85636', '#e27a3f', '#f3b04a', '#f6cc62', '#fbe598', '#ffffff'].map(hx);
const BLAZE_MAX = 60;

function makeBlaze(host) {
  const cv = document.createElement('canvas');
  cv.className = 'ms-blaze';
  cv.setAttribute('aria-hidden', 'true');
  cv.hidden = true;
  host.prepend(cv);
  let gw = 0, gh = 0, heat = null, ring = [], fuel = false, timer = null, img = null, ctx = null;

  function layout(box) {
    // box: circle centre and radii in CSS px, relative to the host
    const w = Math.ceil((box.rx * 3.2) / PX), h = Math.ceil(box.height / PX);
    if (w !== gw || h !== gh) {
      gw = w; gh = h; heat = new Uint8Array(gw * gh);
      cv.width = gw; cv.height = gh;
      ctx = cv.getContext('2d'); img = ctx.createImageData(gw, gh);
    }
    cv.style.width = (gw * PX) + 'px'; cv.style.height = (gh * PX) + 'px';
    cv.style.left = Math.round(box.cx - (gw * PX) / 2) + 'px';
    cv.style.top = Math.round(box.cy + box.ry * 1.1 - gh * PX) + 'px';
    // fuel cells: the ellipse of the circle, in grid coordinates
    ring = [];
    const cx = gw / 2, cy = gh - 1 - (box.ry * 1.1) / PX, rx = box.rx / PX, ry = box.ry / PX;
    for (let k = 0; k < 220; k++) {
      const t = (k / 220) * Math.PI * 2;
      const x = Math.round(cx + Math.cos(t) * rx), y = Math.round(cy + Math.sin(t) * ry);
      if (x >= 0 && x < gw && y > 0 && y < gh) ring.push(y * gw + x);
    }
  }

  function step() {
    // uneven fuel along the ring, so the fire splits into separate tongues
    if (fuel) for (const i of ring) heat[i] = Math.random() < 0.55 ? BLAZE_MAX - ((Math.random() * 10) | 0) : (Math.random() * 24) | 0;
    let alive = false;
    for (let y = 1; y < gh; y++) {
      for (let x = 0; x < gw; x++) {
        const src = y * gw + x, h = heat[src];
        if (!h) { heat[src - gw] = 0; continue; }
        alive = true;
        const r = (Math.random() * 3) | 0;   // drift -1, 0 or +1: flames stand straight
        const dst = src - gw - r + 1;
        const cool = (Math.random() < 0.6 ? 1 : 0) + (Math.random() < 0.14 ? 1 : 0);
        if (dst >= 0 && dst < heat.length) heat[dst] = Math.max(0, h - cool);
      }
    }
    return alive || fuel;
  }

  function draw() {
    const d = img.data;
    for (let y = 0; y < gh; y++) for (let x = 0; x < gw; x++) {
      const i = y * gw + x, h = heat[i], o = i * 4;
      const b = BAY[(y & 3) * 4 + (x & 3)];
      if (h + b * 6 < 12) { d[o + 3] = 0; continue; }   // cool air shows through: separate tongues
      const k = Math.min(BLAZE_RAMP.length - 1, Math.floor((h / BLAZE_MAX) * BLAZE_RAMP.length + (b - 0.5) * 0.9));
      const c = BLAZE_RAMP[Math.max(0, k)];
      d[o] = c[0]; d[o + 1] = c[1]; d[o + 2] = c[2]; d[o + 3] = 255;
    }
    ctx.putImageData(img, 0, 0);
  }

  // heat climbs one row per step: a few steps per frame make it roar up fast
  function loop() {
    let more = false;
    for (let n = 0; n < 3; n++) more = step() || more;
    draw();
    if (!more) { stop(); cv.hidden = true; }
  }
  function stop() { clearInterval(timer); timer = null; }

  return {
    layout,
    set(on, reduced) {
      if (on === fuel && (timer || !on)) return;
      fuel = on;
      if (!heat) return;
      if (on) {
        cv.hidden = false;
        if (reduced) { for (let n = 0; n < 160; n++) step(); draw(); return; }   // a still frame, no motion
        for (let n = 0; n < 12; n++) step();   // a quick burst before the first frame
        if (!timer) timer = setInterval(loop, 60);
      } else if (reduced) { heat.fill(0); cv.hidden = true; }
      else if (!timer) timer = setInterval(loop, 60);
    },
    get on() { return fuel; },
  };
}

// ---------------------------------------------------------------------------
// The shelf and the table — state and interaction (vanilla port of the
// React component in "Estante e Mesa v2").
// ---------------------------------------------------------------------------
const DATA = JSON.parse(document.getElementById('shelf-data').textContent);
const BOOKS = DATA.books;
// object art: see shelf.props.js (pixel-art sprites)

const $ = (id) => document.getElementById(id);
const E = {
  root: $('ms-root'), canvas: $('ms-canvas'), crown: $('ms-crown'), nav: $('ms-nav'), win: $('ms-window'),
  table: $('ms-table'), pool: $('ms-pool'), glowbox: $('ms-glowbox'), glow: $('ms-glow'), beams: $('ms-beams'),
  zone: $('ms-zone'), drop: $('ms-droplabel'), cover: $('ms-cover'), slot: $('ms-cardslot'), hint: $('ms-hint'),
  card: $('ms-card'), props: $('ms-props'), mini: $('ms-mini'), drag: $('ms-drag'), overlay: $('ms-overlay'), live: $('ms-live'),
};
// ---------------- language ----------------
const lang = () => (window.msLang ? window.msLang() : 'pt');
const tr = (v) => (v && typeof v === 'object' && !Array.isArray(v) ? (v[lang()] || v.pt || v.en) : v);
const U = {
  pt: {
    status: { completo: 'Completo', andamento: 'Em andamento', rascunho: 'Rascunho' },
    contents: 'SUMÁRIO', period: 'PERÍODO', place: 'LUGAR', author: 'AUTORIA', additions: 'ACRÉSCIMOS',
    one: 'pessoa contribuiu', many: 'pessoas contribuíram', none: 'Nenhuma contribuição aceita ainda',
    onTable: 'na mesa', open: 'Abrir', contribute: 'Contribuir', giveBack: 'Devolver à estante', keys: 'ENTER ABRE · ESC DEVOLVE',
    drop: 'SOLTE PARA POUSAR', put: 'COLOQUE NA MESA',
    lampTip: 'Arraste o lampião até um livro para ler o resumo', propTip: 'Arraste para mudar de lugar',
    placed: (t) => `${t} está na mesa. Enter abre, Esc devolve à estante.`, back: (t) => `${t} voltou à estante.`, opened: (t) => `${t} aberto.`,
    by: 'por', backShelf: '← Voltar à estante', enter: 'Abrir o grimório →',
    tags: ['HISTÓRIA', 'FICÇÃO', 'HISTÓRIA + FICÇÃO'],
    caseOf: (i, n) => `ESTANTE ${i} DE ${n}`, caseAria: (i, n) => `Estante ${i} de ${n}`, prev: 'Estante anterior', next: 'Próxima estante',
    coverTip: 'Duplo clique para abrir · arraste até a estante para devolver', theBook: 'O livro',
  },
  en: {
    status: { completo: 'Complete', andamento: 'In progress', rascunho: 'Draft' },
    contents: 'CONTENTS', period: 'PERIOD', place: 'PLACE', author: 'AUTHOR', additions: 'ADDITIONS',
    one: 'person contributed', many: 'people contributed', none: 'No contributions accepted yet',
    onTable: 'on the table', open: 'Open', contribute: 'Contribute', giveBack: 'Back to the shelf', keys: 'ENTER OPENS · ESC PUTS BACK',
    drop: 'RELEASE TO PLACE IT', put: 'PUT IT ON THE TABLE',
    lampTip: 'Drag the lamp to a book to read its summary', propTip: 'Drag to move it',
    placed: (t) => `${t} is on the table. Enter opens it, Esc puts it back.`, back: (t) => `${t} is back on the shelf.`, opened: (t) => `${t} opened.`,
    by: 'by', backShelf: '← Back to the shelf', enter: 'Open the grimoire →',
    tags: ['HISTORY', 'FICTION', 'HISTORY + FICTION'],
    caseOf: (i, n) => `BOOKCASE ${i} OF ${n}`, caseAria: (i, n) => `Bookcase ${i} of ${n}`, prev: 'Previous bookcase', next: 'Next bookcase',
    coverTip: 'Double-click to open · drag to the shelf to put it back', theBook: 'The book',
  },
};
const u = () => U[lang()] || U.pt;
const statusLabel = (st) => u().status[st] || st;

const esc = (s) => String(s == null ? '' : s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

const S = {
  lay: null, pdrag: null, lampBook: null, hoverId: null, drag: null, placedId: null,
  opening: false, opened: false, magicColor: null,
  propPos: (() => { try { return JSON.parse(localStorage.getItem(PKEY) || '{}'); } catch (e) { return {}; } })(),
};
let pending = null, ppend = null, justDragged = false, skipLand = false, landFrom = null;
let scene = null, sig = null, laySig = null, paintRaf = null, lastPaint = 0, fogT = 0;
let glowColor = null, glowScene = null, cc = '#dfe7d9', pulseAnim = null, lidAnim = null, flameAnim = null;
let mobileNow = null, capNow = null, propEls = {};

const book = (id) => BOOKS.find((b) => b.id === id);
const isReduced = () => !!(window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches);
const isMobile = () => window.innerWidth < 600;
const announce = (t) => { E.live.textContent = t; };
const spineEl = (id) => document.querySelector(`.ms-book[data-id="${id}"] .ms-spine`);
const spineCenter = (id) => { const el = spineEl(id); if (!el) return null; const r = el.getBoundingClientRect(); return { x: r.left + r.width / 2, y: r.top + r.height / 2 }; };

// ---------------- shelf rows and bookcases ----------------
// Desktop: books fill bookcases of two shelves, leaving room for the props
// (row 1 up to 68 % of its width, row 2 up to 46 %). More books than fit open
// another bookcase to the side, reached by scrolling sideways or with the
// arrows under the shelf. Phone: one shelf that scrolls sideways.
let layoutKey = null, mobileK = 0.85, pager = null, cases = null, scrollTimer = null;
const ROW_LIMITS = [0.68, 0.46];

function sizeSpines(k) {
  E.nav.querySelectorAll('.ms-book, .ms-empty').forEach((li) => {
    if (li.classList.contains('ms-book')) {
      const b = book(li.dataset.id);
      li.style.width = Math.round(b.w * k) + 'px'; li.style.height = Math.round(b.h * k) + 'px';
    } else { li.style.width = Math.round(44 * Math.min(1, k / 0.85)) + 'px'; li.style.height = Math.round(168 * k) + 'px'; }
  });
}
function rowEl(items) {
  const wrap = document.createElement('div'); wrap.className = 'ms-rowwrap';
  const ul = document.createElement('ul'); ul.className = 'ms-row'; ul.append(...items);
  const gap = document.createElement('div'); gap.className = 'ms-row-gap'; gap.setAttribute('aria-hidden', 'true');
  wrap.append(ul, gap); return wrap;
}
function arrangeRows() {
  const mobile = isMobile();
  const k = mobile ? mobileK : 1;
  const navW = E.nav.clientWidth;
  const key = `${mobile}|${k.toFixed(3)}|${mobile ? 0 : Math.round(navW)}`;
  if (key === layoutKey) return;
  layoutKey = key;
  const items = Array.from(E.nav.querySelectorAll('.ms-book, .ms-empty'));
  sizeSpines(k);
  if (mobile) {
    E.nav.replaceChildren(rowEl(items));
    cases = null; updatePager(); return;
  }
  const rowW = Math.max(200, navW - 32 - 40);
  const pages = []; let cur = [[], []], r = 0, acc = 0;
  for (const li of items) {
    const w = parseFloat(li.style.width) + 4;
    if (acc + w > rowW * ROW_LIMITS[r] && cur[r].length) {
      r += 1; acc = 0;
      if (r > 1) { pages.push(cur); cur = [[], []]; r = 0; }
    }
    cur[r].push(li); acc += w;
  }
  pages.push(cur);
  cases = document.createElement('div'); cases.className = 'ms-cases';
  pages.forEach((pg, i) => {
    const page = document.createElement('div'); page.className = 'ms-casepage';
    page.setAttribute('aria-label', u().caseAria(i + 1, pages.length));
    page.append(rowEl(pg[0]), rowEl(pg[1]));
    cases.append(page);
  });
  cases.addEventListener('scroll', onCasesScroll, { passive: true });
  cases.addEventListener('scrollend', () => { clearTimeout(scrollTimer); updatePager(); laySig = null; schedulePaint(); });
  E.nav.replaceChildren(cases);
  updatePager();
}
function updatePager() {
  const n = cases ? cases.children.length : 1;
  if (!pager) {
    pager = document.createElement('div'); pager.className = 'ms-pager';
    pager.innerHTML = '<button type="button" class="ms-pg prev">◀</button><span class="ms-pg-label" aria-live="polite"></span><button type="button" class="ms-pg next">▶</button>';
    pager.querySelector('.prev').addEventListener('click', () => turnCase(-1));
    pager.querySelector('.next').addEventListener('click', () => turnCase(1));
    E.nav.after(pager);
  }
  pager.hidden = n < 2;
  if (n < 2) return;
  const i = Math.round(cases.scrollLeft / Math.max(1, cases.clientWidth));
  pager.querySelector('.ms-pg-label').textContent = u().caseOf(i + 1, n);
  pager.querySelector('.prev').setAttribute('aria-label', u().prev);
  pager.querySelector('.next').setAttribute('aria-label', u().next);
  pager.querySelector('.prev').disabled = i === 0;
  pager.querySelector('.next').disabled = i >= n - 1;
}
function turnCase(dir) {
  if (!cases) return;
  cases.scrollBy({ left: dir * cases.clientWidth, behavior: isReduced() ? 'auto' : 'smooth' });
}
function onCasesScroll() {
  hideTip();
  clearTimeout(scrollTimer);
  scrollTimer = setTimeout(() => { updatePager(); laySig = null; schedulePaint(); }, 160);
}
const inNav = (el) => {
  const n = E.nav.getBoundingClientRect(), r = el.getBoundingClientRect();
  return r.left >= n.left - 2 && r.right <= n.right + 2;   // only the bookcase fully in view
};

// Phone: shrink the shelf and the table so the whole room fits the screen.
function fitMobile() {
  if (!isMobile()) { E.root.style.removeProperty('--row-h'); E.root.style.removeProperty('--gs'); mobileK = 0.85; return; }
  const H = window.innerHeight;
  const info = (E.card.hidden ? E.hint : E.card).offsetHeight;
  const top = parseFloat(getComputedStyle(document.querySelector('.ms-wall')).paddingTop) || 96;
  const fixed = top + 40 + 12 + 16 + 12 + 16 + info;   // top space, crown, row gap, table padding and gap, hint/card
  const rowH = Math.max(132, Math.min(196, H - fixed - 200));
  const gs = Math.max(0.55, Math.min(1, (H - fixed - rowH) / 200));
  E.root.style.setProperty('--row-h', rowH + 'px');
  E.root.style.setProperty('--gs', gs.toFixed(3));
  mobileK = 0.85 * rowH / 196;
}
function relayout() { fitMobile(); arrangeRows(); updateSpines(); schedulePaint(); }

// Hover summary over a spine (one shared element, so the scrolling shelf never clips it)
const tipEl = document.createElement('div');
tipEl.className = 'ms-tip'; tipEl.setAttribute('role', 'tooltip'); tipEl.hidden = true;
E.root.append(tipEl);
function showTip(id) {
  const b = book(id), sp = spineEl(id); if (!b || !sp) return;
  tipEl.innerHTML = `<div class="ms-tip-title">${esc(tr(b.title))}</div><div class="ms-tip-meta">${esc(b.system)} · ${statusLabel(b.status)}</div><span class="ms-tip-arrow"></span>`;
  const rr = E.root.getBoundingClientRect(), r = sp.getBoundingClientRect();
  tipEl.style.left = (r.left + r.width / 2 - rr.left) + 'px';
  tipEl.style.top = (r.top - rr.top - 10) + 'px';
  tipEl.hidden = false;
}
function hideTip() { tipEl.hidden = true; }

// ---------------- render: spines, circle, cover, card, drag, mini ----------------
function updateSpines() {
  const reduced = isReduced(), mobile = isMobile(), dragId = S.drag && S.drag.id;
  document.querySelectorAll('.ms-book').forEach((li) => {
    const id = li.dataset.id;
    const hidden = S.placedId === id || dragId === id;
    const tip = !mobile && S.hoverId === id && !S.drag && !hidden;
    li.classList.toggle('is-gone', hidden);
    li.classList.toggle('is-lift', S.hoverId === id && !S.drag && !reduced);
    li.classList.toggle('is-tip', tip);
  });
  const tipId = !mobile && S.hoverId && !S.drag && S.hoverId !== S.placedId ? S.hoverId : null;
  if (tipId) showTip(tipId); else hideTip();
}

function updateCircle() {
  const pb = S.placedId ? book(S.placedId) : null;
  const fromTable = !!(S.drag && S.drag.from === 'table');
  const lit = !!pb && !fromTable;
  const random = DATA.circle === 'random';
  cc = lit ? (random ? (S.magicColor || MAGIC[0]) : (pb.magic || SYS_COLOR[pb.system] || '#f3b04a')) : '#dfe7d9';
  E.pool.classList.toggle('is-lit', lit);
  // with a book awake in the circle, the lamp's fire (and the candle's) takes its colour
  blaze.tint(lit ? cc : null); candleBlaze.tint(lit ? cc : null);
  E.glowbox.style.background = `radial-gradient(closest-side, ${lit ? cc + '44' : 'transparent'} 0 40%, ${lit ? cc + '1a' : 'transparent'} 40% 70%, transparent 70%)`;
  E.glow.style.filter = `drop-shadow(0 0 4px ${cc}) drop-shadow(0 0 14px ${cc})`;
  E.beams.querySelectorAll('.ms-beam').forEach((bm) => {
    bm.style.background = `linear-gradient(to top, ${cc} 0 20%, ${cc}88 20% 45%, ${cc}33 45% 75%, transparent 75%)`;
  });
  syncGlow();
}

function coverFront(b) {
  if (b.coverHtml) return tr(b.coverHtml);
  return `<div class="ms-generic" style="background:${b.color}; color:${b.ink}; box-shadow:inset 0 0 0 2px #0b0b14, inset 0 0 0 8px ${b.light}, inset 0 0 0 10px #0b0b14;">
    <span class="d" style="background:${b.band}"></span><div class="t">${esc(tr(b.title))}</div><div class="m">${esc(b.system)}</div></div>`;
}

function renderPlaced() {
  const pb = S.placedId ? book(S.placedId) : null;
  E.hint.hidden = !!pb;
  if (!pb) { E.cover.hidden = true; E.cover.innerHTML = ''; E.card.hidden = true; E.card.innerHTML = ''; return; }
  E.cover.hidden = false;
  E.cover.innerHTML = `
    <div class="ms-cover-inside" aria-hidden="true"><div class="k">${u().contents}</div>${tr(pb.toc).map((t) => `<div class="s">${esc(t.s)}</div>`).join('')}</div>
    <div class="ms-lid" id="ms-lid">
      <div class="ms-face front">${coverFront(pb)}</div>
      <div class="ms-face back" aria-hidden="true"><div class="t">${esc(tr(pb.title))}</div><div class="m">${esc(pb.system)}</div></div>
    </div>`;
  const contrib = pb.contributors
    ? `${pb.contributors} ${pb.contributors === 1 ? u().one : u().many}`
    : u().none;
  E.card.setAttribute('aria-label', `${tr(pb.title)}, ${u().onTable}`);
  E.cover.title = u().coverTip;
  E.card.innerHTML = `
    <div class="ms-card-meta"><span class="ms-status" style="background:${STATUS_BG[pb.status]}">${statusLabel(pb.status)}</span><span>${esc(pb.system)}</span></div>
    <h2>${esc(tr(pb.title))}</h2>
    <p>${esc(tr(pb.synopsis))}</p>
    <dl>
      <dt>${u().period}</dt><dd>${esc(tr(pb.period))}</dd>
      <dt>${u().place}</dt><dd>${esc(tr(pb.place))}</dd>
      <dt>${u().author}</dt><dd>${esc(pb.author)}</dd>
      <dt>${u().additions}</dt><dd>${contrib}</dd>
    </dl>
    <div class="ms-card-actions">
      <button type="button" class="ms-btn" id="ms-open">${u().open}</button>
      <a class="ms-btn dark" href="${esc(tr(pb.contribHref))}">${u().contribute}</a>
      <button type="button" class="ms-linkbtn" id="ms-return">${u().giveBack}</button>
    </div>
    <span class="ms-card-keys">${u().keys}</span>`;
  E.card.hidden = false;
  $('ms-open').addEventListener('click', open);
  $('ms-return').addEventListener('click', returnBook);
}

function updateDragUI() {
  const fromTable = !!(S.drag && S.drag.from === 'table');
  E.cover.classList.toggle('is-away', fromTable);
  E.nav.classList.toggle('is-drop', !!(fromTable && S.drag.over));
  const shelfDragging = !!S.drag && !fromTable;
  E.drop.hidden = !shelfDragging;
  if (shelfDragging) E.drop.firstElementChild.textContent = S.drag.over ? u().drop : u().put;
  const db = S.drag ? book(S.drag.id) : null;
  if (!S.drag || !db) { E.drag.hidden = true; E.drag.innerHTML = ''; E.drag.dataset.for = ''; return; }
  const key = db.id + '|' + S.drag.from;
  if (E.drag.dataset.for !== key) {
    E.drag.dataset.for = key;
    E.drag.style.setProperty('--c', db.color); E.drag.style.setProperty('--ink', db.ink);
    E.drag.style.setProperty('--light', db.light); E.drag.style.setProperty('--band', db.band);
    E.drag.innerHTML = fromTable
      ? `<div class="ms-generic"><span class="d" style="background:${db.band}"></span><span class="t">${esc(tr(db.title))}</span></div>`
      : `<span class="ms-sp-band top"></span><span class="ms-sp-band bot"></span><span class="ms-sp-title"><span>${esc(tr(db.title))}</span></span>`;
  }
  Object.assign(E.drag.style, { left: S.drag.x + 'px', top: S.drag.y + 'px', width: S.drag.w + 'px', height: S.drag.h + 'px', transform: 'rotate(6deg)' });
  E.drag.hidden = false;
}

function updateMini() {
  const mb = S.lampBook ? book(S.lampBook) : null;
  const sp = mb && spineEl(mb.id);
  if (!mb || !sp) { E.mini.hidden = true; return; }
  const rr = E.root.getBoundingClientRect(), r = sp.getBoundingClientRect();
  const x = r.right - rr.left + 18;
  E.mini.innerHTML = `<div class="meta"><span style="background:${STATUS_BG[mb.status]}">${statusLabel(mb.status)}</span><span>${esc(mb.system)}</span></div>
    <div class="t">${esc(tr(mb.title))}</div><div class="s">${esc(tr(mb.synopsis).split('. ')[0].replace(/\.$/, '') + '.')}</div>`;
  E.mini.style.left = Math.min(x, rr.width - 270) + 'px';
  E.mini.style.top = Math.max(8, r.top - rr.top - 10) + 'px';
  E.mini.hidden = false;
}

// ---------------- props (dice, potion, books, scroll, candle, orb, lamp) ----------------
function propBox(d) {
  const lay = S.lay, mobile = isMobile();
  const pos = S.propPos[d.id] || d.def;
  let cx, bottom;
  if (pos.surf === 'shelf') { if (mobile) return null; const r = lay.rows[Math.min(pos.row, lay.rows.length - 1)]; if (!r) return null; cx = r.x + pos.fx * r.w; bottom = r.y + r.h; }
  else if (pos.fx == null) { if (!lay.zone) return null; cx = lay.zone.x - (mobile ? 52 : 128) - 32; bottom = lay.zone.y + lay.zone.h - 8; }
  else { cx = lay.table.x + pos.fx * lay.table.w; bottom = lay.table.y + pos.ty; }
  return { x: Math.round(cx - d.w / 2), y: Math.round(bottom - d.h) };
}

function renderProps() {
  if (!S.lay || !S.lay.table) return;
  PROPS.forEach((d) => {
    let el = propEls[d.id];
    if (!el) {
      el = document.createElement('div');
      el.className = 'ms-prop';
      el.dataset.prop = d.id;
      el.style.width = d.w + 'px'; el.style.height = d.h + 'px';
      el.append(propArt(d.k));
      el.addEventListener('pointerdown', (e) => propDown(e, d.id));
      propEls[d.id] = el;
    }
    const dr = S.pdrag && S.pdrag.id === d.id;
    const box = dr ? S.pdrag : propBox(d);
    const onShelf = !dr && (S.propPos[d.id] || d.def).surf === 'shelf';
    // an object standing in the circle goes into the table, between the far
    // flames and the book, so the book is always in front of it
    const host = onShelf ? propsShelf : !dr && box && boxInCircle(box, d) ? propsIn : E.props;
    if (el.parentNode !== host) host.append(el);
    if (!box) { el.hidden = true; return; }
    el.hidden = false;
    el.title = d.id === 'lamp' ? u().lampTip : u().propTip;
    el.style.left = box.x + 'px'; el.style.top = box.y + 'px';
    el.style.transform = dr ? 'rotate(-4deg) translateY(-6px)' : 'none';
    el.style.zIndex = dr ? 70 : 1;
  });
  shadeProps();
  ambient();
  if (!S.pdrag) checkBlaze();
}

// Objects get darker away from the lamp, as the painted room does.
function shadeProps() {
  const lamp = propEls.lamp;
  if (!lamp || lamp.hidden) return;
  const lx = lamp.offsetLeft + lamp.offsetWidth / 2, ly = lamp.offsetTop + lamp.offsetHeight * 0.42;
  for (const id in propEls) {
    const el = propEls[id];
    if (id === 'lamp' || el.hidden) { el.style.filter = ''; continue; }
    const dx = el.offsetLeft + el.offsetWidth / 2 - lx, dy = el.offsetTop + el.offsetHeight / 2 - ly;
    const k = Math.max(0, 1 - Math.hypot(dx, dy * 1.1) / 900);
    el.style.filter = `brightness(${(0.55 + 0.5 * k).toFixed(2)}) saturate(${(0.75 + 0.25 * k).toFixed(2)})`;
  }
}

// Objects on the shelf sit in a layer behind the table, so the fire on the
// table is drawn in front of them; they stay clickable.
const propsShelf = document.createElement('div');
propsShelf.className = 'ms-props ms-props-shelf';
propsShelf.setAttribute('aria-hidden', 'true');
E.table.before(propsShelf);

// Easter eggs (shelf.blaze.js): the lamp inside the circle lights a tall
// blaze; the candle inside it lights a tiny one. Back flames are drawn in the
// table (behind the book), front flames over the table objects.
const blaze = makeBlaze(E.table, E.props);
const candleBlaze = makeBlaze(E.table, E.props, { scale: 0.22 });
// …and all seven objects round the circle, in the right order, summon the dog
const dogBlaze = makeBlaze(E.table, E.props, { style: 'magic' });
dogBlaze.tint('#b48cf0');
const dogFrame = makeFrameFire(E.props, 'egg-dog.png', 'Que que você tá arrumando, garoto?');
// clockwise from the top, as on screen: the lamp at the head of the circle
const RITE = ['lamp', 'orb', 'scroll', 'candle', 'potion', 'dice', 'stack'];
function riteDone() {
  if (S.placedId || !blazeBox || !S.lay || !S.lay.table) return false;
  const t = S.lay.table, ang = [];
  for (const id of RITE) {
    const el = propEls[id];
    if (!el || el.hidden || el.parentNode === propsShelf) return false;
    const bx = el.offsetLeft + el.offsetWidth / 2 - t.x - blazeBox.cx, by = el.offsetTop + el.offsetHeight - 8 - t.y - blazeBox.cy;
    const ex = bx / blazeBox.rx, ey = by / blazeBox.ry;
    if (ex * ex + ey * ey > 2.6) return false;          // on or near the ring
    ang.push({ id, a: Math.atan2(ey, ex) });
  }
  const lampA = ang[0].a;
  if (lampA > -Math.PI / 4 || lampA < -3 * Math.PI / 4) return false;   // the lamp at the top
  ang.sort((p, q) => ((p.a - lampA + 2 * Math.PI) % (2 * Math.PI)) - ((q.a - lampA + 2 * Math.PI) % (2 * Math.PI)));
  return ang.every((x, i) => x.id === RITE[i]);
}
let blazeBox = null;
function boxInCircle(box, d) {
  if (!blazeBox || !S.lay || !S.lay.table) return false;
  const t = S.lay.table;
  const bx = box.x + d.w / 2 - t.x, by = box.y + d.h - 8 - t.y;
  return ((bx - blazeBox.cx) / blazeBox.rx) ** 2 + ((by - blazeBox.cy) / blazeBox.ry) ** 2 <= 1.15;
}
function inCircle(el) {
  if (!el || el.hidden) return false;
  return boxInCircle({ x: el.offsetLeft, y: el.offsetTop }, { w: el.offsetWidth, h: el.offsetHeight });
}
// objects standing in the circle: inside the table, above the far flames, below the book
const propsIn = document.createElement('div');
propsIn.className = 'ms-props ms-props-in';
propsIn.setAttribute('aria-hidden', 'true');
E.table.append(propsIn);
function checkBlaze() {
  const rite = riteDone();
  const lamp = !rite && inCircle(propEls.lamp), candle = !rite && !lamp && inCircle(propEls.candle);
  if (rite && !dogBlaze.on) announce('Que que você tá arrumando, garoto?');
  dogBlaze.set(rite, isReduced());
  if (blazeBox && S.lay && S.lay.table) dogFrame.place(S.lay.table.x + blazeBox.cx - dogFrame.width / 2, Math.max(8, S.lay.table.y + blazeBox.cy - blazeBox.ry * 1.3 - dogFrame.height - 70));
  dogFrame.set(rite, isReduced());
  if (lamp && !blaze.on) announce(lang() === 'pt' ? 'O círculo pega fogo.' : 'The circle bursts into flame.');
  if (candle && !candleBlaze.on) announce(lang() === 'pt' ? 'Uma chaminha acende no círculo.' : 'A tiny flame lights up in the circle.');
  blaze.set(lamp, isReduced());
  candleBlaze.set(candle, isReduced());
}

function renderBeams() {
  const lay = S.lay;
  E.beams.replaceChildren();
  if (!lay || !lay.zone || !lay.table) return;
  const mob = isMobile();
  const zx = lay.zone.x - lay.table.x + lay.zone.w / 2, zy = lay.zone.y - lay.table.y + lay.zone.h * 0.62, rx = mob ? 116 : 184, ry = mob ? 52 : 88;
  blazeBox = { cx: zx, cy: zy, rx, ry, height: mob ? 380 : 560 };
  const origin = { front: { x: lay.table.x, y: lay.table.y } };
  Object.assign(propsIn.style, { left: -lay.table.x + 'px', top: -lay.table.y + 'px' });
  blaze.layout(blazeBox, origin);
  candleBlaze.layout(blazeBox, origin);
  dogBlaze.layout(blazeBox, origin);
  if (!S.pdrag) setTimeout(renderProps, 0);   // re-seat objects against the new circle
  Object.assign(E.glowbox.style, { left: (zx - rx * 1.25) + 'px', top: (zy - ry * 1.25) + 'px', width: (rx * 2.5) + 'px', height: (ry * 2.5) + 'px' });
  for (let i = 0; i < 22; i++) {
    const t = i / 22 * Math.PI * 2 + 0.13, rr2 = 0.9 + ((i * 37) % 10) / 100;
    const w = [4, 8, 4, 12, 4, 8][i % 6], h = 90 + ((i * 53) % 9) * 18;
    const s = document.createElement('span'); s.className = 'ms-beam';
    Object.assign(s.style, {
      left: Math.round((zx + Math.cos(t) * rx * rr2 - w / 2) / 4) * 4 + 'px', top: Math.round((zy + Math.sin(t) * ry * rr2 - h) / 4) * 4 + 'px',
      width: w + 'px', height: h + 'px', opacity: Math.sin(t) > 0 ? 0.35 : 0.7,
    });
    E.beams.append(s);
  }
  updateCircle();
}

let candleAnim = null, glowAnim = null;
function ambient() {
  const glow = E.root.querySelector('.ms-cglow');
  if (glow && !(glowAnim && glowAnim.effect && glowAnim.effect.target === glow) && !isReduced()) {
    if (glowAnim) glowAnim.cancel();
    glowAnim = glow.animate([{ opacity: 1 }, { opacity: 0.75 }, { opacity: 0.95 }, { opacity: 0.8 }, { opacity: 1 }],
      { duration: 1400, iterations: Infinity, easing: 'steps(4)' });
  }
  const cflame = E.root.querySelector('.ms-cflame');
  if (cflame && !(candleAnim && candleAnim.effect && candleAnim.effect.target === cflame) && !isReduced()) {
    if (candleAnim) candleAnim.cancel();
    candleAnim = cflame.animate([
      { transform: 'scale(1,1)', easing: 'steps(1, end)' }, { transform: 'scale(.8,1.15)', easing: 'steps(1, end)' },
      { transform: 'scale(1,.85)', easing: 'steps(1, end)' }, { transform: 'scale(1,1)' },
    ], { duration: 700, iterations: Infinity });
  }
  const flame = E.props.querySelector('.ms-flame');
  if (flame && flameAnim && flameAnim.effect && flameAnim.effect.target === flame && !isReduced()) return;
  if (flameAnim) { flameAnim.cancel(); flameAnim = null; }
  if (flame && !isReduced()) {
    const st = 'steps(1, end)';
    flameAnim = flame.animate([
      { transform: 'scale(1,1)', easing: st }, { transform: 'scale(.75,1.12)', easing: st },
      { transform: 'scale(1.1,.9)', easing: st }, { transform: 'scale(1,1)' },
    ], { duration: 540, iterations: Infinity });
  }
}

function pulse(on) {
  if (pulseAnim) { pulseAnim.cancel(); pulseAnim = null; }
  if (on && !isReduced()) {
    pulseAnim = E.pool.animate([{ filter: 'brightness(1)' }, { filter: 'brightness(1.45)' }, { filter: 'brightness(1)' }], { duration: 900, iterations: Infinity, easing: 'steps(4)' });
  }
  document.body.style.cursor = on ? 'grabbing' : '';
}

// ---------------- painting ----------------
function rootRel(el) {
  if (!el || !el.offsetParent && getComputedStyle(el).position !== 'fixed') return null;
  const rr = E.root.getBoundingClientRect(), r = el.getBoundingClientRect();
  if (!r.width && !r.height) return null;
  return { x: r.left - rr.left, y: r.top - rr.top, w: r.width, h: r.height };
}
function measure() {
  const rr = E.root.getBoundingClientRect();
  const rel = (el) => { const c = rootRel(el); return c ? { x: Math.round(c.x / PX), y: Math.round(c.y / PX), w: Math.round(c.w / PX), h: Math.round(c.h / PX) } : null; };
  const spines = Array.from(document.querySelectorAll('.ms-book:not(.is-gone) .ms-spine')).filter(inNav).map(rel).filter(Boolean);
  return {
    W: Math.ceil(rr.width / PX), H: Math.ceil(E.root.scrollHeight / PX),
    table: rel(E.table), nav: rel(E.nav), crown: rel(E.crown), win: rel(E.win),
    lamp: rel(propEls.lamp && !propEls.lamp.hidden ? propEls.lamp : null), cardSlot: rel(E.slot), zone: rel(E.zone),
    rows: Array.from(E.nav.querySelectorAll('ul')).filter(inNav).map(rel).filter(Boolean), spines,
  };
}
function schedulePaint() {
  if (paintRaf) return;
  paintRaf = requestAnimationFrame(() => {
    paintRaf = null;
    try {
      const lay = { rows: Array.from(E.nav.querySelectorAll('ul')).filter(inNav).map(rootRel).filter(Boolean), table: rootRel(E.table), zone: rootRel(E.zone) };
      const ls = JSON.stringify(lay);
      if (ls !== laySig) { laySig = ls; S.lay = lay; renderProps(); renderBeams(); }
      const R = measure();
      const sg = JSON.stringify(R);
      if (sg === sig) { syncGlow(); return; }
      const now = performance.now();
      if (S.pdrag && now - lastPaint < 90) { setTimeout(schedulePaint, 90); return; }
      lastPaint = now; sig = sg;
      scene = paintSceneInto(E.canvas, R, { wide: window.innerWidth >= 1180 });
      paintGlass(scene, fogT);
      glowColor = null; syncGlow();
    } catch (e) { console.warn('paint', e); }
  });
}
function syncGlow() {
  if (scene && (glowColor !== cc || glowScene !== scene)) { glowColor = cc; glowScene = scene; drawGlow(E.glow, scene, cc); }
}
function tickFog() {
  if (DATA.fog !== false && !isReduced() && scene) { fogT += 1; try { paintGlass(scene, fogT); } catch (e) { /* ignore */ } }
}

// ---------------- actions ----------------
function place(id, from) {
  if (S.opening) return;
  const b = book(id); if (!b) return;
  landFrom = from;
  const was = S.placedId;
  S.magicColor = MAGIC[Math.floor(Math.random() * MAGIC.length)];
  S.placedId = id; S.drag = null; S.hoverId = null;
  announce(u().placed(tr(b.title)));
  renderPlaced(); updateSpines(); updateDragUI(); updateCircle(); pulse(false); relayout();
  if (was !== id) requestAnimationFrame(animateLanding);
}

function animateLanding() {
  const el = E.cover, card = E.card;
  const skip = skipLand; skipLand = false;
  if (!el || el.hidden || skip) return;
  const red = isReduced();
  if (red) el.animate([{ opacity: 0 }, { opacity: 1 }], { duration: 150 });
  else {
    const r = el.getBoundingClientRect();
    const f = landFrom || { x: r.left + r.width / 2, y: r.top - 240 };
    const dx = f.x - (r.left + r.width / 2), dy = f.y - (r.top + r.height / 2);
    el.animate([
      { transform: `translate(${dx}px, ${dy}px) rotate(-80deg) scale(.5)` },
      { transform: `translate(${dx * 0.22}px, ${dy * 0.22 - 26}px) rotate(-10deg) scale(1.05)`, offset: 0.7 },
      { transform: 'none' },
    ], { duration: 380, easing: 'cubic-bezier(.2,.7,.2,1)' });
  }
  if (card) card.animate([{ opacity: 0, transform: red ? 'none' : 'translateY(8px)' }, { opacity: 1, transform: 'none' }], { duration: red ? 150 : 220, delay: red ? 0 : 240, fill: 'backwards' });
  const ob = $('ms-open'); if (ob) ob.focus({ preventScroll: true });
}

function cleared(id) {
  const b = book(id);
  S.placedId = null;
  announce(u().back(b ? tr(b.title) : u().theBook));
  try { localStorage.removeItem(KEY); } catch (e) { /* ignore */ }
  renderPlaced(); updateSpines(); updateCircle(); relayout();
  setTimeout(() => { const sp = spineEl(id); if (sp) sp.focus({ preventScroll: true }); }, 30);
}

function returnBook() {
  if (!S.placedId || S.opening) return;
  const id = S.placedId, el = E.cover;
  let a;
  if (isReduced()) a = el.animate([{ opacity: 1 }, { opacity: 0 }], { duration: 150, fill: 'forwards' });
  else {
    const r = el.getBoundingClientRect();
    const c = spineCenter(id) || { x: r.left, y: r.top - 300 };
    a = el.animate([{ transform: 'none' }, { transform: `translate(${c.x - (r.left + r.width / 2)}px, ${c.y - (r.top + r.height / 2)}px) rotate(-80deg) scale(.5)` }], { duration: 250, easing: 'cubic-bezier(.4,0,.6,1)', fill: 'forwards' });
  }
  a.onfinish = () => { a.cancel(); cleared(id); };
}

function open() {
  if (!S.placedId || S.opening) return;
  S.opening = true;
  try { localStorage.setItem(KEY, S.placedId); } catch (e) { /* ignore */ }
  const lid = $('ms-lid');
  if (!lid || isReduced()) { showSpread(); return; }
  lidAnim = lid.animate([{ transform: 'rotateY(0deg)' }, { transform: 'rotateY(-180deg)' }], { duration: 520, easing: 'steps(4, end)', fill: 'forwards' });
  lidAnim.onfinish = () => setTimeout(showSpread, 140);
}

function showSpread(noAnim) {
  const b = book(S.placedId); if (!b) return;
  S.opened = true;
  E.overlay.setAttribute('aria-label', tr(b.title));
  const tg = u().tags;
  const tags = b.labels ? `<div class="ms-tags"><span style="background:#3e4a2c; color:#dfe7d9;">${tg[0]}</span><span style="background:#7a2f45; color:#dfe7d9;">${tg[1]}</span><span style="background:#b8433e; color:#0b0b14;">${tg[2]}</span></div>` : '';
  E.overlay.innerHTML = `
    <div class="ms-spread" id="ms-spread" style="box-shadow:0 0 0 8px ${b.color}, 0 0 0 12px #0b0b14, 18px 22px 0 12px rgba(0,0,0,.6);">
      <div class="ms-page l">
        <div class="kick">${esc(tr(b.kicker))}</div>
        <h2>${esc(tr(b.title))}</h2>
        <p class="syn">${esc(tr(b.synopsis))}</p>
        <div class="by">${u().by} ${esc(b.author)}</div>
        ${tags}
      </div>
      <div class="ms-page r">
        <div class="ck">${u().contents}</div>
        ${tr(b.toc).map((t) => `<div class="ms-toc"><div class="s">${esc(t.s)}</div><div class="p">${esc(t.p)}</div></div>`).join('')}
      </div>
    </div>
    <div class="ms-overlay-actions">
      <button type="button" class="ms-btn dark sm" id="ms-close">${u().backShelf}</button>
      <a class="ms-btn sm" id="ms-enter" href="${esc(tr(b.href))}">${u().enter}</a>
    </div>`;
  E.overlay.hidden = false;
  $('ms-close').addEventListener('click', closeOpened);
  const sp = $('ms-spread'), cv = E.cover;
  if (noAnim) { /* language switch: redraw in place */ }
  else if (isReduced() || !cv) E.overlay.animate([{ opacity: 0 }, { opacity: 1 }], { duration: 150 });
  else {
    const c = cv.getBoundingClientRect(), t = sp.getBoundingClientRect();
    const src = { l: c.left - c.width, t: c.top, w: c.width * 2, h: c.height };
    const dx = (src.l + src.w / 2) - (t.left + t.width / 2), dy = (src.t + src.h / 2) - (t.top + t.height / 2);
    sp.animate([{ transform: `translate(${dx}px, ${dy}px) scale(${src.w / t.width}, ${src.h / t.height})` }, { transform: 'none' }], { duration: 480, easing: 'cubic-bezier(.5,0,.2,1)' });
    E.overlay.animate([{ backgroundColor: 'rgba(11,11,20,0)' }, { backgroundColor: 'rgba(11,11,20,1)' }], { duration: 480 });
  }
  if (!noAnim) { $('ms-enter').focus({ preventScroll: true }); announce(u().opened(tr(b.title))); }
}

function closeOpened() {
  if (lidAnim) { lidAnim.cancel(); lidAnim = null; }
  S.opened = false; S.opening = false;
  E.overlay.hidden = true; E.overlay.innerHTML = '';
  setTimeout(() => { const ob = $('ms-open'); if (ob) ob.focus({ preventScroll: true }); }, 30);
}

// ---------------- pointer and keyboard ----------------
const overShelf = (x, y) => { const r = E.nav.getBoundingClientRect(); return x >= r.left - 24 && x <= r.right + 24 && y >= r.top - 40 && y <= r.bottom; };
const overTable = (x, y) => { const r = E.table.getBoundingClientRect(); return x >= r.left && x <= r.right && y >= r.top && y <= r.bottom; };

function propDown(e, id) {
  if (e.button !== 0 || S.opening) return;
  e.preventDefault(); e.stopPropagation();
  const r = e.currentTarget.getBoundingClientRect();
  ppend = { id, sx: e.clientX, sy: e.clientY, offX: e.clientX - r.left, offY: e.clientY - r.top, active: false };
}
function propMove(e) {
  const p = ppend;
  if (!p.active) {
    if (Math.hypot(e.clientX - p.sx, e.clientY - p.sy) < 4) return;
    p.active = true;
    if (p.id === 'lamp') blaze.set(false, isReduced());
    if (p.id === 'candle') candleBlaze.set(false, isReduced());
    if (dogBlaze.on) { dogBlaze.set(false, isReduced()); dogFrame.set(false, isReduced()); }
  }
  const rr = E.root.getBoundingClientRect();
  let lampBook = null;
  if (p.id === 'lamp') {
    document.querySelectorAll('.ms-book').forEach((li) => {
      if (lampBook) return;
      const id = li.dataset.id, r = li.querySelector('.ms-spine').getBoundingClientRect();
      if (!inNav(li)) return;
      if (S.placedId !== id && e.clientX >= r.left - 10 && e.clientX <= r.right + 10 && e.clientY >= r.top - 40 && e.clientY <= r.bottom + 10) lampBook = id;
    });
  }
  S.pdrag = { id: p.id, x: e.clientX - rr.left - p.offX, y: e.clientY - rr.top - p.offY };
  S.lampBook = lampBook;
  renderProps(); updateMini(); schedulePaint();
}
function propUp() {
  const p = ppend; ppend = null;
  const d = S.pdrag;
  if (!p.active || !d) { S.pdrag = null; S.lampBook = null; renderProps(); updateMini(); return; }
  const def = PROPS.find((x) => x.id === p.id), lay = S.lay || {};
  const cx = d.x + def.w / 2, bottom = d.y + def.h;
  let pos = null;
  (lay.rows || []).forEach((r, i) => { if (pos) return; const top = r.y + r.h; if (cx >= r.x + 16 && cx <= r.x + r.w - 16 && bottom >= r.y + 10 && bottom <= top + 30) pos = { surf: 'shelf', row: i, fx: (cx - r.x) / r.w }; });
  const t = lay.table;
  if (!pos && t && cx >= t.x + 8 && cx <= t.x + t.w - 8 && bottom >= t.y - 10 && bottom <= t.y + t.h) pos = { surf: 'table', fx: (cx - t.x) / t.w, ty: Math.max(def.h > 60 ? 70 : 34, Math.min(t.h - 46, bottom - t.y)) };
  if (pos) { S.propPos = Object.assign({}, S.propPos, { [p.id]: pos }); try { localStorage.setItem(PKEY, JSON.stringify(S.propPos)); } catch (er) { /* ignore */ } }
  S.pdrag = null; S.lampBook = null;
  renderProps(); updateMini(); schedulePaint();
}

function onSpineDown(e, id) {
  if (e.button !== 0 || e.pointerType === 'touch' || S.opening) return;
  e.preventDefault();
  pending = { id, sx: e.clientX, sy: e.clientY };
}
function onCoverDown(e) {
  if (e.button !== 0 || e.pointerType === 'touch' || S.opening || !S.placedId) return;
  if (e.target.closest('button, a')) return;
  e.preventDefault();
  pending = { id: S.placedId, sx: e.clientX, sy: e.clientY, from: 'table' };
}
function handleMove(e) {
  if (ppend) { propMove(e); return; }
  const p = pending; if (!p) return;
  if (!S.drag) {
    if (Math.hypot(e.clientX - p.sx, e.clientY - p.sy) < 6) return;
    const el = p.from === 'table' ? E.cover : spineEl(p.id); if (!el) return;
    const r = el.getBoundingClientRect();
    Object.assign(p, { offX: p.sx - r.left, offY: p.sy - r.top, w: r.width, h: r.height });
    pulse(true);
  }
  S.drag = { id: p.id, x: e.clientX - p.offX, y: e.clientY - p.offY, w: p.w, h: p.h, from: p.from || 'shelf',
    over: p.from === 'table' ? overShelf(e.clientX, e.clientY) : overTable(e.clientX, e.clientY) };
  S.hoverId = null;
  updateSpines(); updateDragUI(); updateCircle(); schedulePaint();
}
function endDrag() { S.drag = null; pulse(false); updateSpines(); updateDragUI(); updateCircle(); schedulePaint(); }
function handleUp(e) {
  if (ppend) { propUp(e); return; }
  const p = pending; pending = null;
  const d = S.drag; if (!p || !d) return;
  justDragged = true; setTimeout(() => { justDragged = false; }, 40);
  if (d.from === 'table') {
    if (overShelf(e.clientX, e.clientY)) { const id = d.id; S.drag = null; pulse(false); updateDragUI(); cleared(id); return; }
    const cr = E.cover.getBoundingClientRect();
    if (isReduced()) { endDrag(); return; }
    const an = E.drag.animate([{ transform: 'rotate(6deg)' }, { transform: `translate(${cr.left - d.x}px, ${cr.top - d.y}px) rotate(0deg)` }], { duration: 250, easing: 'cubic-bezier(.3,.7,.3,1)', fill: 'forwards' });
    an.onfinish = () => { an.cancel(); endDrag(); };
    return;
  }
  if (overTable(e.clientX, e.clientY)) { place(d.id, { x: e.clientX, y: e.clientY }); return; }
  const sp = spineEl(d.id);
  if (!sp) { endDrag(); return; }
  const r = sp.getBoundingClientRect();
  const a = isReduced()
    ? E.drag.animate([{ opacity: 1 }, { opacity: 0 }], { duration: 150, fill: 'forwards' })
    : E.drag.animate([{ transform: 'rotate(6deg)' }, { transform: `translate(${r.left - d.x}px, ${r.top - d.y}px) rotate(0deg)` }], { duration: 250, easing: 'cubic-bezier(.3,.7,.3,1)', fill: 'forwards' });
  a.onfinish = () => { a.cancel(); endDrag(); };
}
function handleKey(e) {
  if (e.key === 'Escape') {
    if (S.opened) { e.preventDefault(); closeOpened(); }
    else if (S.drag) { pending = null; endDrag(); }
    else if (S.placedId) { e.preventDefault(); returnBook(); }
  } else if (e.key === 'Enter' && S.placedId && !S.opened) {
    const tag = e.target && e.target.tagName;
    if (['A', 'BUTTON', 'INPUT', 'TEXTAREA', 'SELECT'].includes(tag)) return;
    open();
  }
}

// ---------------- boot ----------------
function wireSpine(li) {
  const id = li.dataset.id, a = li.querySelector('.ms-spine');
  a.addEventListener('click', (e) => { e.preventDefault(); if (justDragged) return; place(id, spineCenter(id)); });
  a.addEventListener('keydown', (e) => { if (e.key === ' ') { e.preventDefault(); place(id, spineCenter(id)); } });
  a.addEventListener('pointerdown', (e) => onSpineDown(e, id));
  const enter = () => { if (!S.drag) { S.hoverId = id; updateSpines(); } };
  const leave = () => { if (S.hoverId === id) { S.hoverId = null; updateSpines(); } };
  a.addEventListener('mouseenter', enter); a.addEventListener('mouseleave', leave);
  a.addEventListener('focus', enter); a.addEventListener('blur', leave);
}
document.querySelectorAll('.ms-book').forEach(wireSpine);

// ?demo fills the shelf with sample books (from the design) to preview several bookcases
function maybeDemo() {
  if (!/[?&]demo\b/.test(location.search)) return;
  const DEMO = [
    ['feira-dos-afogados', 'A Feira dos Afogados', 'Tormenta20', 'andamento', '#7a2f45', '#b8433e', '#f3b04a', '#dfe7d9', 38, 168, 3],
    ['farol-queimada', 'O Farol de Queimada Grande', 'Call of Cthulhu 7e', 'completo', '#1f1f3d', '#3b3860', '#dfe7d9', '#dfe7d9', 48, 176, 7],
    ['sal-e-ferro', 'Sal e Ferro', 'D&D 5e', 'rascunho', '#8e8aae', '#dfe7d9', '#3b3860', '#15162a', 30, 150, 0],
    ['coroa-de-cinzas', 'Coroa de Cinzas', 'Old Dragon 2e', 'completo', '#3e4a2c', '#9dbb6a', '#f3b04a', '#dfe7d9', 40, 188, 12],
    ['sinos-ouro-preto', 'Os Sinos de Ouro Preto', 'Ordem Paranormal', 'completo', '#4a2a55', '#7a2f45', '#e27a3f', '#dfe7d9', 36, 160, 2],
    ['rio-sem-volta', 'Mapa do Rio Sem Volta', 'Savage Worlds', 'andamento', '#5a4232', '#7a5a3e', '#dfe7d9', '#dfe7d9', 44, 172, 1],
    ['carta-do-barao', 'A Última Carta do Barão', 'Call of Cthulhu 7e', 'completo', '#b8433e', '#e27a3f', '#15162a', '#0b0b14', 34, 180, 5],
    ['ninho-de-vespas', 'Ninho de Vespas', 'Tormenta20', 'rascunho', '#9fa8a6', '#dfe7d9', '#7a2f45', '#15162a', 32, 144, 0],
    ['lanternas-pantano', 'Lanternas no Pântano', 'D&D 5e', 'completo', '#262543', '#3b3860', '#9dbb6a', '#dfe7d9', 46, 186, 9],
    ['inventario-mago', 'O Inventário do Mago Morto', 'Old Dragon 2e', 'andamento', '#3a2a22', '#5a4232', '#f3b04a', '#dfe7d9', 40, 164, 4],
    ['vila-rica', 'Quatro Estações em Vila Rica', 'GURPS', 'completo', '#15162a', '#3b3860', '#b8433e', '#dfe7d9', 50, 178, 6],
  ];
  const empty = E.nav.querySelector('.ms-empty');
  for (let round = 0; round < 2; round++) DEMO.forEach(([id, title, system, status, color, light, band, ink, w, h, contributors]) => {
    const b = { id: id + '-' + round, title, system, status, color, light, band, ink, w, h, contributors, emblem: false,
      period: '—', place: '—', author: 'Livro de exemplo', kicker: system, labels: false,
      synopsis: 'Livro de exemplo, só para ver a estante com vários títulos, sistemas e estados.',
      toc: [{ s: 'Livro de exemplo', p: 'O sumário vem do book.lua de cada livro.' }], href: '#', contribHref: '#' };
    BOOKS.push(b);
    const li = document.createElement('li');
    li.className = 'ms-book'; li.dataset.id = b.id;
    li.innerHTML = `<a class="ms-spine" href="#" draggable="false" aria-label="${esc(title)}, ${esc(system)}" style="--c:${color}; --ink:${ink}; --light:${light}; --band:${band};">`
      + '<span aria-hidden="true" class="ms-sp-line top"></span><span aria-hidden="true" class="ms-sp-line bot"></span>'
      + '<span aria-hidden="true" class="ms-sp-band top"></span><span aria-hidden="true" class="ms-sp-band bot"></span>'
      + `<span aria-hidden="true" class="ms-sp-title"><span>${esc(title)}</span></span></a>`
      + (status === 'andamento' ? '<span aria-hidden="true" class="ms-ribbon"></span>' : '')
      + (status === 'rascunho' ? '<span aria-hidden="true" class="ms-draft1"></span><span aria-hidden="true" class="ms-draft2"></span>' : '');
    empty.before(li); wireSpine(li);
  });
}
E.cover.addEventListener('pointerdown', onCoverDown);
E.cover.addEventListener('dblclick', open);
window.addEventListener('pointermove', handleMove);
window.addEventListener('pointerup', handleUp);
window.addEventListener('pointercancel', handleUp);
window.addEventListener('keydown', handleKey);
window.addEventListener('resize', relayout);

// Language switch: update the spines' links and labels, and redraw what JS wrote
function applyLang() {
  document.querySelectorAll('.ms-book').forEach((li) => {
    const b = book(li.dataset.id), a = li.querySelector('.ms-spine');
    if (!b || !a) return;
    if (b.href && b.href !== '#') a.setAttribute('href', tr(b.href));
    a.setAttribute('aria-label', `${tr(b.title)}, ${b.system}, ${statusLabel(b.status).toLowerCase()}`);
  });
  const lbl = document.querySelector('.ms-empty a');
  if (lbl) lbl.setAttribute('aria-label', lang() === 'pt' ? 'Sua história aqui: como propor um livro novo' : 'Your story here: how to propose a new book');
  if (S.placedId) { renderPlaced(); }
  if (S.opened) showSpread(true);
  if (cases) { cases.querySelectorAll('.ms-casepage').forEach((pg, i, all) => pg.setAttribute('aria-label', u().caseAria(i + 1, all.length))); }
  updatePager(); renderProps(); updateMini(); hideTip(); relayout();
}
document.addEventListener('ms:lang', applyLang);
window.addEventListener('pageshow', (e) => { if (e.persisted && S.opened) closeOpened(); });

maybeDemo();
try {
  const last = localStorage.getItem(KEY);
  if (last && book(last)) { skipLand = true; S.placedId = last; }
} catch (e) { /* ignore */ }
renderPlaced(); updateDragUI(); updateCircle(); applyLang();
if (document.fonts && document.fonts.ready) document.fonts.ready.then(relayout);
if (window.ResizeObserver) new ResizeObserver(() => schedulePaint()).observe(E.root);
if (document.fonts && document.fonts.ready) document.fonts.ready.then(() => { sig = null; schedulePaint(); });
setInterval(tickFog, 140);
schedulePaint();

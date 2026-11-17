# Figma report (optional)

Build this only when the user asks for the research in Figma. It is a reading document, not a
design: plain grey boards, no brand styling, so nobody mistakes it for a mockup.

Before any `use_figma` call load the `figma-use` skill, as that tool requires.

## Placement

- Put it on the page the user names, in a new Section next to the related work. Scan the
  page's top-level nodes first and choose a spot that overlaps nothing.
- Four boards side by side, 1920 wide each, 160 apart, white background, 80 padding.
- The board's title goes into the **frame name** (`02 · Objection ranking · …`). Do not place
  small text captions above a frame: Figma draws the frame name there and hides them.

## Boards

**00 · Summary.** Title, six conclusions as cards (2 × 3), then the source table: source · what
was taken · how far to trust it. Each row carries a provenance chip.

**01 · Opinions.** A grid: row labels on the left, one column per category. Rows: who these
people are · what they really want · the moment they decide · what they say after starting ·
why they quit. Under each row label, chips for the main sources. Below the grid: one chart
with real numbers (e.g. patient ratings per product) and any single-question finding
(e.g. "injections or pills") as three cards plus a one-paragraph conclusion.

**02 · Objection ranking.** One column per category. Each row: big rank number · objection ·
how it sounds (grey) · chips "also confirmed in" · small label "where to answer on the page" +
the answer. The header must say what the order is based on and that it is not a percentage.
Below: the provider-complaints table with the "what we have" column, then two charts —
service ratings and top videos by views.

**03 · Competitors.** The shared skeleton as a strip of numbered steps · the techniques table
(technique · what it looks like · who) · first screen of the leaders per category · two cards
"what they hide" and "what nobody does" · open questions (e.g. tone) in an outlined card.

## Visual rules

- One font, two weights. Sizes: title 68, section 36, column heading 30, card title 22–26,
  body 18–20, table header 15, chips 14. Nothing smaller: boards are read zoomed out.
- Greys only: ink 0.1, muted 0.42, lines 0.86, card background 0.955.
- **Provenance chips:** solid dark = read directly; outlined = collected by another tool, a
  secondary source, or another market. Put the legend on board 00.
- **Charts only for real numbers** (ratings, view counts, funnel rates): thin horizontal bars,
  one grey, value at the end of the bar, the count as a muted note, a title that states the
  finding. A qualitative order gets rank numbers, never bars.
- Competitor copy and customer quotes stay in the original language; everything else in the
  reader's language.
- Auto-layout everywhere, so a text edit never breaks a board.

## Helpers that worked

Each `use_figma` call is stateless, so repeat these at the top of every call. Build one board
per call, return the board id and height, then screenshot each board once and fix what the
screenshot shows (typical: a long word breaking inside a narrow card).

```js
const page = await figma.getNodeByIdAsync(PAGE_ID);
await figma.setCurrentPageAsync(page);
const R={family:'Roboto',style:'Regular'}, M={family:'Roboto',style:'Medium'};
await figma.loadFontAsync(R); await figma.loadFontAsync(M);
const G=v=>[{type:'SOLID',color:{r:v,g:v,b:v}}];
const INK=0.1,MUTE=0.42,LINE=0.86,SOFT=0.955;

// text: fills the parent's width by default; {w} fixed width; {hug} for chips
function T(p,s,size,o){o=o||{};const t=figma.createText();t.fontName=o.m?M:R;t.fontSize=size||20;
  t.lineHeight={unit:'PERCENT',value:o.lh||(size>=30?118:145)};t.characters=s;t.fills=G(o.c==null?INK:o.c);
  p.appendChild(t);
  if(o.w){t.textAutoResize='HEIGHT';t.resize(o.w,t.height);}
  else if(!o.hug){t.textAutoResize='HEIGHT';t.layoutSizingHorizontal='FILL';}
  return t;}

// auto-layout frame: {gap,p,px,py,r,bg,w|fill,stretch,line}
function F(p,dir,o){o=o||{};const f=figma.createAutoLayout(dir,{name:o.name||'box',itemSpacing:o.gap==null?12:o.gap});
  f.fills=o.bg==null?[]:G(o.bg);const pd=o.p||0,px=o.px==null?pd:o.px,py=o.py==null?pd:o.py;
  f.paddingLeft=px;f.paddingRight=px;f.paddingTop=py;f.paddingBottom=py;if(o.r)f.cornerRadius=o.r;
  if(p)p.appendChild(f);
  if(o.w){f.resize(o.w,Math.max(f.height,1));f.layoutSizingVertical='HUG';}
  else if(o.fill){f.layoutSizingHorizontal='FILL';}
  if(o.stretch)f.layoutSizingVertical='FILL';
  if(o.line){f.strokes=G(LINE);f.strokeWeight=1;f.strokeTopWeight=0;f.strokeLeftWeight=0;f.strokeRightWeight=0;f.strokeBottomWeight=1;}
  return f;}

function chip(p,s,solid){const c=F(p,'HORIZONTAL',{name:'chip',px:10,py:4,r:100,bg:solid?INK:null});
  if(!solid){c.strokes=G(0.6);c.strokeWeight=1;}T(c,s,14,{m:1,c:solid?1:0.35,hug:1});return c;}

function board(sec,x,name){const b=F(null,'VERTICAL',{name,gap:56,p:80,bg:1});sec.appendChild(b);
  b.resize(1920,100);b.layoutSizingVertical='HUG';b.x=x;b.y=100;return b;}

// rows: [label, value, valueText, note]; max = scale maximum
function bars(p,rows,max,o){o=o||{};const W=o.W||420;const box=F(p,'VERTICAL',{name:'chart',gap:14,fill:1});
  rows.forEach(r=>{const row=F(box,'HORIZONTAL',{name:'bar row',gap:16,fill:1});row.counterAxisAlignItems='CENTER';
    T(row,r[0],18,{w:o.lw||220});
    const tr=figma.createFrame();tr.name='track';tr.resize(W,16);tr.fills=[];row.appendChild(tr);
    const bar=figma.createRectangle();bar.resize(Math.max(2,W*r[1]/max),16);bar.fills=G(0.25);
    bar.topRightRadius=4;bar.bottomRightRadius=4;tr.appendChild(bar);
    T(row,r[2],18,{m:1,w:o.vw||56});if(r[3])T(row,r[3],16,{c:MUTE});});
  return box;}
```

Equal columns: a horizontal `F` whose children are all `{fill:1}`; add `{stretch:1}` to make
cards in a row the same height. Table row: a horizontal `F` with `{line:1, py:18}` and fixed
widths on every column but one.

After the last board, resize the section to fit: width = 4 × 1920 + 3 × 160 + 200, height =
tallest board + 200.

## Wireframes (if also requested)

Separate from the report. Mobile width, grey blocks only — the user asked for structure, not
design. Each block is a labelled box with the real headline or item names inside it; to the
right of each wireframe, a notes column: the leading idea on top, then one note per block
saying which finding it answers. If the page background is dark, make the notes light. Offer
two or three variants per category that differ in the leading idea (e.g. "products first",
"main fear first", "doctor picks for you"), not in cosmetics.

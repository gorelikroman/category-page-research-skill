---
name: category-page-research
description: >-
  Market and voice-of-customer research for a sales page (category page, landing page, product
  page) in ANY market — US, UK, Germany, France or another country. Scans competitor pages,
  top YouTube videos, forums (Reddit and local ones), review sites, patient reviews and the
  company's own Confluence and Mixpanel, then turns it into a ranked list of objections, the
  moments that make people act, how competitors sell, what nobody does yet, and a page skeleton.
  Use this whenever a PM or designer says "research the market for X", "scan competitors",
  "what do people say about X", "objections and fears", "voice of customer", "how do competitors
  sell", "prepare research for the category page", "сделай ресёрч", "просканируй конкурентов",
  "что говорят люди", "рейтинг возражений", "как продают конкуренты", "Marktrecherche",
  "Wettbewerbsanalyse", or is about to design a landing or category page with no research
  behind it — even if they only name one source ("check Reddit", "look at YouTube").
---

# Category page research

Research that ends in decisions for a page: what to say first, which fear to answer where,
what competitors already do, what is still free to take. Written after a real run for three
categories on the US market (weight loss, ED, hair loss); the method is the same in every
market, only the sources change.

One principle runs through all of it: **every finding carries its provenance.** A reader must
be able to tell "read directly" from "collected by another tool, not checked" from "a guess".
Research that hides this gets quoted on a live page and turns out to be wrong.

## Step 0 — Scope

Take what the request already gives. Ask only for what is missing, in one round, at most four
questions:

1. **Market** — country and language. This decides almost every source.
2. **Category** — the condition or product line (one to three per run; more gets shallow).
3. **Whose page and what it must do** — brand, and the job of the page ("hard sale: the visitor
   warms up and concludes this is for me", "explain a new product", "win back existing customers").
4. **Depth** — quick scan (competitors + reviews, about an hour) or full run (everything below).

Defaults when the user says "your call": full run, findings written in the user's language,
quotes and competitor copy kept in the original language.

## Step 1 — Source plan for this market

Read `references/source-map.md`. It lists the source types and, for the US, UK and Germany,
concrete starting points; for any other market it gives the recipe for finding local equivalents.

Write the plan as a short table and show it before collecting (do not wait for approval unless
the user asked to review it):

| Source type | Concrete sources for this market | How I will reach it |
|---|---|---|
| Competitor pages | … | browser / saved HTML |
| Video | YouTube, local language queries | search sorted by views |
| Forums | … | ChatGPT / Gemini / Codex prompt, or pasted threads |
| Service reviews | … | browser |
| Patient / product reviews | … | browser |
| Own data | Confluence, Mixpanel | connectors |

Two things change with the market and are easy to miss:

- **The competitor set is local.** A US leader may not operate in the country at all. Find who
  actually ranks and advertises there (search in the local language, check the local Trustpilot).
- **Advertising rules shape the pages.** In the US a page can name the drug and the price. In
  the UK and Germany prescription-only medicines cannot be advertised to the public, so
  competitor pages talk around the product and the same wording cannot simply be copied. Note
  the local rule in the plan as a question for legal — do not state it as settled.

## Step 2 — Collect, one file per source

Read `references/collection-playbook.md` before the first source; it has what to capture from
each source type and what to do when a source will not open.

Work in this order — each step makes the next one sharper:

1. **Competitor pages.** Read the whole page text, not screenshots: headline, bullets, button
   wording, order of sections, how many products, where the real price is disclosed, FAQ
   questions, footnotes. Screen libraries (Mobbin, Refero) are a supplement, never the research.
2. **Service reviews** (Trustpilot or the local equivalent): rating, number of reviews, share of
   one-star, complaint themes. This is where "what people hate about providers" comes from.
3. **Patient or product reviews** (Drugs.com and local equivalents): the most helpful reviews
   per product — outcomes in people's own words, side effects, who is writing.
4. **Video.** Top videos by views for the questions people search. Titles and view counts show
   which questions are biggest. For what is actually said, use transcripts (see below).
5. **Forums.** Triggers, fears, regrets, reasons for quitting. See "Forums" below.
6. **Own data.** Personas, brand vocabulary and prior research in Confluence; behaviour on the
   existing page in Mixpanel (device split, view → click → paid, where on the page people click).

Save each source to its own file as soon as it is read (`competitors-live.md`, `reviews.md`,
`youtube.md`, `forums/<category>.md`, `own-data.md`). Context gets compacted on long runs; what
is not in a file is lost.

### When a source will not open

- **Bot check or CAPTCHA on a competitor site** — do not try to pass it. Ask the user whether
  the pages may be read through their own Chrome; if yes, `scripts/save_chrome_tabs.sh` saves
  each page as HTML and `scripts/extract_text.py` turns it into readable text (macOS). Otherwise
  ask them to save the pages as HTML or PDF. If neither happens, mark the page "not read".
- **Reddit** — browser tools in Claude cannot open it, and mirrors or other workarounds are not
  an option. Use the routes in "Forums" below.
- **YouTube search page renders empty** in a hidden browser pane — take one screenshot to force
  rendering, then read the page.
- Anything else that stays closed goes into the status table as "not read", with the reason.
  A gap that is named is fine; a gap filled from memory is not.

### Forums (Reddit and local ones)

Three routes, in order of preference:

1. **A prompt for ChatGPT or Gemini** (deep research mode) that the PM runs and pastes back.
2. **Codex CLI** in the terminal, if installed — same prompt, run by Claude.
3. **Threads the user pastes or exports.**

`references/forum-research-prompts.md` has the prompt template, how to localise it, the Codex
command, and follow-up prompts for a single question ("injections or pills", "daily or on
demand"). Write the prompt for the user as plain task text — what to find and in which format.

Whatever comes back from another tool is **not verified**: the quotes were not opened by you.
Label the file that way, keep the thread links, and open a quote's link before it goes on a page.

### YouTube transcripts (deeper pass)

Titles tell which questions are big, not what is answered. When the page needs the actual
arguments, numbers or wording from videos, use the `youtube-research` skill
(https://github.com/gorelikroman/youtube-research-skill): it pulls transcripts with `yt-dlp`
on the user's machine and writes cited notes. If it is not installed, offer:

```bash
git clone https://github.com/gorelikroman/youtube-research-skill ~/.claude/skills/youtube-research
```

Pick 5–10 videos per category from the top-by-views list, not all of them.

## Step 3 — Synthesize

Write `README.md` in the research folder from the source files. Template and the tables are in
`references/output-templates.md`. The parts that matter most:

- **Status table** — every source, what was taken, how far to trust it.
- **What people want, in their words** — the life change, not the clinical goal.
- **Trigger moments** — the event after which a person finally acts.
- **Objection ranking per category** — each with how it sounds, where else it is confirmed, and
  where on the page to answer it.
- **Complaints about providers** — and what your own product already has against each.
- **How competitors sell** — the shared skeleton, the techniques with who uses them, what they
  hide, what nobody does.
- **Page skeleton** — block order for this page, with the reason for each block.
- **Open questions and gaps.**

Rules for the ranking, because this is where research most often overclaims:

- A ranking built from "how often a theme shows up in threads" is an **order, not a share**.
  Never attach percentages to it. Say what the order is based on.
- Show numbers only where the source has them: review-site ratings, view counts, funnel rates.
- When two sources disagree on the order, keep both and say so.

## Step 4 — Deliver

1. The research folder (default `docs/<topic>-research/`) with `README.md` as the entry point.
2. A short chat summary: five or six conclusions, what is not verified, what needs a decision.
3. **If the user wants it in Figma** — a report of four boards (summary, opinions, objection
   ranking, competitors). Spec and builder helpers: `references/figma-report.md`.
4. **If the user wants a wireframe** — grey structure only: blocks, order, a note per block
   saying why it is there. No brand design unless asked. Offer two or three variants built on
   different leading ideas rather than one.

## Honesty rules

- Label every source file and every quote: read directly / collected by another tool / secondary.
- Medical, legal and numeric claims are proposals. They go to the medical and legal teams before
  any page.
- Findings from one market do not transfer silently. Personas written for Germany are evidence
  about Germany; say so when using them for another country.
- Do not reproduce long passages of reviews or posts; short quotes with a link are enough.
- Keep the customer's language. A fear paraphrased into marketing speak loses what made it useful.

## Cost

Collection is reading, not reasoning: use the cheapest capable model for other tools (for Codex,
the small model at low effort, one run at a time — parallel runs on a big model burned the
usage limit in the original run). If subagents are used, one per category for the competitor and
review sweep is enough; say what each does before starting it.

## Files

- `references/source-map.md` — source types and local equivalents by market
- `references/collection-playbook.md` — what to capture per source, access problems
- `references/forum-research-prompts.md` — prompts for ChatGPT, Gemini, Codex
- `references/output-templates.md` — folder layout, README and table templates
- `references/figma-report.md` — the four-board Figma report
- `scripts/save_chrome_tabs.sh`, `scripts/extract_text.py` — read bot-protected pages through the user's Chrome
- `scripts/run_codex_research.sh` — run a research prompt through Codex CLI

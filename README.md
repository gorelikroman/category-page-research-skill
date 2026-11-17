# category-page-research (Claude skill)

A [Claude](https://claude.com/claude-code) skill for market and voice-of-customer research
before designing a sales page — a category page, a landing page, a product page — in **any
market**: US, UK, Germany or another country.

It walks Claude through the same method every time:

1. **Scope** — market, category, whose page and what it must do.
2. **Source plan** — local competitors, review sites, forums, video, your own wiki and analytics.
3. **Collect** — one file per source, each labelled "read directly" or "not verified".
4. **Synthesize** — what people want, the moments that make them act, a ranked list of
   objections with where to answer each on the page, complaints about providers, how
   competitors sell, what nobody does yet, a page skeleton.
5. **Deliver** — a research folder with a README; optionally a four-board report and grey
   wireframes in Figma.

See [`SKILL.md`](SKILL.md) for the full instructions.

## Install

Put this folder into your Claude skills directory:

```
git clone https://github.com/gorelikroman/category-page-research-skill ~/.claude/skills/category-page-research
```

Then ask Claude, for example:

- "Research the UK market for a weight loss category page"
- "Сделай ресёрч по hair loss для Германии: конкуренты, возражения, как продают"
- "Write me a ChatGPT prompt to research Reddit on ED treatment in the US"

## What is inside

| File | What it is |
|---|---|
| `SKILL.md` | The method, step by step, and the honesty rules |
| `references/source-map.md` | Source types and local equivalents for the US, UK, Germany; recipe for other markets |
| `references/collection-playbook.md` | What to capture from each source; what to do when a site will not open |
| `references/forum-research-prompts.md` | Prompt templates for ChatGPT, Gemini and Codex (Reddit and local forums) |
| `references/output-templates.md` | Folder layout, README and table templates |
| `references/figma-report.md` | The optional Figma report and wireframes |
| `scripts/save_chrome_tabs.sh` | Save pages as HTML through your own Chrome (macOS) |
| `scripts/extract_text.py` | Turn saved HTML into readable text with headings, buttons, FAQ marked |
| `scripts/run_codex_research.sh` | Run a research prompt through Codex CLI |

## Works well with

[youtube-research-skill](https://github.com/gorelikroman/youtube-research-skill) — pulls
YouTube transcripts with `yt-dlp` for the deeper video pass.

## Good to know

- The source lists for the UK and Germany are starting points, not checked in a live run.
  Confirm them with a search; update `references/source-map.md` after your first run.
- Claude's browser tools cannot open Reddit. Forum research runs through ChatGPT or Gemini
  deep research, Codex CLI, or threads you paste in. Quotes collected that way are not
  verified until someone opens the link.
- The two page-saving scripts need macOS and Google Chrome. Elsewhere, save pages by hand.
- Medical, legal and numeric claims found in research are proposals. Check them with your
  medical and legal teams before they reach a page.

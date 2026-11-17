# Forum research prompts (ChatGPT, Gemini, Codex)

Claude's browser tools cannot open Reddit. Forum research therefore runs in a tool that has
its own search — ChatGPT or Gemini in deep research mode, or Codex CLI — and comes back as a
document. Other forums (Mumsnet, gutefrage.net, HealthUnlocked) may open in the browser; the
same prompt works for them too and saves a lot of reading.

## How to hand the prompt to the user

When the user asks "write me a prompt for ChatGPT / Gemini":

1. Fill the slots in the template below from the scope (market, category, products, forums,
   providers, languages).
2. Give the finished prompt in one code block so it can be copied in one click. Task only:
   what to find, where, in which format. No preamble, no caveats inside the prompt.
3. One prompt per category. A prompt covering three categories returns three thin reports.
4. Tell the user to run it in deep research mode and paste the result back, or save it as a
   file in the research folder.
5. Save what comes back to `forums/<category>.md` with this first line:
   `Collected by <tool> on <date>. Quotes were not opened and checked against the threads.`

## Main template

```text
You are doing voice-of-customer research on {FORUMS_GENERAL, e.g. "Reddit"} for a {MARKET}
{BRAND_TYPE, e.g. "telehealth brand"} that is designing a sales page for this category:
{CATEGORY} ({PRODUCTS — drug or product names people actually use}). The goal of the page: a
visitor arrives, gets warmed up, and concludes "this is exactly what I need". I need raw
material from real people, not a summary of medical facts.

Use web search. Read actual threads, including the comments. Prioritize top posts of the past
year and highly upvoted comments. Only use posts from people in {MARKET} where it can be told.

Communities to cover: {LIST — subreddits or forum sections}

Extract:
1. Trigger moments: the specific event that made people finally act (a photo, a comment from
   a barber or partner, a lab result, a failed night, a wedding coming up). This is the most
   important section.
2. Fears and objections before starting, ranked by how often they appear.
3. The questions people ask most before starting.
4. Desired outcomes in their own words: not the generic goal but the specific life change
   they describe.
5. "Aha" moments and regret statements from people already on treatment.
6. The partner's perspective, where it appears.
7. What people love and hate about providers ({PROVIDERS}): billing, cancellation, support,
   delays, dosing.
8. Reasons people quit.

Output format: one markdown document with the eight numbered parts above. Give customer
language as direct quotes in {QUOTE_LANGUAGE}, each with a link to its thread and the month
and year of the post. Say how many threads you read. For the ranking in part 2, say what it is
based on. Where a section has little evidence, say so in one line. Then a final section
"Implications for a landing page" with 10 headline angles in {PAGE_LANGUAGE} built from the
customers' own phrases and a table "objection -> where on the page to answer it". Write all
analysis in {ANALYSIS_LANGUAGE}; keep quotes, headlines and thread titles in the original
language.
```

Slot notes:

- `{MARKET}` — "US", "UK", "German". For non-English markets name the forums explicitly
  (e.g. "gutefrage.net, German-language Reddit, med1.de") and set `{QUOTE_LANGUAGE}` to the
  local language. Quotes translated by the tool lose the customer's wording.
- `{PRODUCTS}` — the names people type, including brand names and nicknames. In markets where
  some drugs are not sold, drop them; add local brand names.
- `{PROVIDERS}` — the local competitor set from the source plan, not the US one.
- `{ANALYSIS_LANGUAGE}` — the language the PM reads in.

## Single-question template

For a question that comes up mid-research ("are injections a real barrier or do people prefer
pills?", "daily or on-demand?", "do people trust compounded products?"):

```text
You are doing voice-of-customer research on {FORUMS} for a {MARKET} {BRAND_TYPE} that sells
{CATEGORY} both as {OPTION_A} and as {OPTION_B}. I need to understand how real people feel
about {OPTION_A} versus {OPTION_B}. Raw material from real people, not a summary of medical
facts.

Use web search. Read actual threads, including the comments. Prioritize posts of the past
year and highly upvoted comments. Communities to cover: {LIST}.

Extract:
1. Hesitation about {OPTION_A} BEFORE starting: how common it is in these threads, how people
   describe it, and whether it delayed or stopped them.
2. What changed after the first experience with {OPTION_A}.
3. Why people prefer {OPTION_A}.
4. Why people prefer or want {OPTION_B}.
5. Complaints and doubts about {OPTION_B}.
6. Stories of switching in either direction, and why.
7. What hesitant people say would make them start.
8. Practical worries around {OPTION_A}.

Output format: one markdown document with the eight numbered parts above. Give customer
language as direct quotes in {QUOTE_LANGUAGE}, each with a link to its thread. Start with a
short verdict: is this a major barrier or a minor one in these communities, and how strong is
demand for {OPTION_B}. End with a section "Implications for a landing page" with: 5 headline
angles for a section about {OPTION_B}, 3 things the page must not promise about {OPTION_B},
and what to show to reduce hesitation about {OPTION_A}. Write all analysis in
{ANALYSIS_LANGUAGE}; keep quotes, headlines and thread titles in the original language.
```

## Running it through Codex CLI

If `codex` is installed and logged in, Claude can run the prompt itself:

```bash
bash scripts/run_codex_research.sh prompts/weight-loss.txt forums/weight-loss.md
```

What the original run taught:

- **Use the small model at low reasoning effort.** This is search and extraction. Three
  parallel runs on a large model at medium effort hit the usage limit and returned nothing.
  The script takes the model as its third argument; check which small model is current.
- **One run at a time,** in the background. A run takes several minutes.
- **Add "Do not write any files; return the whole document as your final message"** to the
  prompt — the script does this — so the result lands in the output file.
- **If a run stops without output,** resume the same session instead of starting over; the
  searching is already done:
  ```bash
  bash scripts/run_codex_research.sh --resume <session-id> forums/weight-loss.md
  ```
  The session id is printed at the top of the run's log.

## After the document is back

- Read it whole; fold the findings into the README with the "not verified" label.
- Check the mix: old threads, off-topic subreddits and single-person stories are common. The
  tool usually flags them — keep the flags.
- The ranking in part 2 is an order by recurrence, not a count. Never turn it into percentages.
- Before any quote goes onto a page or into a deck, a person opens the link and confirms it.

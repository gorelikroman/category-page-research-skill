# Collection playbook

What to capture from each source and how to get in. Save each source to its own file with a
first line that says how it was read ("read directly on <date>", "collected by <tool>, quotes
not opened", "search snippets only").

## 1. Competitor pages

Read the category or landing page of each competitor for the category in question — not the
home page. Aim for the two or three market leaders in full plus five to ten others.

Capture per page:

- **Headline and subhead**, word for word.
- **Bullets under the headline** (usually three).
- **Buttons in the first screen:** how many, exact wording. Leaders often pair a hard one
  ("Get started") with a soft one ("See if treatment is right for me").
- **The one number** in the first screen, and its footnote.
- **Order of sections** top to bottom, with the section headings.
- **Products:** how many, what is on the card (price, one-line difference, stock status),
  whether anything is marked as the default choice.
- **Price:** where it appears, in what form ("from X"), and where the full cost is disclosed
  (membership, subscription term, prepayment). The gap between the two is a finding.
- **Proof:** testimonial format (number + time span? photos? paid disclosure?), celebrity,
  member counts, survey figures, doctors with credentials.
- **Safety and side effects:** which half of the page, open or collapsed.
- **FAQ questions**, as a list.
- **Closing block:** repeat of the offer, or an emotional line.
- **Tone:** playful, clinical, neutral — with one example.
- **Urgency:** real (biology, eligibility check) or fake (timers, "N left").

Then across pages: the shared skeleton, the outliers, what leaders hide, what none of them do.

Access, in order:

1. Built-in browser or web fetch. Read the page as text.
2. If a bot check appears — stop, do not try to pass it. Ask the user if the pages may be
   opened in their own Chrome. With a yes:
   ```bash
   bash scripts/save_chrome_tabs.sh <outdir> name1=https://… name2=https://…
   python3 -I scripts/extract_text.py <outdir>
   ```
   The first saves each page as HTML through AppleScript (macOS, Google Chrome); the second
   writes a `.txt` per page with headings, buttons and FAQ items marked. Put the saved pages
   in their own empty folder.
3. If that is not possible, ask the user to save the pages (File → Save Page As, or print to
   PDF) and read the files.
4. Screen libraries (Mobbin, Refero) show real screens with unknown dates. Good for funnels
   and quiz screens, not a replacement for reading the live page. Say when a detail comes only
   from there.

Always state what was not seen: images, video, interactive widgets, anything behind a login.

## 2. Service reviews

For each competitor: rating, number of reviews, share of five-star and one-star, and the
complaint themes in the one-star reviews. Usual themes: charges on top of the product price,
auto-renewal and cancellation, no human support, charged before the doctor decided, supply
gaps. Note that the rating is for the brand, not the category.

Then line the themes up against your own product: for each, what do we already have? This
table is often the strongest input for the page.

## 3. Patient or product reviews

Per product, read the 10–15 most helpful reviews. Capture: average rating and count, who is
writing (age, situation), the outcome in their words, what the first weeks were like, side
effects, what almost stopped them, regrets. A product rated far below the others in the same
category set means fear outweighs desire there — the page must lead with the answer to it.

## 4. YouTube

Pass one — what is big:

1. Search each query (see `source-map.md`) and sort by view count.
2. Record title, channel, views, age for the top 10–15 per category.
3. Cluster by question. View counts across clusters give a real, numeric ranking of questions.

If the results page comes back empty in a hidden browser pane, take one screenshot of the
pane and read it again.

Pass two — what is said (optional, on request or when the page needs arguments): transcripts
through the `youtube-research` skill. It runs `yt-dlp` on the user's machine (a home IP is
required), writes `transcripts/<id>.txt` with timecodes, and the notes cite `[m:ss]`. For
non-English markets pass the caption languages, e.g. `--langs "de.*,en.*"`. Auto-captions
mishear drug names; mark doubtful terms.

## 5. Forums

See `forum-research-prompts.md`. Eight things to extract, always the same:

1. Trigger moments — the event that made the person act. Most valuable, least available
   elsewhere.
2. Fears and objections before starting, in order of how often they recur.
3. Questions asked before starting.
4. Desired outcomes in their own words.
5. "Aha" moments and regrets from people on treatment.
6. The partner's perspective.
7. What people love and hate about named providers.
8. Why people quit.

## 6. Own data

**Confluence** (or the company wiki): search for personas, brand guidelines, tone of voice,
release notes for the brand, prior research and PRDs for the category page. Capture the main
customer, brand vocabulary (words to use and to avoid), product facts that answer market
complaints (when the card is charged, how to pause or cancel), and prior findings. Note which
market each document was written for.

**Mixpanel** (or the analytics tool), for the existing category page in this market or the
closest one:

- device split on page views;
- funnel: page view → click into the funnel → questionnaire → treatment choice → paid;
- where on the page the click happens (hero, sticky button, treatment block, FAQ);
- time from landing to click;
- new versus returning visitors;
- conversion by channel — treat with caution until an analyst confirms how the channel
  property is built.

Say what the tool does not track (scroll depth, section views) and recommend adding it for
the new page.

## 7. Often skipped — name them if you skip them

- Meta Ad Library and Google Ads Transparency: which hooks competitors keep running longest.
- Google "People also ask" for the main queries.
- App store reviews of competitors.
- Support tickets and chat logs: questions people ask before buying.
- Cancellation reasons from your own product.
- Answers to the "why do you want this" question in your own questionnaire.

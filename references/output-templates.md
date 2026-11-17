# Output templates

## Folder layout

```
docs/<topic>-research/
├── README.md                 entry point: synthesis + status + how to continue
├── <category>.md             one per category: competitors, video, reviews (first sweep)
├── competitors-live.md       leaders' pages read in full
├── reviews.md                service reviews + patient reviews
├── own-data.md               Confluence + Mixpanel (or one file each)
├── youtube.md                top by views; transcripts notes if a deeper pass was done
└── forums/
    ├── <category>.md         one per category, collected by another tool
    └── <question>.md         single-question follow-ups
```

Every source file starts with one line saying how it was read and when.

## README.md

```markdown
# Research for <page>: <categories> · <market>

Collected <date>. Goal of the page: <one sentence>.

## What was checked and what was not
| Source | Status |
|---|---|
| <source> | Read directly / Collected by <tool>, quotes not checked / Search snippets only / Not read: <reason> |

## Common findings
Numbered, each one a sentence in bold plus two or three lines of evidence.

## By category
| | <Category 1> | <Category 2> | <Category 3> |
|---|---|---|---|
| What they really want | | | |
| Main fear | | | |
| Biggest question on YouTube (views) | | | |
| Hook for the first screen | | | |
| What the leaders already do | | | |
| What is still free | | | |
| Honest urgency | | | |

## Trigger moments
| Category | Triggers |
|---|---|

## Objection ranking
One table per category (see below).

## Complaints about providers
(see below)

## How competitors sell
Shared skeleton · techniques · what they hide · what nobody does.

## What our own data adds
Device split, where clicks happen, funnel, personas, brand vocabulary.

## Page skeleton
Numbered blocks, each with one line on why it is there.

## State on <date> and how to continue
File table with trust level · decisions made by the owner · open questions · gaps.
```

The last section matters: it is what the next session, or the next PM, reads first.

## Objection ranking table

```markdown
Order: by how often the theme recurs in <N> forum threads collected by <tool>.
An order, not a share.

| # | Objection | How it sounds | Also confirmed in | Where to answer on the page |
|---|---|---|---|---|
| 1 | Side effects: nausea, fatigue | "It will wreck my working week" | YouTube 7.1M · patient reviews · own research | Side-effects block in view, not in a collapsed FAQ |
```

- "How it sounds" is the customer's sentence, short, in the original language where it helps.
- "Also confirmed in" lists other sources, with the number when there is one (views, rating).
  An empty cell is information: the objection rests on forums alone.
- "Where to answer" names a block and a position (first screen, next to the product choice,
  FAQ). "In the FAQ" is a legitimate answer only for low-ranked objections.

## Provider complaints table

```markdown
| # | Complaint | What it looks like | Seen in | What we have against it |
|---|---|---|---|---|
| 1 | Charges on top of the product price | Membership as a separate line, disclosed in a footnote | Trustpilot: <brands> · forums | Decide: one all-in price? |
```

The last column has three honest values: what the product already does, "to confirm" with
the owner named, or "no data".

## Competitor techniques table

```markdown
| # | Technique | What it looks like | Who |
|---|---|---|---|
| 1 | Two buttons in the first screen | Hard "Get started" + soft "See if it's right for me" | <brands>, all pages read |
```

Follow it with a first-screen comparison of the two or three leaders per category (headline,
buttons, number of products, whether prices are shown), then two lists: **what they hide**
and **what nobody does**. The second list is where the page's own angle comes from.

## Chat summary

Five or six conclusions, each one sentence; what is not verified; what needs the user's
decision; where the files are. Not a retelling of the README.

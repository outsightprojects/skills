---
name: rice-ice-prioritizer
description: Score features or experiments with RICE and ICE, list the assumptions behind each number, and rank them.
---

# RICE and ICE Prioritizer

## What it does
Takes a list of candidate features, experiments, or initiatives and produces a RICE or ICE scored, ranked table with the reasoning behind each score, confidence callouts, and a final recommendation for what to fund this quarter.

## When to use RICE vs. ICE
- **RICE** (Reach x Impact x Confidence / Effort) when you can estimate how many users each item touches per time period. Good for product roadmaps and prioritizing across customer segments.
- **ICE** (Impact, Confidence, Ease) when reach is roughly constant or unknown, such as scoring growth experiments or early-stage discovery bets. Faster, less rigorous.

## How to use
Collect from the user: the list of items, a one-line description for each, the time window for Reach (per week, per month, per quarter), and any known data (funnel rates, user counts, prior experiment results). If the user provides only titles, ask for a one-liner on each.

## Scoring rules

**Reach** - Estimated unique users or events impacted in the chosen time window. Use real numbers, not vibes. If unknown, mark with a '?' and drop confidence.

**Impact** - Massive 3, High 2, Medium 1, Low 0.5, Minimal 0.25. Anchor to a business metric (activation, retention, revenue). Force the author to state the metric.

**Confidence** - 100 percent for directly-measured evidence, 80 percent for strong qualitative or indirect data, 50 percent for informed guess, below 50 percent means do discovery first, don't score yet.

**Effort** - Person-months across product, design, eng, data. Round to half-months. Include QA and launch ops, not just dev.

**Ease** (ICE only) - 1-10 scale. 10 means a few hours, 1 means a full quarter.

## Output

1. A table with columns: Item, Reach, Impact, Confidence, Effort, RICE score, Top assumptions, Evidence link.
2. Ranked by score, tied scores broken by lower effort.
3. A 'cut line' showing what fits in the stated capacity (e.g., 6 person-months).
4. A narrative block: top 3 picks and why, bottom 3 and why they were cut, any items the author should do MORE discovery on before scoring again.
5. A 'confidence alarm' list: every item scoring below 50 percent confidence and what single piece of evidence would raise it.

## Common failure modes to flag
- Padded confidence numbers. If confidence is always 100 percent, something is wrong.
- Impact with no metric attached.
- Effort estimates that ignore design, QA, docs, and support training.
- Reach in the wrong time window (some items counted monthly, others yearly).
- Scoring strategic bets with RICE. Strategic bets belong on a separate bets list, not scored next to tactical work.
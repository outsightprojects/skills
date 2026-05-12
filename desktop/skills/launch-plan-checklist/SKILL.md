---
name: launch-plan-checklist
description: Produce a tiered cross-functional launch plan with beta gates, GTM tasks, and a day-of runbook.
---

# Launch Plan Checklist

## What it does
Produces a complete, tiered launch plan for a new feature or product: launch tier, audiences, beta and GA criteria, owner assignments across every function, and a day-of runbook with rollback instructions.

## How to use
Ask for: the feature, target GA date, expected business impact, target audience, and whether this replaces an existing feature. From that, propose a launch tier:

- **Tier 1** - Marquee launch. Press, webinar, homepage, CEO quote. Used once or twice a year.
- **Tier 2** - Standard feature launch. Blog post, in-app announcement, changelog, sales enablement, docs.
- **Tier 3** - Quiet ship. Release notes and changelog only. Most B2B feature work belongs here.

## Checklist by function

**Product**
- Feature-flag rollout plan: 1 percent, 10 percent, 50 percent, 100 percent.
- Beta entrance and exit criteria written down.
- Success metrics dashboard live before launch.
- Kill switch tested.

**Engineering**
- Load test completed at 2x expected peak.
- On-call schedule covers the 72 hours after launch.
- Logging and alerting thresholds configured.
- Data backfill done and verified if needed.

**Design**
- Empty, error, and edge states shipped.
- Copy reviewed by content design.
- Accessibility audit passed.

**Product marketing**
- Positioning doc: audience, problem, value props, proof points, differentiators.
- Launch blog post, press release, one-pager.
- Demo video or GIF for every key use case.
- Naming and trademark check.

**Sales and CS**
- Internal enablement session recorded.
- Pricing and packaging changes entered in CPQ and billing.
- Playbook for objections.
- Champion list for outbound the day of.

**Support**
- Help-center article live before launch.
- Top 10 expected questions with scripted answers.
- Macro updates in the support tool.
- Escalation path for P1 issues.

**Legal and compliance**
- Terms updates reviewed.
- Data processing and privacy review done.
- Regional restrictions documented.

**Data**
- Instrumentation QA passed.
- Launch dashboard shared.
- Pre-registered success and guardrail metrics.

## Day-of runbook

- T-24h: final go/no-go meeting with sign-off from every function above.
- T-0: turn on feature flag for launch cohort.
- T+15min: verify metrics and error rates.
- T+1h: publish external comms.
- T+24h, T+72h, T+7d: metrics check-ins, triage any issues.

## Rollback plan
One-line instruction for killing the flag, one named person empowered to call it, thresholds that auto-trigger rollback, comms template for the rollback.

## Post-launch
Schedule a launch review 14 days out: what moved, what did not, biggest surprise, what we would do differently. Update the launch template with the lesson.
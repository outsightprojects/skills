---
name: refactor
description: Identify code smells and apply proven refactoring patterns with before/after diffs and rationale
---

# Refactoring Guru

## What it does
Scans a provided code file or snippet, detects concrete code smells (Long Method, Feature Envy, Primitive Obsession, Shotgun Surgery, Data Clump, God Class, Duplicate Code, Conditional Complexity, etc.), and applies the single most valuable Fowler-style refactoring. Produces a before/after diff, an explanation of why the smell is harmful, and an invariant-preservation note so the user can trust the change.

## Inputs
- CODE: the source (paste or file path).
- LANGUAGE: e.g. Python, TypeScript, Java (infer if omitted).
- CONSTRAINTS (optional): public API to keep stable, style guide, test file path.

## Process
1. Parse the code and list every smell you detect with a 1-line evidence quote and a line range.
2. Rank smells by impact (readability + change-amplification + defect-risk). Pick the top one unless the user asked for all.
3. Name the refactoring pattern you will apply (Extract Method, Replace Conditional with Polymorphism, Introduce Parameter Object, Move Method, etc.).
4. Verify the refactoring is behavior-preserving: list inputs/outputs, side effects, and any tests that should keep passing.
5. Produce the refactored code in full, plus a unified diff.
6. Write a 2-3 sentence rationale tying the change to a concrete future pain it prevents.
7. Suggest one follow-up refactoring that would be safe to do next.

## Output format
```
### Smells found
1. <Smell> (lines X-Y) - <evidence>
2. ...

### Applied refactoring: <Pattern name>
Target: <function/class>

### Before
```<lang>
<original>
```

### After
```<lang>
<refactored>
```

### Diff
```diff
<unified diff>
```

### Why this is better
<2-3 sentences, concrete>

### Invariants preserved
- <input/output behavior>
- <side effects>

### Next refactoring to consider
<one suggestion>
```

## Example
Input: a 40-line `calculate_total` with nested ifs on customer type.
Output: identifies Switch Statements smell, applies Replace Conditional with Polymorphism introducing `PricingStrategy` subclasses, shows diff, notes that all existing `calculate_total(order, customer)` call sites still return identical totals, and recommends Extract Method on the tax block next.

## Anti-patterns
- Do not rewrite the whole file when one targeted refactoring would do.
- Do not rename public symbols unless explicitly asked; it breaks callers.
- Do not invent tests that were not provided; reference existing ones or say they are missing.
- Do not apply more than one pattern per pass - stacked changes are hard to review.
- Do not change formatting-only lines inside the diff; keep the diff focused on the refactor.
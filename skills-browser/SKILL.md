---
name: skills-browser
description: Browse all installed skills with auto-generated friendly names, organized by category. Use when the user wants to see what skills are available, find a skill, or get an overview of installed capabilities.
---

# Skills Browser

When this skill is invoked, present a clean, organized directory of ALL available skills with human-friendly titles.

## How to Generate Friendly Titles

For each skill listed in the system context (the skill registry), generate a short, clear title:

1. **Extract the core purpose** from the skill's description (the text after the colon in the listing)
2. **Create a 2-5 word title** that a non-technical person would understand
3. **Use title case** (e.g., "PDF Tools", "Document Co-Author")

### Title Generation Rules

| Pattern | Title Strategy | Example |
|---------|---------------|---------|
| Tool-like skills (pdf, xlsx, docx, pptx) | "[Format] Tools" | "PDF Tools", "Excel Tools" |
| Workflow skills (doc-coauthoring, create-shortcut) | Verb + Noun | "Co-Author Documents", "Create Shortcuts" |
| Framework/domain skills (axiom:axiom-swiftui-nav) | Domain + Focus | "SwiftUI Navigation", "Core Data Storage" |
| Diagnostic skills (*-diag) | "Troubleshoot [Domain]" | "Troubleshoot SwiftUI" |
| Reference skills (*-ref) | "[Domain] Reference" | "SwiftUI Layout Reference" |
| Audit/analysis skills (aso-*, gsd:*) | Describe the action | "App Store Optimization", "Project Planning" |
| Meta skills (skill-creator, using-*) | "Manage [Thing]" or "Getting Started" | "Create Skills", "Getting Started" |

### Handling Skill Name Patterns

- `axiom:axiom-X` → strip prefix, humanize X
- `gsd:X` → "Project: [humanized X]"
- `Notion:X` → "Notion: [humanized X]"
- `superpowers:X` → "[humanized X]"
- `ralph-loop:X` → "Ralph Loop: [humanized X]"
- `figma:X` → "Figma: [humanized X]"
- `atlassian:X` → "Atlassian: [humanized X]"
- Plain names → humanize directly

## Output Format

Present the skills in this format, grouped by category:

```
## [Category Name]

| # | Title | Command | What It Does |
|---|-------|---------|--------------|
| 1 | Friendly Title | `/skill-name` | One-line plain-English summary |
```

## Categories

Group skills into these user-friendly categories (skip empty categories):

1. **Documents & Files** — PDF, Excel, Word, PowerPoint, document workflows
2. **Writing & Communication** — Co-authoring, internal comms, brainstorming
3. **Project Management** — Planning, execution, debugging workflows, progress tracking
4. **iOS & Swift Development** — All Axiom iOS/Swift skills (sub-group by domain)
5. **Code Quality** — Testing, code review, verification, git workflows
6. **Design & UI** — Figma integration, frontend design
7. **Integrations** — Notion, Atlassian, third-party services
8. **Claude Code Customization** — Skill creation, plugin development, hooks, shortcuts
9. **Other** — Anything that doesn't fit above

### iOS Sub-Groups (within "iOS & Swift Development")

When there are many iOS skills, sub-group them:
- UI & Layout
- Navigation
- Data & Storage
- Networking
- Concurrency
- Performance & Debugging
- Testing
- System Integration (camera, location, StoreKit, etc.)
- AI & ML
- Graphics & Games
- References (collect all *-ref skills)
- Troubleshooting (collect all *-diag skills)

## Interaction

After presenting the directory:

1. Tell the user they can type a number or name to invoke any skill
2. Offer to filter by category or search by keyword
3. If the user asks "what can you do?" or similar, use this skill to answer

## Important

- Include ALL skills from the system context — do not skip any
- If a skill already has a clear title in its name (like "PDF"), still present it with the friendly format
- The `/command` column should show the exact invocation string
- Keep "What It Does" to one short sentence, plain English, no jargon

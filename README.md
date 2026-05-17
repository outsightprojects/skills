# Claude Skills

Single source of truth für Agent Skills, geteilt zwischen **Claude Code CLI**
und **Claude Desktop**. Repo: `git@github.com:outsightprojects/skills.git`.

## Struktur

```
~/.claude/skills/
├── <skill>/SKILL.md     # Die kanonischen Agent Skills (flach, ein Ordner pro Skill)
├── extras/              # Kein Cross-Tool-Sync — nur Ablage
│   ├── desktop-plugins/      # Cowork-Plugin-Bundles (marketing, design, …)
│   ├── desktop-extensions/   # MCP-Extension-Manifeste
│   └── cli-extras/           # Axiom-Referenzen, Plugin-Scaffolds, alte Notizen
├── sync.sh              # Sync zwischen Repo <-> Claude Desktop
└── README.md
```

**Claude Code CLI** liest die Skills direkt aus diesem Verzeichnis — immer
synchron, kein Kopieren nötig. **Claude Desktop** liest aus einem
UUID-verschachtelten, Anthropic-verwalteten Pfad; `sync.sh` gleicht ihn
on-demand ab.

Nur die flachen `<skill>/`-Ordner mit `SKILL.md` sind kanonische Skills.
Alles unter `extras/` ist Ablage und wird nicht synchronisiert.

## Skills (19)

`consolidate-memory`, `create-shortcut`, `doc-coauthoring`, `docx`,
`fundraising-narrative-pressure-tester`, `internal-comms`,
`launch-plan-checklist`, `notion-mcp`, `pdf`, `pptx`, `refactor`,
`rice-ice-prioritizer`, `schedule`, `senior-code-reviewer`, `setup-cowork`,
`skill-creator` (CLI/superpowers), `skill-creator-cowork` (Desktop-Variante),
`skills-browser`, `xlsx`

## Sync

```bash
./sync.sh status   # (default) zeigt Unterschiede Repo <-> Desktop, read-only
./sync.sh push     # Repo  -> Desktop  (Repo gewinnt, spiegelt jeden Skill)
./sync.sh pull     # Desktop -> Repo   (additiv; danach git diff + commit)
```

Der Desktop-Pfad wird per Glob erkannt und überlebt UUID-Wechsel. Anthropic
aktualisiert manche Skills (z. B. `docx`, `pptx`, `skill-creator`) selbst —
um Churn zu vermeiden, in `sync.sh` die Variable `SYNC_EXCLUDE` setzen:

```bash
SYNC_EXCLUDE="docx pptx skill-creator" ./sync.sh push
```

## Workflow

1. Skill bearbeiten/anlegen → in `<skill>/SKILL.md`
2. `./sync.sh push` → in Claude Desktop übernehmen, Desktop neu starten
3. `git add -A && git commit && git push` → auf GitHub sichern

Skill in Desktop geändert? → `./sync.sh pull`, `git diff` prüfen, committen.

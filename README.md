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

## Sync — drei Wege

**1. Automatisch (Standard):** Ein git **post-commit Hook**
(`extras/hooks/post-commit`, aktiviert via `core.hooksPath`) pusht nach
*jedem* Commit automatisch nach Claude Desktop. Nichts zu tun außer
committen — danach Claude Desktop neu starten.

**2. Konversationell:** Der `sync-skills` Skill — einfach „sync my skills"
oder „are my skills in sync" sagen, Claude führt `sync.sh` aus.

**3. Manuell:**

```bash
./sync.sh status   # (default) Unterschiede Repo <-> Desktop, read-only
./sync.sh push     # Repo  -> Desktop  (Repo gewinnt, spiegelt jeden Skill)
./sync.sh pull     # Desktop -> Repo   (additiv; danach git diff + commit)
```

Der Desktop-Pfad wird per Glob erkannt und überlebt UUID-Wechsel. Hook und
manuelle Pushes überspringen standardmäßig die Anthropic-verwalteten Skills
`docx`, `pptx`, `skill-creator` (`SYNC_EXCLUDE`), damit Desktop-seitige
Updates von Anthropic nicht überschrieben werden. Diese trotzdem mitsyncen:

```bash
SYNC_EXCLUDE="" ./sync.sh push
```

Frische Klone: `git config core.hooksPath extras/hooks` einmalig setzen,
damit der Auto-Sync-Hook aktiv ist.

## Workflow

1. Skill bearbeiten/anlegen → in `<skill>/SKILL.md`
2. `git add -A && git commit` → Hook pusht automatisch nach Desktop
3. `git push` → auf GitHub sichern
4. Claude Desktop neu starten, damit die Änderungen geladen werden

Skill in Desktop geändert? → „sync my skills" (pull) oder `./sync.sh pull`,
`git diff` prüfen, committen.

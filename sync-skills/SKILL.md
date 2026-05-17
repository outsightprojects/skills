---
name: sync-skills
description: Use when the user wants to sync Agent Skills between Claude Code CLI and Claude Desktop — e.g. "sync my skills", "push skills to desktop", "pull skills from desktop", "are my skills in sync", "did my skill changes reach desktop". Wraps ~/.claude/skills/sync.sh.
---

# Sync Skills (CLI ⇄ Claude Desktop)

The canonical skills live in `~/.claude/skills/` (this repo). Claude Code CLI
reads them natively. Claude Desktop reads from a separate Anthropic-managed
path. `~/.claude/skills/sync.sh` bridges the two.

## How to run

Always run from the repo so the script can find itself:

```bash
cd ~/.claude/skills && ./sync.sh <command>
```

| Command | Direction | When |
|---|---|---|
| `status` (default) | read-only | "are my skills in sync?" — show what differs |
| `push` | repo → Desktop | user edited a skill and wants it live in Desktop |
| `pull` | Desktop → repo | user edited a skill inside Desktop, bring it back |

## Workflow

1. Run `status` first and report what differs.
2. For `push`: run it, then tell the user to **restart Claude Desktop** to
   load the changes.
3. For `pull`: run it, then run `git diff` so the user can review what came
   back, and offer to commit + push to GitHub.

## Notes

- A git **post-commit hook** already runs `push` automatically after every
  commit in this repo, so manual `push` is usually only needed for an
  immediate sync without committing.
- The hook and manual pushes skip Anthropic-managed skills that Desktop
  auto-updates (`docx`, `pptx`, `skill-creator`) to avoid clobbering upstream
  updates. To force-sync those too: `SYNC_EXCLUDE="" ./sync.sh push`.
- If `sync.sh` reports it can't find the Desktop dir, Claude Desktop hasn't
  been opened with skills enabled yet — that's expected, not an error to fix.
- Only flat `<skill>/SKILL.md` dirs sync. Anything under `extras/` does not.

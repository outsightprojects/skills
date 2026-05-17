#!/usr/bin/env bash
#
# sync.sh — sync Agent Skills between this repo and Claude Desktop.
#
# Topology:
#   - Claude Code CLI reads skills directly from this repo (~/.claude/skills),
#     so the CLI is ALWAYS in sync — no copy needed.
#   - Claude Desktop reads from a UUID-nested, Anthropic-managed path. This
#     script discovers it by glob (survives UUID changes) and copies skills
#     in/out on demand.
#
# Canonical source of truth = top-level <skill>/ dirs in this repo that
# contain a SKILL.md. Everything under extras/ is NOT synced.
#
# Usage:
#   ./sync.sh status     # (default) show which skills differ, read-only
#   ./sync.sh push       # repo  -> Desktop   (repo wins; mirrors each skill)
#   ./sync.sh pull        # Desktop -> repo   (additive; review then commit)
#
# Exclude Anthropic-managed skills that Desktop auto-updates (to avoid churn)
# by adding their dir names to SYNC_EXCLUDE below.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Skills to skip during sync (space-separated dir names). Empty by default.
SYNC_EXCLUDE="${SYNC_EXCLUDE:-}"

# --- Discover the Claude Desktop skills directory -------------------------
discover_desktop_dir() {
  local base="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"
  shopt -s nullglob
  local candidates=( "$base"/*/*/skills )
  shopt -u nullglob
  [ ${#candidates[@]} -eq 0 ] && return 1
  # newest by mtime if more than one
  local newest="" newest_t=0 c t
  for c in "${candidates[@]}"; do
    t=$(stat -f %m "$c" 2>/dev/null || echo 0)
    if [ "$t" -ge "$newest_t" ]; then newest_t=$t; newest="$c"; fi
  done
  printf '%s\n' "$newest"
}

list_skills() {
  local d n
  for d in "$REPO_DIR"/*/; do
    n=$(basename "$d")
    [ "$n" = "extras" ] && continue
    [ -f "$d/SKILL.md" ] || continue
    case " $SYNC_EXCLUDE " in *" $n "*) continue ;; esac
    echo "$n"
  done
}

CMD="${1:-status}"

DESKTOP_DIR="$(discover_desktop_dir || true)"
if [ -z "${DESKTOP_DIR:-}" ]; then
  echo "ERROR: Could not find Claude Desktop skills dir under:"
  echo "  ~/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin/*/*/skills"
  echo "Open Claude Desktop at least once with skills enabled, then retry."
  exit 1
fi

echo "Repo:    $REPO_DIR"
echo "Desktop: $DESKTOP_DIR"
echo "Command: $CMD"
[ -n "$SYNC_EXCLUDE" ] && echo "Excluded: $SYNC_EXCLUDE"
echo

case "$CMD" in
  status)
    differ=0
    while read -r s; do
      if [ ! -d "$DESKTOP_DIR/$s" ]; then
        echo "  [only in repo]    $s"
        differ=1
      elif ! diff -rq "$REPO_DIR/$s" "$DESKTOP_DIR/$s" >/dev/null 2>&1; then
        echo "  [differs]         $s"
        differ=1
      fi
    done < <(list_skills)
    # skills present in Desktop but not in repo
    for d in "$DESKTOP_DIR"/*/; do
      n=$(basename "$d")
      [ -f "$d/SKILL.md" ] || continue
      [ -d "$REPO_DIR/$n" ] || echo "  [only in Desktop] $n"
    done
    [ "$differ" -eq 0 ] && echo "  (repo skills all match Desktop)"
    ;;
  push)
    while read -r s; do
      mkdir -p "$DESKTOP_DIR/$s"
      rsync -a --delete "$REPO_DIR/$s/" "$DESKTOP_DIR/$s/"
      echo "  pushed -> $s"
    done < <(list_skills)
    echo "Done. Restart Claude Desktop to pick up changes."
    ;;
  pull)
    while read -r s; do
      if [ -d "$DESKTOP_DIR/$s" ]; then
        rsync -a "$DESKTOP_DIR/$s/" "$REPO_DIR/$s/"
        echo "  pulled <- $s"
      fi
    done < <(list_skills)
    echo "Done. Review with 'git diff', then commit & push."
    ;;
  *)
    echo "Unknown command: $CMD (use: status | push | pull)"
    exit 1
    ;;
esac

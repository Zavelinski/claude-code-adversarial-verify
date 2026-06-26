#!/usr/bin/env bash
# Install the adversarial-verify skill into ~/.claude (or $CLAUDE_CONFIG_DIR).
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

mkdir -p "$claude_dir/skills/adversarial-verify"
cp "$repo/skills/adversarial-verify/SKILL.md" "$claude_dir/skills/adversarial-verify/SKILL.md"

echo ""
echo "adversarial-verify installed into $claude_dir"
echo "Restart Claude Code, then ask to 'verify this change' (or /adversarial-verify)."

#!/usr/bin/env bash
# Remove the adversarial-verify skill from ~/.claude (or $CLAUDE_CONFIG_DIR).
set -euo pipefail
claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
rm -rf "$claude_dir/skills/adversarial-verify"
echo "adversarial-verify uninstalled from $claude_dir."

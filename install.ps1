# Install the adversarial-verify skill into ~/.claude (or $env:CLAUDE_CONFIG_DIR).
$ErrorActionPreference = 'Stop'

$repo = Split-Path -Parent $MyInvocation.MyCommand.Path
$claudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }

New-Item -ItemType Directory -Force -Path (Join-Path $claudeDir 'skills\adversarial-verify') | Out-Null
Copy-Item (Join-Path $repo 'skills\adversarial-verify\SKILL.md') (Join-Path $claudeDir 'skills\adversarial-verify\SKILL.md') -Force

Write-Host ""
Write-Host "adversarial-verify installed into $claudeDir"
Write-Host "Restart Claude Code, then ask to 'verify this change' (or /adversarial-verify)."

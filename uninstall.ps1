# Remove the adversarial-verify skill from ~/.claude (or $env:CLAUDE_CONFIG_DIR).
$ErrorActionPreference = 'Stop'
$claudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
Remove-Item -Recurse -Force (Join-Path $claudeDir 'skills\adversarial-verify') -ErrorAction SilentlyContinue
Write-Host "adversarial-verify uninstalled from $claudeDir."

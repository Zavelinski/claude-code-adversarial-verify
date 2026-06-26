# adversarial-verify for Claude Code

[![License: MIT](https://img.shields.io/github/license/Zavelinski/claude-code-adversarial-verify)](LICENSE)
[![Stars](https://img.shields.io/github/stars/Zavelinski/claude-code-adversarial-verify?style=flat)](https://github.com/Zavelinski/claude-code-adversarial-verify/stargazers)
[![Last commit](https://img.shields.io/github/last-commit/Zavelinski/claude-code-adversarial-verify)](https://github.com/Zavelinski/claude-code-adversarial-verify/commits)
[![Claude Code skill](https://img.shields.io/badge/Claude%20Code-skill-8A2BE2)](https://claude.com/claude-code)

A [Claude Code](https://claude.com/claude-code) skill that **proves a code change works by trying to break it**. Given a change, it re-derives what the change is supposed to do, writes targeted tests that try to *falsify* that claim, runs them, and returns a binary **PASS / FAIL / INCONCLUSIVE** verdict backed by real executed output — never prose alone.

This is the opposite of a "looks correct to me" review. It pairs naturally with a *no claim without evidence* engineering rule: nothing is "fixed" until a test that could have failed actually passes.

## How it is different from a code review

| Prose review | adversarial-verify |
|---|---|
| "This looks correct, consider edge cases." | Writes a test that reproduces the original bug, runs it, shows it now passes. |
| Opinion. | Binary verdict + executed evidence. |
| Can pass code it never ran. | **No run, no verdict.** |

## The verdict contract

- **PASS** — only if every falsification test passes **and** at least one test actually exercises the change (it would have failed on the pre-change code). A green suite that never touches the change is not a pass.
- **FAIL** — any falsification test fails; the failing case and its output are reported.
- **INCONCLUSIVE** — it cannot be run (no framework, won't build, missing deps). Stated plainly, never upgraded to PASS.

## What it does

1. **Extract the contract** — what the change should now do, and what it must still not break (from the diff + request, not the author's comments).
2. **Pick falsification targets** — reproduce the original failure first, then attack boundaries, error paths, and adjacent behavior.
3. **Write targeted tests** in the project's existing framework, matching its style. Each test must be able to fail.
4. **Run them** and capture the real output.
5. **Confirm the change is exercised** — at least one test maps to it.
6. **Report** — binary verdict + tests added + executed output + an explicit "not covered" list.

### Hard rules
- Never modifies source to make a test pass. Tests adapt to code, never the reverse.
- Never deletes or weakens existing tests to get green.
- Prefers one test that reproduces the bug over ten that decorate the happy path.

## Prerequisites

Claude Code with `/plugin` support (v2.x+) and a shell if you use the manual fallback.

## Install

### Option 1 — Claude Code plugin marketplace (recommended)

```bash
/plugin marketplace add Zavelinski/claude-code-skills
/plugin install adversarial-verify@claude-code-skills
```

Registered hooks (if any) install through the Claude Code consent UI, with no manual edit to `~/.claude/settings.json`.

### Option 2 — Manual fallback (run it yourself)

> **Security note.** This script mutates `~/.claude/settings.json` directly. Claude Code auto-mode blocks it because a third-party `UserPromptSubmit` hook that injects text into every prompt is a known risk vector. The script is benign and local-only (no network), but you must review and run it yourself. Prefer Option 1.

```bash
git clone https://github.com/Zavelinski/claude-code-adversarial-verify.git
cd claude-code-adversarial-verify
bash install.sh        # macOS / Linux
.\install.ps1          # Windows (PowerShell)
```

## Uninstall

```bash
/plugin uninstall adversarial-verify@claude-code-skills    # Option 1
bash uninstall.sh                                # Option 2 (or uninstall.ps1 on Windows)
```

## Update

```bash
/plugin marketplace update claude-code-skills    # Option 1
# Option 2: pull the latest commit and re-run the manual fallback.
```

## License

MIT. See [LICENSE](LICENSE). Original work.

---

## Part of claude-code-skills

This skill ships in the [claude-code-skills](https://zavelinski.github.io/claude-code-skills/) marketplace. Browse its landing page: [adversarial-verify](https://zavelinski.github.io/claude-code-skills/adversarial-verify.html). See also: [godmode](https://github.com/Zavelinski/claude-code-godmode), [skill-security-scan](https://github.com/Zavelinski/claude-code-skill-security-scan).
# adversarial-verify for Claude Code

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

## Install

```bash
git clone https://github.com/Zavelinski/adversarial-verify.git
cd adversarial-verify
```

**macOS / Linux**
```bash
bash install.sh
```

**Windows (PowerShell)**
```powershell
.\install.ps1
```

Skill-only install (no hooks, no `settings.json` changes). Restart Claude Code, then ask to **verify this change** (or `/adversarial-verify`).

## Uninstall

```bash
bash uninstall.sh      # macOS / Linux
```
```powershell
.\uninstall.ps1        # Windows
```

## License

MIT. See [LICENSE](LICENSE). Original work.

# One-shot prompt — bootstrap + wizard

Copy **everything** in the block below into Cursor, Claude Code, or any agent with terminal access.

---

```
You are helping me set up and run the Meraki MX cold-swap wizard from this repository.

PHASE A — BOOTSTRAP (do this first, no migration writes)
1. Read AGENTS.md and docs/agent-bootstrap.md in this repo.
2. If this repo is not open yet, clone: https://github.com/asagatelyan/meraki-mx-cold-swap-ai.git and use it as the workspace.
3. Install Meraki Magic MCP under tools/meraki-magic-mcp-community (clone upstream if missing, install Python deps with uv or venv).
4. Create .env from .env.example (repo root and MCP folder). Ask me for MERAKI_API_KEY and optional MERAKI_ORG_ID — I will provide them; do not commit secrets.
5. Set READ_ONLY_MODE=true in MCP .env.
6. Write .cursor/mcp.json (or my host’s MCP config) with absolute paths to meraki-mcp-dynamic.py.
7. Tell me exactly what to click to enable MCP and reload; wait for my confirmation.
8. Verify MCP with a read-only API call (e.g. list organizations).

PHASE B — WIZARD (after bootstrap works)
9. Follow AGENTS.md, docs/intake.yaml, and docs/playbook.md.
10. One phase at a time. Confirm before every WRITE.
11. Default Method 1 for combined networks unless I explicitly choose Method 2.
12. Start with intake questions, then Phase 0 discovery (READ only).

Official source of truth: Meraki MX Cold Swap documentation.
```

---

## Shorter variant (already set up)

If MCP is already working, use [start-wizard.md](start-wizard.md) instead.

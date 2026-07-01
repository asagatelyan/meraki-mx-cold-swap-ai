# Agent bootstrap (first-time setup)

The AI agent runs this **once** before the migration wizard. Goal: repo ready + Meraki Magic MCP
installed + MCP config written. **No migration writes** in bootstrap.

Reference upstream: [meraki-magic-mcp-community INSTALL](https://github.com/CiscoDevNet/meraki-magic-mcp-community/blob/main/INSTALL.md)

---

## Preconditions (ask user)

1. **AI host** — Cursor, Claude Code, or other agent with terminal access
2. **This repo** — cloned or opened as workspace (if not: `git clone https://github.com/asagatelyan/meraki-mx-cold-swap-ai.git`)
3. **Meraki API key** — org admin; user will paste into `.env` locally (**never** commit or echo in chat logs)
4. **Python 3.10+** — prefer **uv** if system Python is old

---

## Bootstrap steps (agent executes)

| Step | Action | Verify |
|------|--------|--------|
| 1 | Confirm workspace root contains `AGENTS.md` | `pwd` + file exists |
| 2 | `cp -n .env.example .env` if missing | `.env` exists, gitignored |
| 3 | Clone MCP if missing: `git clone https://github.com/CiscoDevNet/meraki-magic-mcp-community.git tools/meraki-magic-mcp-community` | directory exists |
| 4 | Install MCP deps per upstream (uv or venv + `pip install -r requirements.txt`) | `tools/meraki-magic-mcp-community/.venv/bin/python --version` |
| 5 | Copy `.env.example` → `tools/meraki-magic-mcp-community/.env` if missing | file exists |
| 6 | Ask user for `MERAKI_API_KEY` and optional `MERAKI_ORG_ID`; write into **both** `.env` files | `READ_ONLY_MODE=true` |
| 7 | Write `.cursor/mcp.json` (Cursor) or host MCP config with **absolute paths** to dynamic server | see `docs/mcp-setup.md` |
| 8 | **Human step:** user enables MCP in host settings and reloads window | user confirms |
| 9 | Test READ: list organizations or networks via MCP | success, no 401 |

---

## MCP config template (Cursor)

Resolve `REPO_ROOT` to absolute path, then:

```json
{
  "mcpServers": {
    "Meraki_Magic_MCP": {
      "command": "REPO_ROOT/tools/meraki-magic-mcp-community/.venv/bin/python",
      "args": ["REPO_ROOT/tools/meraki-magic-mcp-community/meraki-mcp-dynamic.py"]
    }
  }
}
```

---

## After bootstrap

Say to user: *"Setup complete. Starting MX cold-swap wizard (Phase 0 READ only)."*

Then follow `AGENTS.md` from **Opening dialog** — do not skip intake.

---

## If MCP unavailable

Continue as **checklist-only** wizard (Dashboard clicks). Do not invent API results.

---

## Security

- Never commit `.env`, `mcp.json` with secrets, or `backups/`
- Never print full API key in chat
- Keep `READ_ONLY_MODE=true` until user approves maintenance writes

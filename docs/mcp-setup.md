# Meraki Magic MCP — setup (multi-host)

This repo does **not** vendor Meraki Magic MCP. Clone and install upstream:

**https://github.com/CiscoDevNet/meraki-magic-mcp-community**

Official install: [INSTALL.md](https://github.com/CiscoDevNet/meraki-magic-mcp-community/blob/main/INSTALL.md)

Requires **Python 3.10+** (3.13 recommended via [uv](https://github.com/astral-sh/uv)).

---

## 1. Clone upstream MCP

```bash
mkdir -p tools && cd tools
git clone https://github.com/CiscoDevNet/meraki-magic-mcp-community.git
cd meraki-magic-mcp-community
# Follow upstream INSTALL.md for uv/venv and requirements
```

---

## 2. Credentials (never commit)

In `tools/meraki-magic-mcp-community/.env` (or copy from this repo's `.env.example`):

```env
MERAKI_API_KEY=
MERAKI_ORG_ID=
READ_ONLY_MODE=true
```

| Source | Field |
|--------|--------|
| Dashboard → Organization → Settings → Dashboard API access | API key, Organization ID |

Keep `READ_ONLY_MODE=true` until the user approves maintenance writes.

---

## 3. Host-specific MCP configuration

Adjust paths to your machine. Use the **dynamic** server (`meraki-mcp-dynamic.py`) for full API coverage.

### Cursor (project)

Copy [mcp.json.example](../mcp.json.example) to `.cursor/mcp.json` in **this repo** or your site project:

```json
{
  "mcpServers": {
    "Meraki_Magic_MCP": {
      "command": "/ABSOLUTE/PATH/tools/meraki-magic-mcp-community/.venv/bin/python",
      "args": ["/ABSOLUTE/PATH/tools/meraki-magic-mcp-community/meraki-mcp-dynamic.py"]
    }
  }
}
```

Enable in **Cursor Settings → MCP**, then reload the window.

### Cursor (user-global)

Same block in `~/.cursor/mcp.json` if you want Meraki MCP in every workspace.

### Claude Code

Add MCP server per [Claude Code MCP documentation](https://docs.anthropic.com/en/docs/claude-code/mcp).
Example shape (paths must be absolute on your system):

```json
{
  "mcpServers": {
    "meraki-magic": {
      "command": "/ABSOLUTE/PATH/tools/meraki-magic-mcp-community/.venv/bin/python",
      "args": ["/ABSOLUTE/PATH/tools/meraki-magic-mcp-community/meraki-mcp-dynamic.py"]
    }
  }
}
```

Open this repo as the project directory so `CLAUDE.md` / `AGENTS.md` apply.

### VS Code (GitHub Copilot / MCP)

If your VS Code build supports MCP, use the same `command` + `args` in the host's MCP config file
(location varies by extension — check your MCP extension docs).

---

## 4. Verify

Ask the agent:

- "What Meraki MCP tools are available?"
- "List my Meraki organizations" (after `.env` is set)

If the server fails: check host **MCP output/logs** for `MERAKI_API_KEY is not set` or `401`.

---

## 5. Use with this wizard

1. Configure `.env` and enable MCP.
2. In Cursor: `@meraki-mx-cold-swap-wizard` or enable skill `meraki-mx-cold-swap`.
3. Say: *"Start MX cold-swap wizard — Method 1 for network &lt;name&gt;."*
4. Complete [intake.yaml](intake.yaml) with the agent.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| MCP not listed | Reload window; verify absolute paths |
| Writes blocked | `READ_ONLY_MODE=false` only during approved maintenance |
| Stale device status | Cross-check with live Dashboard or API READ |
| Python too old | Use upstream uv / 3.13 venv |

---

## Update upstream

```bash
cd tools/meraki-magic-mcp-community
git pull
uv pip install -r requirements.txt --python .venv/bin/python
```

Reload your AI host after updates.

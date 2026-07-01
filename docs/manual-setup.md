# Manual setup (without AI bootstrap)

Use this if you prefer hands-on steps or your agent cannot run terminal commands.

---

## 1. Clone and configure

```bash
git clone https://github.com/asagatelyan/meraki-mx-cold-swap-ai.git
cd meraki-mx-cold-swap-ai
cp .env.example .env
# Edit .env — never commit it
```

---

## 2. Install Meraki Magic MCP

```bash
git clone https://github.com/CiscoDevNet/meraki-magic-mcp-community.git tools/meraki-magic-mcp-community
cd tools/meraki-magic-mcp-community
# Follow upstream INSTALL.md (uv recommended, Python 3.10+)
cp .env-example .env   # or copy from repo root .env.example
# Set MERAKI_API_KEY, MERAKI_ORG_ID, READ_ONLY_MODE=true
```

Full host examples: [mcp-setup.md](mcp-setup.md)

---

## 3. Run the wizard

| Tool | How |
|------|-----|
| **Cursor** | Copy `mcp.json.example` → `.cursor/mcp.json` (absolute paths); enable MCP; `@meraki-mx-cold-swap-wizard` |
| **Claude Code** | Open repo; see `CLAUDE.md`; configure MCP per Anthropic docs |
| **Other** | Point agent at `AGENTS.md` + [prompts/start-wizard.md](../prompts/start-wizard.md) |

---

## AI-led alternative (recommended)

See [prompts/bootstrap-and-wizard.md](../prompts/bootstrap-and-wizard.md) — one prompt for the agent to run steps 1–3 for you.

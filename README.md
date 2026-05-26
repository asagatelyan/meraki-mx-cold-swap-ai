# meraki-mx-cold-swap-ai

AI-first wizard and playbook for **Meraki MX cold-swap** migrations (replace an existing MX
with a **different** MX model), designed for Cursor, Claude Code, and other agents.

**Not affiliated with Cisco or Meraki.** Official procedure:
[MX Cold Swap](https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX).

API automation via community MCP:
[meraki-magic-mcp-community](https://github.com/CiscoDevNet/meraki-magic-mcp-community).

---

## Scope (v0.1.0)

| In scope | Out of scope |
|----------|----------------|
| Method 1 (quick swap) and Method 2 (clone / split-recombine) guidance | Non-MX products (standalone MS-only sites without MX) |
| Combined vs appliance-only decision tree | Meraki support or license sales |
| Phase 0–3 checklists, port worksheet, lessons learned | Guaranteed automation for every org API edge case |
| Meraki Magic MCP setup (multi-host examples) | Vendored copy of Meraki Magic MCP (install upstream) |

**Example migration pattern:** MX67W → MX68WC / MX68CW (port mapping and WWAN differ — always verify
against Meraki's table for your exact SKUs).

---

## Quick start

### 1. Clone and configure

```bash
git clone https://github.com/asagatelyan/meraki-mx-cold-swap-ai.git
cd meraki-mx-cold-swap-ai
cp .env.example .env
# Edit .env — never commit it
```

### 2. Install Meraki Magic MCP

Follow [docs/mcp-setup.md](docs/mcp-setup.md) and upstream
[INSTALL.md](https://github.com/CiscoDevNet/meraki-magic-mcp-community/blob/main/INSTALL.md).

### 3. Run the wizard in your AI tool

| Tool | How |
|------|-----|
| **Cursor** | Copy `mcp.json.example` → `.cursor/mcp.json`, enable MCP; `@` rule `meraki-mx-cold-swap-wizard` or install skill from `skills/meraki-mx-cold-swap/` |
| **Claude Code** | Open repo; `CLAUDE.md` points to `AGENTS.md`; configure MCP per Anthropic docs |
| **Other agents** | Point the agent at repo root `AGENTS.md` + `docs/playbook.md` |

Starter prompt: [prompts/start-wizard.md](prompts/start-wizard.md)

---

## Repository layout

```
AGENTS.md              # Portable agent brain (primary)
CLAUDE.md              # Claude Code entry point
skills/meraki-mx-cold-swap/SKILL.md
.cursor/rules/         # Thin Cursor rule → AGENTS.md
docs/
  playbook.md          # Methods, phases, MCP hints
  intake.yaml          # Required fields before Phase 0
  mcp-setup.md         # Cursor, Claude Code, VS Code examples
  lessons-learned.md   # Real-world pitfalls (anonymized)
  validation-checklist.md
prompts/start-wizard.md
examples/phase0-summary.example.md
tools/meraki_backup_network.py   # Optional Phase 0 backup (env-driven)
```

---

## License and attribution

- **Code and docs:** [MIT License](LICENSE)
- **Attribution preference:** [NOTICE](NOTICE)
- **Liability:** [DISCLAIMER.md](DISCLAIMER.md)

Meraki® and Cisco® are trademarks of Cisco Systems, Inc.

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). **Do not** submit real org IDs, serials, API keys, or
customer backups in issues or PRs.

---

## Security

See [SECURITY.md](SECURITY.md). CI runs secret scanning on push/PR.

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

# meraki-mx-cold-swap-ai

**AI-led Meraki MX cold-swap wizard** — replace an existing MX with a different model using
Cursor, Claude Code, or any agent + optional [Meraki Magic MCP](https://github.com/CiscoDevNet/meraki-magic-mcp-community).

**Not affiliated with Cisco or Meraki.** Official procedure:
[MX Cold Swap](https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX).

---

## Start here — one prompt (recommended)

1. **Open this repo in Cursor** (or clone it and open the folder).
2. **Copy the prompt below** into chat and send it.
3. **Answer the agent’s questions** (API key, org/network, MX serials). The agent handles install + wizard.

<details open>
<summary><strong>Copy this into your AI agent</strong></summary>

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

</details>

Same prompt as a file: [prompts/bootstrap-and-wizard.md](prompts/bootstrap-and-wizard.md)

### What the agent does for you

| Phase | Agent | You |
|-------|--------|-----|
| **Bootstrap** | Clone/install MCP, `.env`, MCP config, verify API read | Provide API key; enable MCP in UI; reload |
| **Wizard** | Intake → Phase 0 READ → plan Method 1/2 → cutover steps | Approve writes; physical cabling; maintenance window |

**The “agent”** here is your AI assistant following `AGENTS.md` — not a separate app. See [docs/what-is-the-agent.md](docs/what-is-the-agent.md).

---

## Manual setup (optional)

Prefer typing commands yourself? → [docs/manual-setup.md](docs/manual-setup.md)

Already have MCP working? → [prompts/start-wizard.md](prompts/start-wizard.md)

---

## Scope (v0.2.0)

| In scope | Out of scope |
|----------|----------------|
| AI-led bootstrap + Method 1 / Method 2 wizard | Standalone hosted “Meraki agent” product |
| Combined vs appliance-only decision tree | Official Cisco/Meraki support |
| Phase 0–3, port worksheet, lessons learned | Every org API edge case automated |

**Example pattern:** MX67W → MX68WC / MX68CW — always verify port mapping for your SKUs.

---

## Repository layout

```
AGENTS.md                 # Wizard behavior (+ bootstrap rules)
docs/agent-bootstrap.md   # First-time setup checklist for agents
docs/playbook.md          # Migration phases
docs/intake.yaml          # Required fields
prompts/bootstrap-and-wizard.md
skills/meraki-mx-cold-swap/SKILL.md
.cursor/rules/            # Cursor: thin pointer to AGENTS.md
```

---

## License and attribution

- [MIT License](LICENSE) · [NOTICE](NOTICE) · [DISCLAIMER.md](DISCLAIMER.md)

Meraki® and Cisco® are trademarks of Cisco Systems, Inc.

---

## Contributing · Security · Changelog

- [CONTRIBUTING.md](CONTRIBUTING.md)
- [SECURITY.md](SECURITY.md)
- [CHANGELOG.md](CHANGELOG.md)

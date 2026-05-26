# Claude Code — Meraki MX cold-swap

Use this repository as the working directory for MX cold-swap migrations.

## Primary instructions

Follow **[AGENTS.md](AGENTS.md)** for wizard behavior, safety rules, and phase flow.

## Key documents

- [docs/playbook.md](docs/playbook.md) — Method 1 & 2, phases, MCP patterns
- [docs/intake.yaml](docs/intake.yaml) — required fields before Phase 0
- [docs/mcp-setup.md](docs/mcp-setup.md) — Meraki Magic MCP install (including Claude Code)
- [docs/lessons-learned.md](docs/lessons-learned.md) — pitfalls from field migrations

## MCP

Install [meraki-magic-mcp-community](https://github.com/CiscoDevNet/meraki-magic-mcp-community)
separately. Keep `READ_ONLY_MODE=true` until the user approves writes.

## Official reference

https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX

## Legal

[DISCLAIMER.md](DISCLAIMER.md) — unofficial, not Cisco/Meraki; use at your own risk.

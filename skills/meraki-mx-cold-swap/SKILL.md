---
name: meraki-mx-cold-swap
description: >-
  Meraki MX cold-swap wizard: bootstrap (install MCP) + migration phases. Use when the user
  sets up this repo, migrates MX hardware, cold swap, EOS replacement, MX67W to MX68WC,
  combined network split/recombine, or asks for Meraki MX migration help.
---

# Meraki MX cold-swap wizard

## When to use

- User is replacing a Meraki MX with a **different model** (cold swap)
- User mentions Meraki Magic MCP, MX migration, Method 1/2, or combined network cutover

## Instructions

0. **First run / no MCP?** Follow **[docs/agent-bootstrap.md](../../docs/agent-bootstrap.md)**.
   One-shot user prompt: **[prompts/bootstrap-and-wizard.md](../../prompts/bootstrap-and-wizard.md)**.
1. Read **[AGENTS.md](../../AGENTS.md)** and follow it as the primary behavior contract.
2. Collect intake from **[docs/intake.yaml](../../docs/intake.yaml)**; confirm back to the user.
3. Run **Phase 0 READ** before any write; summarize in a table.
4. Choose path using playbook rules:
   - Combined → default **Method 1** unless user accepts Method 2 risks
   - Appliance-only → Method 1 or 2 per user downtime needs
5. Follow **[docs/playbook.md](../../docs/playbook.md)** phase by phase.
6. For combined Method 2, read **[docs/combined-network-method2.md](../../docs/combined-network-method2.md)** and **[docs/lessons-learned.md](../../docs/lessons-learned.md)**.
7. MCP setup: **[docs/mcp-setup.md](../../docs/mcp-setup.md)** — keep `READ_ONLY_MODE=true` until approved writes.

## MCP

Install upstream (not vendored in this repo):

https://github.com/CiscoDevNet/meraki-magic-mcp-community

## Official doc

https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX

## Safety

- Confirm every WRITE with method + parameters
- Never bulk-move MS/MR/MV/MT on combined Method 2
- See **[DISCLAIMER.md](../../DISCLAIMER.md)**

## Starter prompts

- **Bootstrap + wizard:** **[prompts/bootstrap-and-wizard.md](../../prompts/bootstrap-and-wizard.md)**
- **Wizard only (MCP ready):** **[prompts/start-wizard.md](../../prompts/start-wizard.md)**

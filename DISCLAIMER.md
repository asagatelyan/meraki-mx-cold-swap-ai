# Disclaimer

This repository provides **community-maintained** guidance and AI agent instructions
for Meraki MX cold-swap migrations. It is **not** official Cisco or Meraki
documentation, support, or a certified migration tool.

## No warranty

Use at your own risk. The authors and contributors disclaim all liability for
outages, misconfiguration, data loss, security incidents, or compliance failures
arising from following these materials or from API/MCP automation.

## Your responsibilities

- Validate every step against [Meraki MX Cold Swap](https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX)
  and your organization's change process.
- Test in a **lab network** before production.
- Use `READ_ONLY_MODE` on Meraki Magic MCP until you explicitly approve writes.
- Protect API keys; never commit secrets to git.
- Confirm employer or customer policies before open-sourcing forked changes.

## Trademarks

Meraki®, Cisco®, and MX™ are trademarks of Cisco Systems, Inc. Other names may
be trademarks of their respective owners. This project is unofficial.

# Starter prompt (copy into any AI host)

```
Start the Meraki MX cold-swap wizard for my site.

I will provide:
- Organization ID and network ID (or names for you to look up via MCP)
- Old MX model and serial
- New MX model and serial
- Whether this is a combined network (MX + switch/AP/camera/sensor)
- WAN type (DHCP/static) and whether site-to-site VPN or AnyConnect custom certs apply

Use READ_ONLY_MODE on Meraki MCP until I approve writes.
Follow AGENTS.md and docs/playbook.md one phase at a time.
Default to Method 1 for combined networks unless I explicitly choose Method 2.

Begin with intake confirmation, then Phase 0 discovery (READ only).
```

## Example (synthetic placeholders)

```
Start MX cold-swap wizard — Method 1.

Org: ExampleOrg (123456)
Network: Site-Branch-A (L_000000000000000001)
Old MX: MX67W serial Q2XX-AAAA-BBBB
New MX: MX68WC serial Q2YY-CCCC-DDDD
Combined: yes (MX + MR + MV)
WAN1: DHCP, WAN2: static (will use local status page)
VPN: AutoVPN spoke, no AnyConnect custom cert

Phase 0 only for now.
```

# Official references

Use these as the **source of truth**. This repository supplements them for AI-assisted workflows.

| Topic | URL |
|-------|-----|
| **MX Cold Swap** | https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX |
| **Dashboard API** | https://developer.cisco.com/meraki/api-v1/ |
| **Meraki Magic MCP (community)** | https://github.com/CiscoDevNet/meraki-magic-mcp-community |
| **Unreachable device alerts** | https://documentation.meraki.com/General_Administration/Cross-Platform_Content/Alerts_and_Notifications/Dashboard_Alerts_-_Connectivity_Issues |

## Port mapping

The cold-swap article includes a **port mapping** table when physical port labels differ between
models. Always map by **logical Dashboard port** role (WAN/LAN index), not silkscreen alone.

## Combined networks + clone integration

See the cold-swap article section *Integrating the Cloned MX Network with an Existing Combined
Network* before attempting Method 2 on combined sites.

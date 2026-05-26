# Lessons learned (anonymized)

Pitfalls observed during real MX cold-swap migrations. Generic patterns — no customer identifiers.

---

## Combined network + Method 2

| Issue | What happened | Mitigation |
|-------|---------------|------------|
| Full **combined** clone | Clone copied MX + switch + wireless + cameras → `combineOrganizationNetworks` failed (duplicate product types) | Clone **appliance-only** slice, or use Method 1 |
| Bulk inventory move | Tempting to "move" MS/MR/MV/MT to clone network | **Never** for combined sites — use **split + recombine** per Meraki doc |
| Stale MCP cache | Agent reported device offline while Dashboard showed online | Re-run status via live API READ |

See [combined-network-method2.md](combined-network-method2.md).

---

## MX appliance ports (newer MX models)

| Issue | What happened | Mitigation |
|-------|---------------|------------|
| Disable port via API | `updateNetworkAppliancePort` enable=false failed on unused port | Some models require **enable true**, configure, then **disable** (two-step) |
| Logical vs physical | Camera worked on wrong physical jack after swap | Build [port-worksheet.md](port-worksheet.md); verify LLDP after cutover |
| Access vs trunk on camera port | Trunk + drop untagged broke camera | Use **access VLAN** for single-VLAN cameras unless you need trunk |

---

## WAN / uplink

| Issue | What happened | Mitigation |
|-------|---------------|------------|
| Static WAN2 | Dashboard API showed WAN2 empty after migration | Re-apply on **local status page**; verify in Dashboard uplink UI |
| LAN before check-in | LAN plugged early | **WAN first**, wait for check-in, then LAN per Meraki guidance |

---

## Wireless (post-migration)

| Issue | What happened | Mitigation |
|-------|---------------|------------|
| CW9172 `wpa3_warning` | 6 GHz disabled — no WPA3 SSID | Enable **WPA3 Transition Mode** on primary SSID if you need 6 GHz; brief client reconnect |
| Assurance vs health | Device "alerting" but online | Distinguish configuration warnings from outage |

---

## Method selection (recommendation)

- **Combined network (MX + MS/MR/MV/MT):** default **Method 1** unless stakeholders accept split/recombine risk.
- **Appliance-only:** Method 2 viable when pre-staging and clone workflow are understood.

---

## Pre-flight

- Lab-test `splitNetwork` / `combineOrganizationNetworks` in a throwaway org if possible.
- Phase 0 JSON backup via `tools/meraki_backup_network.py` — store **outside git**.
- Run `gitleaks` before publishing any fork with local edits.

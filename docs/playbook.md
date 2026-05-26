# Meraki MX cold-swap playbook (AI + Dashboard)

Pair with **[AGENTS.md](../AGENTS.md)** so the agent runs **one phase at a time** and confirms
before any `[WRITE]` operation.

**Official reference:**
[MX Cold Swap](https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX)
— including **port mapping** (physical label vs Dashboard port index).

**MCP:**
[meraki-magic-mcp-community](https://github.com/CiscoDevNet/meraki-magic-mcp-community)

---

## Before you start

| Item | Action |
|------|--------|
| API key | Org admin key with access to target org/network |
| MCP | Install dynamic MCP; `READ_ONLY_MODE=true` until cutover approval |
| Backup | Export/screenshot: static WAN, VPN mode, AnyConnect certs, 1:1 NAT, critical firewall rows |
| Intake | Complete [intake.yaml](intake.yaml) fields with the user |

Collect once (READ): `organizationId`, `networkId`, old/new MX serials, `productTypes` / combined vs appliance-only.

---

## Method comparison

| | Method 1 — Quick swap | Method 2 — Clone + pre-stage |
|--|----------------------|------------------------------|
| **Same Dashboard network** | Yes | No (temporary clone network) |
| **MS/MR/MV/MT move** | No | No (if combined: split/recombine — see supplement) |
| **MX downtime** | Maintenance window | Can be shorter if MX pre-staged |
| **Combined sites** | **Recommended default** | Complex; only with explicit acceptance |
| **AutoVPN / DDNS / client history** | Preserved on same network | Risk on split/recombine paths |
| **Best for** | Most sites, especially combined | Appliance-only or experienced operators |

---

## Path A — Method 1 (Quick swap)

**Goal:** Remove old MX, add new MX to the **same** network; downstream products stay put.

### Phase 0 — Discovery (READ only)

1. List network devices → old MX serial, online status.
2. Appliance VLANs, **appliance ports** (access/trunk, allowed VLANs).
3. Site-to-site VPN, L3/L7 firewall, 1:1 NAT, port forwarding if used.
4. Uplink settings (note static WAN — may need **local status page** on new MX).
5. Wireless SSIDs if MX-hosted or design depends on appliance radios.

**MCP patterns** (`call_meraki_api`):

- `appliance` / `getNetworkApplianceVlans`, `getNetworkAppliancePorts`
- `appliance` / `getNetworkApplianceVpnSiteToSiteVpn`, firewall/NAT getters
- `networks` / `getNetwork`, `getNetworkDevices`

### Phase 1 — Staging (READ + human)

1. New MX in org inventory.
2. Fill [port-worksheet.md](port-worksheet.md) using Meraki port-mapping table.
3. Rogue DHCP: allow new WAN MAC if needed.
4. Schedule maintenance window.

### Phase 2 — Cutover (WRITE — user approval)

1. Disconnect **LAN** on new MX until WAN check-in (Meraki guidance).
2. Remove old MX from network.
3. Add/claim new MX to **same** network.
4. Static WAN: configure via **local status page** if required.
5. **WAN first** → firmware/check-in → move **LAN** per port worksheet.
6. Post-cutover: VPN, AnyConnect cert, upstream ARP per official doc.

**MCP (optional):** `removeNetworkDevice`, `claimNetworkDevices`, `updateNetworkAppliancePort`, VPN updates — or use Dashboard for destructive steps.

### Phase 3 — Validation (READ)

Use [validation-checklist.md](validation-checklist.md).

---

## Path B — Method 2 (Clone + pre-stage)

**Goal:** Clone appliance config to a staging network; pre-stage new MX; physical swap; for
**combined** sites use **split + recombine** — see [combined-network-method2.md](combined-network-method2.md).

**Do not** bulk-move MS/MR/MV/MT via inventory to the clone.

**MCP patterns (verify SDK version):**

- `createNetwork` with `copyFromNetworkId`
- `claimNetworkDevices`, port alignment on clone
- Org `splitNetwork` / `combineOrganizationNetworks` — often Dashboard-first; test in lab

### Phase 0–3

Same phase discipline as Path A. Extra READs on slice networks after split.

---

## Model migration notes (example: MX67W → MX68WC)

| Topic | Why |
|-------|-----|
| Port count / mapping | Logical ports in use must exist on new model |
| PoE | Downstream powered gear — budget per port may change |
| WWAN (MX68C/WC) | Cellular not migrated from MX67W Wi‑Fi-only |
| WPA3 / 6 GHz (CW APs) | Catalyst Wi‑Fi may need WPA3 transition on SSID for 6 GHz — see lessons learned |
| License tier | Match new MX capability |

---

## Optional tooling

```bash
export MERAKI_API_KEY=...
export MERAKI_ORG_ID=...
export BACKUP_NETWORK_ID=L_...
python tools/meraki_backup_network.py
```

Writes JSON under `./backups/` (gitignored) — never commit output.

---

## Disclaimer

See [DISCLAIMER.md](../DISCLAIMER.md). Meraki's article overrides this playbook if they conflict.

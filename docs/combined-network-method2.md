# Combined network — Method 2 supplement

**Warning:** Method 2 on a **combined** Dashboard site is advanced. Prefer **Method 1** unless
stakeholders explicitly accept complexity and AutoVPN/DDNS/client-history tradeoffs.

Official section: *Integrating the Cloned MX Network with an Existing Combined Network* in
[MX Cold Swap](https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX).

---

## High-level flow (conceptual)

```
Combined production network
        │
        ▼ splitNetwork
   Separate slices (appliance, switch, wireless, camera, sensor, …)
        │
        ├── Staging: appliance-only clone with NEW MX pre-staged
        │
        ▼ Remove OLD MX from appliance slice; move NEW MX to appliance slice
        ▼ combineOrganizationNetworks (one slice per product type — no duplicates)
        │
Combined production network (new network ID possible — update your runbook)
```

---

## Rules

1. **Do not** create a full combined clone and expect a simple combine — duplicate product types fail.
2. **Do not** bulk-move switches/APs/cameras/sensors via inventory between networks.
3. Include **exactly one** network per `productType` in the final combine set.
4. Exclude the old appliance slice that still contains the **old MX** from the combine list.
5. Document the **new** `networkId` after recombine — Dashboard may assign a new ID.

---

## Phase checklist (agent)

| Step | Mode | Action |
|------|------|--------|
| 1 | READ | Confirm `productTypes` length > 1 on production network |
| 2 | READ | User accepts Method 2 risks (document in chat) |
| 3 | WRITE | Create **appliance-only** clone; claim new MX; align ports on clone |
| 4 | WRITE | `splitNetwork` on production (if still combined) |
| 5 | WRITE | Remove old MX from appliance slice; add/move new MX to appliance slice |
| 6 | WRITE | `combineOrganizationNetworks` with correct ID list |
| 7 | READ | Validate devices, ports, VPN, uplinks on **new** network ID |
| 8 | Human | Physical cabling per port worksheet; WAN before LAN |

---

## After recombine

- Re-verify every appliance port VLAN/trunk against Phase 0 backup.
- Re-check site-to-site VPN and NAT rules.
- Update any external documentation that referenced the old `networkId`.

---

## When to stop and use Method 1

- Unclear slice list after split
- Combine API error mentioning duplicate types
- Tight maintenance window without lab rehearsal

Stop and recommend **Method 1** (quick swap) for combined sites.

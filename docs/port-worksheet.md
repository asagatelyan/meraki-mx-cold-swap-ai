# Port mapping worksheet

Complete during **Phase 1**. Use Meraki's official port-mapping table in the
[cold-swap article](https://documentation.meraki.com/SASE_and_SD-WAN/MX/Operate_and_Maintain/How-Tos/MX_Cold_Swap_-_Replacing_an_Existing_MX_with_a_Different_MX).

**Rule:** Map by **logical Dashboard port** role, not physical silkscreen alone.

---

## Site metadata

| Field | Value |
|-------|-------|
| Network name | |
| Old MX model | |
| New MX model | |
| Cutover date | |

---

## Per-port mapping

| Logical port (Dashboard) | Role (WAN/LAN) | Old physical label | New physical label | VLAN / trunk | Connected device | Notes |
|--------------------------|----------------|--------------------|--------------------|--------------|------------------|-------|
| | | | | | | |
| | | | | | | |
| | | | | | | |

---

## Post-cutover LLDP check

After LAN is connected, verify neighbors match expectations:

| Logical port | Expected neighbor | LLDP seen? |
|--------------|-------------------|------------|
| | | |
| | | |

---

## PoE / WWAN

| Question | Answer |
|----------|--------|
| PoE required on any MX LAN port? | |
| PoE budget OK on new model? | |
| Cellular/WWAN used on new MX (MX68C/WC)? | SIM/APN configured? |

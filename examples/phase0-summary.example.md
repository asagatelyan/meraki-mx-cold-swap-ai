# Phase 0 summary (example — synthetic data)

> Do not commit real org/network IDs, serials, or IPs to this repository.

## Intake

| Field | Value |
|-------|-------|
| Organization | ExampleOrg (`123456`) |
| Network | Site-Branch-A (`L_000000000000000001`) |
| Combined | Yes — appliance, wireless, camera, sensor |
| Old MX | MX67W `Q2XX-AAAA-BBBB` |
| New MX | MX68WC `Q2YY-CCCC-DDDD` (inventory) |
| Path | Method 1 (quick swap) |

## Devices (excerpt)

| Name | Model | Role | Status |
|------|-------|------|--------|
| mx-edge | MX67W | appliance | online |
| ap-floor1 | MR46 | wireless | online |
| cam-lobby | MV32 | camera | online |

## VLANs (excerpt)

| ID | Name | Subnet |
|----|------|--------|
| 1 | default | 192.168.128.0/24 |

## Appliance ports (logical)

| Port | Enabled | Type | VLAN / allowed |
|------|---------|------|----------------|
| 3 | false | trunk | — |
| 4 | true | trunk | native 1; allowed 1, 3 |
| 5 | true | access | VLAN 10 |

## VPN / NAT

| Item | Value |
|------|-------|
| Site-to-site VPN | enabled, spoke |
| 1:1 NAT rules | 2 rules (review before cutover) |

## Uplink notes

| Uplink | Mode | Note |
|--------|------|------|
| WAN1 | DHCP | |
| WAN2 | static | Copy to local status page on new MX |

## Recommended next step

Phase 1: complete port worksheet; schedule maintenance; keep MCP read-only.

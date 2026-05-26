# Phase 3 — validation checklist

Run after cutover (READ-only unless fixes are approved).

## Appliance

- [ ] New MX **online**, expected firmware
- [ ] VLANs and default route correct
- [ ] Appliance ports match port worksheet (access/trunk, allowed VLANs)
- [ ] Uplink: WAN1/WAN2 as designed (static re-verified on device if used)
- [ ] Site-to-site VPN registry correct (hub/spoke if AutoVPN)
- [ ] 1:1 NAT / port forwarding spot-check
- [ ] Content filtering / AMP / intrusion settings present if used before

## Downstream (combined sites)

- [ ] Switches online (if in scope)
- [ ] APs online; clients associating
- [ ] Cameras streaming (if applicable)
- [ ] Sensors reporting (if applicable)

## Wireless (if applicable)

- [ ] SSIDs broadcast; authentication works
- [ ] Catalyst AP assurance: no blocking warnings (e.g. WPA3 / 6 GHz if required)

## Events

- [ ] Review network events for DHCP/VPN/firewall errors (last 1–2 hours)
- [ ] Optional: `getOrganizationConfigurationChanges` for unexpected changes

## Documentation

- [ ] Record new `networkId` if recombine changed it
- [ ] Update internal runbook / diagrams
- [ ] Store Phase 0 backup outside git (encrypted if required)

## Sign-off

- [ ] User confirms business-critical apps reachable
- [ ] Maintenance window closed; `READ_ONLY_MODE=true` restored on MCP

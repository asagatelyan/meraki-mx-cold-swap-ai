#!/usr/bin/env python3
"""Read-only Meraki network backup for MX migration Phase 0.

Requires: pip install meraki python-dotenv (or use Meraki Magic MCP venv)

Environment:
  MERAKI_API_KEY       (required)
  MERAKI_ORG_ID        (optional, for org device list)
  BACKUP_NETWORK_ID    (required)

Output: ./backups/<network>_<timestamp>/  (gitignored — never commit)
"""
from __future__ import annotations

import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
load_env = None
try:
    from dotenv import load_dotenv

    for candidate in (REPO_ROOT / ".env", REPO_ROOT / "tools" / "meraki-magic-mcp-community" / ".env"):
        if candidate.is_file():
            load_dotenv(candidate)
            break
except ImportError:
    pass

API_KEY = os.environ.get("MERAKI_API_KEY", "").strip().strip('"')
ORG_ID = os.environ.get("MERAKI_ORG_ID", "").strip().strip('"')
NETWORK_ID = os.environ.get("BACKUP_NETWORK_ID", "").strip().strip('"')

APPLIANCE_READS = [
    ("appliance", "getNetworkApplianceVlans"),
    ("appliance", "getNetworkApplianceVlansSettings"),
    ("appliance", "getNetworkAppliancePorts"),
    ("appliance", "getNetworkApplianceVpnSiteToSiteVpn"),
    ("appliance", "getNetworkApplianceFirewallL3FirewallRules"),
    ("appliance", "getNetworkApplianceFirewallL7FirewallRules"),
    ("appliance", "getNetworkApplianceFirewallOneToOneNatRules"),
    ("appliance", "getNetworkApplianceFirewallPortForwardingRules"),
    ("appliance", "getNetworkApplianceFirewallInboundFirewallRules"),
    ("appliance", "getNetworkApplianceFirewallCellularFirewallRules"),
    ("appliance", "getNetworkApplianceContentFiltering"),
    ("appliance", "getNetworkApplianceTrafficShaping"),
    ("appliance", "getNetworkApplianceTrafficShapingUplinkBandwidth"),
    ("appliance", "getNetworkApplianceTrafficShapingRules"),
    ("appliance", "getNetworkApplianceSecurityIntrusion"),
    ("appliance", "getNetworkApplianceSecurityMalware"),
    ("appliance", "getNetworkApplianceWarmSpare"),
    ("appliance", "getNetworkApplianceSettings"),
    ("appliance", "getNetworkApplianceConnectivityMonitoringDestinations"),
    ("appliance", "getNetworkApplianceSsids"),
]

OTHER_READS = [
    ("networks", "getNetwork"),
    ("networks", "getNetworkDevices"),
    ("wireless", "getNetworkWirelessSsids"),
]


def call_read(dash, section: str, method: str, network_id: str, org_id: str):
    fn = getattr(getattr(dash, section), method)
    if method == "getOrganizationDevices":
        if not org_id:
            return {"skipped": "MERAKI_ORG_ID not set"}
        return fn(org_id)
    if "Organization" in method:
        return fn(org_id) if org_id else {"skipped": "MERAKI_ORG_ID not set"}
    return fn(network_id)


def main() -> int:
    if not API_KEY:
        print("MERAKI_API_KEY not set", file=sys.stderr)
        return 1
    if not NETWORK_ID:
        print("BACKUP_NETWORK_ID not set", file=sys.stderr)
        return 1

    try:
        import meraki
    except ImportError:
        print("Install meraki: pip install meraki", file=sys.stderr)
        return 1

    dash = meraki.DashboardAPI(API_KEY, suppress_logging=True)
    ts = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    safe_name = NETWORK_ID.replace("/", "_")
    out_dir = REPO_ROOT / "backups" / f"{safe_name}_{ts}"
    out_dir.mkdir(parents=True, exist_ok=True)

    manifest = {"networkId": NETWORK_ID, "organizationId": ORG_ID or None, "timestamp": ts, "files": []}

    reads = list(APPLIANCE_READS) + list(OTHER_READS)
    if ORG_ID:
        reads.append(("organizations", "getOrganizationDevices"))

    for section, method in reads:
        fname = f"{section}_{method}.json"
        path = out_dir / fname
        try:
            data = call_read(dash, section, method, NETWORK_ID, ORG_ID)
            path.write_text(json.dumps(data, indent=2, default=str), encoding="utf-8")
            manifest["files"].append({"file": fname, "status": "ok"})
        except Exception as exc:
            manifest["files"].append({"file": fname, "status": "error", "error": str(exc)})

    (out_dir / "backup_manifest.json").write_text(json.dumps(manifest, indent=2), encoding="utf-8")
    print(f"Backup written to {out_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

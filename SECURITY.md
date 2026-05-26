# Security policy

## Supported versions

| Version | Supported |
|---------|-----------|
| 0.1.x   | Yes       |

## Reporting a vulnerability

If you discover a security issue in **this repository** (not Meraki Dashboard or Cisco products):

1. **Do not** open a public issue for sensitive details.
2. Open a private security advisory on GitHub (**Security → Advisories → Report a vulnerability**), or contact the repository maintainer directly if advisories are not enabled.

## Secrets and customer data

- **Never** commit API keys, `.env`, `mcp.json`, backups, or customer identifiers.
- Run local secret scan before push: `gitleaks detect --source .`
- CI runs gitleaks on push and pull requests.

If you accidentally committed a Meraki API key:

1. Revoke/regenerate the key in Meraki Dashboard immediately.
2. Remove the secret from git history (e.g. `git filter-repo` or GitHub secret scanning remediation).
3. Report via advisory if the key was exposed on a public fork.

## Scope

This project is documentation and agent instructions. It does not run as a hosted service.
Your Meraki API key remains on your machine in MCP `.env` files outside this repo's control.

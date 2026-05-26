# Contributing

Thank you for improving **meraki-mx-cold-swap-ai**.

## Before you open a PR

1. Read [DISCLAIMER.md](DISCLAIMER.md) and [AGENTS.md](AGENTS.md).
2. Do **not** include real customer data:
   - Organization or network IDs
   - Device serials or MAC addresses
   - IP addresses, SSIDs, hostnames, API keys
   - Backup JSON from production sites
3. Run secret scan locally:

   ```bash
   gitleaks detect --source . --verbose
   ```

4. Use **synthetic placeholders** in examples (`L_000...`, `Q2XX-XXXX`).

## What we welcome

- Clearer wizard steps for AI agents
- Additional lessons learned (anonymized)
- Host-specific MCP setup notes (Cursor, Claude Code, VS Code)
- Validation checklist improvements
- Fixes that align with [official Meraki cold-swap doc](docs/official-references.md)

## What we avoid

- Vendoring the full Meraki Magic MCP repo (link upstream instead)
- Site-specific automation with hardcoded IDs
- Changes that contradict Meraki's official cold-swap procedure without documented rationale

## Pull request checklist

- [ ] No secrets or customer identifiers in diff
- [ ] `gitleaks detect` passes (or CI will run it)
- [ ] `CHANGELOG.md` updated under **Unreleased** or new version section
- [ ] Trademark / unofficial notice preserved where relevant

## Code of conduct

Be constructive and respect operational safety — migrations cause outages when rushed.

## License

By contributing, you agree your contributions are licensed under the [MIT License](LICENSE).

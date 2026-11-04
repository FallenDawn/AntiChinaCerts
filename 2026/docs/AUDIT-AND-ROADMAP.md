# AntiChinaCerts 2026 — Audit and multi-platform roadmap

Audit baseline date: 2026-11-04  
Scope: **broad inventory**  
Targets: **Windows, macOS, Linux, Android**

## Important distinction

The broad scope means that mainland-China CA organizations and their certificate hierarchies are inventoried. It does **not** mean that certificates are malicious or should be distrusted. Geographic ownership is metadata, never an enforcement reason.

The initial database carries the legacy SHA-1 fingerprints from the original 2014 README. SHA-256 values and DER certificate paths are deliberately null until the exact certificate bytes have been obtained and independently fingerprinted. Do not fill them by guessing or by copying an unrelated cross-signed certificate's fingerprint.

## Legacy findings

The original project README states its update date as 2014-10-03. Its Windows scripts use an old root update package and CertMgr commands, remove matching certificates from Root/AuthRoot stores, then add certificate files to Disallowed. This is unsuitable as a default Windows 10/11 workflow without a new implementation and validation.

The old list mixes two different kinds of records:
- Historical fraudulent website certificates (Fake GitHub, Fake Google, Fake Yahoo).
- CA root / trust-anchor inventory entries (CNNIC, CFCA, UCA, ROOTCA, SRCA, WoSign, China Trust Network).

These must remain separate categories.

## Required evidence per certificate

Every release-ready record must include:
- Exact DER/PEM certificate bytes and SHA-256 fingerprint computed from those bytes.
- Subject, issuer, serial number, validity interval, Basic Constraints, Key Usage and SKI/AKI.
- Self-signed root vs cross-signed root vs intermediate classification.
- CA owner and aliases, with provenance.
- Dated trust status from Microsoft, Mozilla/NSS, Chrome Root Store, Apple and Android where available.
- Incident/policy evidence with source URL and observed date.
- Enforcement recommendation separate from inventory classification.

## Multi-platform implementation

### Windows 10/11
- Audit Windows certificate stores without modifying them.
- Export selected certificates and create a restore manifest before any change.
- Support CurrentUser and LocalMachine scopes explicitly.
- Never run a global Disallowed-store operation from the broad inventory list.

### macOS
- Inspect Keychain trust settings and system roots.
- Do not edit protected system trust-store files directly.
- Any future change must be user-selected and reversible.

### Linux
- Detect distribution and trust-store mechanism.
- Handle system CA bundle and NSS/Firefox stores as separate trust domains.
- Provide dry-run output and rollback instructions.

### Android
- Distinguish system CA, user-installed CA and app-bundled trust stores.
- Default to read-only inventory; do not require root.
- Explain that apps may use custom trust stores or certificate pinning.

## Release gates

1. Obtain original certificate material for every legacy SHA-1 entry.
2. Recompute SHA-1 and SHA-256 from each DER file and match the legacy SHA-1 exactly.
3. Fetch and archive dated platform trust-list evidence.
4. Add automated JSON schema and fingerprint validation.
5. Implement audit-only adapters for all four platforms.
6. Add tests using fixtures; do not test by modifying a live OS trust store.
7. Only then consider opt-in, per-certificate enforcement adapters.

## Source references

- Original project README: https://github.com/FallenDawn/AntiChinaCerts
- CCADB public certificate datasets: https://ccadb.my.salesforce-sites.com/ccadb/ccadb-public
- Mozilla Root Store Policy: https://www.mozilla.org/about/governance/policies/security-group/certs/policy/
- Chrome Root Program: https://www.chromium.org/Home/chromium-security/root-ca-policy/
- Apple trusted root certificates: https://support.apple.com/HT213459
- Microsoft Trusted Root Program: https://learn.microsoft.com/en-us/security/trusted-root/

## Current audit limitations

This commit is a conservative baseline, not a claim of complete 2026 certificate coverage. No new root SHA-256 values or current cross-platform trust statuses are asserted until the original certificate bytes and dated authoritative datasets have been checked.

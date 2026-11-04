# AntiChinaCerts 2026

A multi-platform certificate inventory and audit modernization effort.

**Scope:** broad CA inventory.  
**Platforms:** Windows 10/11, macOS, Linux, Android.  
**Default mode:** audit-only; no automatic certificate distrust.

Start with:
- [Certificate inventory](data/certificates.json)
- [CA organization inventory](data/ca-owners.json)
- [Audit and roadmap](docs/AUDIT-AND-ROADMAP.md)

The legacy SHA-1 values are preserved for lookup. SHA-256 values remain null until derived from the exact DER certificate files. Do not treat CA geography as a security verdict.

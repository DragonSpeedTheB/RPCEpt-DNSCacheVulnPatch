# RPCEpt-DNSCacheVulnPatch

# Vulnerability
itm4n found a great vulnerability in Windows 7 and 2008 where authenticated (but non-administrator) local users can get SYSTEM rights:
https://itm4n.github.io/windows-registry-rpceptmapper-eop/
This is caused by (non-admin) Users having ability to create subkeys in two Windows services.

# Patch Inspired by
https://github.com/GossiTheDog/fixes/tree/main/RpcEptMapper

Powershell script to create the vulnerable keys and change permissions on them
Can be used in a Configuration baseline in SCCM to deploy on a large scale for those still stuck with W7/Server 2008R2

# File
**Fix-EscalationofPerms-W7+2008R2.ps1** : powershell script to create the keys and change the ACLs on their parents.  Just run it from powershell. Works on W7 and Server 2008R2

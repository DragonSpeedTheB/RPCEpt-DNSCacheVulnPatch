$Usersid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-5-32-545'
$Everyonesid = New-Object System.Security.Principal.SecurityIdentifier 'S-1-1-0'
$user = $Usersid.Translate([System.Security.Principal.NTAccount]).Value
$everyone = $Everyonesid.Translate([System.Security.Principal.NTAccount]).Value
$DNSCacheBasePath='hklm:\system\currentcontrolset\services\dnscache'
$RpcEptMapperBasePath='hklm:\system\currentcontrolset\services\rpceptmapper'
$aclpaths=($DNSCacheBasePath,$RpcEptMapperBasePath)
# get the current acl
foreach ($aclpath in $aclpaths)
{
    $perfpath=$aclpath+'\Performance'
    if (!(Test-Path $perfpath))
    {
        New-Item $aclpath -Name Performance |Out-Null
    }
    $acl = get-acl $aclpath
    # disable permission inheritance and copy existing permissions to explicit permissions on parent Key
    $acl.SetAccessRuleProtection($true,$true)
    # write the changes back to the reg key
    $acl | Set-Acl -Path $aclpath
    # get the new (inheritance disabled) permission structure
    $acl = get-acl $aclpath
    # remove any rule that applies to Users
    $acl.PurgeAccessRules([System.Security.Principal.NTAccount]$user)
    $acl.PurgeAccessRules([System.Security.Principal.NTAccount]$everyone)
    # write the changes 
    $acl | Set-Acl -Path $aclpath
}
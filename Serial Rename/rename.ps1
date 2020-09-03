
# get serial 
#$name=(get-ciminstance win32_bios | format-list serialnumber | out-string).substring(17+1).trim()

# rename computer to serial
#rename-computer -newname $name -restart

rename-computer -newname $((get-ciminstance win32_bios | format-list serialnumber | out-string).substring(17+1).trim()) -DomainCredential *INSERT DOMAIN HERE*\$(Read-Host -Prompt 'Enter username') -Restart
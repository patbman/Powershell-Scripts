$ScriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$serial = $(get-ciminstance win32_bios | format-list serialnumber | out-string).substring(17+1).trim()
Write-Host "Current script directory is $serial"
Set-content "$ScriptDir\$serial.txt" $serial 

Write-Host "getting physical disk"
$(Get-PhysicalDisk) |Select-Object| foreach { Add-Content -Value ("FriendlyName: "+$_.FriendlyName),("Model: "+$_.Model),("MediaType: "+$_.MediaType),("BusType: "+$_.BusType),("Size: "+$([math]::Floor($_.Size / 1000000000))+" GB") -Path "$ScriptDir\$serial.txt"}
Add-Content "$ScriptDir\$serial.txt" ""
Write-Host "getting disk"
Add-content "$ScriptDir\$serial.txt" $(Get-Disk | foreach { $_ | Get-StorageReliabilityCounter |select-object |foreach{("Reallocated Sectors: "+$_.ReadErrorsCorrected),("Pending Sectors: "+$_.ReadErrorsUncorrected),("PowerOnHours: "+$_.PowerOnHours)}})
exit
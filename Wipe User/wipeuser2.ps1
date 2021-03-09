$hostnameFile=$args[0]
$deleteUser=$args[1]
if ($(read-host "are you sure you want to delete $deleteUser \(y or n\)") -eq 'y'){
    get-content "$hostnameFile" | foreach-object{
        if (test-connection -computername $_ -count 1 -quiet){
            Start-Process "cmd.exe" "/c removeUser2.bat $_ $deleteUser"

            #Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq 'testuser2' } | Remove-CimInstance 
            #Remove-LocalUser -Name 'testuser2'
        }else{
            Write-Warning "Can't connect to $_"
            Add-Content -Path "noconnection.txt" -Value "$_"
        }
    }

}else{Write-Warning "Operation Canceled"}
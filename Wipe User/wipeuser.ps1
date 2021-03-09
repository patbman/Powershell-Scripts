#See if Admin2 folder exist
# %1 hostname txt file to iterate through
# %2 user to find and remove
$hostnameFile=$args[0]
$deleteUser=$args[1]

if ($(read-host "are you sure you want to delete $deleteUser \(y or n\)") -eq 'y'){
get-content "$hostnameFile" | foreach-object {
 
    if (test-connection -computername $_ -count 1 -quiet){
        ([ADSI]"WinNT://$_").Children | ?{$_.SchemaClassName -eq 'user'} | %{ 
            $groups = $_.Groups() | %{$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
            if($($_ | select).Name -eq "$deleteUser"){ 
                Start-Process "cmd.exe" "/c removeUser.bat $_ $deleteUser" 
            }else{Write-Warning "$deleteUser on'$_' doesn't exist"}
        }
        
        if (test-path "\\$_\c$\Users\$deleteUser"){
            Start-Process "cmd.exe" "/c folderDelete.bat $_ $deleteUser"
            }
        }Else {
            Write-Warning "Server '$_' is Unreachable hence Could not fetch data"
            add-content "noconnection.txt" -value "$_"
        
        }
    
    }
    }
       

#######################################################################
<#
get-content "admin2_exist.txt" | foreach-object { 
#    $Comp = $_ 
    if (test-connection -computername $_ -count 1 -quiet) 
{ 
                    ([ADSI]"WinNT://$comp").Children | ?{$_.SchemaClassName -eq 'user'} | %{ 
                    $groups = $_.Groups() | %{$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
                    if($($_ | select).Name -eq "admin2"){ 
                        Add-Content -path "C:\Users\pbowden\Documents\Admin2\admin2_bk.txt" -value $_
                        Start-Process "cmd.exe" "/c removeAdmin2.bat $_"
                    #$_ | Select @{n='Server';e={$comp}}, 
                    #@{n='UserName';e={$_.Name}}, 
                    #@{n='Active';e={if($_.PasswordAge -like 0){$false} else{$true}}}, 
                    #@{n='PasswordExpired';e={if($_.PasswordExpired){$true} else{$false}}}, 
                    #@{n='PasswordAgeDays';e={[math]::Round($_.PasswordAge[0]/86400,0)}}, 
                    #@{n='LastLogin';e={$_.LastLogin}}, 
                    #@{n='Groups';e={$groups -join ';'}}, 
                    #@{n='Description';e={$_.Description}} 
   
                 }
                 }  
           } Else {Write-Warning "Server '$Comp' is Unreachable hence Could not fetch data"} 
     }
     #|Export-Csv -NoTypeInformation LocalUsers.csv 

##############################################################################################################
#get-content "admin2.txt" | foreach-object {
 #   if (test-connection -computername $_ -count 1 -quiet){
  #      Start-Process "cmd.exe" "/c removeAdmin2.bat $_"
   # }Else {Write-Warning "Computer '$_' is Unreachable could not delete admin2"}


#}
#>
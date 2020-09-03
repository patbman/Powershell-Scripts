foreach($line in (Get-ADComputer -Filter * -SearchBase "OU=REPLACE,OU=REPLACE,OU=REPLACE,DC=REPLACE,DC=REPLACE" -Properties CanonicalName, Name, Description | Select -Property CanonicalName, Description)){
    $x = ($line.CanonicalName -replace '[^\/]*\/[^\/]*\/[^\/]*\/[^\/]*\/', '').Replace("/",", ")+', ' + $line.description
    add-content ADquery.txt $x
    
}
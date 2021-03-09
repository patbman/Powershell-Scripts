if ($Args.count -eq 0){
	#$AllPrinters = gwmi win32_printer
	#$DefaultPrinter = $AllPrinters | where {$_.Default -eq $true}
    $DefaultPrinter = $(gwmi win32_printer) | where {$_.Default -eq $true}
}else{

	#$AllPrinters = gwmi win32_printer -computername $Args[0]
	#$DefaultPrinter = $AllPrinters | where {$_.Default -eq $true}
	$DefaultPrinter = $(gwmi win32_printer -computername $Args[0]) | where {$_.Default -eq $true}


}
if ($DefaultPrinter -eq $null){
    echo "No Default Printer"

}else{
    echo $DefaultPrinter

}


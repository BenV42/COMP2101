#Network Table formatted into a table based on IPEnabled
#Best Run in full window to avoid losing info 
#Start of function
function get-ipreport {
"---------------------------------------"
"|          Network Information        |"
"---------------------------------------"

$netinfo = get-ciminstance win32_networkadapterconfiguration | 
where { $_.IPEnabled -eq $True } | 
sort Index |
Select-Object Description, Index, IPAddress, IPSubnet, DNSHostName, DNSDomain, DNSServerSearchOrder, DHCPEnabled

#If block to check against empty properties

if ( $null -eq $netinfo.Description) { 
	$netinfo | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSDomain) { 
	$netinfo | Add-member -Notepropertyname DNSDomain -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.IPAddress) { 
	$netinfo | Add-member -Notepropertyname IPAddress -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.IPSubnet) { 
	$netinfo | Add-member -Notepropertyname IPSubnet -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSHostName) { 
	$netinfo | Add-member -Notepropertyname DNSHostName -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSDomain) { 
	$netinfo | Add-member -Notepropertyname DNSDomain -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSServerSearchOrder) { 
	$netinfo | Add-member -Notepropertyname DNSServerSearchOrder -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DHCPEnabled) { 
	$netinfo | Add-member -Notepropertyname DHCPEnabled -Notepropertyvalue "Data Not Available" -force 
}
#Formatting Network object into a nice table
$netinfo | format-table -Autosize -Wrap Description, Index, IPAddress, IPSubnet, DNSHostName, DNSDomain, DNSServerSearchOrder, DHCPEnabled
}
get-ipreport


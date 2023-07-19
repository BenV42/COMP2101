function get-ram {
$totalram = 0
Get-CIMInstance win32_physicalmemory |
foreach {
	new-object -Typename psobject -Property @{Vendor = $_.manufacturer
					  Description = $_.description
					  "Size(GB)" = $_.capacity / 1gb -as [int]
					  Bank = $_.banklabel
					  Slot = $_.devicelocator
					  Speed = [string]$_.speed + " Mhz" 
	}
	$totalram += $_.capacity/1gb
} | 
format-table -autosize Vendor, Description, "Size(GB)", Bank, Slot, Speed
"Total Ram: ${totalram}GB "
}
get-ram
#Ram Memory loop in table format
function get-ram {
"---------------------------------------"
"|          RAM Information            |"
"---------------------------------------"
#Variables and Creating myram object 
$totalram = 0
$myram = Get-CIMInstance win32_physicalmemory |
	ForEach-Object {
		new-object -Typename psobject -Property @{Vendor = $_.manufacturer
					  Description = $_.description
					  "Size(GB)" = $_.capacity / 1gb -as [int]
					  Bank = $_.banklabel
					  Slot = $_.devicelocator
					  Speed = [string]$_.speed + " Mhz" 
						}
	$totalram += $_.capacity/1gb

} | Select-Object Vendor, Description, "Size(GB)", Bank, Slot, Speed

#If block checking for empty property values

if ($null -eq $myram.Vendor) { 
	$myram | Add-member -Notepropertyname Vendor -Notepropertyvalue "Data Not Available" -force
} 

if ($null -eq $myram.Description) { 
	$myram | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force
}
 
if ($null -eq $myram."Size(GB)") { 
	$myram | Add-member -Notepropertyname "Size(GB)" -Notepropertyvalue "Data Not Available" -force
}
 
if ($null -eq $myram.Bank) { 
	$myram | Add-member -Notepropertyname Bank -Notepropertyvalue "Data Not Available" -force
}
 
if ($null -eq $myram.Slot) { 
	$myram | Add-member -Notepropertyname Slot -Notepropertyvalue "Data Not Available" -force
}
 
if ($null -eq $myram.Speed) { 
	$myram | Add-member -Notepropertyname Speed -Notepropertyvalue "Data Not Available" -force
} 
#Formatting Object into a table
$myram | format-table -autosize Vendor, Description, "Size(GB)", Bank, Slot, Speed

"Total Ram: ${totalram}GB "
}
get-ram
$totalram = 0
Get-CIMInstance win32_physicalmemory |
foreach {
	new-object -Typename psobject -Property @{Vendor=$_.manufacturer
					  Description=$_.description
					  "Size(GB)"=$_.size / 1gb -as [int]
					  "Bank Slot"=$_.banklabel
	}
	$totalram += $_.capacity/1gb
} | 
format-table -autosize Vendor, Description, "Size(GB)", "Bank Slot"
"Total Ram: ${totalram}GB "

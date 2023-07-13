$totalram = 0
$rammem = (Get-CIMInstance win32_physicalmemory)
foreach ($Tag in $rammem) {
	new-object -Typename psobject -Property @{Vendor=$rammem.manufacturer
					  Description=$rammem.description
					  "Size(GB)"=$rammem.size / 1gb -as [int]
					  "Bank Slot"=$rammem.banklabel
	}
	$totalram += $_.capacity/1gb
} | 
format-table -autosize Vendor, Description, "Size(GB)", "Bank Slot"
"Total Ram: ${totalram}GB "

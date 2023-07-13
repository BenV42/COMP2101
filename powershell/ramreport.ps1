$totalram = 
$rammem = Get-CIMInstance win32_physicalmemory
foreach ($Tag in $rammem) {
	new-object -typename psobject -property @{Vendor=$rammem.manufacturer
					  Description=$rammem.description
					  "Size(GB)"=$rammem.size / 1gb -as [int]
					  "Bank Slot"=$rammem.banklabel | format-table -autosize	
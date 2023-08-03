#Disk Drive loop to get info into a table
function get-mydisks {
"---------------------------------------"
"|      Disk Storage Information       |"
"---------------------------------------"

#Object Creation Loop 
$mydisks = get-ciminstance win32_diskdrive |
	foreach {
	 	$partitions = get-ciminstance win32_diskdrive | get-cimassociatedinstance -resultclassname win32_diskpartition
      			foreach ($partition in $partitions) {
            			$logicaldisks = $partition | get-cimassociatedinstance -resultclassname win32_logicaldisk
            				foreach ($logicaldisk in $logicaldisks) {
                     				new-object -typename psobject -property @{Manufacturer=$_.caption
                                                               		Location=$partition.deviceid
                                                               		Drive=$logicaldisk.deviceid
                                                               		"Size(GB)"=$logicaldisk.size / 1gb -as [int]
							       		"Free Space(GB)"=$logicaldisk.freespace / 1gb -as [int]
							       		"Percent Free"=($logicaldisk.freespace / $logicaldisk.size * 100 )
                         						}
                                      		}
			}
} | Select-Object Drive, Location, Manufacturer,
		"Free Space(GB)", "Size(GB)", "Percent Free"
#If block checking against empty sections
if ($mydisks.Manufacturer -eq $null) { 
	$mydisks | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks.Location -eq $null) { 
	$mydisks | Add-member -Notepropertyname Location -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks.Drive -eq $null) { 
	$mydisks | Add-member -Notepropertyname Drive -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks."Size(GB)" -eq $null) { 
	$mydisks | Add-member -Notepropertyname "Size(GB)" -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks."Free Space(GB)" -eq $null) { 
	$mydisks | Add-member -Notepropertyname "Free Space(GB)" -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks."Percent Free" -eq $null) { 
	$mydisks | Add-member -Notepropertyname "Percent Free" -Notepropertyvalue "Data Not Available" -force
}
#Formatting Object into a table for viewing 
$mydisks | format-table Drive, Location, Manufacturer,
		"Free Space(GB)", "Size(GB)", "Percent Free" -autosize
           
      
}
get-mydisks 
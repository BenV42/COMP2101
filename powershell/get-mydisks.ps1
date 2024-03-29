#Disk Drive loop to get info into a table
function get-mydisks {
"---------------------------------------"
"|      Disk Storage Information       |"
"---------------------------------------"

#Object Creation Loop 
$mydisks = get-ciminstance win32_diskdrive |
	ForEach-Object {
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
if ($null -eq $mydisks.Manufacturer) { 
	$mydisks | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $mydisks.Location) { 
	$mydisks | Add-member -Notepropertyname Location -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $mydisks.Drive) { 
	$mydisks | Add-member -Notepropertyname Drive -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $mydisks."Size(GB)") { 
	$mydisks | Add-member -Notepropertyname "Size(GB)" -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $mydisks."Free Space(GB)") { 
	$mydisks | Add-member -Notepropertyname "Free Space(GB)" -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $mydisks."Percent Free") { 
	$mydisks | Add-member -Notepropertyname "Percent Free" -Notepropertyvalue "Data Not Available" -force
}
#Formatting Object into a table for viewing 
$mydisks | format-table Drive, Location, Manufacturer,
		"Free Space(GB)", "Size(GB)", "Percent Free" -autosize
           
      
}
get-mydisks 
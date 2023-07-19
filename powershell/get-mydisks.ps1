function get-mydisks {
#Disk Drive loop to get info into a table
"---------------------------------------"
"|      Disk Storage Information       |"
"---------------------------------------"
$diskdrives = Get-CIMInstance win32_diskdrive

foreach ($disk in $diskdrives) {
   $partitions = $disk|get-cimassociatedinstance -resultclassname win32_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname win32_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Caption
                                                               Location=$partition.deviceid
                                                               Drive=$logicaldisk.deviceid
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
							       "Free Space(GB)"=$logicaldisk.freespace / 1gb -as [int]
							       "Percent Free"=($logicaldisk.freespace / $logicaldisk.size * 100 )
                                                               } | format-table Drive, Location, Manufacturer,
									"Free Space(GB)", "Size(GB)", "Percent Free" -autosize
           }
      }
}

}
get-mydisks 
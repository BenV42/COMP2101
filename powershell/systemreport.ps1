#Script to Display System information 

#System info section displayed as a list

$compname = get-ciminstance win32_computersystem
$opname = get-ciminstance win32_operatingsystem
"---------------------------------------"
"|          System Information         |"
"---------------------------------------"
new-object -typename psobject -property @{
			"User Name"=$compname.username
			"Computer Name"=$compname.name
			Description=$compname.description
			Manufacturer=$compname.manufacturer
			Model=$compname.model
			"System Type"=$compname.systemtype
			OS=$opname.caption
			Version=$opname.version
			Architecture=$opname.osarchitecture
			"Root Location"=$opname.systemdirectory
			} | 
format-list "User Name", "Computer Name", Description, Manufacturer,
			Model, "System Type", OS, Version, Architecture,
			"Root Location"

#CPU info grabbed then displayed as a list#
"---------------------------------------"
"|          CPU Information            |"
"---------------------------------------"
Get-ciminstance cim_processor | 
foreach {
	new-object -typename psobject -property @{
				"Device ID"=$_.socketdesignation
				Name=$_.name
				Description=$_.caption
				Manufacturer=$_.manufacturer
				"Current Clock Speed"=$_.currentclockspeed
				"Max Clock Speed"=$_.maxclockspeed
				"Number of Cores"=$_.numberofcores
				"L1 Cache"= 0
				"L2 Cache"=$_.l2cachesize
				"L3 Cache"=$_.l3cachesize
				} 
} | 
format-list "Device ID", Name, Description, Manufacturer, "Current Clock Speed",
		"Max Clock Speed", "Number of Cores", "L1 Cache", "L2 Cache",
		"L3 Cache"

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
                     new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
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

#Ram Memory loop in table format
"---------------------------------------"
"|          RAM Information            |"
"---------------------------------------"
$totalram = 0
Get-CIMInstance win32_physicalmemory |
foreach {
	new-object -Typename psobject -Property @{Vendor=$_.manufacturer
					  Description=$_.description
					  "Size(GB)"=$_.capacity / 1gb -as [int]
					  "Bank Slot"=$_.banklabel
	}
	$totalram += $_.capacity/1gb
} | 
format-table -autosize Vendor, Description, "Size(GB)", "Bank Slot"
"Total Ram: ${totalram}GB "

#Network Adapters formatted into a table based on IPEnabled
"---------------------------------------"
"|          Network Information        |"
"---------------------------------------"
get-ciminstance win32_networkadapterconfiguration | 
where { $_.IPEnabled -eq $True } | 
sort Index |
format-table -Autosize Description, Index, IPAddress, IPSubnet, DNSHostName,
DNSDomain, DNSServerSearchOrder, DHCPEnabled 
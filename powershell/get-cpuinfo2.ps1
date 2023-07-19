function get-cpuinfo {
$cpuinfo = Get-ciminstance cim_processor | 
foreach {
	new-object -typename psobject -property @{
				"Device ID"=$_.socketdesignation
				Name=$_.name
				Description=$_.caption
				Manufacturer=$_.manufacturer
				"Current Clock Speed"=$_.currentclockspeed
				"Max Clock Speed"=$_.maxclockspeed
				"Number of Cores"=$_.numberofcores
				L1=$_.l1cachesize
				"L2 Cache"=$_.l2cachesize
				"L3 Cache"=$_.l3cachesize
				} 
} 
$cpuinfo | get-member * | 
	Where-object $cpuninfo -eq $null |
	Add-member -Notepropertyname L1 -Notepropertyvalue "Data Not Available" -force


$cpuinfo | format-list "Device ID", Name, Description, Manufacturer, "Current Clock Speed",
		"Max Clock Speed", "Number of Cores", L1, "L2 Cache",
		"L3 Cache"



}
get-cpuinfo


#function get-cpuinfo {
#get-ciminstance cim_processor | format-list DeviceID, Description, CurrentClockspeed, MaxClockSpeed, Manufacturer, NumberOfCores
#}
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
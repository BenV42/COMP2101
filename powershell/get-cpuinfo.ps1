#This is a function to collect info about your cpu displayed in a list format

#Start of function and variables
function get-cpuinfo {
$cachemem = get-ciminstance win32_cachememory
$cpuinfo = Get-ciminstance cim_processor |

#loop to make new cpu object
foreach { 
	new-object -typename psobject -property @{
				"Device ID"=$_.socketdesignation
				Name=$_.name
				Description=$_.caption
				Manufacturer=$_.manufacturer
				"Current Clock Speed"=$_.currentclockspeed
				"Max Clock Speed"=$_.maxclockspeed
				"Number of Cores"=$_.numberofcores
				"L1 Cache"= $cachemem.installedsize[0]
				"L2 Cache"=$cachemem.installedsize[1]
				"L3 Cache"=$cachemem.installedsize[2]
				}
} | 

#Selecting objects properties to check for null or empty values

Select-object "Device ID", Name, Description, Manufacturer, "Current Clock Speed",
		"Max Clock Speed", "Number of Cores", "L1 Cache", "L2 Cache",
		"L3 Cache"

#If loops checking null against each property value

if ( $null -eq $cpuinfo."Device ID" ) {
$cpuinfo | Add-member -Notepropertyname "Device ID" -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo.Name ) {
$cpuinfo | Add-member -Notepropertyname Name -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo.Description ) {
$cpuinfo | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo.Manufacturer ) {
$cpuinfo | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo."Current Clock Speed" ) {
$cpuinfo | Add-member -Notepropertyname "Current Clock Speed" -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo."Max Clock Speed" ) {
$cpuinfo | Add-member -Notepropertyname "Max Clock Speed" -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo."Number of Cores" ) {
$cpuinfo | Add-member -Notepropertyname "Number of Cores" -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo."L1 Cache" ) {
$cpuinfo | Add-member -Notepropertyname "L1 Cache" -Notepropertyvalue "Data Not Available" -force
}
if ( $null -eq $cpuinfo."L2 Cache" ) {
$cpuinfo | Add-member -Notepropertyname "L2 Cache" -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $cpuinfo."L3 Cache" ) {
$cpuinfo | Add-member -Notepropertyname "L3 Cache" -Notepropertyvalue "Data Not Available" -force 
}

#formatting final object into a list 

$cpuinfo | format-list "Device ID", Name, Description, Manufacturer, "Current Clock Speed",
		"Max Clock Speed", "Number of Cores", "L1 Cache", "L2 Cache",
		"L3 Cache"



}
#Calling Function to Display Object
get-cpuinfo



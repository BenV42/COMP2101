#script for getting videocard info and displaying as a list
function get-videoreport {
"---------------------------------------"
"|          Video Card Information     |"
"---------------------------------------"
$myvideo = get-ciminstance win32_videocontroller | 
		foreach { 
			new-object -typename psobject -property @{
							Name=$_.Name
							Description=$_.Description
							Manufacturer=$_.AdapterCompatibility
							Version=$_.DriverVersion
							Resolution=[string]$_.CurrentHorizontalResolution + " x " + [string]$_.CurrentVerticalResolution
							}
	} | Select-Object Name, Description, Manufacturer, Version, Resolution

#If block to check for empty property values 

if ($myvideo.Name -eq $null) { 
	$myvideo | Add-member -Notepropertyname Name -Notepropertyvalue "Data Not Available" -force
}
if ($myvideo.Description -eq $null) { 
	$myvideo | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force
}
if ($myvideo.Manufacturer -eq $null) { 
	$myvideo | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force
}
if ($myvideo.Version -eq $null) { 
	$myvideo | Add-member -Notepropertyname Version -Notepropertyvalue "Data Not Available" -force
}
if ($myvideo.Resolution -eq $null) { 
	$myvideo | Add-member -Notepropertyname Resolution -Notepropertyvalue "Data Not Available" -force
}
#Formatting object in list and displaying 
$myvideo | format-list Name, Description, Manufacturer, Version, Resolution
}
get-videoreport
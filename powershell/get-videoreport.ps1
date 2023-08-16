#script for getting videocard info and displaying as a list
function get-videoreport {
"---------------------------------------"
"|          Video Card Information     |"
"---------------------------------------"
$myvideo = get-ciminstance win32_videocontroller | 
		ForEach-Object { 
			new-object -typename psobject -property @{
							Name=$_.Name
							Description=$_.Description
							Manufacturer=$_.AdapterCompatibility
							Version=$_.DriverVersion
							Resolution=[string]$_.CurrentHorizontalResolution + " x " + [string]$_.CurrentVerticalResolution
							}
	} | Select-Object Name, Description, Manufacturer, Version, Resolution

#If block to check for empty property values 

if ($null -eq $myvideo.Name) { 
	$myvideo | Add-member -Notepropertyname Name -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $myvideo.Description) { 
	$myvideo | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $myvideo.Manufacturer) { 
	$myvideo | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $myvideo.Version) { 
	$myvideo | Add-member -Notepropertyname Version -Notepropertyvalue "Data Not Available" -force
}
if ($null -eq $myvideo.Resolution) { 
	$myvideo | Add-member -Notepropertyname Resolution -Notepropertyvalue "Data Not Available" -force
}
#Formatting object in list and displaying 
$myvideo | format-list Name, Description, Manufacturer, Version, Resolution
}
get-videoreport
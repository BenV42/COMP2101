#script for getting videocard info and displaying as a list
function get-videoreport {
"---------------------------------------"
"|          Video Card Information     |"
"---------------------------------------"
get-ciminstance win32_videocontroller | 
foreach { 
	new-object -typename psobject -property @{
				Name=$_.DeviceID
				Description=$_.Description
				Manufacturer=$_.AdapterCompatibility
				Version=$_.DriverVersion
				Resolution=[string]$_.CurrentHorizontalResolution + " x " + [string]$_.CurrentVerticalResolution
				}
	} |
format-list Name, Description, Manufacturer, Version, Resolution
}
get-videoreport
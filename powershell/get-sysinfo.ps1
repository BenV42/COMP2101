#Script to Display System information 
#Get-sysinfo function displays general system info in list format

#Start of function and variables

function get-sysinfo {
$time = get-date -format 'ddd MMM dd yyyy "at" hh:mmtt'
$compname = get-ciminstance win32_computersystem
$opname = get-ciminstance win32_operatingsystem

"---------------------------------------"
"|          System Information         |"
"---------------------------------------"
"This report was produced on $time"
$sysinfo = $compname | 
		ForEach-Object { 
			new-object -typename psobject -property @{
				"User Name"=$Env:Username
				"Computer Name"=$compname.name
				Description=$compname.description
				Manufacturer=$compname.manufacturer
				Model=$compname.model
				"System Type"=$compname.systemtype
				OS=$opname.caption
				Version=$opname.version
				Architecture=$opname.osarchitecture
				"Root Location"=$opname.systemdirectory
				}
			} | 
Select-Object "User Name", "Computer Name", Description, Manufacturer, Model, "System Type", OS, Version, Architecture, "Root location"

#If block to check against empty entries
#
if ( $null -eq $sysinfo."User Name" ) {
$sysinfo | Add-member -NotepropertyName "User Name" -Value "Data Not Available" -force 
}

if ( $null -eq $sysinfo."Computer Name" ) {
$sysinfo | Add-member -Notepropertyname "Computer Name" -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo.Description ) {
$sysinfo | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo.Manufacturer ) {
$sysinfo | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo.Model ) {
$sysinfo | Add-member -Notepropertyname Model -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo."System Type" ) {
$sysinfo | Add-member -Notepropertyname "System Type" -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo.OS ) {
$sysinfo | Add-member -Notepropertyname OS -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo.Version ) {
$sysinfo | Add-member -Notepropertyname Version -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $sysinfo.Architecture ) {
$sysinfo | Add-member -Notepropertyname Architecture -Notepropertyvalue "Data Not Available" -force 
}
if ( $null -eq $sysinfo."Root Location" ) {
$sysinfo | Add-member -Notepropertyname "Root Location" -Notepropertyvalue "Data Not Available" -force 
}
 
$sysinfo | format-list "User Name", "Computer Name", Description, Manufacturer,
			Model, "System Type", OS, Version, Architecture,
			"Root Location"
}
get-sysinfo

			
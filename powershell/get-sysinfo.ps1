#Script to Display System information 

#System info section displayed as a list
function get-sysinfo {
$time = get-date -format 'ddd MMM dd "at" hh:mm-tt-yyyy'
$compname = get-ciminstance win32_computersystem
$opname = get-ciminstance win32_operatingsystem
"---------------------------------------"
"|          System Information         |"
"---------------------------------------"
new-object -typename psobject -property @{
			"User Name"=$env:username
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
}
get-sysinfo

			
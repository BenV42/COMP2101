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


			
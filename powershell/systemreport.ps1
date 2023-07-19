#Script to Display System information 

#System info section displayed as a list
function get-sysinfo {
$time = get-date -format 'ddd MMM dd "at" hh:mm-tt-yyyy'
$compname = get-ciminstance win32_computersystem
$opname = get-ciminstance win32_operatingsystem
"---------------------------------------"
"|          System Information         |"
"---------------------------------------"
"This Report was produced on $time "
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

#This is a function to collect info about your cpu displayed in a list format

#Start of function and variables
function get-cpuinfo {
"---------------------------------------"
"|          CPU Information            |"
"---------------------------------------"
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

#Disk Drive loop to get info into a table

function get-mydisks {
"---------------------------------------"
"|      Disk Storage Information       |"
"---------------------------------------"
$diskdrives = Get-CIMInstance win32_diskdrive

foreach ($disk in $diskdrives) {
   $partitions = $disk|get-cimassociatedinstance -resultclassname win32_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname win32_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer=$disk.Caption
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
}

#Ram Memory loop in table format

function get-ram {
"---------------------------------------"
"|          RAM Information            |"
"---------------------------------------"
$totalram = 0
Get-CIMInstance win32_physicalmemory |
foreach {
	new-object -Typename psobject -Property @{Vendor = $_.manufacturer
					  Description = $_.description
					  "Size(GB)" = $_.capacity / 1gb -as [int]
					  Bank = $_.banklabel
					  Slot = $_.devicelocator
					  Speed = [string]$_.speed + " Mhz" 
	}
	$totalram += $_.capacity/1gb
} | 
format-table -autosize Vendor, Description, "Size(GB)", Bank, Slot, Speed
"Total Ram: ${totalram}GB "
}

#Function for getting videocard info and displaying as a list

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

#Network Adapters function formatting into a table based on IPEnabled

function get-ipreport {
"---------------------------------------"
"|          Network Information        |"
"---------------------------------------"
get-ciminstance win32_networkadapterconfiguration | 
where { $_.IPEnabled -eq $True } | 
sort Index |
format-table -Autosize -Wrap Description, Index, IPAddress, IPSubnet, DNSHostName,
DNSDomain, DNSServerSearchOrder, DHCPEnabled
}
get-sysinfo
get-cpuinfo
get-mydisks
get-ram
get-videoreport
get-ipreport 
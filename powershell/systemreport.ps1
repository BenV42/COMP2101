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
		foreach { 
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
Select-Object "User Name", "Computer Name", Description, Manufacturer, Model,
		"System Type", OS, Version, Architecture, "Root location"

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

#Object Creation Loop 
$mydisks = get-ciminstance win32_diskdrive |
	foreach {
	 	$partitions = get-ciminstance win32_diskdrive | get-cimassociatedinstance -resultclassname win32_diskpartition
      			foreach ($partition in $partitions) {
            			$logicaldisks = $partition | get-cimassociatedinstance -resultclassname win32_logicaldisk
            				foreach ($logicaldisk in $logicaldisks) {
                     				new-object -typename psobject -property @{Manufacturer=$_.caption
                                                               		Location=$partition.deviceid
                                                               		Drive=$logicaldisk.deviceid
                                                               		"Size(GB)"=$logicaldisk.size / 1gb -as [int]
							       		"Free Space(GB)"=$logicaldisk.freespace / 1gb -as [int]
							       		"Percent Free"=($logicaldisk.freespace / $logicaldisk.size * 100 )
                         						}
                                      		}
			}
} | Select-Object Drive, Location, Manufacturer,
		"Free Space(GB)", "Size(GB)", "Percent Free"
#If block checking against empty sections
if ($mydisks.Manufacturer -eq $null) { 
	$mydisks | Add-member -Notepropertyname Manufacturer -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks.Location -eq $null) { 
	$mydisks | Add-member -Notepropertyname Location -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks.Drive -eq $null) { 
	$mydisks | Add-member -Notepropertyname Drive -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks."Size(GB)" -eq $null) { 
	$mydisks | Add-member -Notepropertyname "Size(GB)" -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks."Free Space(GB)" -eq $null) { 
	$mydisks | Add-member -Notepropertyname "Free Space(GB)" -Notepropertyvalue "Data Not Available" -force
}
if ($mydisks."Percent Free" -eq $null) { 
	$mydisks | Add-member -Notepropertyname "Percent Free" -Notepropertyvalue "Data Not Available" -force
}
#Formatting Object into a table for viewing 
$mydisks | format-table Drive, Location, Manufacturer,
		"Free Space(GB)", "Size(GB)", "Percent Free" -autosize
           
      
}

#Ram Memory loop in table format
function get-ram {
"---------------------------------------"
"|          RAM Information            |"
"---------------------------------------"
#Variables and Creating myram object 
$totalram = 0
$myram = Get-CIMInstance win32_physicalmemory |
	foreach {
		new-object -Typename psobject -Property @{Vendor = $_.manufacturer
					  Description = $_.description
					  "Size(GB)" = $_.capacity / 1gb -as [int]
					  Bank = $_.banklabel
					  Slot = $_.devicelocator
					  Speed = [string]$_.speed + " Mhz" 
						}
	$totalram += $_.capacity/1gb

} | Select-Object Vendor, Description, "Size(GB)", Bank, Slot, Speed

#If block checking for empty property values

if ($myram.Vendor -eq $null) { 
	$myram | Add-member -Notepropertyname Vendor -Notepropertyvalue "Data Not Available" -force
} 

if ($myram.Description -eq $null) { 
	$myram | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force
}
 
if ($myram."Size(GB)" -eq $null) { 
	$myram | Add-member -Notepropertyname "Size(GB)" -Notepropertyvalue "Data Not Available" -force
}
 
if ($myram.Bank -eq $null) { 
	$myram | Add-member -Notepropertyname Bank -Notepropertyvalue "Data Not Available" -force
}
 
if ($myram.Slot -eq $null) { 
	$myram | Add-member -Notepropertyname Slot -Notepropertyvalue "Data Not Available" -force
}
 
if ($myram.Speed -eq $null) { 
	$myram | Add-member -Notepropertyname Speed -Notepropertyvalue "Data Not Available" -force
} 
#Formatting Object into a table
$myram | format-table -autosize Vendor, Description, "Size(GB)", Bank, Slot, Speed

"Total Ram: ${totalram}GB "
}

#Function for getting videocard info and displaying as a list
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

#Network Table formatted into a table based on IPEnabled
#Best Run in full window to avoid losing info 
#Start of function
function get-ipreport {
"---------------------------------------"
"|          Network Information        |"
"---------------------------------------"

$netinfo = get-ciminstance win32_networkadapterconfiguration | 
Where-Object { $_.IPEnabled -eq $True } | 
Sort-Object Index |
Select-Object Description, Index, IPAddress, IPSubnet, DNSHostName, DNSDomain, DNSServerSearchOrder, DHCPEnabled

#If block to check against empty properties

if ( $null -eq $netinfo.Description) { 
	$netinfo | Add-member -Notepropertyname Description -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSDomain) { 
	$netinfo | Add-member -Notepropertyname DNSDomain -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.IPAddress) { 
	$netinfo | Add-member -Notepropertyname IPAddress -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.IPSubnet) { 
	$netinfo | Add-member -Notepropertyname IPSubnet -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSHostName) { 
	$netinfo | Add-member -Notepropertyname DNSHostName -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSDomain) { 
	$netinfo | Add-member -Notepropertyname DNSDomain -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DNSServerSearchOrder) { 
	$netinfo | Add-member -Notepropertyname DNSServerSearchOrder -Notepropertyvalue "Data Not Available" -force 
}

if ( $null -eq $netinfo.DHCPEnabled) { 
	$netinfo | Add-member -Notepropertyname DHCPEnabled -Notepropertyvalue "Data Not Available" -force 
}
#Formatting Network object into a nice table
$netinfo | format-table -Autosize -Wrap Description, Index, IPAddress, IPSubnet, DNSHostName, DNSDomain, DNSServerSearchOrder, DHCPEnabled
}
get-sysinfo
get-cpuinfo
get-mydisks
get-ram
get-videoreport
get-ipreport 
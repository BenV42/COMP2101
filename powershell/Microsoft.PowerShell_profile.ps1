$env:PATH += ";C:\Users\administrator\Documents\GitHub\COMP2101\powershell"
new-item -path alias:np -value notepad | Out-Null

function welcomemsg {
$time = get-date -format 'HH:mm on ddd d MMM in yyyy'
write-output "Welcome to Powershell $env:username"
write-output "Have a Crazy Time at $time."
}

function get-cpuinfo {
	get-ciminstance cim_processor | format-list DeviceID, Description,
 	CurrentClockspeed, MaxClockSpeed, Manufacturer, NumberOfCores
}

function get-mydisks {
	get-disk | format-table DiskNumber, Manufacturer, Model, 
	SerialNumber, FirmwareVersion, Size
} 

welcomemsg
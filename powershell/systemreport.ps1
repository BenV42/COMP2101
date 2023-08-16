CmdletBinding()
#Script to Display System information 
#Parameter block with them all cast as switch to give either a true or false 
param ( 
		[switch]$System,
		[switch]$Disks,
		[switch]$Network
		)
#Main Function
function systemreport { 
	
#If statement block comparing each parameter to true and then storing it in systemreport making a shorter report
if ( $System -eq $true) {
	get-sysinfo
	get-cpuinfo
	get-ram
	get-videoreport
	}

if ( $Disks -eq $true ) {
	get-mydisks
	}

if ( $Network -eq $true ) {
	get-ipreport
	}

}

#Prints full report to the user after checking if a shorter report has been made with the systemreport function 
if ( systemreport -ne $null ) {
	systemreport	
}
else { 
	get-sysinfo
	get-cpuinfo
	get-ram
	get-mydisks
	get-videoreport
	get-ipreport
}
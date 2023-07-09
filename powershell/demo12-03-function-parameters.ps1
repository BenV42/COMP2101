# this script demonstrates allowing for parameters in scripts

Param (
  [Parameter(Mandatory=$true,HelpMessage="This parameter is just here to demonstrate a mandatory parameter, enter any value you like - it is not used for anything in this script")]$MyParameter,
  [long]$MinimumFreeSpace=0,
  [int]$MinimumPercentFree=0,
  [int]$MaximumPercentFree=100
)

"
You can have parameters for a script. The Param statement is used to define parameters and must be the first executing statement in the script.
e.g. Param(`$MyParameter,`$SecondParameter)
This script has a Param statement defining 4 parameters. One is mandatory, the other three are not and have default values. You can use the Tab key when entering the command that runs this script exactly like you would for a cmdlet.
" | out-host
Read-Host -Prompt "Press Enter to see how to add parameters to functions" | out-null
"
Functions are a way of creating a script block without running that block immediately. The script block gets a name, and is stored on the function: drive using that name. Then you can use that name as a command, and the script block will execute.
e.g. function somename { some script commands }

You can have parameters for a function, just like you can with a script. The Param statement can be the first executing statement in a script block and then that function will accept the parameters in your Param definition.
e.g. function somename { Param(`$MyParameter,`$SecondParameter) ; some commands }

The remainder of this script demonstrates using the parameters which this script allows for on the command line to provide data for a function in the script. Examine the code for this script using ISE or your favourite editor to see the actual Param statements used.
" | out-host

function Get-DiskSpace {
  param (
    [long]$MinFreeInBytes,
    [int]$MinPercentFree,
    [int]$MaxPercentFree
  )
  $drives = Get-WmiObject -Class win32_logicaldisk
  $filesystems = $drives | Where-Object size -GT 0
  $minfreedrives = $filesystems| Where-Object freespace -GT $MinFreeInBytes
  $minpctfreedrives = $minfreedrives | Where-Object {(100 * $_.freespace/$_.size) -gt $MinPercentFree}
  $maxpctfreedrives = $minpctfreedrives | Where-Object {(100 * $_.freespace/$_.size) -le $MaxPercentFree}
  $maxpctfreedrives | Format-Table -AutoSize DeviceID,
                                    @{ n= "Size(GB)" ; e= {$_.size / 1gb -as [int]} } ,
                                    @{ n= "Free(GB)" ; e= {$_.freespace / 1gb -as [int]} } ,
                                    @{ n= "% Free" ; e= {100 * $_.freespace / $_.size -as [int]} } ,
                                    ProviderName
}

Get-DiskSpace -MinFreeInBytes $MinimumFreeSpace -MinPercentFree $MinimumPercentFree -MaxPercentFree $MaximumPercentFree | out-host
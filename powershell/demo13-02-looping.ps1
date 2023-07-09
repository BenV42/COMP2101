# this script will demonstrate looping using the while and for commands

"
The While statement can be used to specify a script block to repeatedly execute as long as a test evaluates as true.
The general form is:
While ( testexpression ) {
  commands to run
}
To see the example commands in this script, open the script in ISE or your favourite editor.
"
Read-Host -Prompt "Press enter to start a countdown from 3 to 1 using a While loop" | out-null
$mycount = 3
While ( $mycount -gt 0 ) { $mycount; sleep 1; $mycount-- }
"
The alternate form for the While loop is to put a Do statement in front of the script block, and place the While at the end. This causes the script block to execute once before the test is evaluated.
Do {
  commands to run
} While ( testexpression )
"
Read-Host -Prompt "Press enter to use the Do statement to execute a script block once followed by the While to rerun the script block until the test is satisfied using a Do-While loop" | out-null
Do {
  $annoyed = Read-Host -Prompt "Are you annoyed yet[y/N]?"
} While ( $annoyed -notlike "y*" )
"Sorry about that, friend." | out-host

"
When you want to loop through a collection running a script block for every object in the collection, you can use the Foreach command.
The general form is:
foreach ($variablename in somecollection) { commands to run once for each object }
The Foreach command can be used in a pipeline using this form:
somecmdletToMakeObjects | foreach { commands to run once for each object, the object is in the $_ variable }
"
Read-Host -Prompt "Press enter to create a table showing the maximum decimal value of a binary, octal, and hexadecimal number having from 1 to 8 places in it" | out-null
(1..10)| foreach {
  New-Object -TypeName psobject -Property @{
    NumberOfDigits=$_
    MaxValueWithBinary=[math]::Pow(2,$_)
    MaxValueWithOctal=[math]::Pow(8,$_)
    MaxValueWithHexadecimal=[math]::Pow(16,$_)  
  }
} | Format-Table -AutoSize NumberOfDigits, MaxValueWithBinary, MaxValueWithOctal, MaxValueWithHexadecimal | out-host

Read-Host -Prompt "Press Enter to run a foreach loop that is a little more complex - this one goes through the Win32_NetworkAdapter objects for your ethernet adapters and joins each of them to the related Win32_NetworkAdapterConfiguration object that provides complementary data, and then creates new output objects summarizing the related Win32_Network objects"
Get-WmiObject Win32_NetworkAdapter | ? adaptertype -match "ethernet" | Foreach-Object{
    
    $nac = $_.GetRelated('Win32_NetworkAdapterConfiguration')
    
    New-Object PSObject -Property @{
        Index = $_.Index
        DHCPEnabled = $nac.DHCPEnabled
        DHCPServer = $nac.dhcpserver
        DHCPLeased = $nac.dhcpleaseobtained
        DHCPExpired = $nac.dhcpleaseexpired
        IP = $nac.IPAddress|? {$_.indexof('.') -gt 0}
        NetconnectionID = $_.NetconnectionID
        Name = $_.name
        MAC = $_.macaddress
        "Speed(Mb)" = $_.speed/1000000 -as [int]
        GW = $nac.defaultipgateway
        Netmask = $nac.ipsubnet|? {$_.indexof('.') -gt 0}
        Domain = $nac.dnsdomain
        Hostname = $nac.dnshostname
        "DNS Servers" = $nac.dnsserversearchorder
    }
  } |Format-List Name, MAC, "Speed(Mb)", IP, Netmask, GW, Domain, Hostname, "DNS Servers"
"
"

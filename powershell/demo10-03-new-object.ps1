# this script demonstrates creating custom objects with new-object

"
When you are writing scripts, you may encounter a situation where there is no predefined object you know about that has the properties you want. In that situation, you can create your own objects using the New_object cmdlet.
You may also find yourself in need of some existing object type, but you don't want the data for it to come from the usual places. You can create many object types with New-Object. A relatively blank object type to start with is psobject.
The general form is:
New-Object -TypeName sometypename -Property @{ some hash-syntax defining properties and their values for the new object }
"

Read-Host -Prompt "Press enter to create a custom object with 3 properties named First, Second, Third" | out-null
new-object -typename psobject -property @{First="value1";Second="value2";Third=(get-date).millisecond} | Format-List First, Second, Third | out-host

Read-Host -Prompt "Press enter to display the properties we could set in a DayOfWeek object" | out-null
New-Object -TypeName System.DayOfWeek|Get-Member -MemberType Property | out-host
Read-Host -Prompt "Press enter to create a DayOfWeek object with the value__ property set to 3 and display it using the default display rules for a DayOfWeek object"
New-Object -TypeName System.DayOfWeek -Property @{value__=3} | out-host

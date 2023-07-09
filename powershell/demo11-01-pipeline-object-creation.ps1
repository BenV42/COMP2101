# This script demonstrates using ft, fl, select to create objects in a pipeline

# Select-Object, Format-List, and Format-Table are examples of cmdlets that create new objects based
# on their input objects received from the pipeline. When we specify properties as
# parameters for these cmdlets and then these cmdlets will produce new objects with only the properties we
# specified. The data for those new objects' properties will come from the input objects, copied from
# the properties of our input objects with the same names. If we are using Format-List or Format-Table,
# the new objects will be a collection of multiple object types, containing formatting information for
# the data which was in the original objects' properties. This is because those cmdlets are designed
# to go at the end of a pipeline and only display objects.
# Select-Object creates special objects as well, but different from the format cmdlets. Select-Object
# is more likely to be used in the middle of a pipeline and creates one object type with string versions
# of the original properties.

clear-host
"
The Select-Object, Format-List, and Format-Table cmdlets can extract data from objects to
make new objects in a pipeline. We might do this to control what is in our output, or to
reduce the amount of data going through the pipeline for performance reasons.

If we wanted to know what software products are installed on our PC, we could use the
cmdlet Get-WmiObject -Class Win32_Product. It will create an object for each installed
product and that collection of objects will be displayed.
... generating Win32_Product object collection, please wait ...
"
$p=gwmi -Class win32_product
Read-Host -Prompt "   Press enter to try 'Get-WmiObject -Class Win32_Product'" |out-null
$p|out-host
"
The objects have lots of properties with information about the installed software. The
default display is a list of the objects with 5 properties displayed. It does not show
when the software was installed, or other items of information. A cmdlet like Get-Member
could help us to explore the Win32_Product objects to learn what else we can get from
these objects.
"
Read-Host -Prompt "   Press enter to try 'Get-WmiObject -Class Win32_Product|Get-Member -MemberType Property'" |out-null
$p|Get-Member -MemberType Property|out-host
"
If we only want the version, name, and installdate properties, we can use a cmdlet to
create simpler objects for us, having only the properties we want, and to have our new objects
copy the property data from the original objects. To reduce the length of the display, we will
improve our pipeline to be more choosy about the products and sort them. Let's eliminate
product objects which have the string `"Microsoft`" in the Vendor property.
"
Read-Host -Prompt "   Press enter to try 
  Get-WmiObject -Class Win32_Product |
    Where-Object Vendor -NotMatch `"Microsoft`" |
    Sort-Object Name, Version |
    Format-Table -AutoSize Vendor, Name, Version, InstallDate" |out-null
$p | Where-Object Vendor -NotMatch "Microsoft" |
  Sort-Object Name, Version |
  Format-Table -AutoSize Vendor, Name, Version, InstallDate |
  out-host
"
When we are creating objects like this, we can add our own properties if we want. We can use
a hash syntax to create a property with a name and a value.
The syntax for a custom property is
@{n=`"CustomPropertyName`";e={script block that generates a value for the propery}}
In the script block, you can use $_ to access the input object and of course, dot notation
to access methods and properties in the input object. The next example uses the existing
property value but creates the property in the new object with a different name from the
original.
"
Read-Host -Prompt "   Press enter to try 
  Get-WmiObject -Class Win32_Product |
  Where-Object Vendor -NotMatch `"Microsoft`" |
    Sort-Object Vendor, Name, Version |
    Format-Table -AutoSize Vendor, Name, Version, @{n=`"Installed On`";e={$_.InstallDate}}" |out-null
$p | Where-Object Vendor -NotMatch "Microsoft" |
  Sort-Object Vendor, Name, Version |
  Format-Table -AutoSize Vendor, Name, Version, @{n="Installed On";e={$_.InstallDate}} |
  out-host
"
The script block does not have to be trivial. It can invoke methods, run cmdlets, and do whatever
you want to do in a script block. The next example rewrites the 8-character InstallDate string to
a string which can be automatically converted to a DateTime, then converts it so that our
`"Installed On`" property can display a more interesting date.
"
Read-Host -Prompt "   Press enter to try 
  Get-WmiObject -Class Win32_Product |
  Where-Object Vendor -NotMatch `"Microsoft`" |
    Sort-Object Vendor, Name, Version |
    Format-Table -AutoSize Vendor, Name, Version, 
      @{n=`"Installed On`";e={([datetime]($_.installdate.substring(0,4) + `" `" +
                                    $_.installdate.substring(4,2) + `" `" +
                                    $_.installdate.substring(6,2))).ToString(`"ddd MMM dd, yyyy`")}}" |
  out-null
$p | Where-Object Vendor -NotMatch "Microsoft" |
  Sort-Object Vendor, Name, Version |
  Format-Table -AutoSize Vendor, Name, Version,
   @{n="Installed On";e={([datetime]($_.installdate.substring(0,4) + " " +
                                    $_.installdate.substring(4,2) + " " +
                                    $_.installdate.substring(6,2))).ToString("ddd MMM dd, yyyy")}} |
  out-host

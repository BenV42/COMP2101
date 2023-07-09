# This script demonstrates exploring objects with the get-member and
# format-list cmdlets
clear-host

"
This script demonstrates exploring objects with the Get-Member and
Format-List cmdlets. Get-Member is useful for examining an object's
structure definition and Format-List is useful for examining the
values of properties in actual objects.

We will use a simple object to demonstrate, the System.DateTime object
as produced by the Get-Date cmdlet. Running Get-Date produces output
that looks like a string and is a human-readable representation of
the date and time which was stored in the DateTime object by Get-Date. 
"
Read-Host -Prompt "   Press enter to run 'Get-Date'"| out-null
Get-Date | out-host
"
The Get-Member cmdlet can show us the structure of an object. It can show
all members of an object which can be quite long, or just a subset of them
using parameters. The -Property parameter will show simple properties and
the -Properties parameter will show all varieties of properties.
"
Read-Host -Prompt "   Press enter to run 'Get-Date|Get-Member -MemberType Properties'"| out-null
Get-Date | Get-Member -MemberType Properties | out-host
"
The -Methods parameter will show only methods.
"
Read-Host -Prompt "   Press enter to run 'Get-Date|Get-Member -MemberType Methods'"| out-null
Get-Date | Get-Member -MemberType Method | out-host
"
Format-List can be told what property values to display from an object. Which
properties to display can be a comma-separated list of property names.
The list of names can use the '*' as a wildcard, so just using '*' for the
property list will display all properties of an object. There are other ways
to specify the things to display, but this is all we need for exploring objects.
"
Read-Host -Prompt "   Press enter to run 'Get-Date|Format-List *'"| out-null
Get-Date | Format-List * | out-host
"
Be careful when looking at values displayed for properties. Just like a DateTime
object displays what appears to be a string of characters but is actually a more
complex object, the objects which are the property values may also not be the
simple number or strings they look like in the format-list output. You may need
to examine the property objects to determine what they are and how you can use them.

For example, the DayOfWeek property in our Datetime looks like a string with
the current day of the week saved there as text. In fact, it is something different.
We can explore property objects the exact same way as any other objects. Let's try that.
"
Read-Host -Prompt "   Press enter to run '(Get-Date).DayOfWeek |Get-Member -MemberType Properties'" | out-null
(Get-Date).DayOfWeek |Get-Member -MemberType Properties | out-host
"
The only property there is an integer named value__. So the day of week is actually
stored as a number, not a name. This allows for interpretation of what the name of the
weekday might be in different countries.
"
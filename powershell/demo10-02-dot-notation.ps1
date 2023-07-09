# this script demonstrates the use of dot notation to access members of an object
clear-host

$d = Get-Date
"
Get-Date produces an object with the current date and time in it.
If we let powershell display it, the output looks like: '$d'.
Piping that object to Get-Member will show us the object typename,
as well as methods and properties which we can try to use in the object.
We can restrict Get-Member to only showing properties using the
-Membertype parameter.
"
Read-Host -Prompt "   Press enter to run 'Get-Date|Get-Member -MemberType Property'" | out-null
Get-Date|Get-Member -MemberType Property|out-host
"
We can access the members of objects using dot notation. This means
specifying an object handle, then adding a dot, then adding the property
name we are interested in. We can get the handle of an object in several ways.
The simplest way on the command line is to run a cmdlet in a subshell and it
will give us an object handle. We can create a subshell using the '()' syntax.
"
Read-Host -Prompt "   Press enter to run '(Get-Date).Year'" | out-null
(Get-Date).Year|out-host
"
The members of an object are not all properties. There are several
flavours of properties and there are methods. To see the methods available
in an object, we can use the -Methods parameter of Get-Member.
"
Read-Host -Prompt "   Press enter to run 'Get-Date|Get-Member -MemberType Methods'" | out-null
Get-Date|Get-Member -MemberType Methods|out-host
"
Methods are suffixed with parentheses when using dot notation to identify
that they are methods instead of properties. If a method will accept parameters,
they go inside the parentheses, and they are shown in the Get-Member output
with their name and type. A method is code, so making an object run a method
may generate new objects. If a Method returns an object, the type of the object
is shown in front of the method name in the Get-Member output. A return type of
'void' means the method returns nothing.
"

"
Using the GetType() method in the object, we can see what type of
object it actually is. To use the method, we need the object handle.
Putting the command inside '()' will give us the object handle. We can
then use the dot '.' and the method name to make the object run the
method's code. When the member is a method, we need to add '()' after
the method name to run it. If the method requires parameters, they go
inside the '()'.
"
Read-Host -Prompt "   Press enter to run '(Get-Date).IsDaylightSavingTime()'" | out-null
(Get-Date).IsDaylightSavingTime()|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).AddDays(180)'" | out-null
(Get-Date).AddDays(180)|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).GetType()'" | out-null
(Get-Date).GetType()|out-host
"
Retrieving an object property or getting a returned object from a method
gives us an object handle. So if the object we got has members we are
interested in, we can access them by simply adding another dot, and the
member name we want.

The GetType() method produced an object which does not have a trivial
default display. In fact, it has several properties. The only property
of the type which we were actually interested in at this time was the
name of the type, so let's drill down into members of the objects we
can pull out of the DateTime object.
"
Read-Host -Prompt "   Press enter to run '(Get-Date).GetType().Name'" | out-null
(Get-Date).GetType().Name|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).DayOfWeek.value__'" | out-null
(Get-Date).DayOfWeek.value__|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).Kind'" | out-null
(Get-Date).Kind|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).Kind.value__'" | out-null
(Get-Date).Kind.value__|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).TimeOfDay'" | out-null
(Get-Date).TimeOfDay|out-host
Read-Host -Prompt "   Press enter to run '(Get-Date).TimeOfDay.TotalMinutes'" | out-null
(Get-Date).TimeOfDay.TotalMinutes|out-host
# this script demos doing testing with the if and switch statements

"
Many scripts can do whatever they need to do with an arbitrary number objects completely within a pipeline. There are also times when decisions have to be made about what steps to take next and they require more control than simply working on objects in a pipeline.
Powershell includes the If and Switch statements to allow for controlling what gets done in a script based on the results of tests. The tests may be based on the data contained in objects, the object types we are working with, or the results of commands.
The If statement allows a script block to be executed based on whether a test expression is true. It further allows a second script block to be executed if the initial test was false. And you can have additional tests which each have their own script blocks to execute if their test evaluates as true.
The general form is:
if ( testexpression ) {
  some commands
} elseif ( anothertestexpression ) {
  some different commands
} else {
  some other commands
}
To see the example commands in this script, open the script in ISE or your favourite editor.
"

$userinput = Read-Host -Prompt "Enter something to test it as a string using an If-Else statement"
if ($userinput) {
    "The string '$userinput' evaluates as true." | out-host
} else {
    "The string '$userinput' evaluates as false." | out-host
}
$userinput = Read-Host -Prompt "Now enter an integer to test it using an If-Else statement"
if ([int]$userinput) {
    "The number '$userinput' evaluates as true." | out-host
} else {
    "The number '$userinput' evaluates as false." | out-host
}
"
The Switch statement allows executing a script block selected from multiple distinct script blocks based on a test. Each script block has an associated test, and if the test evaluates to true, then its script block runs. The test can be simple, such as evaluating a typical testing expression. Or the test can be complex using a script block to supply the test code.
Switches are often used to implement menus or work with enumerations (when a data item can only have one out of a specific set of values).
It has the general form:
switch ($myvar) {
  testexpression { some commands }
  nexttestexpression { some more commands }
  anothertest { yet more commands }
  ...
  default { this is the script block that runs when no other tests evaluate as true }
}
"
$userinput = Read-Host -Prompt "Enter one of 1, 2, 3, or 4 and this Switch script will take action based on what you entered"
$secretnum=3
switch ($userinput) {
  "1" {"You entered 1." | out-host}
  2 {"2 was entered." | out-host}
  $secretnum {"That looked like a 3." | out-host}
  { $_ -eq 96 / 24 } {"I believe you gave me a 4." | out-host}
  default {"You were supposed to enter a 1, 2, 3, or 4."|out-host}
}
# Example code for read-host
clear-host
"
This script demonstrates using the read-host cmdlet to get user input
-----------------------

Read-Host gets user input without any prompt (you'll have to type something and press enter to continue)
e.g. Read-Host
"
$userInput = Read-Host
"You entered: $userInput"

"
Using the -Prompt parameter display a prompt and then gets user input
e.g. Read-Host -Prompt `"Enter something here: `"
"
$promptedInput = Read-Host -Prompt "Enter something here: "
"You entered: $promptedInput"

"
Using the -AsSecureString parameter gets user input without the user's text appearing on the screen
e.g. Read-Host -Prompt `"Password: `" -AsSecureString
"
$pass = Read-Host -Prompt "Password: " -AsSecureString
"I saved what you entered as: $pass"

# Retrieving the string the user entered in secure mode
$passwordAsString = (New-Object PSCredential -ArgumentList "CannotBeEmptyString", $pass).GetNetworkCredential().Password
"
What you entered can be turned back into a string,
but that means having that text stored in RAM without
protection from RAM snooping programs
e.g. (New-Object PSCredential -ArgumentList `"username`", $secureStringVariable).GetNetworkCredential().Password

You entered: $passwordAsString for your secure password
"
$env:PATH += ";E:\Scripting Files\COMP2101\powershell"
new-item -path alias:np -value notepad | Out-Null
function welcomemsg {
$time = get-date -format 'MMM d, yyyy HH:mm tt'
write-output "Welcome to Powershell $env:username"
write-output "Have a Crazy Time on $time."
}
welcomemsg
$env:PATH += ";C:\Users\administrator\Documents\GitHub\COMP2101\powershell"
new-item -path alias:np -value notepad | Out-Null
function welcomemsg {
$time = get-date -format 'HH:MM on ddd d MMM in yyyy'
write-output "Welcome to Powershell $env:username"
write-output "Have a Crazy Time at $time."
}
welcomemsg
$env:PATH += ";C:\Users\benve\Documents\Github\COMP2101\powershell"
new-item -path alias:np -value notepad | Out-Null
function welcomemsg {
$time = get-date -format 'HH:mm ddd d MMM yyyy'
write-output "Welcome to Powershell $env:username"
write-output "Have a Crazy Time at $time."
}
welcomemsg
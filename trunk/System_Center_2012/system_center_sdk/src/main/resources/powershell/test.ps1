#Get-ExecutionPolicy
$uname="system\vmm"
$pwd=ConvertTo-SecureString  "Abcd.123" -AsPlainText -Force;
$credential =New-Object System.Management.Automation.PSCredential($uname,$pwd);

Invoke-Command -ComputerName localhost -ScriptBlock {get-item c:} -Credential $credential
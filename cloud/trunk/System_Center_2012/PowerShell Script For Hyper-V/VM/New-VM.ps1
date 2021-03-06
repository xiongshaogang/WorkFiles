$lstr_VMCreating         = "Create Virtual Machine on Server {0} "
$lstr_VMCreationFailed   = "Failed to Create Virtual Machine {0} on Server {1}"
$lstr_VMCreationSuccess  = "Sucessfully created Virtual Machine {0} on Server {1}"


Function New-VM
{# .ExternalHelp  MAML-VM.XML
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [parameter(Mandatory = $true, ValueFromPipeLine = $true)][ValidateNotNullOrEmpty()]
        [string[]]$Name,   
    
        [string]$Path,
        
        [ValidateNotNullOrEmpty()] 
        [string]$Server = "." #Only allow VMs to be created on a single server
    )
    Process {
        $VSMgtSvc = Get-WmiObject -ComputerName $Server -Namespace $HyperVNamespace -Class "MSVM_VirtualSystemManagementService"
        $name | forEach-Object {
            $GlobalSettingsData             = ([WMIClass]"\\$Server\Root\Virtualization:MSVM_VirtualSystemGlobalSettingData").CreateInstance()
            $GlobalSettingsData.ElementName = $_
            if ($Path -is [string])       { $GlobalSettingsData.ExternalDataRoot = $Path }
            if ($pscmdlet.shouldProcess($_,($lstr_VMCreating -f $Server))) {  
	            $result = $VSMgtSvc.DefineVirtualSystem($GlobalSettingsData.GetText([System.Management.TextFormat]::WmiDtd20), $null, $null)
                
                if ( ($Result | Test-wmiResult -wait:$wait -JobWaitText (($lstr_VMCreating -f $Server) + $_)`
                                                           -SuccessText ($lstr_VMCreationSuccess  -f $_,$server) `
                                                           -failText ($lstr_VMCreationFailed   -f $_,$server) ) -eq [returnCode]::ok) {
                     [WMI]$result.DefinedSystem | Add-Member -MemberType ALIASPROPERTY -Name "VMElementName" -Value "ElementName" -PassThru
                }
            }
        }
    }
}
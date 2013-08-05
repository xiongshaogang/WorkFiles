$lstr_VMstopping   = "Stopping VM"
$lstr_WMIJobFailed1 = "The WMI Job failed: {0}"


Function Stop-VM
{# .ExternalHelp  MAML-VM.XML
    [CmdletBinding(SupportsShouldProcess=$True , ConfirmImpact='High')]
    Param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $VM, 
        
        [ValidateNotNullOrEmpty()]
        $Server = "." ,      
        [Switch]$Wait,
        $PSC,
        [Switch]$force
    ) 
    Process { if ($psc -eq $null)  {$psc = $pscmdlet} ; if (-not $PSBoundParameters.psc) {$PSBoundParameters.add("psc",$psc)}
               Set-VmState -State ([VMState]::Stopped) @PSBoundParameters }   
}

$lstr_syncConfig   = "Update Cluster Virtual Machine Configuration"
$lstr_noCluster    = "Cluster commands not loaded. Import-Modue FailoverClusters and try again"

Function Sync-VMClusterConfig 
{# .ExternalHelp  MAML-VMConfig.XML
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [parameter(ValueFromPipeLine = $true)]
        $VM="%",
        
        [ValidateNotNullOrEmpty()]
        $Server = ".",
        $PSC,
        [switch]$Force
    )
    process {
        if (-not (get-command -Name Move-ClusterVirtualMachineRole -ErrorAction "SilentlyContinue")) {Write-warning $lstr_noCluster ; return}
        if ($psc -eq $null)   {$psc = $pscmdlet} ; if (-not $PSBoundParameters.psc) {$PSBoundParameters.add("psc",$psc)}
        if ($VM -is [String]) {$VM=(Get-VM -Name $VM -server $server) }
        if ($VM.count -gt 1 )  {[Void]$PSBoundParameters.Remove("VM") ;  $VM | ForEach-object {Move-VM -VM $_  @PSBoundParameters}}
        if (($vm.__CLASS -eq 'Msvm_ComputerSystem') -and ($force -or $psc.shouldProcess(($lStr_VirtualMachineName -f $vm.elementName ), $lstr_syncConfig))) {
            Write-Progress -Activity $lstr_syncConfig -Status $vm.ElementName 
            Get-vmClusterGroup -vm $vm | Get-ClusterResource | where-object {($_.resourceType -like "Virtual Machine Configuration")}  | Update-ClusterVirtualMachineConfiguration
            Write-Progress -Activity $lstr_syncConfig -Status $vm.ElementName  -Completed
        }
    }
 }
 
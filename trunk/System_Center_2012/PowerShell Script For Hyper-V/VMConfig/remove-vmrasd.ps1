$lStr_VirtualMachineName             = "VM: {0}"
$lstr_RemoveHW                       = "Remove {0}" 
$lstr_RemoveHWSuccess                = "Removed {0} from {1}."
$lstr_RemoveHWFailure                = "Failed to remove {0} from {1}: Result was {2}."


Function Remove-VMRASD
{# .ExternalHelp  MAML-VMConfig.XML
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [parameter(Mandatory = $true)]
        $RASD ,
        
        $VM ,   # VM is discovered in the funtion, may be passed for backwards comapatibility
        $PSC, 
        [switch]$Force
    )
    if ($psc -eq $null) { $psc = $pscmdlet }
    $HWLabel  = $Rasd.elementName
    $VM  = Get-VM $rasd 
    $VSMgtSvc = Get-WmiObject -ComputerName $rasd.__Server -Namespace $HyperVNamespace -Class "MSVM_VirtualSystemManagementService"
    if ($force -or $psc.shouldProcess(($lStr_VirtualMachineName -f $vm.elementName ), ($lstr_RemoveHW -f $HWlabel))) {
         $result=$VSMgtSvc.RemoveVirtualSystemResources($VM.__Path, @( $Rasd.__Path )) 
         if     ( $result.returnValue -eq [returnCode]::OK)         {  IF ((Get-Module FailoverClusters) -and (Get-vmclusterGroup $VM)) {Sync-VMClusterConfig $vm | out-null }
                                                                       [returncode]::ok
                                                                       write-verbose ($lstr_RemoveHWSuccess -f $Hwlabel, $vm.elementname)
         }  
         elseif ( $result.returnValue -eq [returnCode]::JobStarted) {
             $job = Test-WMIJob -Wait -Job $result.job
             if     ($job.jobstate -eq [JobState]::completed )      { IF ((Get-Module FailoverClusters) -and (Get-vmclusterGroup $VM)) {Sync-VMClusterConfig $vm | out-null }
                                                                      [returncode]::ok
                                                                      write-verbose ($lstr_RemoveHWSuccess -f $Hwlabel, $vm.elementname)
             }  
             else                                                   { write-error   ($lstr_RemoveHWFailure -f $Hwlabel, $vm.elementname , $job.ErrorDescription ) }    
         }
         else                                                       { write-error   ($lstr_RemoveHWFailure -f $Hwlabel, $vm.elementname , [resultCode]$Result.returnValue) }
    }
}
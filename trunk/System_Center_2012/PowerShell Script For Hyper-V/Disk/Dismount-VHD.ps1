$lStr_WMIJobFailed2                  = "The WMI Job failed with status {0} `n {1} "
$lStr_DiskDismounting                = "Dismount VHD "
$lStr_DiskDismountFailed             = "The Dismount operation for {0} returned a failure response of: "
$lStr_DiskDismountSuccess            = "Successfully Dismounted {0}"
$lStr_DiskDismountBadPath            = "{0} Doesn't appear to be a valid path"


Function Dismount-VHD
{# .ExternalHelp  MAML-VMDisk.XML
    [CmdletBinding(SupportsShouldProcess=$True , ConfirmImpact='High' )]
    param(
        [parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, valueFromPipeline=$true)][ValidateNotNullOrEmpty()][Alias("path","FullName")]
        [string[]]$VHDPaths,
        
        [parameter(ValueFromPipelineByPropertyName =$true)][Alias("__Server")][ValidateNotNullOrEmpty()] 
        [string]$Server = ".",   #Only work with images on one server  
        
        $PSC, 
        [switch]$Force
    )
    process {
        if ($psc -eq $null)  {$psc = $pscmdlet} ; if (-not $PSBoundParameters.psc) {$PSBoundParameters.add("psc",$psc)}
        write-debug "Before Resolution VHDPaths = $VHDPaths"
        #Slightly odd syntax in the next line to cope with file names being passed instead of paths and not throwing an error
        # Line is only there in the first place to resolve incomplete / implied paths e.g. .\tenby.vhd and wildcards
        if (($Server -eq ".") -and ((test-path $vhdpaths) -contains $true))  {$VHDPaths = (Resolve-Path -path $VHDPaths -errorAction "SilentlyContinue" | ForEach-Object {$_.path}) }
        Foreach ($vhdPath in $vhdPaths) {
            if ($vhdpath -notmatch ".VHD$" )       {$vhdPath += ".VHD"}
            if ($VHDPath -notmatch "(\w:|\w)\\\w") {$VHDPath  = Join-Path (Get-VhdDefaultPath)  $VHDPath }
            write-debug "After Resolution VHDPath = $VHDPath"
            if ($vhdPath){     
                if ($force -or $psc.shouldProcess($VHDPath,$lStr_DiskDismounting)) {
                    Get-VHDMountPoint -VHDPath $VHDPath | foreach-object {Remove-PSDrive -Name $_.deviceID.substring(0,1) -ErrorAction SilentlyContinue }
                    $ImageManagementService = Get-WmiObject -Namespace $HyperVNamespace -Class $ImageManagementServiceName
                    Test-wmiResult -result ($ImageManagementService.Unmount($VHDPath)) -wait -JobWaitText ($lStr_DiskDismounting + $vhdPath) `
                            -SuccessText ($lStr_DiskDismountSuccess -f $vhdPath) -failText ($lStr_DiskDismountFailed -f $vhdPath)  
                }
            }
            else { write-warning ($lStr_DiskDismountBadPath-f $vhdPath) }
       }
   }        
}
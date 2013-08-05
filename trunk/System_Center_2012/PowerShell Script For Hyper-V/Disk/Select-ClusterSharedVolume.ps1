Function Select-ClusterSharedVolume
{# .ExternalHelp  MAML-VMDisk.XML
    Param([ValidateNotNullOrEmpty()][Alias("Cluster")]
          [string]$Server="."  #Only look at one cluster[node]
         )   
    if (-not (get-command -Name Get-ClusterSharedVolume -ErrorAction "SilentlyContinue")) {Write-Error "Cluster commands not loaded. Import-Modue FailoverClusters and try again" ; return}
    $CSVs=$(foreach ($vol in (Get-ClusterSharedVolume -cluster $server )) {foreach ($sharedVol in $vol.sharedvolumeinfo) { $sharedVol.partition | 
                 add-member -passthru -type Noteproperty -name "VolName"  -value $sharedvol.FriendlyVolumeName   |
                 add-member -passthru -type Noteproperty -name "DiskName" -value $vol.name                       |
                 add-member -passthru -type Noteproperty -name "Owner"    -value $vol.ownerNode.name }})

    select-list -InputObject $csvs -Property @{name="Name"; expression={$_.volname}},
                                             @{name="Size"; expression={($_.size/1gb).tostring("#,###.## GB")}},
                                             @{name="Free"; expression={($_.freespace / 1gb).tostring("#,###.## GB")}}  ,
                                             filesystem, owner
}     

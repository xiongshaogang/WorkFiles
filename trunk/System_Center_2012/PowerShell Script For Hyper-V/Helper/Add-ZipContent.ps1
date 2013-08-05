Function Add-ZIPContent 
{<#
    .SYNOPSIS
        Adds content to a Zip file
 #>
    [CmdletBinding()]
    Param (
        [parameter(mandatory = $true)][ValidateNotNullOrEmpty()]
        [String]$ZipFile,
        
        [parameter(mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        $file
    )
    if (-not $global:ShellApp) {$global:shellApp = New-Object -com Shell.Application }
    if ($ZipFile -notMatch "ZIP$") { $ZipFile += ".ZIP" }
    if (-not (test-path $Zipfile)) { New-Zip $ZipFile | out-null }
    $zipPath = (Resolve-Path $ZipFile).path
    if ($zipPath) {  
        # If we've got a string, convert it to a file/directoryinfo object
       if ($file -is [String])  { $file = (Resolve-Path $file | get-item) }
       if ($file -is [Array])   { $file | forEach-Object {Add-ZIPContent -ZipFile $Zippath -File $_}}
       if (($file -is [System.IO.FileInfo]) -or ($file -is [System.IO.DirectoryInfo])) {
             write-Debug "Copying $($File.fullname) to $ZipPath" 
             $global:shellApp.NameSpace($Zippath).CopyHere($File.fullname) 
             start-sleep -seconds 2
       }        
    } 
}
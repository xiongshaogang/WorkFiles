Function ConvertTo-Enum
{
<#
    .SYNOPSIS
        Converts a hashtable to an enum.
        
    .PARAMETER Table
        Specifies the hashtable to convert.
        
    .PARAMETER Name
        Specifies the name of the int-based enum to create.
        
    .EXAMPLE
        Creates an enum based on a hashtable with the names and values of the three lowest-valued U.S. coins.
        
        PS > @{"Penny" = 1;"Nickle" = 5;"Dime" = 10} | ConvertTo-Enum -Name SmallChange
        PS > [SmallChange]::Penny
        1
        PS > [SmallChange]10
        Dime
        
#>
    [CmdletBinding()]
    param(
        [parameter(Mandatory = $true, ValueFromPipeLine = $true)]
        [Hashtable]
        [ValidateNotNullOrEmpty()]
        $Table,
        
        [parameter(Mandatory = $true)]
        [string]
        [ValidateNotNullOrEmpty()]
        $Name,
        
        [Switch]$CodeOnly
    )
    
    foreach ($key in $Table.Keys) {$items += (",`n {0,20} = {1}" -f $key,$($Table[$key]) ) }
    
    $code = "public enum $Name : int  `n{$($items.Substring(1)) `n}" 
    if ($codeOnly) {$code } else {Add-Type $code}
}
[CmdletBinding(SupportsShouldProcess)]
param (
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$projectName,

    [Parameter(Mandatory)]
    [ValidateSet('Console', 'Windows', 'Android', 'AspNet', 'BlazorWebAssembly')]
    [string]$platform
)

[string]$outputFileName = 'repository.json'

[Management.Automation.OrderedHashtable]$output = [Ordered]@{
    'Projects' = [Ordered]@{
        'Console' = @()
        'Windows' = @()
        'Android' = @()
        'AspNet' = @()
        'BlazorWebAssembly' = @()
    }
}

if (Test-Path $outputFileName -PathType Leaf)
{
    $output = Get-Content $outputFileName | ConvertFrom-Json -AsHashtable
}

if ($output.Projects[$platform] -contains $projectName)
{
    Write-Verbose "Skip: $projectName"
    exit
}

$output.Projects[$platform] += $projectName
$output.Projects[$platform] = ($output.Projects[$platform] | Sort-Object) -as [string[]]

$output | ConvertTo-Json | Out-File $outputFileName

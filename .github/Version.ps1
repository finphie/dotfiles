param (
    [string]$buildNumber = ''
)

$versionFile = 'version.json'
$version = ''

if (Test-Path $versionFile) {
    $json = Get-Content $versionFile | ConvertFrom-Json -AsHashtable
    $version = "$($json['major']).$($json['minor']).$($json['patch'])"

    if ($buildNumber -ne '') {
        $version += ".$buildNumber"
    }
}

Write-Output "::set-output name=version::$version"
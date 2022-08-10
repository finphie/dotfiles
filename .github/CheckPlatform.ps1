function Set-Output {
    [CmdletBinding()]
    param ($name)

    Write-Output "::set-output name=$name::True"
}

$files = Get-ChildItem Source -Include *.csproj -Recurse

foreach ($file in $files) {
    $xml = [Xml](Get-Content $file -Encoding UTF8)
    $projectNode = $xml.Project
    $propertyGroupNode = $projectNode.SelectSingleNode('PropertyGroup')

    $targetFrameworkNode =  $propertyGroupNode.SelectSingleNode('TargetFramework') ??
        $propertyGroupNode.SelectSingleNode('TargetFrameworks')

    [string] $targetFrameworkText = $targetFrameworkNode.InnerText
    Write-Output "$($file.Name) $targetFrameworkText"

    $targetFrameworks = $targetFrameworkText -Split ';'

    foreach ($targetFramework in $targetFrameworks) {
        $framework, $os = $targetFramework -Split '-'

        if (-not $os) {
            continue;
        }

        Set-Output 'gui'

        if ($os.StartsWith('windows')) {
            Set-Output 'windows'

            if ($propertyGroupNode.UseWPF) {
                Set-Output 'wpf'
            }
            elseif ($propertyGroupNode.UseWinUI) {
                Set-Output 'winui'
            }
            elseif ($propertyGroupNode.UseMaui) {
                Set-Output 'maui'
            }
        }
        elseif ($os.StartsWith('mac')) {
            Set-Output 'mac'
        }
        elseif ($os.StartsWith('linux')) {
            Set-Output 'linux'
        }
        elseif ($os.StartsWith('android')) {
            Set-Output 'android'
        }
        elseif ($os.StartsWith('ios')) {
            Set-Output 'ios'
        }
    }
}

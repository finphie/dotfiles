@{
    Rules = @{
        PSAvoidSemicolonsAsLineTerminators = @{
            Enable = $true
        }
        AvoidUsingDoubleQuotesForConstantString = @{
            Enable = $true
        }
        PSPlaceCloseBrace = @{
            Enable = $true
            NoEmptyLineBefore = $true
            IgnoreOneLineBlock = $true
            NewLineAfter = $true
        }
        PSPlaceOpenBrace = @{
            Enable = $true
            OnSameLine = $false
            NewLineAfter = $true
            IgnoreOneLineBlock = $true
        }
        UseCorrectCasing = @{
            Enable = $true
        }
    }
}

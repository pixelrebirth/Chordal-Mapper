Write-Host -object "Running Pester..."

$Results = Invoke-pester -CodeCoverage (ls -recurse *.ps1 -Exclude *.tests.*,RunPester.ps1) -PassThru
$FailedResults = $Results.TestResult | where {-not $_.Passed}
$FailedResults | foreach {
    $_.StackTrace -match "at line: (\d*)" | Out-Null
    $LineNumber = $matches[1]
    
    $_.StackTrace -match "at line: (?:\d*) in (.*)\n" | Out-Null
    $File = $matches[1] | Resolve-Path -Relative
    
    $CollapsedMessage = $_.FailureMessage -replace "`n"," "
    $TestDescription = "$($_.Describe):$($_.Name)"
    "$File;$LineNumber;$TestDescription`:$CollapsedMessage"
}

$FailedLines = $Results.CodeCoverage.MissedCommands
$FailedLines | foreach {
    $File = $_.file | Resolve-Path -Relative
    $LineNumber = $_.line
    "$File;$LineNumber;Missing Code Coverage"
}


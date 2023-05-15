Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

Import-Module posh-git
Import-Module Terminal-Icons
Import-Module PoshColor

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

oh-my-posh init pwsh --config '~/.oh-my-posh/themes/powerlevel10k_rainbow.omp.json' | Invoke-Expression

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# PUBLIC-SAFE: no secrets, no personal values beyond the GitHub org name. Run in an ADMIN PowerShell.
$ErrorActionPreference = 'Stop'
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
if ($env:USERNAME -ne 'Levi') { Write-Warning "Signed in as '$env:USERNAME', not 'Levi'. The scripts hard-code C:\Users\Levi. Create a local account named exactly Levi (link the Microsoft account later) and sign in as it before continuing." }
$work = 'C:\Users\Levi\Desktop\Work'
foreach ($id in 'Git.Git','GitHub.cli') {
  if (-not (winget list --id $id --exact --accept-source-agreements 2>$null | Select-String $id)) {
    winget install --id $id --exact --silent --accept-package-agreements --accept-source-agreements
  }
}
$env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User')
gh auth status 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
  Write-Host 'A browser will open. Approve the GitHub login for the MALBVC account.'
  gh auth login -h github.com -p https -w
}
gh auth setup-git
if (-not (Test-Path "$work\.git")) {
  New-Item -ItemType Directory -Force (Split-Path $work) | Out-Null
  git clone -b master https://github.com/MALBVC/DesktopWork.git $work
}
Write-Host 'Bootstrap done. Next, run 01_base.ps1 from:'
Write-Host "  $work\TEAM\Nick\workstation\rebuild"

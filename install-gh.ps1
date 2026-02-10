# GitHub CLI Installer
Write-Host "Getting latest GitHub CLI version..." -ForegroundColor Green

try {
    # Get latest version info from GitHub API
    $apiUrl = "https://api.github.com/repos/cli/cli/releases/latest"
    $releaseInfo = Invoke-WebRequest -Uri $apiUrl -UseBasicParsing | ConvertFrom-Json
    $version = $releaseInfo.tag_name -replace 'v', ''
    $asset = $releaseInfo.assets | Where-Object { $_.name -like "*windows_amd64.zip*" } | Select-Object -First 1

    Write-Host "Latest version: $version" -ForegroundColor Cyan
    Write-Host "Downloading from: $($asset.browser_download_url)" -ForegroundColor Cyan

    $tempDir = Join-Path $env:TEMP "gh_install"
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    $outputZip = Join-Path $tempDir "gh.zip"
    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $outputZip -UseBasicParsing

    Write-Host "Download complete, extracting..." -ForegroundColor Green
    Expand-Archive -Path $outputZip -DestinationPath $tempDir -Force

    # List extracted files for debugging
    Write-Host "Extracted files:" -ForegroundColor Gray
    Get-ChildItem -Path $tempDir -Recurse | ForEach-Object { Write-Host "  $($_.FullName)" -ForegroundColor Gray }

    $targetDir = "C:\Program Files\gh"
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null

    # Find gh.exe anywhere in the extracted files
    $ghExe = Get-ChildItem -Path $tempDir -Filter "gh.exe" -Recurse | Select-Object -First 1

    if ($ghExe) {
        Write-Host "Found gh.exe at: $($ghExe.FullName)" -ForegroundColor Green
        Copy-Item -Path $ghExe.FullName -Destination (Join-Path $targetDir "gh.exe") -Force
        Write-Host "Installation complete!" -ForegroundColor Green
        Write-Host "GitHub CLI installed to: $targetDir" -ForegroundColor Cyan

        & (Join-Path $targetDir "gh.exe") --version

        Write-Host "`nTo use gh CLI, restart your terminal or run:" -ForegroundColor Yellow
        Write-Host "`$env:Path += ';C:\Program Files\gh'" -ForegroundColor Gray
    } else {
        Write-Host "Error: gh.exe not found in extracted files" -ForegroundColor Red
    }

} catch {
    Write-Host "Installation failed: $_" -ForegroundColor Red
    Write-Host "`nYou can manually download from: https://github.com/cli/cli/releases/latest" -ForegroundColor Yellow
}

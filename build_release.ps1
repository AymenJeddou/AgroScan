# AgroScan release build script
# Usage: .\build_release.ps1

$envFile = Join-Path $PSScriptRoot "key.env"

if (-not (Test-Path $envFile)) {
    Write-Error "Missing key.env file. Create it with: GEMINI_KEY=your_actual_key"
    exit 1
}

# Read key from key.env
$geminiKey = ""
foreach ($line in Get-Content $envFile) {
    if ($line -match "^GEMINI_KEY=(.+)$") {
        $geminiKey = $Matches[1].Trim()
    }
}

if ($geminiKey -eq "") {
    Write-Error "GEMINI_KEY not found or empty in key.env"
    exit 1
}

Write-Host "Building AgroScan release APKs..." -ForegroundColor Green

New-Item -ItemType Directory -Force "build\debug_info" | Out-Null

flutter build apk --release --split-per-abi `
    "--dart-define=GEMINI_KEY=$geminiKey" `
    --obfuscate `
    --split-debug-info=build/debug_info

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Build successful! APKs are in:" -ForegroundColor Green
    Write-Host "  build\app\outputs\flutter-apk\" -ForegroundColor Cyan
    Write-Host "  -> Send app-arm64-v8a-release.apk to friends" -ForegroundColor Cyan
} else {
    Write-Host "Build failed." -ForegroundColor Red
    exit 1
}

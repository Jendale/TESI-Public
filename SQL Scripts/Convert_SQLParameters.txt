param(
    [Parameter(Mandatory = $true)]
    [string]$InputFile,

    [string]$OutputFile
)

if (-not (Test-Path $InputFile)) {
    Write-Error "Input file '$InputFile' does not exist."
    exit 1
}

if ([string]::IsNullOrWhiteSpace($OutputFile)) {
    $OutputFile = $InputFile
}

# Read the SQL file
$content = Get-Content -Path $InputFile -Raw

# 1. Convert @Entity -> {Entity}
$content = $content -replace '@([A-Za-z_][A-Za-z0-9_]*)', '{$1}'

# 2. Convert alias.column -> alias.[column]
$content = $content -replace '\b([A-Za-z_][A-Za-z0-9_]*)\.([A-Za-z_][A-Za-z0-9_]*)\b', '$1.[$2]'

# Save the file
Set-Content -Path $OutputFile -Value $content -Encoding UTF8

Write-Host "Conversion completed successfully!"
Write-Host "Input : $InputFile"
Write-Host "Output: $OutputFile"


# Instructions
# 1. If nandyan na kayo sa Folder mismo ng file along with the SQL
# SQLConverter/
# │
# ├── Convert-SqlParameters.ps1
# ├── Query.sql

# Note yung Query.sql is yung file na gusto nyo i convert

# 2. Commands
# .\Convert-SqlParameters.ps1 -InputFile .\Query.sql

# 3. If no permission to execute the powershell script, run this command. This command is for temporary execution of powershell script
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Sample
# INPUT: SELECT * FROM @VG_VesselSchedule
# RESULT: SELECT * FROM {VG_VesselSchedule}
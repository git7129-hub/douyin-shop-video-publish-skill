# Douyin shop skill + run-log sync -> GitHub private repo (douyin-shop-video-publish-skill)
# Uses gh api contents PUT (works even when git 443 is blocked).
# Usage: powershell -ExecutionPolicy Bypass -File sync_skill.ps1
# Pushes: skills/douyin-shop-video-publish/SKILL.md
#         docs/run-log/<latest run log>.md
#         tools/sync_skill.ps1

$ErrorActionPreference = "Stop"

$repo = "git7129-hub/douyin-shop-video-publish-skill"
$branch = "main"

$RealProjectDir = [System.IO.File]::ReadAllText("$PSScriptRoot\.sync_realpath.txt", [System.Text.Encoding]::UTF8).Trim()
$SkillSrc = Join-Path $RealProjectDir "douyin-shop-video-publish\SKILL.md"
$LogDir = $RealProjectDir

function Put-GhFile {
    param([string]$path, [string]$file, [string]$msg)
    $enc = [Uri]::EscapeDataString($path)
    $b64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($file))
    $sha = ""
    try {
        $sha = (gh api "repos/$repo/contents/$enc" --jq .sha 2>$null | Out-String).Trim()
    } catch { $sha = "" }
    if ($sha -match "Not Found" -or -not $sha) { $sha = "" }
    $bodyObj = @{ message = $msg; content = $b64; branch = $branch }
    if ($sha) { $bodyObj.sha = $sha }
    $body = $bodyObj | ConvertTo-Json -Compress
    $tmp = "$env:TEMP\gh_sync.json"
    [IO.File]::WriteAllText($tmp, $body, (New-Object System.Text.UTF8Encoding $false))
    $out = gh api --method PUT "repos/$repo/contents/$enc" --input $tmp 2>&1 | Out-String
    if ($out -match '"path"') { Write-Output "PUSH OK: $path" }
    else { Write-Output "PUSH FAIL: $path :: $($out.Trim())" }
}

# 1. SKILL.md
Put-GhFile "skills/douyin-shop-video-publish/SKILL.md" $SkillSrc "sync: SKILL.md update"

# 2. latest run log (file name like 2026-09-28 ....md)
$latest = Get-ChildItem -Path $LogDir -Filter "*.md" -File |
    Where-Object { $_.Name -match '^\d{4}-\d{2}-\d{2}.*\.md$' } |
    Sort-Object Name -Descending | Select-Object -First 1
if ($latest) {
    Put-GhFile ("docs/run-log/" + $latest.Name) $latest.FullName ("sync: run log " + $latest.Name)
} else {
    Write-Output "WARN: no run log found"
}

# 3. sync script itself
Put-GhFile "tools/sync_skill.ps1" "$PSScriptRoot\sync_skill.ps1" "sync: sync_skill.ps1 update"

Write-Output "SYNC DONE"

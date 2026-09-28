# Douyin shop skill + run-log sync -> GitHub private repo (douyin-shop-video-publish-skill)
# Uses gh api contents PUT (works even when git 443 is blocked).
# Usage: powershell -ExecutionPolicy Bypass -File sync_skill.ps1
# Pushes:
#   skills/douyin-shop-video-publish/{SKILL.md,config.example.json,README.md}
#   docs/run-log/<latest run log>.md
#   tools/sync_skill.ps1
#   README.md (repo root, from local skill-repo checkout)

$ErrorActionPreference = "Stop"

$repo = "git7129-hub/douyin-shop-video-publish-skill"
$branch = "main"

$RealProjectDir = [System.IO.File]::ReadAllText("$PSScriptRoot\.sync_realpath.txt", [System.Text.Encoding]::UTF8).Trim()
$SkillDir = Join-Path $RealProjectDir "douyin-shop-video-publish"
$LogDir = $RealProjectDir
$RepoCheckout = Join-Path $RealProjectDir "_repo_sync\douyin-shop-video-publish-skill"

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

# 1. skill dir files (SKILL.md, config.example.json, README.md)
Get-ChildItem -Path $SkillDir -File | ForEach-Object {
    $rel = "skills/douyin-shop-video-publish/$($_.Name)"
    Put-GhFile $rel $_.FullName ("sync: skill file " + $_.Name)
}

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

# 4. repo root README (source = local checkout of the skill repo)
if (Test-Path "$RepoCheckout\README.md") {
    Put-GhFile "README.md" "$RepoCheckout\README.md" "sync: README update"
}

Write-Output "SYNC DONE"

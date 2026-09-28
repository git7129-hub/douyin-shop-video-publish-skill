# Douyin shop skill + run-log sync script -> GitHub private repo
# Usage: powershell -ExecutionPolicy Bypass -File sync_skill.ps1
# Pushes updated SKILL.md and latest run log to git7129-hub/douyin_shop_video_publish (private):
#   skills/douyin-shop-video-publish/SKILL.md
#   docs/run-log/YYYY-MM-DD-runlog.md
# Note: SKILL.md content updates are done by the Agent during run summary.
# This script only syncs and pushes; it never modifies content.

$ErrorActionPreference = "Stop"

$ProjectDir = "E:\test_douyin\publish"   # placeholder, real path set below
$RepoDir = "$ProjectDir\_repo_sync\douyin_shop_video_publish"
$SkillSrc = "$ProjectDir\douyin-shop-video-publish\SKILL.md"
$LogDir = "$ProjectDir"

# Real paths (UTF-8 handled by caller; keep ASCII here for PS 5.1 safety)
$RealProjectDir = [System.IO.File]::ReadAllText("$PSScriptRoot\.sync_realpath.txt", [System.Text.Encoding]::UTF8).Trim()
$ProjectDir = $RealProjectDir
$RepoDir = Join-Path $ProjectDir "_repo_sync\douyin-shop-video-publish-skill"
$SkillSrc = Join-Path $ProjectDir "douyin-shop-video-publish\SKILL.md"
$LogDir = $ProjectDir

if (-not (Test-Path $RepoDir)) {
    Write-Output "ERROR: repo dir missing: $RepoDir"
    exit 1
}

# 1. Sync SKILL.md
$SkillDst = Join-Path $RepoDir "skills\douyin-shop-video-publish\SKILL.md"
$SkillDstDir = Split-Path $SkillDst
if (-not (Test-Path $SkillDstDir)) { New-Item -ItemType Directory -Force $SkillDstDir | Out-Null }
Copy-Item $SkillSrc $SkillDst -Force
Write-Output "SYNC: SKILL.md"

# 2. Sync latest run log (file name like 2026-09-28-runlog .md, may contain CJK)
$latest = Get-ChildItem -Path $LogDir -Filter "*.md" -File |
    Where-Object { $_.Name -match '^\d{4}-\d{2}-\d{2}.*\.md$' } |
    Sort-Object Name -Descending | Select-Object -First 1
if ($latest) {
    $LogDstDir = Join-Path $RepoDir "docs\run-log"
    if (-not (Test-Path $LogDstDir)) { New-Item -ItemType Directory -Force $LogDstDir | Out-Null }
    Copy-Item $latest.FullName (Join-Path $LogDstDir $latest.Name) -Force
    Write-Output "SYNC: $($latest.Name)"
} else {
    Write-Output "WARN: no run log found"
}

# 3. git commit + push
Push-Location $RepoDir
try {
    git add -A
    $changed = git status --porcelain
    if ($changed) {
        git commit -m "sync: skill + run log ($(Get-Date -Format 'yyyy-MM-dd HH:mm'))"
        git push origin main
        Write-Output "PUSH: OK"
    } else {
        Write-Output "PUSH: no changes, skip"
    }
} finally {
    Pop-Location
}

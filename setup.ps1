# =====================================================
# Cursor Config Setup — Windows 설정 스크립트 (PowerShell)
# 사용법: PowerShell에서 .\setup.ps1 실행
# 주의: 관리자 권한 없이도 실행 가능 (Junction 방식)
# =====================================================

$ErrorActionPreference = "Stop"

$repoDir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$cursorDir = "$env:USERPROFILE\.cursor"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

Write-Host ""
Write-Host "======================================"
Write-Host "  Cursor Config Setup (Windows)"
Write-Host "======================================"
Write-Host "레포 경로: $repoDir"
Write-Host ""

# ── 1. ~/.cursor 폴더 없으면 생성
if (-not (Test-Path $cursorDir)) {
  New-Item -ItemType Directory -Path $cursorDir | Out-Null
}

# ── 2. Junction(디렉터리 연결) 설정 함수
function Link-Dir {
  param($name)

  $target = "$repoDir\.cursor\$name"   # 레포 안의 실제 폴더
  $link   = "$cursorDir\$name"          # 연결될 경로

  # 이미 연결된 Junction이면 스킵
  if (Test-Path $link) {
    $item = Get-Item $link -Force
    if ($item.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
      Write-Host "✅ $name — 이미 연결됨 (스킵)"
      return
    }
    # 기존 폴더 백업
    $backupPath = "${link}_backup_${timestamp}"
    Move-Item -Path $link -Destination $backupPath
    Write-Host "📦 $name 기존 폴더 백업: $backupPath"
  }

  # Junction 생성 (관리자 권한 불필요, 같은 드라이브)
  cmd /c "mklink /J `"$link`" `"$target`"" | Out-Null
  Write-Host "🔗 $name — Junction 연결 완료"
}

Link-Dir "rules"
Link-Dir "command"
Link-Dir "skills"

Write-Host ""
Write-Host "======================================"
Write-Host "  ✅ 설정 완료!"
Write-Host "======================================"
Write-Host ""
Write-Host "다음 단계:"
Write-Host "  1. Cursor를 완전히 종료 후 재시작"
Write-Host "  2. 아무 프로젝트나 열고 AI 채팅에서 테스트"
Write-Host ""
Write-Host "새 프로젝트에 적용하려면:"
Write-Host "  프로젝트 루트 폴더에서 PowerShell 실행 후:"
Write-Host "  cmd /c 'mklink /J .cursor $repoDir\.cursor'"
Write-Host ""

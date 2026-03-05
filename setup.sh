#!/bin/zsh
# =====================================================
# Cursor Config Setup — Mac 설정 스크립트
# 사용법: chmod +x setup.sh && ./setup.sh
# =====================================================

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CURSOR_DIR="$HOME/.cursor"
BACKUP_SUFFIX=".backup_$(date +%Y%m%d_%H%M%S)"

echo ""
echo "======================================"
echo "  Cursor Config Setup (Mac)"
echo "======================================"
echo "레포 경로: $REPO_DIR"
echo ""

# ── 1. ~/.cursor 폴더 없으면 생성
mkdir -p "$CURSOR_DIR"

# ── 2. 기존 폴더 백업 후 심볼릭 링크 연결
link_dir() {
  local target="$REPO_DIR/.cursor/$1"   # 레포 안의 실제 폴더
  local link="$CURSOR_DIR/$1"           # 연결될 심볼릭 링크 경로

  # 이미 같은 심볼릭 링크면 스킵
  if [ -L "$link" ] && [ "$(readlink "$link")" = "$target" ]; then
    echo "✅ $1 — 이미 연결됨 (스킵)"
    return
  fi

  # 기존 폴더/링크가 있으면 백업
  if [ -e "$link" ] || [ -L "$link" ]; then
    mv "$link" "${link}${BACKUP_SUFFIX}"
    echo "📦 $1 기존 폴더 백업: ${link}${BACKUP_SUFFIX}"
  fi

  ln -s "$target" "$link"
  echo "🔗 $1 — 심볼릭 링크 연결 완료"
}

link_dir "rules"
link_dir "command"
link_dir "skills"

echo ""
echo "======================================"
echo "  ✅ 설정 완료!"
echo "======================================"
echo ""
echo "다음 단계:"
echo "  1. Cursor를 완전히 종료 후 재시작"
echo "  2. 아무 프로젝트나 열고 AI 채팅에서 테스트"
echo ""
echo "새 프로젝트에 적용하려면:"
echo "  프로젝트 루트에서 다음 명령어 실행:"
echo "  ln -s $REPO_DIR/.cursor .cursor"
echo ""

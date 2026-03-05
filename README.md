# Cursor Config — 웹 퍼블리셔 AI 규칙 모음

웹 퍼블리셔 실무에 맞춘 Cursor AI 규칙(Rules), 명령어(Command), 스킬(Skills)을 버전 관리합니다.  
Mac(집)과 Windows(회사) 모두 동일한 규칙으로 작업할 수 있습니다.

---

## 파일 구조

```
cursor-config/
├── .cursor/
│   ├── rules/
│   │   └── base.mdc              # 항상 적용되는 기본 규칙 (언어·역할·HTML·SCSS·JS·성능·접근성)
│   ├── command/
│   │   ├── a11y_check.mdc        # /a11y_check · /qc_report · /before_service 명령어
│   │   └── markup_generator.mdc  # /markup_generator · 표준 프롬프트 10종
│   └── skills/
│       └── jsp_project_analysis.mdc  # JSP 프로젝트 구조 분석 스킬
├── setup.sh      # Mac 초기 설정 스크립트
├── setup.ps1     # Windows 초기 설정 스크립트
└── README.md
```

---

## 처음 설치하기

### Mac 

**1. 레포 클론**
```bash
git clone https://github.com/[계정명]/cursor-config.git ~/cursor-config
```

**2. 설정 스크립트 실행**
```bash
cd ~/cursor-config
chmod +x setup.sh
./setup.sh
```

**3. Cursor 재시작**  
Cursor를 완전히 종료(`Cmd+Q`)했다가 다시 열면 규칙이 자동 적용됩니다.

**4. 동작 확인**  
아무 프로젝트나 열고 AI 채팅창에 다음을 입력해보세요:
```
접근성 검사해줘
```
한글로 접근성 체크리스트 결과가 나오면 성공입니다.

---

### Windows 

> **PowerShell 실행 정책 오류가 나는 경우**  
> PowerShell을 **관리자 권한**으로 열고 아래 명령어를 먼저 실행하세요.  
> ```powershell
> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```
> 이후 PowerShell을 닫고 일반 모드로 다시 열어서 진행하세요.

**1. Git 설치 확인**  
[git-scm.com](https://git-scm.com)에서 Git을 설치합니다.  
설치 후 PowerShell을 새로 열어주세요.

**2. 레포 클론**  
PowerShell에서 실행:
```powershell
git clone https://github.com/[계정명]/cursor-config.git $HOME\cursor-config
```

**3. 설정 스크립트 실행**
```powershell
cd $HOME\cursor-config
.\setup.ps1
```

**4. Cursor 재시작**  
Cursor를 완전히 종료했다가 다시 열면 규칙이 자동 적용됩니다.

**5. 동작 확인**  
아무 프로젝트나 열고 AI 채팅창에 다음을 입력해보세요:
```
접근성 검사해줘
```

---

## 새 프로젝트 시작할 때

규칙을 특정 프로젝트에도 직접 연결하고 싶을 때 사용합니다.  
(글로벌 설정만으로 충분하면 이 단계는 건너뛰어도 됩니다.)

### Mac
```bash
# 프로젝트 루트로 이동
cd ~/Desktop/[프로젝트 폴더]

# .cursor 폴더를 레포와 심볼릭 링크로 연결
ln -s ~/cursor-config/.cursor .cursor
```

### Windows
```powershell
# 프로젝트 루트로 이동
cd $HOME\Desktop\[프로젝트 폴더]

# .cursor 폴더를 레포와 Junction으로 연결
cmd /c "mklink /J .cursor $HOME\cursor-config\.cursor"
```

> **주의**: 프로젝트를 Git으로 관리하는 경우 `.cursor`를 `.gitignore`에 추가하세요.  
> 규칙 파일을 프로젝트 레포에 같이 올리지 않아야 관리가 깔끔합니다.
> ```
> # .gitignore
> .cursor
> ```

---

## 규칙 수정하고 반영하기

규칙을 수정하면 **심볼릭 링크 특성상 Cursor를 재시작하지 않아도** 바로 반영됩니다.

```bash
# 1. 규칙 파일 수정 (Cursor에서 직접 편집 가능)
# ~/cursor-config/.cursor/rules/base.mdc 등 수정

# 2. 변경사항 커밋
cd ~/cursor-config
git add .
git commit -m "규칙 업데이트: [변경 내용 요약]"

# 3. GitHub에 push
git push origin main
```

---

## 다른 기기에서 최신 규칙 받기

```bash
cd ~/cursor-config
git pull origin main
```

pull 후 Cursor를 재시작하면 최신 규칙이 바로 적용됩니다.

---

## 명령어 사용법

Cursor AI 채팅창에서 다음 문장으로 명령어를 실행합니다.

| 명령어 | 실행 방법 | 설명 |
|---|---|---|
| `/a11y_check` | `접근성 검사해줘` | HTML 접근성 7항목 자동 검사 |
| `/qc_report` | `QC 리포트 만들어줘` | 21개 항목 QC 체크리스트 검사 + 리포트 생성 |
| `/before_service` | `오픈 전 점검해줘` | 배포 전 5단계 최종 점검 |
| `/markup_generator` | `[UI명] 만들어줘` | 시맨틱 HTML 마크업 자동 생성 |

### 표준 프롬프트 10종

`markup_generator.mdc` 파일 하단에 P01~P10 프롬프트가 있습니다.  
`[대괄호]` 안만 바꿔서 바로 사용하세요.

| # | 용도 | 사용 시점 |
|---|---|---|
| P01 | 마크업 생성 | UI 구현 시작 |
| P02 | 접근성 검사 | 마크업 완료 후 |
| P03 | SCSS 구조 생성 | 스타일 작업 시작 |
| P04 | QC 리포트 | 검수 제출 전 |
| P05 | Before Service | 오픈 당일 최종 확인 |
| P06 | JSP 구조 분석 | JSP 파일 수정 전 |
| P07 | Lighthouse 개선 | 성능 점수 미달 시 |
| P08 | KRDS 변환 | KRDS 전환 작업 시 |
| P09 | 반응형 점검 | 모바일 QC 시 |
| P10 | 코드 컨벤션 교정 | 납품·PR 전 |

---

## 문제 해결

### 규칙이 적용이 안 돼요
1. Cursor를 완전히 종료(`Cmd+Q` / 작업표시줄 우클릭 → 종료)
2. 심볼릭 링크/Junction이 제대로 연결됐는지 확인

**Mac 확인:**
```bash
ls -la ~/.cursor/
# rules → ~/cursor-config/.cursor/rules 처럼 화살표로 연결됐으면 정상
```

**Windows 확인:**
```powershell
dir $HOME\.cursor
# <JUNCTION> 표시가 있으면 정상
```

### Windows에서 setup.ps1 실행 오류

```
이 시스템에서 스크립트를 실행할 수 없습니다
```
→ PowerShell을 **관리자 권한**으로 열고 아래 명령어 실행 후 재시도:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Mac에서 permission denied 오류
```bash
chmod +x setup.sh
./setup.sh
```

---

## 업데이트 이력

| 날짜 | 내용 |
|---|---|
| 2026.03 | 최초 구성 (rules / command / skills) |

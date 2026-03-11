# Cursor Config — 웹 퍼블리셔 AI 규칙 모음

웹 퍼블리셔 실무에 맞춘 Cursor AI 규칙(Rules), 명령어(Command), 스킬(Skills)을 **GitHub에서 버전 관리**합니다.  
팀원 모두가 같은 규칙으로 Cursor를 쓰고, **규칙이 수정되면 `git pull` 한 번으로 최신 버전을 받을 수 있습니다.**

| 누가            | 할 일                                                           |
| --------------- | --------------------------------------------------------------- |
| **팀원**        | 처음 한 번 설치 → 이후엔 주기적으로 `git pull`로 최신 규칙 받기 |
| **규칙 관리자** | 규칙 수정 후 커밋·push → 팀원들은 pull로 반영                   |

---

## 1. 처음 설치 (한 번만 하면 됨)

본인 PC에 이 레포를 받고, 설정 스크립트를 실행하면 Cursor 전역에 규칙이 연결됩니다.

### Mac

```bash
# 1) 레포 받기
git clone https://github.com/[계정명]/cursor-config.git ~/cursor-config

# 2) 설정 스크립트 실행
cd ~/cursor-config
chmod +x setup.sh
./setup.sh

# 3) Cursor 완전 종료 후 다시 실행 (Cmd+Q 후 재실행)
```

### Windows

1. **Git 설치**  
   [git-scm.com](https://git-scm.com)에서 설치 후, PowerShell을 **새로** 연다.

2. **PowerShell에서 아래 순서대로 실행**

```powershell
# 1) 레포 받기
git clone https://github.com/[계정명]/cursor-config.git $HOME\cursor-config

# 2) 받은 폴더로 이동 (클론하면 cursor-config 폴더가 생김)
cd $HOME\cursor-config

# 3) 설정 스크립트 실행
.\setup.ps1

# 4) Cursor 완전 종료 후 다시 실행 (작업표시줄에서 우클릭 → 종료 후 재실행)
```

> **Windows에서 "스크립트를 실행할 수 없습니다" 나오면**  
> PowerShell을 **관리자 권한**으로 열고 한 번만 실행:  
> `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`  
> 그다음 PowerShell 닫고, 다시 보통 모드로 열어서 위 1~4 진행.

### 동작 확인

Cursor에서 아무 프로젝트나 연 뒤, **AI 채팅창**에 `접근성 검사해줘` 입력.  
한글로 접근성 결과가 나오면 성공입니다.

---

## 2. 팀원이 할 일: 최신 규칙 받기 (pull)

규칙이 GitHub에서 업데이트되면, 본인 PC에도 **최신 규칙**을 받아야 합니다.  
**레포를 받아둔 폴더**에서 아래만 실행하면 됩니다.

### Mac

```bash
cd ~/cursor-config
git pull origin main
```

### Windows

```powershell
cd $HOME\cursor-config
git pull origin main
```

**pull 한 다음에는 Cursor를 한 번 종료했다가 다시 켜주세요.** 그러면 최신 규칙이 적용됩니다.

-   언제 pull 하면 되나요? → 규칙 관리자가 "규칙 업데이트했어요"라고 공지했을 때, 또는 주기적으로 (예: 주 1회).
-   레포를 다른 경로에 받아둔 경우 → 그 경로로 이동한 뒤 `git pull origin main` 실행.

---

## 3. 사용법

Cursor **AI 채팅창**에 **말로** 입력하면 됩니다. 슬래시 명령어(`/qc_report` 등)를 따로 외울 필요 없습니다.

| 하고 싶은 일              | 채팅창에 이렇게 입력                               |
| ------------------------- | -------------------------------------------------- |
| 접근성 검사               | `접근성 검사해줘`                                  |
| QC·QA 체크리스트 + 리포트 | `QC 리포트 만들어줘` 또는 `QC 검사해줘`            |
| 오픈 전 최종 점검         | `오픈 전 점검해줘`                                 |
| 시맨틱 마크업 생성        | `[만들 UI 이름] 만들어줘` (예: 메인 배너 만들어줘) |

표준 프롬프트(P01~P10)는 `markup_generator.mdc` 하단에 정리돼 있습니다. `[대괄호]`만 바꿔서 쓰면 됩니다.

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

## 4. 새 프로젝트에 규칙 연결

규칙을 특정 프로젝트에도 직접 연결하고 싶을 때 사용합니다.  
(글로벌 설정만으로 충분하다면 이 단계는 건너뛰어도 됩니다.)

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
>
> ```
> # .gitignore
> .cursor
> ```

---

## 5. 규칙 관리자: 수정 후 GitHub에 반영하기

규칙 파일을 수정한 뒤 커밋·push 하면, 팀원들은 **2. 최신 규칙 받기**에서 `git pull`로 받으면 됩니다.

```bash
# 1. 규칙 파일 수정 (Cursor에서 이 레포 열고 .cursor/ 안 파일 수정)

# 2. 변경사항 커밋 & push (Mac/Windows 공통)
cd ~/cursor-config   # Windows: cd $HOME\cursor-config
git add .
git commit -m "규칙 업데이트: [변경 내용 요약]"
git push origin main
```

---

## 표준 프롬프트 10종 (P01~P10)

`markup_generator.mdc` 파일 하단에 P01~P10 프롬프트가 있습니다. `[대괄호]` 안만 바꿔서 바로 사용하세요.

| #   | 용도             | 사용 시점           |
| --- | ---------------- | ------------------- |
| P01 | 마크업 생성      | UI 구현 시작        |
| P02 | 접근성 검사      | 마크업 완료 후      |
| P03 | SCSS 구조 생성   | 스타일 작업 시작    |
| P04 | QC 리포트        | 검수 제출 전        |
| P05 | Before Service   | 오픈 당일 최종 확인 |
| P06 | JSP 구조 분석    | JSP 파일 수정 전    |
| P07 | Lighthouse 개선  | 성능 점수 미달 시   |
| P08 | KRDS 변환        | KRDS 전환 작업 시   |
| P09 | 반응형 점검      | 모바일 QC 시        |
| P10 | 코드 컨벤션 교정 | 납품·PR 전          |

---

## 문제 해결 (FAQ)

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

| 날짜    | 내용                                 |
| ------- | ------------------------------------ |
| 2026.03 | 최초 구성 (rules / command / skills) |

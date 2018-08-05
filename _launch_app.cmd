@echo off
chcp 949 1> NUL 2> NUL
set "PATH=%~dp0\bin;%~dp0\tools;%PATH%"
setlocal enabledelayedexpansion enableextensions

pushd "%~dp0"
set TARGET=be.wazabe.appdrawer
if "%~1" == "" (
  echo   # 실행할 앱의 패키지명을 입력하세요
  set /p TARGET_USER="(입력 없이 엔터 키 누르면 "be.wazabe.appdrawer" 실행) > "
  if "!TARGET_USER!" NEQ "" (
    set TARGET=!TARGET_USER!
  )
) else (
set TARGET=%~1
)

echo   # 다음 명령으로 앱을 실행합니다.
echo adb shell monkey -p %TARGET% -c android.intent.category.LAUNCHER 1
adb shell monkey -p %TARGET% -c android.intent.category.LAUNCHER 1

echo # 엔터 키 또는 아무 키나 눌러 이 창을 닫으세요!
pause > nul

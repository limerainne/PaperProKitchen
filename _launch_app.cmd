@echo off
chcp 949 1> NUL 2> NUL
set "PATH=%~dp0\bin;%~dp0\tools;%PATH%"
setlocal enabledelayedexpansion enableextensions

pushd %~dp0
title Ridibooks Paper Pro Kitchen # 앱 실행

:ask_user
set TARGET_PKG=cn.modificator.launcher
if "%~1" == "" (
  echo # 실행할 앱의 패키지명을 입력하거나 아래 목록에서 번호를 골라 입력하세요:
  REM NOTE echo문에 괄호 쓰지 말 것...
  echo   1. E-Ink Launcher [cn.modificator.launcher]
  echo   2. App Drawer -- 카페 인기 상품 [au.radsoft.appdrawer]
  echo   3. App Drawer -- r11까지 기본 앱 서랍 [be.wazabe.appdrawer]
  echo.
  set /p TARGET_PKG_USER="(입력 없이 엔터 키 누르면 1번 항목 실행) > "
  echo.
  if "!TARGET_PKG_USER!" NEQ "" (
    if /i "!TARGET_PKG_USER!" EQU "1" (
      set TARGET_PKG=cn.modificator.launcher
    ) else if /i "!TARGET_PKG_USER!" EQU "2" (
      set TARGET_PKG=au.radsoft.appdrawer
    ) else if /i "!TARGET_PKG_USER!" EQU "3" (
      set TARGET_PKG=be.wazabe.appdrawer
    ) else (  
      set TARGET_PKG=!TARGET_PKG_USER!
    )
  )
) else (
  set TARGET_PKG=%~1
)

echo # 다음 명령으로 앱을 실행합니다.
echo   ^> adb shell monkey -p !TARGET_PKG! -c android.intent.category.LAUNCHER 1
adb shell monkey -p !TARGET_PKG! -c android.intent.category.LAUNCHER 1
echo.

REM 매개변수가 없었으면, 처음으로 돌아가 반복
if "%~1" == "" goto ask_user

echo # 엔터 키 또는 아무 키나 눌러 창을 닫으세요
pause > nul

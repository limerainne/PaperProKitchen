@echo off
chcp 65001 1> NUL 2> NUL
set "PATH=%~dp0\bin;%~dp0\tools;%PATH%"

pushd "%~dp0"

echo # 다음 경로의 ADB 설정 파일에 네트로닉스의 Vendor ID를(0x1f85) 추가합니다:
set ADB_USB="%userprofile%\.android\adb_usb.ini"
echo  %ADB_USB%
echo 0x1f85>>%ADB_USB%
echo.

echo # 현재 실행 중인 ADB 서버가 있으면 이를 종료합니다:
adb kill-server
echo.

echo # 아무 키나 눌러 종료하세요!
pause > nul
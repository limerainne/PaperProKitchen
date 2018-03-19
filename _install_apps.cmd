@echo off
chcp 65001 1> NUL 2> NUL
set "PATH=%~dp0\bin;%~dp0\tools;%PATH%"

pushd "%~dp0"

echo   # 다음 앱을 설치합니다:
for /r %%i in (apps\*.apk) do (
  echo   * "%%~nxi"
  call :get_app_pkg_name %%i
)
echo.

for /r %%i in (apps\*.apk) do (
  echo   * 설치: "%%~nxi"
  adb install "apps\%%~nxi"
  echo.
)

echo   # 다음 명령으로 앱 런처를 실행합니다.
echo adb shell monkey -p be.wazabe.appdrawer -c android.intent.category.LAUNCHER 1
adb shell monkey -p be.wazabe.appdrawer -c android.intent.category.LAUNCHER 1

echo   # 모든 앱 파일에 대해 설치 명령을 진행했습니다! 아무 키나 눌러 종료하세요.
pause > NUL
exit /b 0

:get_app_pkg_name <apk_path>
(
echo       - 앱 이름
aapt d badging "apps\%~nx1" 2>&1 | findstr /rc:"^application-label:\'.*\'"
echo       - 패키지 이름
aapt d badging "apps\%~nx1" 2>&1 | findstr /rc:"^package: name="
echo.
)

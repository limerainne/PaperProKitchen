@echo off
chcp 949 1> NUL 2> NUL
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
  echo adb install -r "apps\%%~nxi"
  adb install -r "apps\%%~nxi"
  echo.
)
echo.

echo   # 기기에서 '앱 서랍' 앱을 강제 종료합니다.
echo adb shell am force-stop be.wazabe.appdrawer
adb shell am force-stop be.wazabe.appdrawer
echo adb shell am force-stop au.radsoft.appdrawer
adb shell am force-stop au.radsoft.appdrawer
echo.

echo   # 모든 앱 파일에 대해 설치 명령을 진행했습니다! 엔터 키 또는 아무 키나 눌러 종료하세요.
pause > NUL
goto finish

:get_app_pkg_name <apk_path>
(
echo       - 앱 이름
aapt d badging "apps\%~nx1" 2>&1 | findstr /rc:"^application-label:\'.*\'"
echo       - 패키지 이름
aapt d badging "apps\%~nx1" 2>&1 | findstr /rc:"^package: name="
echo.
)

:finish
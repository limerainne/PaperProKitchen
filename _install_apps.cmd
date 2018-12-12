@echo off
chcp 949 1> NUL 2> NUL
set "PATH=%~dp0\bin;%~dp0\tools;%PATH%"
setlocal enabledelayedexpansion enableextensions

pushd "%~dp0"

:check_if_device_recognized

echo # USB 케이블로 기기를 PC에 연결했는지, ADB 장치로 인식되는지 먼저 확인해주세요:
echo   ^> adb devices  # ADB 프로그램이 인식한 장치 목록
adb devices
echo.

:: https://superuser.com/questions/959036/what-is-the-windows-equivalent-of-wc-l
for /f "tokens=*" %%i in ('adb devices ^| find /c /v ""') do set lines=%%i
:: SHOULD have only one device = header + device + empty lines
if /i !lines! neq 3 (
echo ^^! 장치가 인식되지 않은 것 같습니다. 확인해주세요.
echo ^(또는 ADB 장치가 한 개만 연결되어 있어야 합니다.^)
pause
echo.

goto check_if_device_recognized
)


echo # 설치할 앱 목록 (도구 폴더/apps/*.apk):
set /a apps_count=0
for /r %%i in (apps\*.apk) do (
  echo   * "%%~nxi"
  call :get_app_pkg_name %%i
  
  set /a apps_count=apps_count+1
)
echo.

if /i !apps_count! lss 1 (
echo ^^! PC의 'apps' 폴더에 APK 파일이 하나도 없습니다.
echo.
goto ask_install_apps_in_device
)

echo # 설치 명령을 내립니다. 각 명령에 대해:
echo ^- APK 파일이 기기로 잘 전송되는지,
echo ^- "Success" 메시지가 표시되는지 확인하세요.
echo.
for /r %%i in (apps\*.apk) do (
  echo   * 설치: "%%~nxi"
  echo ^> adb install -r "apps\%%~nxi"
  adb install -r "apps\%%~nxi"
  echo.
)
echo.


:ask_install_apps_in_device
echo # 혹 앱 설치 파일을 PC 도구 폴더가 아닌 기기 내부저장소의 "Apps" 폴더에 넣으셨나요?
echo ^- 첫 부팅 시 자동 설치가 되지 않았다면, 여기서 설치해보세요.
echo.

set AREYOUSURE=N
SET /P AREYOUSURE=기기의 "Apps" 폴더에 둔 APK 파일을 설치해볼까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO force_close_app_drawers

set INSTALL_COUNT=0
call :install_apps_in_device /sdcard/Apps
IF /I !INSTALL_COUNT! LSS 1 call :install_apps_in_device /sdcard/apps

set INSTALL_COUNT=0
call :install_apps_in_device /extsd/Apps
IF /I !INSTALL_COUNT! LSS 1 call :install_apps_in_device /extsd/apps
:: NOTE case insensitive??

echo.
goto force_close_app_drawers

:install_apps_in_device <path>
(
echo # 대상 경로: %1
echo ^- 폴더가 있는지, APK 파일이 있는지, '.installed' 파일이 없는지 확인해봅니다.
for /f "tokens=*" %%i in ('adb shell echo "$([ -d %1 ] && [ -f %1/*.apk ] && [ ^! -e %1/.installed ] && echo 1 || echo 0)"') do set DIR_EXIST=%%i

IF /I !DIR_EXIST! LSS 1 goto install_apps_in_device__stop

echo ^- 설치 명령을 전달합니다.
echo ^> adb shell "for apk in %1/*.apk; do echo App: $apk; pm install -r $apk; done"
adb shell "for apk in %1/*.apk; do echo App: $apk; pm install -r $apk; done"

set /A INSTALL_COUNT=INSTALL_COUNT+1

:install_apps_in_device__stop
echo.
exit /b  REM return to 'call' position
)

:force_close_app_drawers
echo # 기기에서 '앱 서랍' 앱을 강제 종료할 수 있습니다.
echo ^- 강제 종료 후 재실행할 때 앱 목록이 새로고침됩니다.
echo ^- E-Ink Launcher(이잉크 런처)로 교체한 r12 버전부터는 필요하지 않습니다!
echo.

set AREYOUSURE=N
SET /P AREYOUSURE=^'앱 서랍^' 앱들을 강제 종료할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO finish

echo ^> adb shell am force-stop be.wazabe.appdrawer
adb shell am force-stop be.wazabe.appdrawer
echo ^> adb shell am force-stop au.radsoft.appdrawer
adb shell am force-stop au.radsoft.appdrawer
echo.

:finish
echo # 모든 앱 파일에 대해 설치 명령을 진행했습니다! 엔터 키 또는 아무 키나 눌러 종료하세요.
pause
goto _exit


:get_app_pkg_name <apk_path>
(
echo       - 앱 이름
aapt d badging "apps\%~nx1" 2>&1 | findstr /rc:"^application-label:\'.*\'"
echo       - 패키지 이름
aapt d badging "apps\%~nx1" 2>&1 | findstr /rc:"^package: name="
echo.

exit /b  REM return to 'call' position
)

:_exit
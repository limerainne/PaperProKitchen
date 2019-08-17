@echo off
chcp 949 1> NUL 2> NUL
set "PATH=%~dp0\bin;%~dp0\tools;%PATH%"
setlocal enabledelayedexpansion enableextensions

cd %~dp0
pushd %~dp0
title Ridibooks Paper Pro Kitchen # 열린서재 준비 도구

echo =========================================
echo Ridi Paper Pro Kitchen r13_1
echo.
echo - 안내서
echo https://cafe.naver.com/bookbook68912/770
echo - 배포용 저장소
echo https://github.com/limerainne/PaperProKitchen
echo =========================================

:detect_os_arch
REM default value
set ASK_WIN7_DRVTWK=0
set USE_DPINST=1
set OS=64BIT
set DRV_W8A_UTIL_EXIST=1

REM https://helloacm.com/windows-batch-script-to-detect-windows-version/
for /f "tokens=2 delims=[]" %%i in ('ver') do set VERSION=%%i
for /f "tokens=2-3 delims=. " %%i in ("%VERSION%") do set VERSION=%%i.%%j
if "%VERSION%" == "6.0" ( 
  REM echo Windows Vista
  set USE_DPINST=1
  set ASK_WIN7_DRVTWK=1
)
if "%VERSION%" == "6.1" ( 
  REM echo Windows 7
  set USE_DPINST=1
  set ASK_WIN7_DRVTWK=1
)
if "%VERSION%" == "6.2" ( 
  REM echo Windows 8
  set USE_DPINST=1
)
if "%VERSION%" == "6.3" ( 
  REM echo Windows 8.1
  set USE_DPINST=1
)
if "%VERSION%" == "10.0" ( 
  REM echo Windows 10
  set USE_DPINST=0
)

REM https://stackoverflow.com/questions/12322308/batch-file-to-check-64bit-or-32bit-os
REM http://www.robvanderwoude.com/condexec.php
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
REM echo %OS%

REM check if powershell, (pnputil), infdefaultinstall exist
where powershell > NUL
IF %ERRORLEVEL% NEQ 0 set DRV_W8A_UTIL_EXIST=0
REM where pnputil > NUL
REM IF %ERRORLEVEL% NEQ 0 set DRV_W8A_UTIL_EXIST=0
where infdefaultinstall > NUL
IF %ERRORLEVEL% NEQ 0 set DRV_W8A_UTIL_EXIST=0



REM DEBUG
REM goto 4_2_choose_image
REM goto 6_wait_for_the_job


:0_enable_win7_driver_friendly_tweak

if %ASK_WIN7_DRVTWK% EQU 0 goto 0_notice_first_boot_app_install

echo ==== 0. Win7 드라이버 설치 편의 위한 트윅 ====
echo.
echo Windows 7인 경우, 드라이버 수동 설치를 피하기 위한 트윅을 활성화할 수 있습니다.
echo ^* 루트 이미지인 경우에만 해당합니다. ADB만 활성화한 경우는 트윅이 적용되지 않습니다.
echo.
echo 루트 도구 폴더에 있는 ".win7" 파일을 기기의 내부저장소 최상위 위치에 넣어주세요.
echo.
pause

:0_notice_first_boot_app_install

echo ==== 0. 첫 부팅 시 앱 자동 설치 기능 ====
echo.
echo 기기 내부 저장소에 "Apps" 폴더를 만들고 그 안에 설치할 앱 파일들을 미리 넣어두면,
echo 루트 작업을 마친 후 정상 부팅된 뒤 넣은 앱들을 알아서 설치합니다.
echo.
echo * "Apps" 폴더 이름은 대소문자를 지켜 만들어주세요.
echo * 앱 자동 설치 기능은 세 번째 정상 부팅 때 삭제됩니다.
echo   ^- 설치 작업이 끝나면 "Apps" 폴더 안에 ".installed" 파일을 만들어 둡니다. 이 파일이 있으면 자동 설치 기능이 동작하지 않습니다.
echo * 주의^: ADB만 여는 이미지에는 없는 기능입니다.
echo.


:1_install_driver
echo ==== 1. Google ADB 드라이버 설치 ====
echo.
set DRIVER_PATH=drivers\GoogleUSBDriver
if %USE_DPINST% EQU 1 (
  REM install driver using DPINST tool
  echo DPInst 도구를 이용해 드라이버를 설치합니다. 아무키나 누르면 나타날
  echo ^- 관리자 권한 승인 창에서 권한 사용을 허락하고
  echo ^- 나타날 DPInst 도구 창의 설명을 따라 진행해주세요.
  pause
  if %OS% == 32BIT (
    start /wait %DRIVER_PATH%\DPINST_x86.exe
  ) else if %OS% == 64BIT (
    start /wait %DRIVER_PATH%\DPINST_x64.exe
  )
) else (
  REM install driver using pnputil + powershell to elevate
  REM https://stackoverflow.com/questions/22496847/installing-a-driver-inf-file-from-command-line
  REM 'pnputil -i -a <PATH_TO_DRIVER_INF>
  REM => it seems not reliable...

  REM install driver using 'infdefaultinstall' same as right click -> install
  REM 'infdefaultinstall' <path/to/inf>
  
  if %DRV_W8A_UTIL_EXIST% == 1 (
    echo 드라이버를 설치합니다. 아무키나 누르면 나타날..
    echo ^- 관리자 권한 승인 창^(^"INF Default Install^"^)에서 권한 사용을 허락한 뒤
    echo ^- 잠시 후 나타날 설치 완료 메시지를 확인하세요.
    pause
    REM powershell -command "start-process cmd -argumentlist '/c','pnputil','-i','-a','%cd%\%DRIVER_PATH%\android_winusb.inf','&','pause' -verb runas -wait"
    infdefaultinstall "%cd%\%DRIVER_PATH%\android_winusb.inf"
  ) else (
    echo 다음 윈도 탐색기 창에서 드라이버를 직접 설치해 주세요.
    echo android_winusb.inf 파일에서 오른쪽 클릭 ^> 설치
    
    start /wait explorer %cd%\%DRIVER_PATH%
    
    echo 설치를 마치셨다면 계속 진행해주세요.
    pause
  )
)
REM NOTE 괄호짝 잘 맞출 것...

echo.
echo 혹시 드라이버 설치를 다시 시도해야 하나요?
echo 그렇다면 Y를 입력하고 엔터 키를, 다음 단계로 가려면 엔터 키를 누르세요.

set AREYOUSURE=N
SET /P AREYOUSURE=다시 설치할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 1_install_driver

echo.


:2_start_devmgmt
echo ==== 2. 장치 관리자 열어두기 ====
echo.
echo 곧 나타날 장치 관리자 창에서 장치 정상 인식 여부를 확인하세요.
echo 장치 관리자 창은 닫지 마시고 절차가 끝날 때까지 그대로 두어 주세요.
echo.
echo * 창을 닫으셨더라도 다시 띄울 수 있습니다:
echo ^- 루트 도구에 들어 있는 "_open_devmgmt.cmd" 실행
echo ^- 시작 버튼 오른쪽 클릭 ^> "장치 관리자" 선택
echo ^- [시작] ^> [실행] 창에 "devmgmt.msc" 입력 후 [확인] 버튼 클릭
start devmgmt.msc
pause

echo.


:3_shutdown_device
echo ==== 3. 기기 전원 끄기 ====
echo.
echo 기기를 USB 케이블로 PC에 연결해두세요. 원활한 인식을 위해 다음을 권장합니다:
echo ^- 좋은 USB 케이블: 리디 번들, 휴대폰 제조사 정품, ...
echo ^- PC에 직접 연결 (USB 허브 대신), 데스크탑이면 뒷면 포트
echo.
echo 기기가 켜진 상태에서 전원 버튼을 꾹 눌러 기기 종료 메뉴를 띄우고 [확인]을 눌러 기기 전원을 끄세요.
echo.
pause

echo.


:4_reboot_into_fastboot
echo ==== 4. Fastboot 모드로 기기 시작 ====
echo.
echo 전면 물리 버튼 중 우상단 버튼과 기기 상단 전원 버튼을 동시에 누르고 계세요.
echo 전원 버튼 왼쪽의 전원 LED가 잠시 옅은 초록빛이었다가 우윳빛 하얀색으로 바뀌면 두 버튼에서 손을 떼세요.
echo.
pause

echo.


:5_boot_with_image
echo ==== 5. 루트 이미지로 부팅 ====
echo.
echo 도움글의 스크린샷과 비슷하게 장치 관리자에 기기가 인식되었나요? 그렇지 않다면,
echo ^- USB 케이블을 바꿔보거나,
echo ^- PC의 다른 USB 포트를 사용해 보세요.

:5_1_fastboot_devices
echo.
echo -- Fastboot 프로그램이 인식한 기기 목록 --
echo ^> fastboot devices
fastboot devices
echo.

echo 위 목록에 기기가 있나요? 계속하려면 Y를 입력하고 엔터 키를, 목록을 새로고치려면 엔터 키를 누르세요.

set AREYOUSURE=N
SET /P AREYOUSURE=계속 진행할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO 5_1_fastboot_devices

:5_2_choose_image
echo -- 사용할 수 있는 루트 이미지 --
echo 1. 루트 + 기본 앱 설치
echo 2. 루트 + 필요한 최소 앱만 설치 (소프트키, 앱 서랍)
echo 3. 루트만 진행
echo ---
echo 4. ADB만 활성화 (업데이트 후 ADB 유지 없음)
echo.

set RECV_IMAGE=0
SET /P RECV_IMAGE=사용할 이미지 번호를 입력하고 엔터 키를 누르세요 [1-4]: 
echo.
IF /I "%RECV_IMAGE%" GEQ "5" GOTO 5_2_choose_image
IF /I "%RECV_IMAGE%" LEQ "0" GOTO 5_2_choose_image

set RECV_IMAGE_PATH=images
if /I "%RECV_IMAGE%" == "1" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/openlib_r13_full.img
) else if /I "%RECV_IMAGE%" == "2" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/openlib_r13_light.img
) else if /I "%RECV_IMAGE%" == "3" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/openlib_r13_basic.img
) else if /I "%RECV_IMAGE%" == "4" (
set RECV_IMAGE_PATH=%RECV_IMAGE_PATH%/open_adb_only_r1.img
)

echo 선택한 이미지가 맞나요? 맞다면 Y를 입력하고 엔터 키를, 아니라면 엔터 키를 눌러 다시 선택하세요.
echo ^# !RECV_IMAGE!번 이미지
echo ^> !RECV_IMAGE_PATH!
echo.

set AREYOUSURE=N
SET /P AREYOUSURE=계속 진행할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" NEQ "Y" GOTO 5_2_choose_image

:5_3_fastboot_boot_with_chosen_image

echo ^> fastboot boot %RECV_IMAGE_PATH%
fastboot boot %RECV_IMAGE_PATH%
echo.

echo 'downloading', 'booting', 'finished' 메시지가 차례로 떴나요? 그렇지 않아서 다시 시도하려면 Y를 입력하고 엔터 키를, 다음으로 넘어가려면 엔터 키를 누르세요.
set AREYOUSURE=N
SET /P AREYOUSURE=Fastboot 명령을 다시 내릴까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO 5_3_fastboot_boot_with_chosen_image


:6_wait_for_the_job
echo ==== 6. 이제 기다려주세요 ====
echo.
echo 기기 화면이 깜빡인 뒤, 선택한 이미지에 따라 잠시 아래와 같은 화면이 표시된 뒤 (화면 표시 후 최대 1분 소요)
echo.
echo   ^- 루트 이미지^: 업데이트 패키지 설치 화면 ^+ 로고 옆 꽃 그림 ^+ '열린서재' 문구
echo   ^- ADB 이미지^: 화면 위에 작은 'recovery' 메뉴 글씨
echo.
echo 화면이 다시 깜빡이고 리디 로고가 뜨면서 정상 부팅됩니다.
echo.
echo 작업 완료 후 기기가 정상 부팅되어 리디 앱 서재 화면이 표시되었나요?
echo 이제 아무 키나 눌러 마지막 단계로 넘어가주세요.
pause

echo.

:7_check_for_adb_recognization
echo ==== 7. ADB 인식 점검 ====
echo.
echo 이전에 실행중인 ADB 서버가 있다면 강제 종료하고, 다시 시작합니다.
adb kill-server > NUL 2>&1
adb start-server

echo.
echo -- ADB 프로그램이 인식한 기기 목록 --
adb devices
echo.

echo 위 목록에 기기가 나타나지 않는 경우,
echo ^- 장치 관리자를 확인해 보니 기기가 정상 설치되지 않은 경우,
echo    ^-^> 장치 관리자에서 드라이버를 수동 설치하세요.
echo ^- 장치 관리자에서는 정상 인식되지만 위 목록에 뜨지 않는 경우,
echo    ^-^> 루트 도구 폴더에 있는 "_add_vendor_to_adb_usb_ini.cmd" 파일을 실행하세요.
echo.
echo 위 항목에 기기가 있나요? 계속하려면 Y를 입력하고 엔터 키를, 목록을 새로고치려면 엔터 키를 누르세요.

set AREYOUSURE=N
SET /P AREYOUSURE=계속 진행할까요? [Y/[N]]: 
echo.
IF /I "!AREYOUSURE!" EQU "Y" GOTO finish

goto 7_check_for_adb_recognization

:finish

echo 작업이 모두 끝난 것 같습니다. 창을 닫으셔도 좋습니다.
echo.

cmd /K
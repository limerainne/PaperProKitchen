@echo off
PUSHD %~DP0
setlocal enabledelayedexpansion enableextensions

title ROM Signer
echo Welcome to ROM Signer^^!
echo by haoyangw@xda, modified by Limerainne
echo.

set tools_path=%~dp0\ROM_Signer

REM check if required files, Java JRE are exist
if not exist "%tools_path%\testkey.x509.pem" (
      echo key is NOT found
      echo File signing Aborted!
      echo Grab all required files from the main thread and come back again!
      echo Press any key to exit
      pause>nul
      exit 1
)
if not exist "%tools_path%\testkey.pk8" (
      echo key is NOT found
      echo File signing Aborted!
      echo Grab all required files from the main thread and come back again!
      echo Press any key to exit
      pause>nul
      exit 1
)
if not exist "%tools_path%\signapk.jar" (
      echo signapk.jar is NOT found
      echo File signing Aborted!
      echo Grab all required files from the main thread and come back again!
      echo Press any key to exit
      pause>nul
      exit 1
)

java -version 2>/nul
if errorlevel==2 (
      echo Java cannot be executed...
      echo File signing Aborted!
      echo Press any key to exit
      pause>nul
      exit 1
)
REM end of check the environment

if "%~1" == "" (
  :ChoosePath
  set /p TARGET="Path to signing target (ZIP, APK, JAR) > "
)  else (
  set TARGET=%~1
)

if not exist "%TARGET%" (
  echo Target file is nonexist^^!
  echo.
  goto ChoosePath
)

call :path_from_full_loc TARGET_PATH "!TARGET!"
call :filename_wo_ext_from_full_loc TARGET_FILENAME "!TARGET!"
call :fileext_from_full_loc TARGET_EXT "!TARGET!"

echo Target file to be signed:
echo   %TARGET%
echo     with key from:
echo     %tools_path%\testkey.x509.pem
echo.

java -Xmx1024m -jar %tools_path%\signapk.jar -w %tools_path%\testkey.x509.pem %tools_path%\testkey.pk8 "%TARGET%" "!TARGET_PATH!!TARGET_FILENAME!-signed!TARGET_EXT!"

echo.
echo File Signing operation succeeded if no errors above^^!
echo Path to signed file is ('-signed' after original filename):
echo   !TARGET_PATH!!TARGET_FILENAME!-signed!TARGET_EXT!
echo.

echo Press any key to exit...
pause>nul
exit

:path_from_full_loc <resultVar> <pathVar>
(
    set %~1=%~dp2
    exit /b
)
:filename_wo_ext_from_full_loc <resultVar> <pathVar>
(
    set %~1=%~n2
    exit /b
)
:fileext_from_full_loc <resultVar> <pathVar>
(
    set %~1=%~x2
    exit /b
)
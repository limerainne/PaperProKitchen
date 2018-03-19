@echo off
title ROM Signer by haoyangw@xda
Color 2
echo Welcome to ROM Signer!
echo Press any key to continue!
pause>nul
mkdir signed 2>/nul
if not exist "testkey.x509.pem" (
      echo testkey is NOT found
      echo File signing canNOT proceed
      echo Grab all required files from the main thread and come back again!
      echo Press any key to exit
      pause>nul
      exit 69
)
if not exist "testkey.pk8" (
      echo testkey is NOT found
      echo File signing Aborted!
      echo Grab all required files from the main thread and come back again!
      echo Press any key to exit
      pause>nul
      exit 69
)
if not exist "signapk.jar" (
      echo signapk.jar is NOT found
      echo File signing Aborted!
      echo Grab all required files from the main thread and come back again!
      echo Press any key to exit
      pause>nul
      exit 69
)
set /p sign= Please Enter the name of the zip/jar/apk that you want to sign:
echo Press any key to continue
pause>nul
java -version 2>/nul
if errorlevel==2 (
	echo  Java is NOT Installed in system32
        set /p Java= Please enter the path to Portable Java:
        goto nojava
) else ( echo  Java is installed in system32... nice!
)
set /p enter= Time to start signing... Press the enter key!
java -Xmx1024m -jar signapk.jar -w testkey.x509.pem testkey.pk8 "%sign%.zip" "signed\%sign%-signed.zip"
echo File Signing operation succeeded if no errors above!
echo Check the "signed" folder for signed files!
echo Hit any key to exit!
pause>nul
exit
:nojava
set /p enter= Time to start signing... Press the enter key!
"%Java%\java" -Xmx1024m -jar signapk.jar -w testkey.x509.pem testkey.pk8 "%sign%.zip" "signed\%sign%-signed.zip"
echo File Signing operation succeeded if no errors above!
echo Check the "signed" folder for signed files!
echo Hit any key to exit!
pause>nul
exit

        
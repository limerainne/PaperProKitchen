@echo off
if "%PATH_BASE%" == "" set PATH_BASE=%PATH%
set PATH=%CD%;%PATH_BASE%;
java -jar -Duser.language=en -Dfile.encoding=UTF8 "%~dp0\..\bin\apktool.jar" %*

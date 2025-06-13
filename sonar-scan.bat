
@echo off

@REM set local scope for the variables with windows NT shell
@setlocal

if not "%SONAR_SCANNER_HOME%" == "" goto foundHome

:foundHome
if EXIST "%SONAR_SCANNER_HOME%\bin\sonar-scanner.bat" go foundBatFromHome

:foundBatFromHome
set SCANNER_BAT="%SONAR_SCANNER_HOME%\bin\sonar-scanner.bat"

if "%2" == "C++" goto checkCPPCheck
if "%2" == "c++" goto checkCPPCheck
if "%2" == "C#" goto checkMSBuild
if "%2" == "c#" (goto checkMSBuild) else (goto runOther)

:checkCPPCheck
echo ........
echo Run C++ Project Scanning
echo ........

if not "%CPPCHECK_HOME%" == "" goto foundCPPCheckHome
:foundCPPCheckHome
if EXIST "%CPPCHECK_HOME%\cppcheck.exe" goto runCPPCheck
echo ........
echo Error: %CPPCHECK_HOME%\cppcheck.exe NOT found.
echo ........

@REM ==== CPP Check ====
:runCPPCheck
cppcheck --enable=all --xml --xml-version=2 ./ 2>cppcheck-result.xml

@REM ==== Start Run ====
:runSonarScanForCPP
%SCANNER_BAT% -D sonar.login= -D sonar.projectKey=%1 -D sonar.projectName=%1 -D sonar.language=%2 -D sonar.sourceEncoding=UTF-8 -D sonar.source=./ -D sonar.projectBaseDir=./ -D sonar.host.url=http://localhost:9000/ -D sonar.cxx.cppcheck.reportPaths=cppcheck-result.xml -D sonar.cxx.includeDirectories=/
goto end

:checkMSBuild
echo ........
echo Run C# Project Scanning
echo ........

if not "%MSBUILD_HOME%" == "" goto foundMSBuild
:foundMSBuild
if EXIST "%MSBUILD_HOME%\MSBuild.exe" goto runCSBegin
echo ........
echo Error: %MSBUILD_HOME%\MSBuild.exe NOT found.
echo ........
goto end

:runCSBegin
SonarScanner.MSBuild.exe begin /key:%1 /name:%1 /d:sonar.language=c# /d:sonar.login= /d:sonar.host.url=http://localhost:9000/

:runMSBuild
MSBuild.exe /t:Rebuild

:runCSEnd
SonarScanner.MSBuild.exe end /d:sonar.login=
goto end

:runOther
echo ........
echo Run %2 Project Scanning
echo ........
%SCANNER_BAT% -D sonar.login= -D sonar.projectKey=%1 -D sonar.projectName=%1 -D sonar.language=%2 -D sonar.sourceEncoding=UTF-8 -D sonar.source=./ -D sonar.projectBaseDir=./ -D sonar.host.url=http://localhost:9000/

:end

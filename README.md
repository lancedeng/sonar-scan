# sonar-scan
Sonar Scan script for C++ and C# on Windows

## Prerequisites
1. SonarQube 9.9.8 has been installed, and long-term access token has been generated.
2. Java 17 is required to be installed as Sonar Scanner need, environment variable JAVA_HOME is needed to be added.
2. sonar-scanner-cli-7.0.2.4839-windows-x64.zip is to be extracted, and environment variable SONAR_SCANNER_HOME is to be added to point to the extracted directory.
3. sonar-scanner-msbuild-5.15.1.88158-net46.zip is to be extracted, and add the directory path to the environment variable PATH.
4. Find the path of MSBuild.exe and append it to the environment variable PATH if Visual Studio has been installed, like D:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin.
5. Install cppcheck-2.17.1-x64-Setup.msi, and add environment variable CPPCHECK_HOME which points to the directory CPPCheck installed, and append %CPPCHECK_HOME% to the environment variable PATH.

## Usage
1. Edit the sonar-scan.bat, 
   - append the long-term access token to the end of "sonar.login=".
   - check the "sonar.host.url" to the actual url.
2. Go to the root directory of source to be scanned, run the bat with 1st param to be the project name and 2nd as language, for example: D:\tools\sonar-scan.bat test c#
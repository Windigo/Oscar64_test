@echo off
setlocal

set "ROOT_DIR=%~dp0"
if "%ROOT_DIR:~-1%"=="\" set "ROOT_DIR=%ROOT_DIR:~0,-1%"

set "BUILD_DIR=%ROOT_DIR%\build"
if "%PREFIX%"=="" set "PREFIX=%LOCALAPPDATA%\oscar64"

where cmake >nul 2>nul
if errorlevel 1 (
  echo CMake was not found in PATH.
  echo Install CMake and rerun this script.
  exit /b 1
)

cmake -S "%ROOT_DIR%" -B "%BUILD_DIR%" -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 exit /b 1

cmake --build "%BUILD_DIR%" --config Release
if errorlevel 1 exit /b 1

cmake --install "%BUILD_DIR%" --prefix "%PREFIX%"
if errorlevel 1 exit /b 1

if not exist "%BUILD_DIR%\include" (
  mklink /D "%BUILD_DIR%\include" "%ROOT_DIR%\include" >nul
)

echo Installed Oscar64 to %PREFIX%
echo Add %PREFIX%\bin to PATH to use oscar64 from the shell.
endlocal
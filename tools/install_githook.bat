@echo off

setlocal enabledelayedexpansion

REM Determine the project root directory
set "ROOT_DIR=%~dp0.."

REM Create the hooks directory if it doesn't exist
set "HOOKS_DIR=%ROOT_DIR%\.git\hooks"
if not exist "%HOOKS_DIR%" (
  mkdir "%HOOKS_DIR%"
)

REM Register the hook script
set "HOOK_NAME=pre-commit"
set "HOOK_CMD=%ROOT_DIR%\tools\pre-commit.sh"
set "HOOK_FILE=%HOOKS_DIR%\%HOOK_NAME%"

(
echo #^^!/bin/sh
echo # Check if there are changes in client/Scripts directory
echo if git diff --cached --name-only --diff-filter=ACM ^| grep -q "^client/Scripts/"; then
echo     echo "Compressing client/Scripts directory"
echo     ruby tools/rxscript.rb compress
echo else
echo     echo "No changes in client/Scripts directory"
echo fi
echo exit 0
) > "%HOOK_FILE%"
echo Registered hook: %HOOK_NAME%

REM Exit with a zero status to indicate success
exit /b 0

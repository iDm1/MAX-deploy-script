@ECHO OFF
CLS
SET "TITLE=Скачивание MAX"
SET "MYPATH=%~dp0"
SET "YEAR=%DATE:~-4,4%"
SET "MONTH=%DATE:~-7,2%"
SET "DAY=%DATE:~-10,2%"
SET "SOURCE=https://trk.mail.ru/c/h172vv5"
REM SET "SOURCE=https://download.cdn.oneme.ru/win/release/MAX.msi"
SET "PACKAGE=MAX.msi"
SET "TEMPFILE=%MYPATH%%YEAR%-%MONTH%-%DAY%-%PACKAGE%"
SET "TARGET=%MYPATH%%PACKAGE%"

ECHO.
TITLE %TITLE%
ECHO %TITLE%

ECHO.
CD /D "%TEMP%"
POWERSHELL.EXE -NoProfile -Command "Invoke-WebRequest -Uri '%SOURCE%' -OutFile '%TEMPFILE%'"
IF ERRORLEVEL 1 GOTO :error
MOVE /Y "%TEMPFILE%" "%TARGET%"

:done
TITLE %TITLE% - Готово!
RUNDLL32 user32.dll,MessageBeep
COLOR 0A
ECHO.
ECHO  Готово! Выход через 3 секунды...
TIMEOUT /T 3 >NUL
EXIT /B 0

:error
TITLE %TITLE% - Ошибка!
RUNDLL32 user32.dll,MessageBeep
COLOR 0C
ECHO.
ECHO  Ошибка! Выход через 3 секунды...
TIMEOUT /T 3 >NUL
EXIT /B 1
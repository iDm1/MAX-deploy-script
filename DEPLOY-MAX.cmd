@ECHO OFF
CLS
SET "TITLE=Установка MAX"
SET "MYPATH=%~dp0"
SET "SOURCE="
SET "PACKAGE=MAX.msi"
SET "TARGET=%LOCALAPPDATA%\Programs\MAX"
SET "TMPDIR=%TARGET%\tmp"
SET "LNKPATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\MAX.lnk"

IF NOT EXIST "%SOURCE%%PACKAGE%" NET USE "%SOURCE%" /USER:Guest
IF NOT EXIST "%SOURCE%%PACKAGE%" SET "SOURCE=%MYPATH%"
IF NOT EXIST "%SOURCE%%PACKAGE%" ECHO  %PACKAGE% не найден! & EXIT /B 1

COLOR 03
TITLE %TITLE%
ECHO  %TITLE%
ECHO ________________________________________________________________________
ECHO.
ECHO                             ################                     
ECHO                         ########################                 
ECHO                       #############################              
ECHO                     #################################            
ECHO                   ####################################           
ECHO                  ######################################          
ECHO                 ################        ################         
ECHO                ##############              ##############        
ECHO                #############                 ############        
ECHO               #############                   ############       
ECHO               ############                    ############       
ECHO               ############                     ###########       
ECHO               ############                    ############       
ECHO               ############                    ############       
ECHO               ############                   ############        
ECHO                ###########                 ##############        
ECHO                ############  ###        ################         
ECHO                 #######################################          
ECHO                 ######################################           
ECHO                  ###################################             
ECHO                  #################################               
ECHO                  ###############################                 
ECHO                  ########    ###############                     
ECHO ________________________________________________________________________
ECHO.
ECHO  Подождите...

TASKKILL /F /IM max.exe >NUL 2>&1
TASKKILL /F /IM max-service.exe >NUL 2>&1
TIMEOUT /T 3 /NOBREAK >NUL

RMDIR /S /Q "%TARGET%"
MKDIR "%TARGET%"
MKDIR "%TMPDIR%"

MSIEXEC.EXE /a "%SOURCE%%PACKAGE%" /qb TARGETDIR="%TMPDIR%"
IF NOT EXIST "%TMPDIR%\MAX" ECHO  Ошибка извлечения файлов! & TIMEOUT /T 3 >NUL & EXIT 1
ROBOCOPY "%TMPDIR%\MAX" "%TARGET%" /MOVE /E /NFL /NDL /NJH /NJS /ETA
RMDIR /S /Q "%TMPDIR%"

POWERSHELL.EXE -Command "$sh=(New-Object -COM WScript.Shell).CreateShortcut('%LNKPATH%');$sh.TargetPath='%TARGET%\max.exe';$sh.Save()"

TITLE %TITLE% - Готово!
RUNDLL32 user32.dll,MessageBeep
ECHO.
ECHO  Готово! Выход через 3 секунды...
TIMEOUT /T 3 >NUL

EXIT /B

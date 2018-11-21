:: ExclamationMarkGame by Addison Djatschenko
:: Version 1.7.2

@echo off
title ExclamationMarkGame!
goto start

:start
cls
echo Are you ready?
echo WASD to move,
echo O to eat the !
echo P to pause.
echo. 
pause
cls
set coord.1.1= 
set coord.1.2= 
set coord.1.3= 
set coord.1.4= 
set coord.1.5= 
set coord.2.1= 
set coord.2.2= 
set coord.2.3= 
set coord.2.4= 
set coord.2.5= 
set coord.3.1= 
set coord.3.2= 
set coord.3.3=+
set coord.3.4= 
set coord.3.5= 
set coord.4.1= 
set coord.4.2= 
set coord.4.3= 
set coord.4.4= 
set coord.4.5= 
set coord.5.1= 
set coord.5.2= 
set coord.5.3= 
set coord.5.4= 
set coord.5.5= 
set yCoord=3
set xCoord=3
set points=0
set gameTick=-1
set highScore=-1
set hesitations=0
:firstGoalGeneration1
set /a goalYCoord=%random:~-1,1%
if %goalYCoord% GEQ 5 goto firstGoalGeneration1
if %goalYCoord%==0 goto firstGoalGeneration1
:firstGoalGeneration2
set /a goalXCoord=%random:~-1,1%
if %goalXCoord% GEQ 5 goto firstGoalGeneration2
if %goalXCoord%==0 goto firstGoalGeneration2
(
@echo off
echo set coord.%goalYCoord%.%goalXCoord%=!
echo. 
)>tmp.bat
call tmp.bat
goto gameTick

:playing
:goalGeneration1
set /a potentialGoalYCoord=%random:~-1,1%
if %potentialGoalYCoord% GEQ 5 goto goalGeneration1
if %potentialGoalYCoord%==0 goto goalGeneration1
:goalGeneration2
set /a potentialGoalXCoord=%random:~-1,1%
if %potentialGoalXCoord% GEQ 5 goto goalGeneration2
if %potentialGoalXCoord%==0 goto goalGeneration2
set originalYCoord=%yCoord%
set originalXCoord=%xCoord%
set /a countdown=100-%gameTick%
set /a expectedScore=%points% * 100 / %gameTick%
cls
echo Chase the exclamation marks!
echo Points: %points%
echo Countdown: %countdown%
echo Hesitations: %hesitations%
echo Expected score: %expectedScore%
echo. 
echo  -----
echo ^|%coord.1.1%%coord.1.2%%coord.1.3%%coord.1.4%%coord.1.5%^|
echo ^|%coord.2.1%%coord.2.2%%coord.2.3%%coord.2.4%%coord.2.5%^|
echo ^|%coord.3.1%%coord.3.2%%coord.3.3%%coord.3.4%%coord.3.5%^|
echo ^|%coord.4.1%%coord.4.2%%coord.4.3%%coord.4.4%%coord.4.5%^|
echo ^|%coord.5.1%%coord.5.2%%coord.5.3%%coord.5.4%%coord.5.5%^|
echo  -----
echo Your Coordinates: %xCoord%, %yCoord%
choice /c 0wasdpo /t 1 /d 0 >nul
if %ERRORLEVEL%==1 (
set /a hesitations=%hesitations%+1
goto gameTick
)
if %ERRORLEVEL%==2 goto moveForward
if %ERRORLEVEL%==3 goto moveLeft
if %ERRORLEVEL%==4 goto moveBackward
if %ERRORLEVEL%==5 goto moveRight
if %ERRORLEVEL%==6 goto paused
if %ERRORLEVEL%==7 goto gameTick
goto playing

:paused
cls
echo GAME PAUSED!
echo Points: %points%
echo Countdown: %countdown%
echo Hesitations: %hesitations%
echo Expected score: %expectedScore%
echo. 
pause
goto playing

:moveForward
set /a yCoord=%yCoord%-1
if %yCoord%==0 set yCoord=1
goto gameTick

:moveLeft
set /a xCoord=%xCoord%-1
if %xCoord%==0 set xCoord=1
goto gameTick

:moveBackward
set /a yCoord=%yCoord%+1
if %yCoord%==6 set yCoord=5
goto gameTick

:moveRight
set /a xCoord=%xCoord%+1
if %xCoord%==6 set xCoord=5
goto gameTick

:gameTick
(
@echo off
echo set coord.%originalYCoord%.%originalXCoord%= 
echo set coord.%yCoord%.%xCoord%=+
echo if %yCoord%==%goalYCoord% if %xCoord%==%goalXCoord% (
echo set goalYCoord=%potentialGoalYCoord%
echo set goalXCoord=%potentialGoalXCoord%
echo set coord.%potentialGoalYCoord%.%potentialGoalXCoord%=!
echo set /a points=%points%+1
echo ^)
echo. 
)>tmp.bat
call tmp.bat
del tmp.bat
set /a gameTick=%gameTick%+1
if %gameTick%==100 goto gameOver
goto playing

:gameOver
set hour=%time:~0,2%
set m=AM
if %hour% GEQ 11 (
set m=PM
set /a hour=%hour%-12
)
set minute=%time:~3,2%
set day=%date:~4,2%
set monthNumber=%date:~7,2%
if %monthNumber%==01 set month=Jan
if %monthNumber%==02 set month=Feb
if %monthNumber%==03 set month=Mar
if %monthNumber%==04 set month=Apr
if %monthNumber%==05 set month=May
if %monthNumber%==06 set month=Jun
if %monthNumber%==07 set month=Jul
if %monthNumber%==08 set month=Aug
if %monthNumber%==09 set month=Sep
if %monthNumber%==10 set month=Oct
if %monthNumber%==11 set month=Nov
if %monthNumber%==12 set month=Dec
set year=%date:~-4,4%
set modifiedTime=%hour%:%minute% %m%
set modifiedDate=%day% %month% %year%
cls
echo GAME OVER!
echo. 
echo Your Score: %points%
echo Hesitations: %hesitations%
echo. 
echo What is your name?
set /p name="--> "
call data.bat
if "%highScoreHesitations%"=="" set highScoreHesitations=unknown
cls
if %points%==%highScore% (
echo You matched the high score! (%highScore%^) by %highScoreName% on %highScoreEpoch% with %highScoreHesitations% hesitations.
goto end
)
if %points% GEQ %highScore% goto highScore
echo You didn't beat the high score (%highScore%) by %highScoreName% on %highScoreEpoch% with %highScoreHesitations% hesitations.
:end
echo Press any key to exit...
pause>nul
exit

:highScore
echo You have the high score!
if %highScore%==-1 goto save
echo Previous record: %highScore% by %highScoreName% on %highScoreEpoch% with %highScoreHesitations% hesitations.
:save
(
@echo off
echo set highScore=%points%
echo set highScoreName=%name%
echo set highScoreEpoch=%modifiedTime% on %modifiedDate%
echo set highScoreHesitations=%hesitations%
echo. 
)>data.bat
goto end
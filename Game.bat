:: Game by Addison Djatschenko
:: Version 1.0

@echo off
title Game!
mode 1000
goto start

:start
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
set gameTick=0
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
cls
echo Chase the exclamation marks!
echo Points: %points%
echo Countdown: %countdown%
echo. 
echo  -----
echo ^|%coord.1.1%%coord.1.2%%coord.1.3%%coord.1.4%%coord.1.5%^|
echo ^|%coord.2.1%%coord.2.2%%coord.2.3%%coord.2.4%%coord.2.5%^|
echo ^|%coord.3.1%%coord.3.2%%coord.3.3%%coord.3.4%%coord.3.5%^|
echo ^|%coord.4.1%%coord.4.2%%coord.4.3%%coord.4.4%%coord.4.5%^|
echo ^|%coord.5.1%%coord.5.2%%coord.5.3%%coord.5.4%%coord.5.5%^|
echo  -----
choice /c 0wasd /t 1 /d 0 >nul
if %ERRORLEVEL%==1 goto gameTick
if %ERRORLEVEL%==2 goto moveForward
if %ERRORLEVEL%==3 goto moveLeft
if %ERRORLEVEL%==4 goto moveBackward
if %ERRORLEVEL%==5 goto moveRight
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
cls
echo GAME OVER!
echo. 
echo Your Score: %points%
echo. 
timeout /t 3 >nul
echo Press any key to exit...
pause>nul
exit
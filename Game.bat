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
goto playing

:playing
cls
echo  -----
echo ^|%coord.1.1%%coord.1.2%%coord.1.3%%coord.1.4%%coord.1.5%^|
echo ^|%coord.2.1%%coord.2.2%%coord.2.3%%coord.2.4%%coord.2.5%^|
echo ^|%coord.3.1%%coord.3.2%%coord.3.3%%coord.3.4%%coord.3.5%^|
echo ^|%coord.4.1%%coord.4.2%%coord.4.3%%coord.4.4%%coord.4.5%^|
echo ^|%coord.5.1%%coord.5.2%%coord.5.3%%coord.5.4%%coord.5.5%^|
echo  -----
choice /c 0wasd /n /t 1 /d 0 >nul
goto playing
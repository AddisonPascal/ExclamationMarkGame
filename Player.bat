@echo off
title Recorded game player
set tick=0
:a
cls
type Recorded\%tick%.txt
set /a tick=%tick%+1
::timeout /t 1
timeout /t 1 >nul
goto a
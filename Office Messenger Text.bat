@ECHO OFF
REM Author: Dean Sofer (ProLoser)
REM Created: 8/3/09
REM Version: 1.0
SET config="Office Manager.dat"

:main 
	CALL :title "            Office Net Send Messenger"
	ECHO If this is your first time running this program,
	ECHO please type "/start" without quotes at the next 
	ECHO available prompt
	ECHO.
	PAUSE
	GOTO list
   
:help
   CALL :title "          Net Send Messenger Help"
   ECHO Here is a list of available commands:
   ECHO.
   ECHO  /help = Brings up this dialogue
   ECHO  /list = Brings up a list of possible recipients
   ECHO  /start = Turns on all messaging services (run once)
   ECHO.
   PAUSE
   ECHO.
   GOTO sendMsg 

:list
	CALL :title "               Office User List"
	ECHO You can return here any time by typing in "/list"
	ECHO.
	ECHO Please choose a recipient:
	ECHO (1) Dean (WEBDESIGN)
	ECHO (2) Shirley (ACCTLJOST)
	ECHO (3) Marcus (BACKROOM)
	ECHO (4) Minh (GBALTAZAR)
	ECHO (5) Rachel (RECEPTION)
	ECHO (6) Jonathan (DIRECTOR)
	ECHO (7) Rick (WAREHOUSE1)
	ECHO (8) Arthur (DD02)
	ECHO (9) Manually Enter Recipient
	ECHO. 
	SET /P response=Recipient Number: 
	IF %response% == 1 (do
		SET name=Dean
		SET user=webdesign
	)
	IF %response% == 2 (
		SET name=Shirley
		SET user=acctljost
	)
	IF %response% == 3 (
		SET name=Marcus
		SET user=backroom
	)
	IF %response% == 4 (
		SET name=Minh
		SET user=gbaltazar
	)
	IF %response% == 5 (
		SET name=Rachel
		SET user=reception
	)
	IF %response% == 6 (
		SET name=Jonathan
		SET user=director
	)
	IF %response% == 7 (
		SET name=Rick
		SET user=warehouse1
	)
	IF %response% == 8 (
		SET name=Arthur
		SET user=dd02
	)
	IF %response% == 9 SET /P user=Recipient: 
	IF %response% == 9 SET /P name=Nickname:
	
	CLS
	SET return=sendMsg
	CALL :commands %response%
	
	GOTO conversation

:conversation
	CALL :title "           Office Net Send Messenger"     
	GOTO sendMsg
	
:sendMsg 
	IF NOT DEFINED name GOTO list
	SET /P response=%name%: 
	CALL :commands %response%
	SET text=%response%
	::ECHO NET SEND %user% %text%
	NET SEND %user% %text%
	GOTO sendMsg
   
:start
	CALL :title "           Office Net Send Messenger"
	ECHO Enabling service start on windows startup...
	SC config messenger start= auto
	ECHO.
	ECHO Starting the messenger service...
	NET start messenger
	ECHO.
	PAUSE
	GOTO list
GOTO EOF
	
:: %~1 = %response%
:commands
	IF %~1 == /list GOTO list
	IF %~1 == /help GOTO help
	IF %~1 == /start GOTO start
	IF %~1 ==  GOTO quit
GOTO :EOF

:readConfig
	SET count=1
	FOR /f "tokens=1 delims=," %%i IN (%config%) DO (
		::ECHO (%count%) %%i (%%j)
		ECHO ( %count% )
		SET count=%count% + 1
	)
GOTO :EOF

:writeConfig

	ECHO %~1,%~2 > %config%
GOTO :EOF

:app

	echo " I am in App"

	echo FileName = %~nx1 
	echo FileSize = %~z1
	echo TimeStamp = %~t1 
	echo FullPathofFile = %~f1 
	echo ShortPathFile = %~s1
	echo Attribute = %~a1 

GOTO :EOF

:sys

	echo " I am in sys"
	echo FileName = %~nx1 
	echo FileSize = %~z1
	echo TimeStamp = %~t1 

GOTO :EOF

:: %~1 = %title%
:title
	CLS
	ECHO. 
	ECHO -------------------------------------------------- 
	ECHO %~1
	ECHO -------------------------------------------------- 
	ECHO. 
GOTO :EOF

:quit
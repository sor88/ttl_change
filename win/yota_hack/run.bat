@echo off
color 0a

:start
echo (����᪠�� �� ����� �����������)
echo ���� �� ���� 100%% ��࠭⨨ ��室� ��࠭�祭��.
echo ���஡��� ᬮ��� �� ��㬥 http://4pda.ru/forum/index.php?showtopic=596728 ⠬ �� ����� ���� ���� 䠩�� hosts.
echo ��⠭����� ��室 ��࠭�祭�� Yota?
echo (y) - ��⠭�����.
echo (n) - ���� �� ���������.
echo (enter) - ��室.
set /p input="> "
if %input% == y goto install
if %input% == n goto uninstall
echo bad command
cls
goto start

:install
cls
IF EXIST %windir%\system32\drivers\etc\hosts.bak goto error
::��⠭�������� �㦡� ���������� Windows
sc config wuauserv start= disabled
if %ERRORLEVEL% neq 0 goto ERROR
net stop wuauserv
ren %windir%\system32\drivers\etc\hosts hosts.bak
copy "%~d0%~p0\hosts.txt" %windir%\system32\drivers\etc\hosts
::������塞 ��ࠬ���� � ॥���
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 65 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters" /v DefaultTTL /t REG_DWORD /d 65 /f
echo.
if %ERRORLEVEL% equ 0 echo ��⠭���� �����襭�
if %ERRORLEVEL% neq 0 goto ERROR
echo ����室��� ��१���㧨�� ��������.
echo ������ ���� ������ ��� ��室�.
@pause >nul
exit

:uninstall
cls
::����᪠�� �㦡� ���������� Windows
sc config wuauserv start= demand
if %ERRORLEVEL% neq 0 goto ERROR
net start wuauserv
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v DefaultTTL /f
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters" /v DefaultTTL /f
IF EXIST %windir%\system32\drivers\etc\hosts.bak del /F /Q %windir%\system32\drivers\etc\hosts
ren %windir%\system32\drivers\etc\hosts.bak hosts
echo.
if %ERRORLEVEL% equ 0 echo �⪠� ��������� ��襫 �ᯥ譮.
if %ERRORLEVEL% neq 0 goto ERROR
echo ����室��� ��१���㧨�� ��������.
echo ������ ���� ������ ��� ��室�.
@pause >nul
exit

:ERROR
cls
color 0c
echo ������!
echo �� � ��諮 �� ⠪.
echo ��� ����㯠 � ��⥬�� 䠩��� ��� �㦡��.
echo ��� ��室 ��࠭�祭�� 㦥 ��⠭�����.
echo �������� � ⮬ �� ����᪠�� ��� 䠩� �� ����� ����������� ��� �� ��⠭�������� 㦥 ࠭�� ��� ����.
echo ������ ���� ������ ��� ��室�.
pause >nul
exit
@echo off
color 0a

:start
echo (Запускать от имени администратора)
echo Патч не дает 100%% гарантии обхода ограничения.
echo Подробнее смотрите на форуме http://4pda.ru/forum/index.php?showtopic=596728 там же можете найти новые файлы hosts.
echo Установить обход ограничения Yota?
echo (y) - установить.
echo (n) - убрать все изменения.
echo (enter) - выход.
set /p input="> "
if %input% == y goto install
if %input% == n goto uninstall
echo bad command
cls
goto start

:install
cls
IF EXIST %windir%\system32\drivers\etc\hosts.bak goto error
::Останавливаем службу обновления Windows
sc config wuauserv start= disabled
if %ERRORLEVEL% neq 0 goto ERROR
net stop wuauserv
ren %windir%\system32\drivers\etc\hosts hosts.bak
copy "%~d0%~p0\hosts.txt" %windir%\system32\drivers\etc\hosts
::Добавляем параметры в реестр
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v DefaultTTL /t REG_DWORD /d 65 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters" /v DefaultTTL /t REG_DWORD /d 65 /f
echo.
if %ERRORLEVEL% equ 0 echo Установка завершена
if %ERRORLEVEL% neq 0 goto ERROR
echo Необходимо перезагрузить компьютер.
echo Нажмите любую кнопку для выхода.
@pause >nul
exit

:uninstall
cls
::Запускаем службу обновления Windows
sc config wuauserv start= demand
if %ERRORLEVEL% neq 0 goto ERROR
net start wuauserv
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v DefaultTTL /f
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters" /v DefaultTTL /f
IF EXIST %windir%\system32\drivers\etc\hosts.bak del /F /Q %windir%\system32\drivers\etc\hosts
ren %windir%\system32\drivers\etc\hosts.bak hosts
echo.
if %ERRORLEVEL% equ 0 echo Откат изменений прошел успешно.
if %ERRORLEVEL% neq 0 goto ERROR
echo Необходимо перезагрузить компьютер.
echo Нажмите любую кнопку для выхода.
@pause >nul
exit

:ERROR
cls
color 0c
echo ОШИБКА!
echo Что то пошло не так.
echo Нет доступа к системным файлам или службам.
echo Или обход ограничения уже установлен.
echo Убедитесь в том что запускаете этот файл от имени администратора или не устанавливали уже ранее этот патч.
echo Нажмите любую кнопку для выхода.
pause >nul
exit
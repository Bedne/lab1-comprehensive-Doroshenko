@echo off
chcp 65001 >nul
set score=0
set correct=0
set total=3

echo === Модуль формализации процесса ревьюирования ===
echo Предметная область: скрипты и конфигурация антивирусной защиты (Вариант 8)
echo.

echo Фрагмент 1 (проверка количества лицензий на рабочие станции):
echo 10: def check_workstation_limit(active_agents):
echo 11:     if active_agents ^> 50:
echo 12:         return "Limit exceeded"
echo 13:     return "OK"
echo.
echo Какой дефект здесь скрыт?
echo 1. Магическое число (50)
echo 2. Утечка ресурса
echo 3. Неинициализированная переменная
choice /c 123 /n
if errorlevel 3 goto f1_wrong
if errorlevel 2 goto f1_wrong
if errorlevel 1 goto f1_ok

:f1_wrong
echo Неверно (-5 очков). Правильный ответ: 1 (число 50 нужно вынести в константу MAX_STATIONS).
set /a score-=5
goto frag2

:f1_ok
echo Верно (+10 очков)! Лимит рабочих станций (50) должен быть вынесен в именованную константу.
set /a score+=10
set /a correct+=1

:frag2
echo.
echo Фрагмент 2 (сканирование карантинного файла):
echo 20: def inspect_quarantine_file(filepath):
echo 21:     f = open(filepath, "rb")
echo 22:     header = f.read(64)
echo 23:     if header.startswith(b"MZ"):
echo 24:         return True
echo 25:     f.close()
echo 26:     return False
echo.
echo Какой дефект здесь скрыт?
echo 1. Мёртвое присваивание
echo 2. Утечка ресурса
echo 3. Магическое число
choice /c 123 /n
if errorlevel 3 goto f2_wrong
if errorlevel 2 goto f2_ok
if errorlevel 1 goto f2_wrong

:f2_wrong
echo Неверно (-5 очков). Правильный ответ: 2 (файл не закрывается при раннем return).
set /a score-=5
goto frag3

:f2_ok
echo Верно (+10 очков)! При обнаружении заголовка MZ выполняется return без закрытия файла f.
set /a score+=10
set /a correct+=1

:frag3
echo.
echo Фрагмент 3 (синхронизация политик с сервером администрирования):
echo 30: def sync_security_policy(server_url, policy_data):
echo 31:     response = send_policy_packet(server_url, policy_data)
echo 32:     status = "synced"
echo 33:     return status
echo.
echo Какой дефект здесь скрыт?
echo 1. Отсутствие обработки ошибок
echo 2. Неинициализированная переменная
echo 3. Утечка ресурса
choice /c 123 /n
if errorlevel 3 goto f3_wrong
if errorlevel 2 goto f3_wrong
if errorlevel 1 goto f3_ok

:f3_wrong
echo Неверно (-5 очков). Правильный ответ: 1 (нет обработки сетевых исключений и статуса ответа).
set /a score-=5
goto summary

:f3_ok
echo Верно (+10 очков)! Отсутствует блок try/except при сетевом обмене с сервером управления.
set /a score+=10
set /a correct+=1

:summary
echo.
set /a accuracy=correct*100/total
set "reviewer_level=Junior"
if %accuracy% geq 50 set "reviewer_level=Middle"
if %accuracy% geq 80 set "reviewer_level=Senior"

echo === Итоговый отчёт ревью ===
echo Просмотрено фрагментов: %total%
echo Правильных ответов: %correct% из %total%
echo Точность: %accuracy%%%
echo Набранные очки: %score%
echo Уровень ревьюера: %reviewer_level%
echo %reviewer_level% (%accuracy%%%)>last_review.txt
pausess
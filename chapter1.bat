@echo off
chcp 65001 >nul
set score_kaspersky=0
set score_eset=0
set score_drweb=0

echo === Модуль выбора антивирусного решения ===
echo Контекст: офис на 50 рабочих станций, централизованное управление.
echo.

echo Вопрос 1: Насколько критично наличие единой консоли централизованного управления и детальных политик безопасности?
echo 1. Максимально критично (нужен полный контроль над 50 ПК, аудит устройств и веб-контроль)
echo 2. Важно (базовое удалённое развёртывание и мониторинг обновлений)
echo 3. Не критично (подойдёт простая настройка групп станций)
choice /c 123 /n
if errorlevel==3 set /a score_drweb+=10
if errorlevel==2 set /a score_eset+=15
if errorlevel==1 set /a score_kaspersky+=20

echo.
echo Вопрос 2: Какая аппаратная нагрузка на рабочие станции допустима?
echo 1. Минимальная (много слабых офисных ПК, нужна лёгкость агента)
echo 2. Средняя (современные офисные компьютеры)
echo 3. Не имеет значения (главное — глубина эвристического анализа)
choice /c 123 /n
if errorlevel==3 set /a score_kaspersky+=15
if errorlevel==2 set /a score_drweb+=10
if errorlevel==1 set /a score_eset+=20

echo.
echo Вопрос 3: Требуется ли сертификация ФСТЭК/ФСБ и отечественная техподдержка для корпоративного сектора?
echo 1. Да, обязательны отечественная разработка и сертифицированные сборки
echo 2. Желательна локальная поддержка и простое лицензирование
echo 3. Нет жёстких регуляторных требований
choice /c 123 /n
if errorlevel==3 set /a score_eset+=15
if errorlevel==2 set /a score_drweb+=15
if errorlevel==1 set /a score_kaspersky+=15
if errorlevel==1 set /a score_drweb+=15

echo.
set "rec_tech=Kaspersky Endpoint Security"
set "max_score=%score_kaspersky%"
if %score_eset% gtr %max_score% (
    set "rec_tech=ESET NOD32"
    set "max_score=%score_eset%"
)
if %score_drweb% gtr %max_score% (
    set "rec_tech=Dr.Web"
    set "max_score=%score_drweb%"
)

echo Баллы кандидатов: Kaspersky=%score_kaspersky%, ESET NOD32=%score_eset%, Dr.Web=%score_drweb%
echo Рекомендация: %rec_tech%
echo %rec_tech%>last_tech.txt
pause

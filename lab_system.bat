@echo off
chcp 65001 >nul

:menu
cls
echo ====================================================
echo   СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo   Вариант 8: Выбор антивирусного решения (50 ПК)
echo ====================================================
echo.
echo 1. Модуль выбора технологий
echo 2. Модуль инспекции кода
echo 3. Модуль сравнительного анализа
echo 4. Запустить все модули последовательно
echo 5. Выход
echo.
set /p choice="Ваш выбор: "

if "%choice%"=="1" goto run_ch1
if "%choice%"=="2" goto run_ch2
if "%choice%"=="3" goto run_ch3
if "%choice%"=="4" goto run_all
if "%choice%"=="5" exit /b 0
goto menu

:run_ch1
call chapter1.bat
goto menu

:run_ch2
call chapter2.bat
goto menu

:run_ch3
call chapter3.bat
goto menu

:run_all
call chapter1.bat
call chapter2.bat
call chapter3.bat

set "tech_res=Не сформировано"
set "rev_res=Не определено"
set "wsm_res=Не определён"

if exist last_tech.txt set /p tech_res=<last_tech.txt
if exist last_review.txt set /p rev_res=<last_review.txt
if exist last_wsm.txt set /p wsm_res=<last_wsm.txt

echo.
echo === Итоговый отчёт системы ===
echo Все модули пройдены.
echo Результаты сохранены в report.txt
echo.
echo Модуль 1 (Рекомендация по технологии): %tech_res%
echo Модуль 2 (Уровень ревьюера): %rev_res%
echo Модуль 3 (Победитель сравнительного анализа): %wsm_res%

echo === ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ === > report.txt
echo Выполнил: Дорошенко К. В., группа 3525П1ИН1 » report.txt
echo Вариант 8: Выбор антивирусного решения для организации » report.txt
echo Дата и время: %date% %time% » report.txt
echo ---------------------------------------------------- » report.txt
echo Модуль 1 (Рекомендация по технологии): %tech_res% » report.txt
echo Модуль 2 (Уровень ревьюера): %rev_res% » report.txt
echo Модуль 3 (Победитель сравнительного анализа): %wsm_res% » report.txt

pause
goto menu
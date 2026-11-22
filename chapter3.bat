@echo off
chcp 65001 >nul
echo === Модуль сравнительного анализа антивирусных решений (WSM) ===
echo Кандидаты: Kaspersky Endpoint Security, ESET NOD32, Dr.Web
echo.

echo Назначьте веса критериям (сумма должна быть равна 100):
set /p w1="Вес критерия 1 (Централизованное управление): "
set /p w2="Вес критерия 2 (Уровень защиты и детекта): "
set /p w3="Вес критерия 3 (Низкая нагрузка и стоимость): "

set /a total_weight=w1+w2+w3
if %total_weight% neq 100 (
    echo Ошибка: сумма весов равна %total_weight%, а должна быть равна 100!
    pause
    exit /b 1
)

echo.
echo Оцените альтернативы по шкале от 1 до 5:
echo --- Kaspersky Endpoint Security ---
set /p k_1="Kaspersky по критерию 1 (Централизованное управление): "
set /p k_2="Kaspersky по критерию 2 (Уровень защиты и детекта): "
set /p k_3="Kaspersky по критерию 3 (Низкая нагрузка и стоимость): "

echo --- ESET NOD32 ---
set /p e_1="ESET NOD32 по критерию 1 (Централизованное управление): "
set /p e_2="ESET NOD32 по критерию 2 (Уровень защиты и детекта): "
set /p e_3="ESET NOD32 по критерию 3 (Низкая нагрузка и стоимость): "

echo --- Dr.Web ---
set /p d_1="Dr.Web по критерию 1 (Централизованное управление): "
set /p d_2="Dr.Web по критерию 2 (Уровень защиты и детекта): "
set /p d_3="Dr.Web по критерию 3 (Низкая нагрузка и стоимость): "

set /a score_k=k_1*w1+k_2*w2+k_3*w3
set /a score_e=e_1*w1+e_2*w2+e_3*w3
set /a score_d=d_1*w1+d_2*w2+d_3*w3

echo.
echo === Матрица решений ===
echo Критерий                    ^| Вес ^| Kaspersky ^| ESET NOD32 ^| Dr.Web
echo Централизованное управление ^| %w1%  ^| %k_1%         ^| %e_1%          ^| %d_1%
echo Уровень защиты и детекта    ^| %w2%  ^| %k_2%         ^| %e_2%          ^| %d_2%
echo Нагрузка и стоимость        ^| %w3%  ^| %k_3%         ^| %e_3%          ^| %d_3%
echo ИТОГО                       ^| 100 ^| %score_k%       ^| %score_e%        ^| %score_d%
echo.

set "winner=Kaspersky Endpoint Security"
set "best_score=%score_k%"
if %score_e% gtr %best_score% (
    set "winner=ESET NOD32"
    set "best_score=%score_e%"
)
if %score_d% gtr %best_score% (
    set "winner=Dr.Web"
    set "best_score=%score_d%"
)

echo Победитель: %winner% (итоговый балл: %best_score%)
echo %winner% (%best_score%)>last_wsm.txt
pause

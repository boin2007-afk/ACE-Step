@echo off
chcp 1251 >nul
title ACE-Step[](http://127.0.0.1:7865)

cd /d "%~dp0"

echo ======================================
echo Запуск ACE-Step...
echo Текущая папка: %CD%
echo ======================================

if not exist "venv" (
    echo ОШИБКА: venv не найдена! Установи зависимости сначала.
    pause
    exit /b
)

call venv\Scripts\activate.bat

echo venv активировано. Запускаем Gradio...

acestep ^
    --port 7865 ^
    --bf16 true ^
    --cpu_offload true ^
    --overlapped_decode true
    :: --torch_compile true   :: раскомментируй, если установлен triton-windows

echo.
echo Ждем запуска сервера (5 секунд)...
timeout /t 5 /nobreak >nul

start "" "http://127.0.0.1:7865"

echo.
echo ACE-Step запущен! Браузер должен открыться автоматически.
echo Если окно браузера не появилось — открой вручную: http://127.0.0.1:7865
echo Чтобы остановить сервер — нажми Ctrl+C в этой консоли.

pause
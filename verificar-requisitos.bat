@echo off
color 0A
title Sistema Bodega - Verificador de Requisitos
CLS

echo.
echo ========================================
echo VERIFICADOR DE REQUISITOS
echo Sistema Bodega
echo ========================================
echo.

REM Verificar Python
echo Verificando Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('python --version') do set PYTHON_VERSION=%%i
    echo [OK] %PYTHON_VERSION%
) else (
    color 0C
    echo [ERROR] Python no encontrado
    echo Descarga desde: https://www.python.org/downloads/
    set ERROR=1
)

REM Verificar Node.js
echo.
echo Verificando Node.js...
node --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo [OK] %NODE_VERSION%
) else (
    color 0C
    echo [ERROR] Node.js no encontrado
    echo Descarga desde: https://nodejs.org/
    set ERROR=1
)

REM Verificar Git
echo.
echo Verificando Git...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    for /f "tokens=*" %%i in ('git --version') do set GIT_VERSION=%%i
    echo [OK] %GIT_VERSION%
) else (
    color 0C
    echo [ERROR] Git no encontrado
    echo Descarga desde: https://git-scm.com/
    set ERROR=1
)

REM Verificar PostgreSQL (opcional)
echo.
echo Verificando PostgreSQL...
where psql >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] PostgreSQL encontrado
) else (
    color 0E
    echo [ADVERTENCIA] PostgreSQL no encontrado
    echo Es recomendable instalarlo desde: https://www.postgresql.org/
)

REM Resultado final
echo.
echo ========================================
if defined ERROR (
    color 0C
    echo INSTALACION NO PUEDE CONTINUAR
    echo Instala las dependencias faltantes
) else (
    color 0A
    echo TODOS LOS REQUISITOS ESTAN OK
    echo Ya puedes ejecutar el instalador
)
echo ========================================
echo.
pause

@echo off
CLS
color 0A
echo.
echo ========================================
echo INSTALADOR - SISTEMA BODEGA
echo ========================================
echo.
echo Este script instalara el Sistema de Gestion de Bodega
echo en tu equipo.
echo.
pause

REM Verificar si Python esta instalado
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    color 0C
    echo [ERROR] Python no esta instalado
    echo Descarga Python desde: https://www.python.org/downloads/
    echo Asegurate de marcar "Add Python to PATH"
    pause
    exit /b 1
)

REM Verificar si Node.js esta instalado
node --version >nul 2>&1
if errorlevel 1 (
    echo.
    color 0C
    echo [ERROR] Node.js no esta instalado
    echo Descarga Node.js desde: https://nodejs.org/
    pause
    exit /b 1
)

REM Verificar si Git esta instalado
git --version >nul 2>&1
if errorlevel 1 (
    echo.
    color 0C
    echo [ERROR] Git no esta instalado
    echo Descarga Git desde: https://git-scm.com/
    pause
    exit /b 1
)

color 0A
echo [OK] Todas las dependencias estan instaladas
echo.

REM Crear directorio de instalacion
set INSTALL_DIR=%USERPROFILE%\BodegaSystem
if exist "%INSTALL_DIR%" (
    color 0E
    echo El directorio ya existe: %INSTALL_DIR%
    set /p OVERWRITE="Deseas sobrescribir? (s/n): "
    if /i not "%OVERWRITE%"=="s" (
        echo Instalacion cancelada
        pause
        exit /b 1
    )
    rmdir /s /q "%INSTALL_DIR%"
)

mkdir "%INSTALL_DIR%"
cd /d "%INSTALL_DIR%"

echo.
color 0A
echo [*] Clonando repositorio...
git clone https://github.com/carlonxo911/bodega.git .
if errorlevel 1 (
    color 0C
    echo [ERROR] No se pudo clonar el repositorio
    pause
    exit /b 1
)

echo.
echo [*] Instalando dependencias de Backend...
cd backend
python -m venv venv
call venv\Scripts\activate.bat
pip install --upgrade pip
pip install -r requirements.txt
if errorlevel 1 (
    color 0C
    echo [ERROR] Error al instalar dependencias de Python
    pause
    exit /b 1
)

echo.
echo [*] Configurando base de datos...
python manage.py migrate
if errorlevel 1 (
    color 0C
    echo [ERROR] Error en migraciones de BD
    pause
    exit /b 1
)

echo.
echo [*] Instalando dependencias de Frontend...
cd ..
cd frontend
call npm install
if errorlevel 1 (
    color 0C
    echo [ERROR] Error al instalar dependencias de Node.js
    pause
    exit /b 1
)

echo.
color 0B
echo ========================================
echo INSTALACION COMPLETADA EXITOSAMENTE
echo ========================================
echo.
echo La aplicacion se ha instalado en:
echo %INSTALL_DIR%
echo.
echo PROXIMOS PASOS:
echo.
echo 1. Crear archivo .env en backend/
echo    - Copiar backend/.env.example a backend/.env
echo    - Editar con tus configuraciones
echo.
echo 2. Crear superusuario:
echo    cd %INSTALL_DIR%\backend
echo    venv\Scripts\activate.bat
echo    python manage.py createsuperuser
echo.
echo 3. Iniciar la aplicacion:
echo    Ejecutar "iniciar-bodega.bat" en el escritorio
echo.
pause

REM Crear archivo de inicio rapido
echo.
echo [*] Creando archivo de inicio rapido...

cd /d "%INSTALL_DIR%"

REM Crear script de inicio
(
echo @echo off
echo title Sistema Bodega - Backend
echo color 0A
echo cd /d "%INSTALL_DIR%\backend"
echo call venv\Scripts\activate.bat
echo echo.
echo echo Iniciando servidor Django...
echo echo URL: http://localhost:8000
echo echo.
echo python manage.py runserver 0.0.0.0:8000
) > "%INSTALL_DIR%\iniciar-backend.bat"

REM Crear script para frontend
(
echo @echo off
echo title Sistema Bodega - Frontend
echo color 0B
echo cd /d "%INSTALL_DIR%\frontend"
echo echo.
echo echo Iniciando React...
echo echo URL: http://localhost:3000
echo echo.
echo npm start
) > "%INSTALL_DIR%\iniciar-frontend.bat"

REM Crear script combinado
(
echo @echo off
echo title Sistema Bodega - Instalacion Completa
echo.
echo echo ========================================
echo echo SISTEMA BODEGA - INICIANDO
echo echo ========================================
echo echo.
echo echo Este script iniciara tanto el backend como el frontend
echo echo Abre DOS ventanas nuevas para cada servicio
echo echo.
echo echo Iniciando BACKEND en nueva ventana...
echo start "Backend" cmd /k "%INSTALL_DIR%\iniciar-backend.bat"
echo.
echo timeout /t 2
echo echo.
echo echo Iniciando FRONTEND en nueva ventana...
echo start "Frontend" cmd /k "%INSTALL_DIR%\iniciar-frontend.bat"
echo.
echo echo.
echo echo ABRE TU NAVEGADOR EN: http://localhost:3000
echo echo.
echo echo Presiona CTRL+C en cualquier ventana para detener
echo pause
) > "%INSTALL_DIR%\iniciar-bodega.bat"

echo [OK] Archivo creado: %INSTALL_DIR%\iniciar-bodega.bat

REM Crear acceso directo en escritorio
echo.
echo [*] Creando acceso directo en el escritorio...

set DESKTOP=%USERPROFILE%\Desktop
powersh -NoProfile -Command "$WshShell = New-Object -ComObject WScript.Shell; $shortcut = $WshShell.CreateShortcut('%DESKTOP%\Bodega.lnk'); $shortcut.TargetPath = '%INSTALL_DIR%\iniciar-bodega.bat'; $shortcut.WorkingDirectory = '%INSTALL_DIR%'; $shortcut.Save()"

echo.
color 0A
echo [OK] Acceso directo creado en el escritorio
echo.
echo ========================================
echo INSTALACION FINALIZADA
echo ========================================
echo.
echo Puedes iniciar la aplicacion desde:
echo - Escritorio: Bodega.lnk
echo - O ejecutar: %INSTALL_DIR%\iniciar-bodega.bat
echo.
echo Admin URL: http://localhost:8000/admin/
echo App URL: http://localhost:3000/
echo.
pause

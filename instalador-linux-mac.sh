#!/bin/bash

# Colores para el output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}"
echo "========================================"
echo "INSTALADOR - SISTEMA BODEGA"
echo "========================================"
echo -e "${NC}"
echo ""
echo "Este script instalará el Sistema de Gestión de Bodega"
echo "en tu equipo."
echo ""
read -p "¿Continuar? (s/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    exit 1
fi

# Verificar si Python está instalado
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}[ERROR] Python 3 no está instalado${NC}"
    echo "Instala Python 3 usando:"
    echo "  Ubuntu/Debian: sudo apt-get install python3 python3-pip python3-venv"
    echo "  macOS: brew install python3"
    exit 1
fi

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    echo -e "${RED}[ERROR] Node.js no está instalado${NC}"
    echo "Instala Node.js desde: https://nodejs.org/"
    exit 1
fi

# Verificar si Git está instalado
if ! command -v git &> /dev/null; then
    echo -e "${RED}[ERROR] Git no está instalado${NC}"
    echo "Instala Git usando:"
    echo "  Ubuntu/Debian: sudo apt-get install git"
    echo "  macOS: brew install git"
    exit 1
fi

echo -e "${GREEN}[OK] Todas las dependencias están instaladas${NC}"
echo ""

# Crear directorio de instalación
INSTALL_DIR="$HOME/BodegaSystem"
if [ -d "$INSTALL_DIR" ]; then
    echo -e "${YELLOW}El directorio ya existe: $INSTALL_DIR${NC}"
    read -p "¿Deseas sobrescribir? (s/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "Instalación cancelada"
        exit 1
    fi
    rm -rf "$INSTALL_DIR"
fi

mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo ""
echo -e "${BLUE}[*] Clonando repositorio...${NC}"
git clone https://github.com/carlonxo911/bodega.git .
if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] No se pudo clonar el repositorio${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}[*] Instalando dependencias de Backend...${NC}"
cd backend
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] Error al instalar dependencias de Python${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}[*] Configurando base de datos...${NC}"
python3 manage.py migrate
if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] Error en migraciones de BD${NC}"
    exit 1
fi

echo ""
echo -e "${BLUE}[*] Instalando dependencias de Frontend...${NC}"
cd ../frontend
npm install
if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] Error al instalar dependencias de Node.js${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}"
echo "========================================"
echo "INSTALACIÓN COMPLETADA EXITOSAMENTE"
echo "========================================"
echo -e "${NC}"
echo ""
echo "La aplicación se ha instalado en:"
echo "$INSTALL_DIR"
echo ""
echo -e "${YELLOW}PRÓXIMOS PASOS:${NC}"
echo ""
echo "1. Crear archivo .env en backend/"
echo "   - Copiar backend/.env.example a backend/.env"
echo "   - Editar con tus configuraciones"
echo ""
echo "2. Crear superusuario:"
echo "   cd $INSTALL_DIR/backend"
echo "   source venv/bin/activate"
echo "   python3 manage.py createsuperuser"
echo ""
echo "3. Iniciar la aplicación:"
echo "   Ejecutar ./iniciar-bodega.sh"
echo ""

# Crear scripts de inicio
echo -e "${BLUE}[*] Creando scripts de inicio...${NC}"

cd "$INSTALL_DIR"

# Script para backend
cat > "$INSTALL_DIR/iniciar-backend.sh" << 'EOF'
#!/bin/bash
clear
echo "========================================"
echo "SISTEMA BODEGA - BACKEND"
echo "========================================"
echo ""
echo "Iniciando servidor Django..."
echo "URL: http://localhost:8000"
echo ""
cd "$(dirname "$0")/backend"
source venv/bin/activate
python3 manage.py runserver 0.0.0.0:8000
EOF
chmod +x "$INSTALL_DIR/iniciar-backend.sh"

# Script para frontend
cat > "$INSTALL_DIR/iniciar-frontend.sh" << 'EOF'
#!/bin/bash
clear
echo "========================================"
echo "SISTEMA BODEGA - FRONTEND"
echo "========================================"
echo ""
echo "Iniciando React..."
echo "URL: http://localhost:3000"
echo ""
cd "$(dirname "$0")/frontend"
npm start
EOF
chmod +x "$INSTALL_DIR/iniciar-frontend.sh"

# Script combinado
cat > "$INSTALL_DIR/iniciar-bodega.sh" << 'EOF'
#!/bin/bash
clear
echo "========================================"
echo "SISTEMA BODEGA - INICIANDO"
echo "========================================"
echo ""
echo "Este script iniciará tanto el backend como el frontend"
echo ""
echo "Abre dos terminales diferentes para cada servicio"
echo ""
read -p "Presiona Enter para continuar..."

DIR="$(dirname "$0")"

# Iniciar backend en background
echo ""
echo "Iniciando BACKEND..."
"$DIR/iniciar-backend.sh" &
BACKEND_PID=$!

sleep 3

# Iniciar frontend en background
echo ""
echo "Iniciando FRONTEND..."
"$DIR/iniciar-frontend.sh" &
FRONTEND_PID=$!

echo ""
echo "========================================"
echo "SERVICIOS INICIADOS"
echo "========================================"
echo ""
echo "Abre tu navegador en: http://localhost:3000"
echo "Admin: http://localhost:8000/admin/"
echo ""
echo "Presiona CTRL+C para detener los servicios"
echo ""

# Esperar a que se detengan los procesos
wait
EOF
chmod +x "$INSTALL_DIR/iniciar-bodega.sh"

echo -e "${GREEN}[OK] Scripts creados${NC}"
echo ""
echo -e "${GREEN}"
echo "========================================"
echo "INSTALACIÓN FINALIZADA"
echo "========================================"
echo -e "${NC}"
echo ""
echo "Puedes iniciar la aplicación ejecutando:"
echo "  $INSTALL_DIR/iniciar-bodega.sh"
echo ""
echo "URLs de acceso:"
echo "  - Frontend: http://localhost:3000/"
echo "  - Admin: http://localhost:8000/admin/"
echo "  - API: http://localhost:8000/api/"
echo ""

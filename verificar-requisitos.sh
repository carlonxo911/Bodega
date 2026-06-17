#!/bin/bash

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

clear
echo -e "${BLUE}"
echo "========================================"
echo "VERIFICADOR DE REQUISITOS"
echo "Sistema Bodega"
echo "========================================"
echo -e "${NC}"
echo ""

ERROR=0

# Verificar Python
echo "Verificando Python..."
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    echo -e "${GREEN}[OK]${NC} $PYTHON_VERSION"
else
    echo -e "${RED}[ERROR]${NC} Python 3 no encontrado"
    echo "Instala desde: https://www.python.org/downloads/"
    ERROR=1
fi

# Verificar Node.js
echo ""
echo "Verificando Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    echo -e "${GREEN}[OK]${NC} $NODE_VERSION"
else
    echo -e "${RED}[ERROR]${NC} Node.js no encontrado"
    echo "Instala desde: https://nodejs.org/"
    ERROR=1
fi

# Verificar Git
echo ""
echo "Verificando Git..."
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    echo -e "${GREEN}[OK]${NC} $GIT_VERSION"
else
    echo -e "${RED}[ERROR]${NC} Git no encontrado"
    echo "Instala desde: https://git-scm.com/"
    ERROR=1
fi

# Verificar PostgreSQL (opcional)
echo ""
echo "Verificando PostgreSQL..."
if command -v psql &> /dev/null; then
    echo -e "${GREEN}[OK]${NC} PostgreSQL encontrado"
else
    echo -e "${YELLOW}[ADVERTENCIA]${NC} PostgreSQL no encontrado"
    echo "Es recomendable instalarlo desde: https://www.postgresql.org/"
fi

# Resultado final
echo ""
echo "========================================"
if [ $ERROR -eq 1 ]; then
    echo -e "${RED}INSTALACION NO PUEDE CONTINUAR${NC}"
    echo "Instala las dependencias faltantes
    exit 1
else
    echo -e "${GREEN}TODOS LOS REQUISITOS ESTAN OK${NC}"
    echo "Ya puedes ejecutar el instalador
fi
echo "========================================"
echo ""

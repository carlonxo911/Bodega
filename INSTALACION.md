# 🚀 Sistema de Gestión de Bodega - Guía de Instalación

## 📋 Requisitos Previos

Antes de instalar, asegúrate de tener:

- **Python 3.9+** - [Descargar](https://www.python.org/downloads/)
- **Node.js 16+** - [Descargar](https://nodejs.org/)
- **PostgreSQL 12+** - [Descargar](https://www.postgresql.org/download/)
- **Git** - [Descargar](https://git-scm.com/)

## 🖥️ Instalación en Windows

### Opción 1: Instalador Automático (Recomendado)

1. Descarga el archivo `instalador-windows.bat` del repositorio
2. Haz doble clic en el archivo
3. Sigue las instrucciones en pantalla
4. ¡Listo! Se creará un acceso directo en el escritorio

### Opción 2: Instalación Manual

```bash
# Clonar repositorio
git clone https://github.com/carlonxo911/bodega.git
cd bodega

# Instalar Backend
cd backend
python -m venv venv
venv\Scripts\activate.bat
pip install -r requirements.txt
python manage.py migrate

# Instalar Frontend
cd ../frontend
npm install
```

## 🐧 Instalación en Linux/macOS

### Opción 1: Instalador Automático (Recomendado)

```bash
# Descargar el instalador
wget https://raw.githubusercontent.com/carlonxo911/bodega/main/instalador-linux-mac.sh

# O con curl
curl -O https://raw.githubusercontent.com/carlonxo911/bodega/main/instalador-linux-mac.sh

# Dar permisos de ejecución
chmod +x instalador-linux-mac.sh

# Ejecutar
./instalador-linux-mac.sh
```

### Opción 2: Instalación Manual

```bash
# Clonar repositorio
git clone https://github.com/carlonxo911/bodega.git
cd bodega

# Instalar Backend
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python3 manage.py migrate

# Instalar Frontend
cd ../frontend
npm install
```

## ⚙️ Configuración Inicial

### 1. Configurar Base de Datos

```bash
# Copiar archivo de ejemplo
cp backend/.env.example backend/.env

# Editar .env con tus datos
# - DB_NAME
# - DB_USER
# - DB_PASSWORD
# - DB_HOST
```

### 2. Crear Superusuario (Admin)

```bash
cd backend
# Activar venv
source venv/bin/activate  # Linux/Mac
# o
venv\Scripts\activate.bat  # Windows

# Crear usuario admin
python manage.py createsuperuser
```

## 🎯 Iniciar la Aplicación

### Windows

1. Haz doble clic en `Bodega.lnk` (acceso directo del escritorio)
2. O ejecuta `iniciar-bodega.bat` desde el directorio de instalación

### Linux/macOS

```bash
cd ~/BodegaSystem
./iniciar-bodega.sh
```

## 🌐 Acceso a la Aplicación

Una vez iniciada:

- **Frontend**: http://localhost:3000/
- **Admin**: http://localhost:8000/admin/
- **API**: http://localhost:8000/api/

## 🔌 Acceso Remoto

### Para acceder desde otra máquina en la red local:

1. **Obtener tu IP local**:
   ```bash
   # Windows
   ipconfig
   
   # Linux/Mac
   ifconfig
   ```

2. **Editar `.env`**:
   ```
   CORS_ALLOWED_ORIGINS=http://localhost:3000,http://192.168.1.XXX:3000
   ALLOWED_HOSTS=localhost,127.0.0.1,192.168.1.XXX
   ```

3. **Reiniciar aplicación y acceder**:
   - Frontend: `http://192.168.1.XXX:3000`
   - Admin: `http://192.168.1.XXX:8000/admin/`

## 🐳 Instalación con Docker

```bash
# Navegar al directorio del proyecto
cd bodega

# Iniciar contenedores
docker-compose up -d

# Ejecutar migraciones
docker-compose exec backend python manage.py migrate

# Crear superusuario
docker-compose exec backend python manage.py createsuperuser

# La aplicación estará disponible en:
# Frontend: http://localhost:3000
# Admin: http://localhost:8000/admin/
```

## 🛠️ Troubleshooting

### Error: "Python no está instalado"

- Descarga Python desde https://www.python.org/downloads/
- **Importante**: Marca la opción "Add Python to PATH"
- Reinicia tu terminal

### Error: "Puerto 8000 ya está en uso"

```bash
# Cambiar puerto
python manage.py runserver 0.0.0.0:8001
```

### Error de conexión a PostgreSQL

```bash
# Verificar que PostgreSQL está corriendo
# Windows
net start PostgreSQL-X64-XX

# Linux
sudo systemctl start postgresql

# Verificar credenciales en .env
```

### Error: "Module not found"

```bash
# Reinstalar dependencias
cd backend
rm -rf venv  # o rmdir venv /s /q en Windows
python -m venv venv
source venv/bin/activate  # o venv\Scripts\activate.bat
pip install -r requirements.txt
```

## 📱 Requisitos del Sistema

### Mínimos
- RAM: 2 GB
- Disco: 500 MB
- CPU: 1.5 GHz

### Recomendados
- RAM: 4 GB
- Disco: 1 GB
- CPU: 2.0 GHz

## 📞 Soporte

Para reportar problemas o sugerencias:

1. Crea un issue en GitHub
2. Incluye:
   - Tu sistema operativo
   - Versión de Python y Node.js
   - El error completo
   - Pasos para reproducir

## 📄 Licencia

Privada - Todos los derechos reservados

---

**¡Listo para usar!** 🎉

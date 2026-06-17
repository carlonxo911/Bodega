# 📦 Sistema de Gestión de Bodega

Sistema integral para la gestión de inventario de bodega con control de entradas, salidas, proyecciones y reportes.

## 🎯 Características Principales

- ✅ **Gestión de Inventario**: Entrada y salida de insumos
- ✅ **Guías de Movimiento**: Registro de entradas y salidas
- ✅ **Control de Usuarios**: Sistema de roles (Admin, Bodeguero, Usuario)
- ✅ **Reportes en Excel**: Exportación de datos
- ✅ **Proyecciones**: Análisis a 6 meses de insumos
- ✅ **Solicitudes de Insumos**: Generación automática según stock
- ✅ **Dashboard**: Visualización de datos en tiempo real

## 🏗️ Arquitectura

```
bodega/
├── backend/          # Django REST API
├── frontend/         # React + TypeScript
├── docs/             # Documentación
└── docker/           # Configuración Docker
```

## 🚀 Inicio Rápido

### Requisitos
- Python 3.9+
- Node.js 16+
- PostgreSQL 12+
- Docker (opcional)

### Instalación Backend
```bash
cd backend
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

### Instalación Frontend
```bash
cd frontend
npm install
npm start
```

## 📚 Documentación

Ver carpeta `docs/` para documentación completa.

## 👥 Perfiles de Usuario

1. **Administrador**: Acceso total al sistema
2. **Bodeguero**: Gestión de entradas/salidas
3. **Usuario**: Solicitud de insumos

## 📝 Licencia

Privada - Todos los derechos reservados

# Asistente-de-ingles

Sistema interactivo con machine learning y detección de voz para la mejora del vocabulario y pronunciación de inglés de estudiantes de primer semestre de la Universidad Privada Franz Tamayo.

## Ramas

| Rama | Uso |
|------|-----|
| `main` | Versión estable |
| `develop` | Integración del desarrollo |
| `feature/*` | Una funcionalidad por rama, creada desde `develop` |

## Base de datos (PostgreSQL)

| Archivo | Contenido |
|---------|-----------|
| `base_de_datos/01_esquema.sql` | Creación de tablas, claves primarias y foráneas |
| `base_de_datos/02_datos_prueba.sql` | Datos de prueba |
| `base_de_datos/03_consultas.sql` | Consultas del proyecto |

```bash
psql -d asistente_ingles -f base_de_datos/01_esquema.sql
psql -d asistente_ingles -f base_de_datos/02_datos_prueba.sql
psql -d asistente_ingles -f base_de_datos/03_consultas.sql
```

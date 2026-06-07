# Sistema de Gestión de Alojamientos - Consultas SQL

Este repositorio contiene el archivo de scripts SQL diseñados para responder a la guía práctica del módulo de bases de datos relacionales.

## 🛠️ Motor de Base de Datos Utilizado
* **PostgreSQL** (Administrado a través de pgAdmin)

---

## 🗂️ Esquema de la Base de Datos

El sistema está compuesto por las siguientes tablas relacionales y sus campos principales:

### 1. Alojamientos (`accommodations`)
* `accommodation_id` (PK)
* `name` (Nombre del alojamiento)
* `accommodation_type_id` (FK)
* `location_id` (FK)
* `owner_id` (FK)

### 2. Habitaciones (`rooms`)
* `room_id` (PK)
* `accommodation_id` (FK)
* `room_name` (Nombre o tipo de habitación)
* `room_code`
* `floor_number`
* `capacity`
* `bed_count`
* `room_price_per_night` (Precio por noche)

### 3. Reservas (`bookings`)
* `booking_id` (PK)
* `booking_reference` (Código de referencia)
* `guest_id` (FK)
* `accommodation_id` (FK)

### 4. Reseñas / Opiniones (`reviews`)
* `review_id` (PK)
* `booking_id` (FK)
* `guest_id` (FK)
* `accommodation_id` (FK)
* `rating` (Calificación numérica)
* `review_title` (Título de la reseña)
* `review_text` (Detalle del comentario)

### 5. Huéspedes (`guests`)
* `guest_id` (PK)
* `first_name`
* `last_name`
* `email`

### 6. Pagos (`payments`)
* `payment_id` (PK)
* `booking_id` (FK)
* `amount` (Monto pagado)
* `payment_date`

---

## 🚀 Contenido del Repositorio
* `CONSULTAS KARLA MENDOZA.sql`: Archivo principal que contiene las consultas solicitadas (consultas generales, INNER JOIN, LEFT JOIN con filtros NULL, funciones de agregación, ordenamiento, filtrado con HAVING y subconsultas), separadas por comentarios descriptivos.

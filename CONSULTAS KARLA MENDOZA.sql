SELECT * FROM owners;
-- Item 1 agregar un nuevo propietario --
INSERT INTO owners (
    first_name,
    last_name,
    company_name,
    email,
    phone,
    tax_id,
    address_line1,
    address_line2,
    city,
    state,
    country,
    postal_code
)
VALUES (
    'Karla',
    'Mendoza',
    'INFRAMEN',
    'karlamendoza19899@hotmail.com',
    '7658-2345',
    'SV-12345678',
    '29 calle oriente',
    'Edificio A tercer nivel',
    'San Salvador',
    'San Salvador Centro',
    'EL SALVADOR',
    '503'
);

-- Item 2 crear alojamiento vinculado
SELECT * FROM accommodations;
INSERT INTO accommodations (
    owner_id, 
    accommodation_type_id, 
    location_id, 
    name, 
    description,
    max_guests,
    bedroom_count,
    bathroom_count,
    base_price_per_night,
    currency_code,
    check_in_time,
    check_out_time,
    is_active
)
VALUES (
    21,                               -- Tu ID de propietaria (Karla Mendoza)
    2,                                -- ID del tipo de alojamiento
    13,                               -- ID de la ubicación
    'Alojamiento Karla Mendoza',      -- Nombre
    'Hermoso alojamiento administrado por Karla Mendoza para las prácticas del INFRAMEN.',
    4,                                -- max_guests
    2,                                -- bedroom_count
    1,                                -- bathroom_count
    45.00,                            -- base_price_per_night
    'USD',                            -- currency_code
    '15:00:00',                       -- check_in_time
    '11:00:00',                       -- check_out_time
    true                              -- is_active
);

-- Item 3 Registrar huésped y reserva--
SELECT * FROM guests;
INSERT INTO guests (
    first_name,
    last_name,
    email,
    phone,
    date_of_birth,
    nationality,
    passport_number,
    emergency_contact_name,
    emergency_contact_phone
)
VALUES (
    'Maria Elena',
    'Echeverria',
    'maria.echeverria@gmail.com',
    '7000-1122',
    '1955-09-08',                 
    'Salvadoreña',
    '01234567-8',
    'Karla Mendoza',                 
    '2255-8899'                  
);
SELECT * FROM bookings;
INSERT INTO bookings (
    guest_id,
    accommodation_id,
    room_id,                          
    booking_status_id,
    check_in_date,
    check_out_date,
    adult_count,
    child_count,
    subtotal_amount,
    tax_amount,
    discount_amount,
    total_amount,
    special_requests,
    booking_reference
)
VALUES (
    101,                                      -- El código de Maria Elena Echeverria
    23,                                       
    NULL,                              
    1,                                        
    '2026-10-10',                      
    '2026-10-12',                      
    1,                                 
    0,                                 
    90.00,                                
    0.00,                              
    0.00,                              
    90.00,                            
    'Contacto de emergencia: Karla Mendoza.', 
    'BK-MECHEVERRIA-101-2026'                 
);



--ITEM 3Registrar huésped y reserva
INSERT INTO bookings (
    guest_id,
    accommodation_id,
    room_id,                          
    booking_status_id,
    check_in_date,
    check_out_date,
    adult_count,
    child_count,
    subtotal_amount,
    tax_amount,
    discount_amount,
    total_amount,
    special_requests,
    booking_reference
)
VALUES (
    101,                                             
    (SELECT max(accommodation_id) FROM accommodations), 
    NULL,                              
    1,                                                
    '2026-10-10',                      
    '2026-10-12',                      
    1,                                 
    0,                                 
    90.00,                                         
    0.00,                              
    0.00,                              
    90.00,                            
    'Contacto de emergencia: Karla Mendoza.',         
    'BK-MECHEVERRIA-101-2026'                       
);

SELECT * FROM bookings ;

-- 	item 4 Registrar pago---
SELECT * FROM payments;
INSERT INTO payments (
    booking_id,
    payment_date,
    amount,
    payment_method,
    payment_status,
    transaction_reference,
    notes                                                    
)
VALUES (
    (SELECT booking_id FROM bookings WHERE booking_reference = 'BK-MECHEVERRIA-101-2026'), 
    NOW(),                                                    
    90.00,                                                    
    'Efectivo',                                               
    'Completado',                                             
    'TR-PAGO-101-2026',                                       
    'Pago completo de la estadía para las prácticas de Karla Mendoza INFRAMEN.'
);

--Item 5 Filtrar activos

SELECT accommodation_id, name, base_price_per_night, is_active 
FROM accommodations 
WHERE is_active = true;

--Item 6 Filtrar activos
SELECT guest_id, first_name, last_name, nationality, email 
FROM guests 
WHERE nationality = 'Salvadoreña';

--item 7  Reserva por fechas
SELECT booking_id, guest_id, accommodation_id, check_in_date, total_amount
FROM bookings
WHERE check_in_date BETWEEN '2026-07-01' AND '2026-10-31';

--item 8  Actualizar precio
UPDATE accommodations
SET base_price_per_night = 35.00
WHERE name = 'Alojamiento Karla Mendoza';

--item 9  Estado de la reserva
UPDATE bookings
SET booking_status_id = 2                      
WHERE booking_reference = 'BK-MECHEVERRIA-101-2026';

-- item 10 eliminar Reseña
DELETE FROM reviews
WHERE review_id = 1;

--item 11  Reservas + huésped
SELECT 
    a.booking_id,
    a.booking_reference,
    b.first_name,
    b.last_name,
    a.check_in_date,
    a.total_amount
FROM bookings a                  
INNER JOIN guests b             
    ON a.guest_id = b.guest_id; 

--item 12  Alojamiento completo
SELECT 
    a.accommodation_id,
    a.name AS nombre_alojamiento,
    b.first_name AS nombre_propietario,
    b.last_name AS apellido_propietario,
    c.city AS ciudad_ubicacion,          
    c.state AS departamento_ubicacion,
    a.base_price_per_night,
    a.max_guests,
    a.is_active
FROM accommodations a             
INNER JOIN owners b               
    ON a.owner_id = b.owner_id
INNER JOIN locations c            
    ON a.location_id = c.location_id;

--Item 13 Pagos + reservas

SELECT 
    a.payment_id,
    a.amount AS monto_pagado,
    a.payment_method AS metodo_pago,
    b.booking_reference AS referencia_reserva,
    b.check_in_date AS fecha_entrada
FROM payments a                 -- 'a' es la tabla de Pagos
INNER JOIN bookings b           -- 'b' es la tabla de Reservas
    ON a.booking_id = b.booking_id;

--Item 14 Sin reseñas
SELECT 
    a.accommodation_id,
    a.name AS nombre_alojamiento,
    b.review_id,
    b.rating AS calificacion,
    b.review_title AS titulo_comentario,
    b.review_text AS detalle_comentario
FROM accommodations a                     
LEFT JOIN reviews b                       
    ON a.accommodation_id = b.accommodation_id
WHERE b.review_id IS NULL;


--Item 15  sin reservas
SELECT 
    a.guest_id,
    a.first_name AS nombre_huesped,
    a.last_name AS apellido_huesped,
    b.booking_id,
    b.booking_reference AS referencia_reserva
FROM guests a                            
LEFT JOIN bookings b                     
    ON a.guest_id = b.guest_id
WHERE b.booking_id IS NULL;              !

--Item 16 Total ingresos  
SELECT 
    SUM(amount) AS total_ingresos
FROM payments;

-- Item 17  Promedio rating
SELECT 
    AVG(rating) AS promedio_rating
FROM reviews;

--Item 18  Top Alojamientos
SELECT 
    a.accommodation_id,
    a.name AS nombre_alojamiento,
    COUNT(b.booking_id) AS total_reservas    
FROM accommodations a
INNER JOIN bookings b 
    ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name          
ORDER BY total_reservas DESC                 
LIMIT 5;                                     

--Item 19  mas de 3 reservas
SELECT 
    a.accommodation_id,
    a.name AS nombre_alojamiento,
    COUNT(b.booking_id) AS total_reservas
FROM accommodations a
INNER JOIN bookings b 
    ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name
HAVING COUNT(b.booking_id) > 3;

--Item 20  Alojamiento mas caro
SELECT 
    a.accommodation_id,
    a.name AS nombre_alojamiento,
    r.room_id,
    r.room_name AS nombre_habitacion,
    r.room_price_per_night AS precio_maximo
FROM accommodations a
INNER JOIN rooms r 
    ON a.accommodation_id = r.accommodation_id
WHERE r.room_price_per_night = (
    SELECT MAX(room_price_per_night) 
    FROM rooms
);
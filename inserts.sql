--inserts.sql  

--clientes

INSERT INTO clientes (nombre) VALUES 
('Empresa cliente 1'), 
('Empresa cliente 2'),  
('Empresa cliente 3'),  
('Empresa cliente 4'), ('Empresa cliente 5'),
('Empresa cliente 6'), ('Empresa cliente 7'), ('Empresa cliente 8');
SELECT * FROM `freelancers` WHERE 1

--freelancers

INSERT INTO freelancers (nombre, especialidad, fecha_registro, tarifa_hora)
VALUES
 ('Ana Gomez', 'Desarrollo web', '2025-01-10', 25000), 
 ('Luis Perez', 'Diseño grafico', '2025-01-15', 20000), 
 ('Maria Lopez', 'Desarrollo web', '2025-01-20', 30000), 
 ('Carlos Soto', 'Marketing Digital', '2025-02-01', 18000),
 ('Crist Warhol', 'Diseño grafico', '2025-02-05', 22000), 
 ('Felipe Gonzalez', 'Desarrollo web', '2025-02-10', 45000),
 ('Mora Lupita', 'Marketing Digital', '2025-02-12', 15000), 
 ('Tomas Sanabria', 'data science', '2025-02-12', 50000), 
 ('Valery Sierra', 'Desarrollo web', '2025-02-20', 28000); 

--proyectos

INSERT INTO proyectos (id_cliente, titulo, descripcion, presupuesto_maximo, fecha_limite) VALUES 
(1, 'Landing Page', 'Página de aterrizaje...', 300000, '2025-02-20'),
(2, 'Branding Empresa', 'Identidad visual...', 500000, '2025-03-01'),
(3, 'E-commerce', 'Tienda virtual...', 1200000, '2025-04-01'),
(3, 'App Móvil', 'Aplicación interna...', 800000, '2025-04-15'),
(1, 'SEO Posicionamiento', 'Estrategia SEO...', 400000, '2025-03-15'),
(4, 'Campaña publicidad', 'Gestión de pauta...', 250000, '2025-05-10'),
(5, 'Dashboard BI', 'Tablero en power BI...', 600000, '2025-06-01'),
(6, 'Seguridad web', 'Auditoría técnica...', 150000, '2025-04-30'),
(2, 'Video Corporativo', 'Edición de video...', 450000, '2025-05-20'),
(1, 'Redacción blog', '10 artículos tech...', 100000, '2025-06-15');
SELECT * FROM `freelancers` WHERE 1

-- postulaciones

INSERT INTO postulaciones (id_freelancer, id_proyecto, propuesta_economica, mensaje, fecha_postulacion)
VALUES

 ( 1, 1, 280000, 'Experiencia en HTML/CSS', '2025-01-15'), 
 ( 2, 2, 450000, 'Propuesta integral de marca', '2025-01-20'), 
 (3, 3, 1150000, 'Experiencia en tiendas online', '2025-01-22'),
 (3, 4, 780000, 'Desarrollo con React Native', '2025-01-25'), 
 (4, 5, 380000, 'Estrategia completa SEO', '2025-02-05'), 
 ( 6, 1, 295000, 'Desarrollador Senior con disponibilidad inmediata', '2025-01-16'),
 (9, 3, 1100000, 'Especialista en Shopify (otras plataformas e-commerce) y pasarelas de pago', '2025-01-24'),
 (8, 7, 580000, 'Analista de datos con experiencia en BI', '2025-02-15'),
 (5, 8, 145000, 'Experto en seguridad y certificados SSL', '2025-02-20'),
 (7, 10, 98000, 'Copywriter con enfoque en SEO y tecnología', '2025-02-25');

--asignaciones

INSERT INTO asignaciones (id_postulacion, fecha_asignacion)
VALUES

 (1, '2025-01-20'),
 (2, '2025-01-28'), 
 (5, '2025-02-10'),
 (7, '2025-02-15'), 
 (8, '2025-03-05'), 
 (9, '2025-03-10'), 
 (10, '2025-03-20'), 
 (6, '2025-03-25');

--pagos

INSERT INTO pagos (id_proyecto, monto_pagado, fecha_pago)
VALUES
 (1, 140000, '2025-01-25'),
 (1, 140000, '2025-02-10'),
 (2, 450000, '2025-02-05'),
 (5, 190000, '2025-02-15'),
 (5, 190000, '2025-02-28'),
 (6, 250000, '2025-04-01'), 
 (7, 300000, '2025-04-10'), 
 (8, 150000, '2025-04-15'), 
 (9, 200000, '2025-04-20'), 
 (10, 100000, '2025-05-01'); 

--reportes.sql

--1. Listar todos los freelancers con su especialidad y tarifa por hora, incluyendo aquellos que nunca han sido asignados a un proyecto.

SELECT f.nombre, f.especialidad, f.tarifa_hora
FROM freelancers f
LEFT JOIN postulaciones p ON f.id_freelancer = p.id_freelancer
LEFT JOIN asignaciones a ON p.id_postulacion = a.id_postulacion
GROUP BY f.id_freelancer, f.nombre, f.especialidad, f.tarifa_hora;


--2. Mostrar todos los proyectos junto con el nombre del freelancer asignado (si lo tienen) y la cantidad total pagada hasta el momento.

SELECT
    p.titulo,
    f.nombre AS freelancer_asignado,
    (SELECT COALESCE(SUM(monto_pagado), 0) 
     FROM pagos pa 
     WHERE pa.id_proyecto = p.id_proyecto) AS total_pagado
FROM proyectos p
LEFT JOIN postulaciones pos ON p.id_proyecto = pos.id_proyecto
LEFT JOIN asignaciones a ON pos.id_postulacion = a.id_postulacion
LEFT JOIN freelancers f ON pos.id_freelancer = f.id_freelancer
WHERE a.id_asignacion IS NOT NULL
   OR pos.id_postulacion IS NULL;


--3. Listar los freelancers que han postulado a proyectos pero que aún no han sido asignados a ninguno.

SELECT DISTINCT f.nombre
FROM freelancers f
INNER JOIN postulaciones p ON f.id_freelancer = p.id_freelancer
WHERE NOT EXISTS (
    SELECT 1 FROM asignaciones a 
    WHERE a.id_postulacion = p.id_postulacion
);



--4 Mostrar por cada proyecto el título, el presupuesto máximo, la postulación más alta recibida y la más baja recibida.

SELECT p.titulo, p.presupuesto_maximo, 
       MAX(pos.propuesta_economica) AS postulacion_mas_alta, 
       MIN(pos.propuesta_economica) AS postulacion_mas_baja
FROM proyectos p
LEFT JOIN postulaciones pos ON p.id_proyecto = pos.id_proyecto
GROUP BY p.id_proyecto, p.titulo, p.presupuesto_maximo;


--5. Listar todos los clientes (considerando que el cliente se identifica por el proyecto que publica) junto con el número de proyectos publicados, incluyendo aquellos que no tienen proyectos.

SELECT c.nombre, COUNT(p.id_proyecto) AS numero_proyectos
FROM clientes c
LEFT JOIN proyectos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre;


--6. Mostrar los freelancers que tienen una tarifa por hora superior al promedio de su misma especialidad.

SELECT nombre, especialidad, tarifa_hora
FROM freelancers f1
WHERE tarifa_hora > (
    SELECT AVG(tarifa_hora) 
    FROM freelancers f2 
    WHERE f1.especialidad = f2.especialidad
);


--7. Listar los proyectos que tienen pagos registrados pero cuyo total pagado aún no alcanza el presupuesto máximo del proyecto.

SELECT p.titulo, p.presupuesto_maximo, SUM(pa.monto_pagado) AS total_pagado
FROM proyectos p
INNER JOIN pagos pa ON p.id_proyecto = pa.id_proyecto
GROUP BY p.id_proyecto, p.titulo, p.presupuesto_maximo
HAVING total_pagado < p.presupuesto_maximo;


--8. Mostrar todos los freelancers, indicando el número de postulaciones que han realizado, el número de asignaciones recibidas, y la suma total pagada en los proyectos asignados (mostrar 0 si no tienen).

SELECT
    f.nombre,
    (SELECT COUNT(*) 
     FROM postulaciones p 
     WHERE p.id_freelancer = f.id_freelancer
    ) AS total_postulaciones,
    
    (SELECT COUNT(*) 
     FROM asignaciones a
     INNER JOIN postulaciones p ON a.id_postulacion = p.id_postulacion
     WHERE p.id_freelancer = f.id_freelancer
    ) AS total_asignaciones,
    
    COALESCE((
        SELECT SUM(pa.monto_pagado)
        FROM pagos pa
        WHERE pa.id_proyecto IN (
            SELECT pos.id_proyecto
            FROM postulaciones pos
            INNER JOIN asignaciones asig ON pos.id_postulacion = asig.id_postulacion
            WHERE pos.id_freelancer = f.id_freelancer
        )
    ), 0) AS total_cobrado

FROM freelancers f;

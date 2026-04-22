CREATE TABLE clientes(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(90)
);

CREATE TABLE freelancers(
    id_freelancer INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(90),
    especialidad VARCHAR(120),
    fecha_registro DATE NOT NULL,
    tarifa_hora DECIMAL NOT NULL
);

CREATE TABLE proyectos(
    id_proyecto INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    titulo VARCHAR(140),
    descripcion TEXT,
    presupuesto_maximo DECIMAL NOT NULL,
    fecha_limite DATE NOT NULL,
    
    CONSTRAINT fk_clientes_proyectos
    FOREIGN KEY(id_cliente)
    REFERENCES clientes(id_cliente)
);

CREATE TABLE postulaciones(
    id_postulacion INT AUTO_INCREMENT PRIMARY KEY,
    id_freelancer INT NOT NULL,
    id_proyecto INT NOT NULL,
    propuesta_economica DECIMAL NOT NULL,
    mensaje TEXT,
    fecha_postulacion DATE NOT NULL,
    
    CONSTRAINT fk_freelancers_postulaciones
    FOREIGN KEY(id_freelancer)
    REFERENCES freelancers(id_freelancer),
    
    CONSTRAINT fk_proyectos_postulaciones
    FOREIGN KEY(id_proyecto)
    REFERENCES proyectos(id_proyecto)
);

CREATE TABLE asignaciones(
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_postulacion INT NOT NULL UNIQUE,
    fecha_asignacion DATE,
    
    CONSTRAINT fk_postulaciones_asignaciones
    FOREIGN KEY(id_postulacion)
    REFERENCES postulaciones(id_postulacion)

);

CREATE TABLE pagos(
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_proyecto INT NOT NULL,
    monto_pagado DECIMAL,
    fecha_pago DATE,
    
    CONSTRAINT fk_proyectos_pagos
    FOREIGN KEY (id_proyecto)
    REFERENCES proyectos(id_proyecto)
);
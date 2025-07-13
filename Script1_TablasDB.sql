-- Tabla Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    tipo_cliente VARCHAR(50), -- Empresa o Particular
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- Tabla Equipo
CREATE TABLE Equipo (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    tipo VARCHAR(50),
    marca VARCHAR(50),
    modelo VARCHAR(50),
    numero_serie INT,
    fecha_ingreso DATE,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabla Técnico
CREATE TABLE Tecnico (
    id_tecnico INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    especialidad VARCHAR(100),
    disponibilidad BOOLEAN DEFAULT TRUE
);

-- Tabla Orden de Servicio
CREATE TABLE Orden_Servicio (
    id_orden INT PRIMARY KEY AUTO_INCREMENT,
    id_equipo INT,
    id_tecnico INT,
    tipo_servicio VARCHAR(100),
    estado VARCHAR(50), -- Ej: Pendiente, En proceso, Finalizado
    fecha_ingreso DATE,
    fecha_entrega DATE,
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo),
    FOREIGN KEY (id_tecnico) REFERENCES Tecnico(id_tecnico)
);

-- Tabla Detalle de Servicio
CREATE TABLE Detalle_Servicio (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_orden INT,
    descripcion TEXT,
    repuestos_utilizados TEXT,
    costo DECIMAL(10,2),
    FOREIGN KEY (id_orden) REFERENCES Orden_Servicio(id_orden)
);

-- Tabla Contrato de Mantenimiento
CREATE TABLE Contrato_Mantenimiento (
    id_contrato INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    tipo_contrato VARCHAR(50), -- Preventivo, Correctivo, Mixto
    estado VARCHAR(50),        -- Vigente, Vencido, Cancelado
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

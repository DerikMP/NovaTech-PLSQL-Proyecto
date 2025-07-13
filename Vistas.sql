-- ======================================
-- Script: Vistas.sql
-- Descripción: Vistas útiles para el sistema NovaTech Solutions
-- ======================================

-- Vista 1: Información consolidada de órdenes de servicio
CREATE OR REPLACE VIEW VW_ORDENES_DETALLADAS AS
SELECT
    os.id_orden,
    c.nombre AS nombre_cliente,
    t.nombre AS nombre_tecnico,
    os.fecha_inicio,
    os.fecha_fin,
    os.estado,
    os.tipo_servicio
FROM orden_servicio os
JOIN equipo e ON os.id_equipo = e.id_equipo
JOIN cliente c ON e.id_cliente = c.id_cliente
JOIN tecnico t ON os.id_tecnico = t.id_tecnico;

-- Vista 2: Equipos por cliente
CREATE OR REPLACE VIEW VW_EQUIPOS_CLIENTE AS
SELECT
    c.id_cliente,
    c.nombre AS nombre_cliente,
    e.id_equipo,
    e.tipo,
    e.marca,
    e.modelo,
    e.numero_serie,
    e.fecha_ingreso
FROM cliente c
JOIN equipo e ON c.id_cliente = e.id_cliente;

-- Vista 3: Contratos de mantenimiento activos
CREATE OR REPLACE VIEW VW_CONTRATOS_ACTIVOS AS
SELECT
    cm.id_contrato,
    c.nombre AS nombre_cliente,
    cm.fecha_inicio,
    cm.fecha_fin,
    cm.condiciones
FROM contrato_mantenimiento cm
JOIN cliente c ON cm.id_cliente = c.id_cliente
WHERE cm.fecha_fin >= SYSDATE;

-- Fin del archivo Vistas.sql

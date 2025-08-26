-- ======================================
-- Script: Triggers.sql
-- Descripción: Triggers para validaciones automáticas
-- ======================================

-- Trigger 1: Validar correo electrónico antes de insertar en CLIENTE
CREATE OR REPLACE TRIGGER TRG_VALIDAR_CORREO_CLIENTE
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
  IF NOT REGEXP_LIKE(:NEW.email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Correo electrónico no válido');
  END IF;
END;
/

-- Trigger 2: Establecer estado por defecto en ORDEN_SERVICIO al insertar
CREATE OR REPLACE TRIGGER TRG_ESTADO_POR_DEFECTO_ORDEN
BEFORE INSERT ON orden_servicio
FOR EACH ROW
BEGIN
  IF :NEW.estado IS NULL THEN
    :NEW.estado := 'Pendiente';
  END IF;
END;
/

-- Trigger 3: Auditar eliminaciones de técnicos (guardar en tabla log_tecnico)
CREATE TABLE log_tecnico (
    id_log NUMBER GENERATED ALWAYS AS IDENTITY,
    id_tecnico NUMBER,
    nombre_tecnico VARCHAR2(50),
    fecha_eliminacion DATE
);

CREATE OR REPLACE TRIGGER TRG_AUDITAR_TECNICO
AFTER DELETE ON tecnico
FOR EACH ROW
BEGIN
  INSERT INTO log_tecnico (id_tecnico, nombre_tecnico, fecha_eliminacion)
  VALUES (:OLD.id_tecnico, :OLD.nombre, SYSDATE);
END;
/

-- Fin del archivo Triggers.sql



-- ======================================
-- Actualizacion final de proyecto triggers
-- ======================================

-- Trigger 4: Validar fechas en contratos de mantenimiento
CREATE OR REPLACE TRIGGER TRG_VALIDAR_FECHAS_CONTRATO
BEFORE INSERT OR UPDATE ON contrato_mantenimiento
FOR EACH ROW
BEGIN
  IF :NEW.fecha_fin < :NEW.fecha_inicio THEN
    RAISE_APPLICATION_ERROR(-20002, 'La fecha de fin no puede ser anterior a la fecha de inicio del contrato');
  END IF;
END;
/

-- Trigger 5: Auditoría de creación de órdenes de servicio
CREATE TABLE log_orden_servicio (
    id_log NUMBER GENERATED ALWAYS AS IDENTITY,
    id_orden NUMBER,
    id_cliente NUMBER,
    id_tecnico NUMBER,
    fecha_creacion DATE
);

CREATE OR REPLACE TRIGGER TRG_AUDITAR_INSERCION_ORDEN
AFTER INSERT ON orden_servicio
FOR EACH ROW
BEGIN
  INSERT INTO log_orden_servicio (id_orden, id_cliente, id_tecnico, fecha_creacion)
  VALUES (:NEW.id_orden, :NEW.id_equipo, :NEW.id_tecnico, SYSDATE);
END;
/

-- Trigger 6: Evitar eliminación de clientes con equipos asociados
CREATE OR REPLACE TRIGGER TRG_EVITAR_ELIMINAR_CLIENTE
BEFORE DELETE ON cliente
FOR EACH ROW
DECLARE
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count
  FROM equipo
  WHERE id_cliente = :OLD.id_cliente;

  IF v_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20003, 'No se puede eliminar el cliente porque tiene equipos asociados');
  END IF;
END;
/

-- Fin de los triggers adicionales

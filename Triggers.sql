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

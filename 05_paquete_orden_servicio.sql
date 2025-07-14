-- ================================
-- ESPECIFICACIÓN DEL PAQUETE
-- ================================
CREATE OR REPLACE PACKAGE PAQ_ORDEN_SERVICIO AS
  -- Inserta una nueva orden de servicio
  PROCEDURE insertar_orden(
    p_id_equipo INT,
    p_id_tecnico INT,
    p_tipo_servicio VARCHAR2,
    p_estado VARCHAR2,
    p_fecha_ingreso DATE,
    p_fecha_entrega DATE
  );

  -- Actualiza una orden existente
  PROCEDURE actualizar_orden(
    p_id_orden INT,
    p_id_equipo INT,
    p_id_tecnico INT,
    p_tipo_servicio VARCHAR2,
    p_estado VARCHAR2,
    p_fecha_ingreso DATE,
    p_fecha_entrega DATE
  );

  -- Elimina una orden
  PROCEDURE eliminar_orden(p_id_orden INT);

  -- Busca una orden por ID
  PROCEDURE buscar_orden(p_id_orden INT, p_cursor OUT SYS_REFCURSOR);

  -- Lista todas las órdenes
  PROCEDURE listar_ordenes(p_cursor OUT SYS_REFCURSOR);

  -- Cuenta órdenes por estado
  FUNCTION fn_contar_ordenes_estado(p_estado VARCHAR2) RETURN INT;
END PAQ_ORDEN_SERVICIO;
/
-- ================================
-- CUERPO DEL PAQUETE
-- ================================
CREATE OR REPLACE PACKAGE BODY PAQ_ORDEN_SERVICIO AS

  PROCEDURE insertar_orden(
    p_id_equipo INT,
    p_id_tecnico INT,
    p_tipo_servicio VARCHAR2,
    p_estado VARCHAR2,
    p_fecha_ingreso DATE,
    p_fecha_entrega DATE
  ) IS
  BEGIN
    INSERT INTO ORDEN_SERVICIO (id_equipo, id_tecnico, tipo_servicio, estado, fecha_ingreso, fecha_entrega)
    VALUES (p_id_equipo, p_id_tecnico, p_tipo_servicio, p_estado, p_fecha_ingreso, p_fecha_entrega);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar orden: ' || SQLERRM);
  END;

  PROCEDURE actualizar_orden(
    p_id_orden INT,
    p_id_equipo INT,
    p_id_tecnico INT,
    p_tipo_servicio VARCHAR2,
    p_estado VARCHAR2,
    p_fecha_ingreso DATE,
    p_fecha_entrega DATE
  ) IS
  BEGIN
    UPDATE ORDEN_SERVICIO
    SET id_equipo = p_id_equipo,
        id_tecnico = p_id_tecnico,
        tipo_servicio = p_tipo_servicio,
        estado = p_estado,
        fecha_ingreso = p_fecha_ingreso,
        fecha_entrega = p_fecha_entrega
    WHERE id_orden = p_id_orden;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al actualizar orden: ' || SQLERRM);
  END;

  PROCEDURE eliminar_orden(p_id_orden INT) IS
  BEGIN
    DELETE FROM ORDEN_SERVICIO WHERE id_orden = p_id_orden;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al eliminar orden: ' || SQLERRM);
  END;

  PROCEDURE buscar_orden(p_id_orden INT, p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM ORDEN_SERVICIO WHERE id_orden = p_id_orden;
  END;

  PROCEDURE listar_ordenes(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM ORDEN_SERVICIO;
  END;

  FUNCTION fn_contar_ordenes_estado(p_estado VARCHAR2) RETURN INT IS
    v_total INT;
  BEGIN
    SELECT COUNT(*) INTO v_total
    FROM ORDEN_SERVICIO
    WHERE UPPER(estado) = UPPER(p_estado);
    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END PAQ_ORDEN_SERVICIO;
/

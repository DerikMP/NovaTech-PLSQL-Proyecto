-- ==================================
-- ESPECIFICACIÓN DEL PAQUETE
-- ==================================
CREATE OR REPLACE PACKAGE PAQ_DETALLE_SERVICIO AS
  -- Inserta un nuevo detalle
  PROCEDURE insertar_detalle(
    p_id_orden INT,
    p_descripcion TEXT,
    p_repuestos_utilizados TEXT,
    p_costo DECIMAL
  );

  -- Actualiza un detalle existente
  PROCEDURE actualizar_detalle(
    p_id_detalle INT,
    p_id_orden INT,
    p_descripcion TEXT,
    p_repuestos_utilizados TEXT,
    p_costo DECIMAL
  );

  -- Elimina un detalle por su ID
  PROCEDURE eliminar_detalle(p_id_detalle INT);

  -- Busca un detalle por ID
  PROCEDURE buscar_detalle(p_id_detalle INT, p_cursor OUT SYS_REFCURSOR);

  -- Lista todos los detalles de servicio
  PROCEDURE listar_detalles(p_cursor OUT SYS_REFCURSOR);

  -- Calcula el costo total de una orden
  FUNCTION fn_total_costo_orden(p_id_orden INT) RETURN DECIMAL;
END PAQ_DETALLE_SERVICIO;
/
-- ===============================
-- CUERPO DEL PAQUETE
-- ===============================
CREATE OR REPLACE PACKAGE BODY PAQ_DETALLE_SERVICIO AS

  PROCEDURE insertar_detalle(
    p_id_orden INT,
    p_descripcion TEXT,
    p_repuestos_utilizados TEXT,
    p_costo DECIMAL
  ) IS
  BEGIN
    INSERT INTO DETALLE_SERVICIO (
      id_orden,
      descripcion,
      repuestos_utilizados,
      costo
    ) VALUES (
      p_id_orden,
      p_descripcion,
      p_repuestos_utilizados,
      p_costo
    );
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar detalle: ' || SQLERRM);
  END;

  PROCEDURE actualizar_detalle(
    p_id_detalle INT,
    p_id_orden INT,
    p_descripcion TEXT,
    p_repuestos_utilizados TEXT,
    p_costo DECIMAL
  ) IS
  BEGIN
    UPDATE DETALLE_SERVICIO
    SET id_orden = p_id_orden,
        descripcion = p_descripcion,
        repuestos_utilizados = p_repuestos_utilizados,
        costo = p_costo
    WHERE id_detalle = p_id_detalle;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al actualizar detalle: ' || SQLERRM);
  END;

  PROCEDURE eliminar_detalle(p_id_detalle INT) IS
  BEGIN
    DELETE FROM DETALLE_SERVICIO WHERE id_detalle = p_id_detalle;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al eliminar detalle: ' || SQLERRM);
  END;

  PROCEDURE buscar_detalle(p_id_detalle INT, p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM DETALLE_SERVICIO WHERE id_detalle = p_id_detalle;
  END;

  PROCEDURE listar_detalles(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM DETALLE_SERVICIO;
  END;

  FUNCTION fn_total_costo_orden(p_id_orden INT) RETURN DECIMAL IS
    v_total DECIMAL := 0;
  BEGIN
    SELECT NVL(SUM(costo), 0)
    INTO v_total
    FROM DETALLE_SERVICIO
    WHERE id_orden = p_id_orden;

    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END PAQ_DETALLE_SERVICIO;
/

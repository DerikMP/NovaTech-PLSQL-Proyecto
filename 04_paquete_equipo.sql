-- ================================
-- ESPECIFICACIÓN DEL PAQUETE
-- ================================
CREATE OR REPLACE PACKAGE PAQ_EQUIPO AS
  -- Inserta un nuevo equipo
  PROCEDURE insertar_equipo(
    p_id_cliente INT,
    p_tipo VARCHAR2,
    p_marca VARCHAR2,
    p_modelo VARCHAR2,
    p_numero_serie INT,
    p_fecha_ingreso DATE
  );

  -- Actualiza un equipo existente
  PROCEDURE actualizar_equipo(
    p_id_equipo INT,
    p_id_cliente INT,
    p_tipo VARCHAR2,
    p_marca VARCHAR2,
    p_modelo VARCHAR2,
    p_numero_serie INT,
    p_fecha_ingreso DATE
  );

  -- Elimina un equipo
  PROCEDURE eliminar_equipo(p_id_equipo INT);

  -- Busca un equipo por ID
  PROCEDURE buscar_equipo(p_id_equipo INT, p_cursor OUT SYS_REFCURSOR);

  -- Lista todos los equipos
  PROCEDURE listar_equipos(p_cursor OUT SYS_REFCURSOR);

  -- Cuenta los equipos registrados de un cliente
  FUNCTION fn_contar_equipos_cliente(p_id_cliente INT) RETURN INT;
END PAQ_EQUIPO;
/
-- ================================
-- CUERPO DEL PAQUETE
-- ================================
CREATE OR REPLACE PACKAGE BODY PAQ_EQUIPO AS

  PROCEDURE insertar_equipo(
    p_id_cliente INT,
    p_tipo VARCHAR2,
    p_marca VARCHAR2,
    p_modelo VARCHAR2,
    p_numero_serie INT,
    p_fecha_ingreso DATE
  ) IS
  BEGIN
    INSERT INTO EQUIPO (id_cliente, tipo, marca, modelo, numero_serie, fecha_ingreso)
    VALUES (p_id_cliente, p_tipo, p_marca, p_modelo, p_numero_serie, p_fecha_ingreso);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar equipo: ' || SQLERRM);
  END;

  PROCEDURE actualizar_equipo(
    p_id_equipo INT,
    p_id_cliente INT,
    p_tipo VARCHAR2,
    p_marca VARCHAR2,
    p_modelo VARCHAR2,
    p_numero_serie INT,
    p_fecha_ingreso DATE
  ) IS
  BEGIN
    UPDATE EQUIPO
    SET id_cliente = p_id_cliente,
        tipo = p_tipo,
        marca = p_marca,
        modelo = p_modelo,
        numero_serie = p_numero_serie,
        fecha_ingreso = p_fecha_ingreso
    WHERE id_equipo = p_id_equipo;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al actualizar equipo: ' || SQLERRM);
  END;

  PROCEDURE eliminar_equipo(p_id_equipo INT) IS
  BEGIN
    DELETE FROM EQUIPO WHERE id_equipo = p_id_equipo;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al eliminar equipo: ' || SQLERRM);
  END;

  PROCEDURE buscar_equipo(p_id_equipo INT, p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM EQUIPO WHERE id_equipo = p_id_equipo;
  END;

  PROCEDURE listar_equipos(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM EQUIPO;
  END;

  FUNCTION fn_contar_equipos_cliente(p_id_cliente INT) RETURN INT IS
    v_total INT;
  BEGIN
    SELECT COUNT(*) INTO v_total
    FROM EQUIPO
    WHERE id_cliente = p_id_cliente;
    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END PAQ_EQUIPO;
/

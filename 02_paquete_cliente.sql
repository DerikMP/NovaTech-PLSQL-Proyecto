-- =============================
-- ESPECIFICACIÓN DEL PAQUETE
-- =============================
CREATE OR REPLACE PACKAGE PAQ_CLIENTE AS
  -- Inserta un nuevo cliente en la tabla CLIENTE
  PROCEDURE crear_cliente(p_nombre VARCHAR2, p_tipo_cliente VARCHAR2, p_email VARCHAR2);

  PROCEDURE actualizar_cliente(p_id_cliente NUMBER, p_nombre VARCHAR2, p_tipo_cliente VARCHAR2, p_email VARCHAR2);
  PROCEDURE eliminar_cliente(p_id_cliente NUMBER);
  PROCEDURE buscar_cliente(p_id_cliente NUMBER, p_cursor OUT SYS_REFCURSOR);
  PROCEDURE listar_clientes(p_cursor OUT SYS_REFCURSOR);

  FUNCTION fn_validar_correo(p_email VARCHAR2) RETURN BOOLEAN;
  FUNCTION fn_es_cliente_empresa(p_id_cliente NUMBER) RETURN BOOLEAN;
  FUNCTION fn_contar_ordenes_cliente(p_id_cliente NUMBER) RETURN NUMBER;
END PAQ_CLIENTE;
/

-- ===========================
-- CUERPO DEL PAQUETE
-- ===========================
CREATE OR REPLACE PACKAGE BODY PAQ_CLIENTE AS

  PROCEDURE crear_cliente(p_nombre VARCHAR2, p_tipo_cliente VARCHAR2, p_email VARCHAR2) IS
  BEGIN
    IF fn_validar_correo(p_email) THEN
      INSERT INTO CLIENTE (NOMBRE, TIPO_CLIENTE, EMAIL)
      VALUES (p_nombre, p_tipo_cliente, p_email);
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Correo no válido.');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar cliente: ' || SQLERRM);
  END;

  PROCEDURE actualizar_cliente(p_id_cliente NUMBER, p_nombre VARCHAR2, p_tipo_cliente VARCHAR2, p_email VARCHAR2) IS
  BEGIN
    UPDATE CLIENTE
    SET NOMBRE = p_nombre,
        TIPO_CLIENTE = p_tipo_cliente,
        EMAIL = p_email
    WHERE ID_CLIENTE = p_id_cliente;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al actualizar cliente: ' || SQLERRM);
  END;

  PROCEDURE eliminar_cliente(p_id_cliente NUMBER) IS
  BEGIN
    DELETE FROM CLIENTE WHERE ID_CLIENTE = p_id_cliente;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al eliminar cliente: ' || SQLERRM);
  END;

  PROCEDURE buscar_cliente(p_id_cliente NUMBER, p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM CLIENTE WHERE ID_CLIENTE = p_id_cliente;
  END;

  PROCEDURE listar_clientes(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM CLIENTE;
  END;

  FUNCTION fn_validar_correo(p_email VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
  END;

  FUNCTION fn_es_cliente_empresa(p_id_cliente NUMBER) RETURN BOOLEAN IS
    v_tipo_cliente VARCHAR2(20);
  BEGIN
    SELECT TIPO_CLIENTE INTO v_tipo_cliente
    FROM CLIENTE
    WHERE ID_CLIENTE = p_id_cliente;
    RETURN UPPER(v_tipo_cliente) = 'EMPRESA';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END;

  FUNCTION fn_contar_ordenes_cliente(p_id_cliente NUMBER) RETURN NUMBER IS
    v_total NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM ORDEN_SERVICIO os
    JOIN EQUIPO e ON os.ID_EQUIPO = e.ID_EQUIPO
    WHERE e.ID_CLIENTE = p_id_cliente;
    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END PAQ_CLIENTE;
/

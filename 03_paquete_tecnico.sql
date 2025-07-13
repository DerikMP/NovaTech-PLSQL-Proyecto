   -- =====================================
-- ESPECIFICACIÓN DEL PAQUETE PAQ_TECNICO
-- =====================================
CREATE OR REPLACE PACKAGE PAQ_TECNICO AS
  -- Inserta nuevo técnico
  PROCEDURE insertar_tecnico(p_nombre VARCHAR2, p_apellido VARCHAR2, p_especialidad VARCHAR2, p_email VARCHAR2);

  -- Actualiza los datos de un técnico
  PROCEDURE actualizar_tecnico(p_id_tecnico NUMBER, p_nombre VARCHAR2, p_apellido VARCHAR2, p_especialidad VARCHAR2, p_email VARCHAR2);

  -- Elimina un técnico
  PROCEDURE eliminar_tecnico(p_id_tecnico NUMBER);

  -- Busca un técnico por ID
  PROCEDURE buscar_tecnico(p_id_tecnico NUMBER, p_cursor OUT SYS_REFCURSOR);

  -- Lista todos los técnicos
  PROCEDURE listar_tecnicos(p_cursor OUT SYS_REFCURSOR);

  -- Valida si el correo del técnico es válido
  FUNCTION fn_validar_correo_tecnico(p_email VARCHAR2) RETURN BOOLEAN;

  -- Verifica si el técnico tiene una especialidad específica
  FUNCTION fn_es_especialista_en(p_id_tecnico NUMBER, p_especialidad VARCHAR2) RETURN BOOLEAN;

  -- Cuenta cuántas órdenes ha tenido asignadas el técnico
  FUNCTION fn_contar_ordenes_tecnico(p_id_tecnico NUMBER) RETURN NUMBER;
END PAQ_TECNICO;
/
-- ================================
-- CUERPO DEL PAQUETE PAQ_TECNICO
-- ================================
CREATE OR REPLACE PACKAGE BODY PAQ_TECNICO AS

  PROCEDURE insertar_tecnico(p_nombre VARCHAR2, p_apellido VARCHAR2, p_especialidad VARCHAR2, p_email VARCHAR2) IS
  BEGIN
    IF fn_validar_correo_tecnico(p_email) THEN
      INSERT INTO TECNICO (NOMBRE, APELLIDO, ESPECIALIDAD, EMAIL)
      VALUES (p_nombre, p_apellido, p_especialidad, p_email);
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Correo inválido');
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar técnico: ' || SQLERRM);
  END;

  PROCEDURE actualizar_tecnico(p_id_tecnico NUMBER, p_nombre VARCHAR2, p_apellido VARCHAR2, p_especialidad VARCHAR2, p_email VARCHAR2) IS
  BEGIN
    UPDATE TECNICO
    SET NOMBRE = p_nombre,
        APELLIDO = p_apellido,
        ESPECIALIDAD = p_especialidad,
        EMAIL = p_email
    WHERE ID_TECNICO = p_id_tecnico;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al actualizar técnico: ' || SQLERRM);
  END;

  PROCEDURE eliminar_tecnico(p_id_tecnico NUMBER) IS
  BEGIN
    DELETE FROM TECNICO WHERE ID_TECNICO = p_id_tecnico;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al eliminar técnico: ' || SQLERRM);
  END;

  PROCEDURE buscar_tecnico(p_id_tecnico NUMBER, p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM TECNICO WHERE ID_TECNICO = p_id_tecnico;
  END;

  PROCEDURE listar_tecnicos(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM TECNICO;
  END;

  FUNCTION fn_validar_correo_tecnico(p_email VARCHAR2) RETURN BOOLEAN IS
  BEGIN
    RETURN REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');
  END;

  FUNCTION fn_es_especialista_en(p_id_tecnico NUMBER, p_especialidad VARCHAR2) RETURN BOOLEAN IS
    v_especialidad VARCHAR2(50);
  BEGIN
    SELECT ESPECIALIDAD INTO v_especialidad
    FROM TECNICO
    WHERE ID_TECNICO = p_id_tecnico;

    RETURN UPPER(v_especialidad) = UPPER(p_especialidad);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
  END;

  FUNCTION fn_contar_ordenes_tecnico(p_id_tecnico NUMBER) RETURN NUMBER IS
    v_total NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM ORDEN_SERVICIO
    WHERE ID_TECNICO = p_id_tecnico;
    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END PAQ_TECNICO;
/
 
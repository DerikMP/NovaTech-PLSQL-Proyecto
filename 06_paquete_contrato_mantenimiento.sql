-- ===============================
-- ESPECIFICACIÓN DEL PAQUETE
-- ===============================
CREATE OR REPLACE PACKAGE PAQ_CONTRATO AS
  -- Inserta un nuevo contrato
  PROCEDURE insertar_contrato(
    p_id_cliente INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_tipo_contrato VARCHAR2,
    p_estado VARCHAR2
  );

  -- Actualiza un contrato existente
  PROCEDURE actualizar_contrato(
    p_id_contrato INT,
    p_id_cliente INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_tipo_contrato VARCHAR2,
    p_estado VARCHAR2
  );

  -- Elimina un contrato por ID
  PROCEDURE eliminar_contrato(p_id_contrato INT);

  -- Buscar un contrato por su ID
  PROCEDURE buscar_contrato(p_id_contrato INT, p_cursor OUT SYS_REFCURSOR);

  -- Lista todos los contratos
  PROCEDURE listar_contratos(p_cursor OUT SYS_REFCURSOR);

  -- Verifica si un contrato está vigente
  FUNCTION fn_contrato_vigente(p_id_contrato INT) RETURN BOOLEAN;

  -- Cuenta contratos activos de un cliente
  FUNCTION fn_contar_contratos_cliente(p_id_cliente INT) RETURN NUMBER;
END PAQ_CONTRATO;
/
-- =============================
-- CUERPO DEL PAQUETE
-- =============================
CREATE OR REPLACE PACKAGE BODY PAQ_CONTRATO AS

  PROCEDURE insertar_contrato(
    p_id_cliente INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_tipo_contrato VARCHAR2,
    p_estado VARCHAR2
  ) IS
  BEGIN
    INSERT INTO CONTRATO_MANTENIMIENTO (
      id_cliente,
      fecha_inicio,
      fecha_fin,
      tipo_contrato,
      estado
    ) VALUES (
      p_id_cliente,
      p_fecha_inicio,
      p_fecha_fin,
      p_tipo_contrato,
      p_estado
    );
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al insertar contrato: ' || SQLERRM);
  END;

  PROCEDURE actualizar_contrato(
    p_id_contrato INT,
    p_id_cliente INT,
    p_fecha_inicio DATE,
    p_fecha_fin DATE,
    p_tipo_contrato VARCHAR2,
    p_estado VARCHAR2
  ) IS
  BEGIN
    UPDATE CONTRATO_MANTENIMIENTO
    SET id_cliente = p_id_cliente,
        fecha_inicio = p_fecha_inicio,
        fecha_fin = p_fecha_fin,
        tipo_contrato = p_tipo_contrato,
        estado = p_estado
    WHERE id_contrato = p_id_contrato;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al actualizar contrato: ' || SQLERRM);
  END;

  PROCEDURE eliminar_contrato(p_id_contrato INT) IS
  BEGIN
    DELETE FROM CONTRATO_MANTENIMIENTO WHERE id_contrato = p_id_contrato;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error al eliminar contrato: ' || SQLERRM);
  END;

  PROCEDURE buscar_contrato(p_id_contrato INT, p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM CONTRATO_MANTENIMIENTO WHERE id_contrato = p_id_contrato;
  END;

  PROCEDURE listar_contratos(p_cursor OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN p_cursor FOR
    SELECT * FROM CONTRATO_MANTENIMIENTO;
  END;

  FUNCTION fn_contrato_vigente(p_id_contrato INT) RETURN BOOLEAN IS
    v_estado VARCHAR2(20);
    v_fecha_fin DATE;
  BEGIN
    SELECT estado, fecha_fin INTO v_estado, v_fecha_fin
    FROM CONTRATO_MANTENIMIENTO
    WHERE id_contrato = p_id_contrato;

    RETURN (UPPER(v_estado) = 'VIGENTE' AND SYSDATE <= v_fecha_fin);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN FALSE;
    WHEN OTHERS THEN
      RETURN FALSE;
  END;

  FUNCTION fn_contar_contratos_cliente(p_id_cliente INT) RETURN NUMBER IS
    v_total NUMBER := 0;
  BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM CONTRATO_MANTENIMIENTO
    WHERE id_cliente = p_id_cliente AND UPPER(estado) = 'VIGENTE';

    RETURN v_total;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN 0;
  END;

END PAQ_CONTRATO;
/

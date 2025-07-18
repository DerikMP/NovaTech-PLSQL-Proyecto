--------------------------------------------------------
-- Archivo creado  - lunes-julio-14-2025   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table CLIENTE
--------------------------------------------------------

  CREATE TABLE "DERIK"."CLIENTE" 
   (	"ID_CLIENTE" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APELLIDO" VARCHAR2(50 BYTE), 
	"TIPO_CLIENTE" VARCHAR2(10 BYTE), 
	"EMAIL" VARCHAR2(50 BYTE), 
	"TELEFONO" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CONTRATO_MANTENIMIENTO
--------------------------------------------------------

  CREATE TABLE "DERIK"."CONTRATO_MANTENIMIENTO" 
   (	"ID_CONTRATO" NUMBER(*,0), 
	"ID_CLIENTE" NUMBER(*,0), 
	"FECHA_INICIO" DATE, 
	"FECHA_FIN" DATE, 
	"TIPO_CONTRATO" VARCHAR2(50 BYTE), 
	"ESTADO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table DETALLE_SERVICIO
--------------------------------------------------------

  CREATE TABLE "DERIK"."DETALLE_SERVICIO" 
   (	"ID_DETALLE" NUMBER(*,0), 
	"ID_ORDEN" NUMBER(*,0), 
	"DESCRIPCION" VARCHAR2(200 BYTE), 
	"HORAS_TRABAJADAS" NUMBER(*,0), 
	"COSTO_APROXIMADO" NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table EQUIPO
--------------------------------------------------------

  CREATE TABLE "DERIK"."EQUIPO" 
   (	"ID_EQUIPO" NUMBER(*,0), 
	"ID_CLIENTE" NUMBER(*,0), 
	"TIPO" VARCHAR2(50 BYTE), 
	"MARCA" VARCHAR2(50 BYTE), 
	"MODELO" VARCHAR2(50 BYTE), 
	"NUMERO_SERIE" NUMBER(*,0), 
	"FECHA_INGRESO" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ESTADO_ORDEN
--------------------------------------------------------

  CREATE TABLE "DERIK"."ESTADO_ORDEN" 
   (	"ID_ESTADO" NUMBER GENERATED BY DEFAULT AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"DESCRIPCION" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table LOG_TECNICO
--------------------------------------------------------

  CREATE TABLE "DERIK"."LOG_TECNICO" 
   (	"ID_LOG" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"ID_TECNICO" NUMBER, 
	"NOMBRE_TECNICO" VARCHAR2(50 BYTE), 
	"FECHA_ELIMINACION" DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table ORDEN_SERVICIO
--------------------------------------------------------

  CREATE TABLE "DERIK"."ORDEN_SERVICIO" 
   (	"ID_ORDEN" NUMBER(*,0), 
	"ID_EQUIPO" NUMBER(*,0), 
	"ID_TECNICO" NUMBER(*,0), 
	"FECHA_INICIO" DATE, 
	"FECHA_FIN" DATE, 
	"ESTADO" VARCHAR2(50 BYTE), 
	"TIPO_SERVICIO" VARCHAR2(50 BYTE), 
	"ID_ESTADO" NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TECNICO
--------------------------------------------------------

  CREATE TABLE "DERIK"."TECNICO" 
   (	"ID_TECNICO" NUMBER(*,0), 
	"NOMBRE" VARCHAR2(50 BYTE), 
	"APELLIDO" VARCHAR2(50 BYTE), 
	"ESPECIALIDAD" VARCHAR2(50 BYTE), 
	"EMAIL" VARCHAR2(50 BYTE), 
	"TELEFONO" NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
REM INSERTING into DERIK.CLIENTE
SET DEFINE OFF;
Insert into DERIK.CLIENTE (ID_CLIENTE,NOMBRE,APELLIDO,TIPO_CLIENTE,EMAIL,TELEFONO) values (1,'Carlos','Ramírez','EMPRESA','carlos@empresa.com',88889999);
Insert into DERIK.CLIENTE (ID_CLIENTE,NOMBRE,APELLIDO,TIPO_CLIENTE,EMAIL,TELEFONO) values (2,'María','Gómez','PERSONA','maria@gmail.com',88997766);
REM INSERTING into DERIK.CONTRATO_MANTENIMIENTO
SET DEFINE OFF;
REM INSERTING into DERIK.DETALLE_SERVICIO
SET DEFINE OFF;
REM INSERTING into DERIK.EQUIPO
SET DEFINE OFF;
REM INSERTING into DERIK.ESTADO_ORDEN
SET DEFINE OFF;
REM INSERTING into DERIK.LOG_TECNICO
SET DEFINE OFF;
REM INSERTING into DERIK.ORDEN_SERVICIO
SET DEFINE OFF;
REM INSERTING into DERIK.TECNICO
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Trigger TRG_AUDITAR_TECNICO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DERIK"."TRG_AUDITAR_TECNICO" 
AFTER DELETE ON tecnico
FOR EACH ROW
BEGIN
  INSERT INTO log_tecnico (id_tecnico, nombre_tecnico, fecha_eliminacion)
  VALUES (:OLD.id_tecnico, :OLD.nombre, SYSDATE);
END;

/
ALTER TRIGGER "DERIK"."TRG_AUDITAR_TECNICO" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_ESTADO_POR_DEFECTO_ORDEN
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DERIK"."TRG_ESTADO_POR_DEFECTO_ORDEN" 
BEFORE INSERT ON orden_servicio
FOR EACH ROW
BEGIN
  IF :NEW.estado IS NULL THEN
    :NEW.estado := 'Pendiente';
  END IF;
END;

/
ALTER TRIGGER "DERIK"."TRG_ESTADO_POR_DEFECTO_ORDEN" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TRG_VALIDAR_CORREO_CLIENTE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE TRIGGER "DERIK"."TRG_VALIDAR_CORREO_CLIENTE" 
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
  IF NOT REGEXP_LIKE(:NEW.email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') THEN
    RAISE_APPLICATION_ERROR(-20001, 'Correo electrónico no válido');
  END IF;
END;

/
ALTER TRIGGER "DERIK"."TRG_VALIDAR_CORREO_CLIENTE" ENABLE;
--------------------------------------------------------
--  DDL for Package PAQ_CLIENTE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "DERIK"."PAQ_CLIENTE" AS
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
--------------------------------------------------------
--  DDL for Package PAQ_CONTRATO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "DERIK"."PAQ_CONTRATO" AS
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
--------------------------------------------------------
--  DDL for Package PAQ_DETALLE_SERVICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "DERIK"."PAQ_DETALLE_SERVICIO" AS
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
--------------------------------------------------------
--  DDL for Package PAQ_EQUIPO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "DERIK"."PAQ_EQUIPO" AS
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
--------------------------------------------------------
--  DDL for Package PAQ_ORDEN_SERVICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "DERIK"."PAQ_ORDEN_SERVICIO" AS
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
--------------------------------------------------------
--  DDL for Package PAQ_TECNICO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE "DERIK"."PAQ_TECNICO" AS
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
--------------------------------------------------------
--  DDL for Package Body PAQ_CLIENTE
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "DERIK"."PAQ_CLIENTE" AS

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
--------------------------------------------------------
--  DDL for Package Body PAQ_CONTRATO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "DERIK"."PAQ_CONTRATO" AS

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
--------------------------------------------------------
--  DDL for Package Body PAQ_DETALLE_SERVICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "DERIK"."PAQ_DETALLE_SERVICIO" AS

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
--------------------------------------------------------
--  DDL for Package Body PAQ_EQUIPO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "DERIK"."PAQ_EQUIPO" AS

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
--------------------------------------------------------
--  DDL for Package Body PAQ_ORDEN_SERVICIO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "DERIK"."PAQ_ORDEN_SERVICIO" AS

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
--------------------------------------------------------
--  DDL for Package Body PAQ_TECNICO
--------------------------------------------------------

  CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "DERIK"."PAQ_TECNICO" AS

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
--------------------------------------------------------
--  Constraints for Table CONTRATO_MANTENIMIENTO
--------------------------------------------------------

  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" ADD PRIMARY KEY ("ID_CONTRATO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" MODIFY ("ID_CONTRATO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" MODIFY ("FECHA_INICIO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" MODIFY ("FECHA_FIN" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" MODIFY ("TIPO_CONTRATO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" MODIFY ("ESTADO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ORDEN_SERVICIO
--------------------------------------------------------

  ALTER TABLE "DERIK"."ORDEN_SERVICIO" ADD PRIMARY KEY ("ID_ORDEN")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("ID_ORDEN" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("ID_EQUIPO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("ID_TECNICO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("FECHA_INICIO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("ESTADO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("TIPO_SERVICIO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" MODIFY ("ID_ESTADO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table EQUIPO
--------------------------------------------------------

  ALTER TABLE "DERIK"."EQUIPO" ADD PRIMARY KEY ("ID_EQUIPO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("ID_EQUIPO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("TIPO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("MARCA" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("MODELO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("NUMERO_SERIE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."EQUIPO" MODIFY ("FECHA_INGRESO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TECNICO
--------------------------------------------------------

  ALTER TABLE "DERIK"."TECNICO" ADD PRIMARY KEY ("ID_TECNICO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."TECNICO" MODIFY ("ID_TECNICO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."TECNICO" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."TECNICO" MODIFY ("APELLIDO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."TECNICO" MODIFY ("ESPECIALIDAD" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."TECNICO" MODIFY ("EMAIL" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."TECNICO" MODIFY ("TELEFONO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LOG_TECNICO
--------------------------------------------------------

  ALTER TABLE "DERIK"."LOG_TECNICO" MODIFY ("ID_LOG" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."LOG_TECNICO" MODIFY ("ID_TECNICO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."LOG_TECNICO" MODIFY ("NOMBRE_TECNICO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table ESTADO_ORDEN
--------------------------------------------------------

  ALTER TABLE "DERIK"."ESTADO_ORDEN" MODIFY ("ID_ESTADO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."ESTADO_ORDEN" ADD PRIMARY KEY ("ID_ESTADO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."ESTADO_ORDEN" MODIFY ("DESCRIPCION" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CLIENTE
--------------------------------------------------------

  ALTER TABLE "DERIK"."CLIENTE" ADD PRIMARY KEY ("ID_CLIENTE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."CLIENTE" MODIFY ("NOMBRE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CLIENTE" MODIFY ("APELLIDO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CLIENTE" MODIFY ("TIPO_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CLIENTE" MODIFY ("EMAIL" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."CLIENTE" MODIFY ("TELEFONO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table DETALLE_SERVICIO
--------------------------------------------------------

  ALTER TABLE "DERIK"."DETALLE_SERVICIO" ADD PRIMARY KEY ("ID_DETALLE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "DERIK"."DETALLE_SERVICIO" MODIFY ("ID_DETALLE" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."DETALLE_SERVICIO" MODIFY ("ID_ORDEN" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."DETALLE_SERVICIO" MODIFY ("DESCRIPCION" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."DETALLE_SERVICIO" MODIFY ("HORAS_TRABAJADAS" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."DETALLE_SERVICIO" MODIFY ("COSTO_APROXIMADO" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table CONTRATO_MANTENIMIENTO
--------------------------------------------------------

  ALTER TABLE "DERIK"."CONTRATO_MANTENIMIENTO" ADD FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "DERIK"."CLIENTE" ("ID_CLIENTE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table DETALLE_SERVICIO
--------------------------------------------------------

  ALTER TABLE "DERIK"."DETALLE_SERVICIO" ADD CONSTRAINT "FK_DETALLE_ORDEN" FOREIGN KEY ("ID_ORDEN")
	  REFERENCES "DERIK"."ORDEN_SERVICIO" ("ID_ORDEN") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table EQUIPO
--------------------------------------------------------

  ALTER TABLE "DERIK"."EQUIPO" ADD CONSTRAINT "FK_EQUIPO_CLIENTE" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "DERIK"."CLIENTE" ("ID_CLIENTE") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table ORDEN_SERVICIO
--------------------------------------------------------

  ALTER TABLE "DERIK"."ORDEN_SERVICIO" ADD CONSTRAINT "FK_ORDEN_EQUIPO" FOREIGN KEY ("ID_EQUIPO")
	  REFERENCES "DERIK"."EQUIPO" ("ID_EQUIPO") ENABLE;
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" ADD CONSTRAINT "FK_ORDEN_TECNICO" FOREIGN KEY ("ID_TECNICO")
	  REFERENCES "DERIK"."TECNICO" ("ID_TECNICO") ENABLE;
  ALTER TABLE "DERIK"."ORDEN_SERVICIO" ADD CONSTRAINT "FK_ESTADO_ORDEN" FOREIGN KEY ("ID_ESTADO")
	  REFERENCES "DERIK"."ESTADO_ORDEN" ("ID_ESTADO") ENABLE;

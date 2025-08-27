--------------------------------------------------------
-- Archivo creado  - martes-agosto-26-2025   
--------------------------------------------------------
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
REM INSERTING into DERIK.LOG_TECNICO
SET DEFINE OFF;
--------------------------------------------------------
--  Constraints for Table LOG_TECNICO
--------------------------------------------------------

  ALTER TABLE "DERIK"."LOG_TECNICO" MODIFY ("ID_LOG" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."LOG_TECNICO" MODIFY ("ID_TECNICO" NOT NULL ENABLE);
  ALTER TABLE "DERIK"."LOG_TECNICO" MODIFY ("NOMBRE_TECNICO" NOT NULL ENABLE);

--------------------------------------------------------
-- Archivo creado  - martes-agosto-26-2025   
--------------------------------------------------------
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
REM INSERTING into DERIK.EQUIPO
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index SYS_C008381
--------------------------------------------------------

  CREATE UNIQUE INDEX "DERIK"."SYS_C008381" ON "DERIK"."EQUIPO" ("ID_EQUIPO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE "USERS" ;
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

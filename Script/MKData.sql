/******************************************************************************/
/***         Generated by IBExpert 2022.1.21.1 06/10/2022 02:28:44          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES ISO8859_1;

SET CLIENTLIB 'C:\Program Files (x86)\Firebird\Firebird_4_0\fbclient.dll';

CREATE DATABASE 'C:\Users\Wesley\Desktop\MKDATA\Win32\Debug\DB.FDB'
USER 'SYSDBA' PASSWORD 'masterkey'
PAGE_SIZE 4096
DEFAULT CHARACTER SET ISO8859_1 COLLATION PT_BR;



/******************************************************************************/
/***                                Domains                                 ***/
/******************************************************************************/

CREATE DOMAIN DM_ATIVO AS
BOOLEAN
NOT NULL;

CREATE DOMAIN DM_BAIRRO AS
VARCHAR(50);

CREATE DOMAIN DM_CEP AS
CHAR(8);

CREATE DOMAIN DM_CIDADE AS
VARCHAR(50);

CREATE DOMAIN DM_CNPJ AS
CHAR(14);

CREATE DOMAIN DM_CPF AS
CHAR(11);

CREATE DOMAIN DM_DATA AS
DATE
NOT NULL;

CREATE DOMAIN DM_DDD AS
CHAR(3);

CREATE DOMAIN DM_ESTADO AS
VARCHAR(30);

CREATE DOMAIN DM_ID AS
INTEGER
NOT NULL;

CREATE DOMAIN DM_IE AS
CHAR(9);

CREATE DOMAIN DM_LOGRADOURO AS
VARCHAR(50);

CREATE DOMAIN DM_NOME AS
VARCHAR(50)
NOT NULL;

CREATE DOMAIN DM_NUMERO AS
VARCHAR(10);

CREATE DOMAIN DM_PAIS AS
VARCHAR(50);

CREATE DOMAIN DM_RG AS
VARCHAR(8);

CREATE DOMAIN DM_TELEFONE AS
VARCHAR(9);

CREATE DOMAIN DM_TIPO_PESSOA AS
SMALLINT
NOT NULL;



/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE GENERATOR GEN_CLIENTES_ID START WITH 1 INCREMENT BY 1;
SET GENERATOR GEN_CLIENTES_ID TO 1;

CREATE GENERATOR GEN_ENDERECOS_ID START WITH 1 INCREMENT BY 1;
SET GENERATOR GEN_ENDERECOS_ID TO 1;

CREATE GENERATOR GEN_TELEFONES_ID START WITH 1 INCREMENT BY 1;
SET GENERATOR GEN_TELEFONES_ID TO 1;



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE CLIENTES (
    ID           DM_ID NOT NULL,
    NOME         DM_NOME,
    TIPO_PESSOA  DM_TIPO_PESSOA,
    CPF          DM_CPF,
    CNPJ         DM_CNPJ,
    RG           DM_RG,
    IE           DM_IE,
    DATA         DM_DATA,
    ATIVO        DM_ATIVO
);

CREATE TABLE ENDERECOS (
    ID          DM_ID NOT NULL,
    ID_CLIENTE  DM_ID NOT NULL,
    LOGRADOURO  DM_LOGRADOURO,
    NUMERO      DM_NUMERO,
    CEP         DM_CEP,
    BAIRRO      DM_BAIRRO,
    CIDADE      DM_CIDADE,
    ESTADO      DM_ESTADO,
    PAIS        DM_PAIS
);

CREATE TABLE TELEFONES (
    ID          DM_ID NOT NULL,
    ID_CLIENTE  DM_ID NOT NULL,
    DDD         DM_DDD,
    TELEFONE    DM_TELEFONE
);



/******************************************************************************/
/***                              Primary keys                              ***/
/******************************************************************************/

ALTER TABLE CLIENTES ADD CONSTRAINT PK_CLIENTES PRIMARY KEY (ID);
ALTER TABLE ENDERECOS ADD CONSTRAINT PK_ENDERECOS PRIMARY KEY (ID);
ALTER TABLE TELEFONES ADD CONSTRAINT PK_TELEFONES PRIMARY KEY (ID);


/******************************************************************************/
/***                              Foreign keys                              ***/
/******************************************************************************/

ALTER TABLE ENDERECOS ADD CONSTRAINT FK_ENDERECOS_1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES (ID);
ALTER TABLE TELEFONES ADD CONSTRAINT FK_TELEFONES_1 FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTES (ID);


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: CLIENTES_BI */
CREATE TRIGGER CLIENTES_BI FOR CLIENTES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_clientes_id,1);
end
^

/* Trigger: ENDERECOS_BI */
CREATE TRIGGER ENDERECOS_BI FOR ENDERECOS
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_enderecos_id,1);
end
^

/* Trigger: TELEFONES_BI */
CREATE TRIGGER TELEFONES_BI FOR TELEFONES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_telefones_id,1);
end
^
SET TERM ; ^

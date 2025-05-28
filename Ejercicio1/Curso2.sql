--Crear Una Entidad con DDL

--Table
CREATE TABLE EMPLEADO(
    ID_CLIENTE NUMBER,
    NOMBRE NVARCHAR2(100),
    APP NVARCHAR2(100),
    EDAD NUMBER,
    PUESTO NVARCHAR2(100),
    DEPARTAMENTO NVARCHAR2(100)
);

--DML Lenguaje de manipulacion:

INSERT INTO empleado VALUES(12,'Raul', 'Jimenez', 23, 'Encargado de TI', 'TI');
COMMIT; 
--Una vez que se ejecuta una sentencia DML se deben confirmar los cambios al terminar con la transaccion realizada
--Si una transaccion se queda sin guardar confirmada, la BD quedara bloqueada por el usuario que realizo la transaccion y ningun otro podra realiar operaciones

SELECT * FROM empleado;

--EJECUTAR UN DDL: Para eliminar la tabla creada
DROP TABLE empleado;--ELIMINA TODA LA TABLA
--EJECUTAR UN DML: Para eliminar la tabla
DELETE FROM empleado;-- Eliminar todos los registros de la tabla
COMMIT;


--USO DE LOS CONSTRAINS
--Crear una entidad con PRIMARY KEY -- Primera Forma
CREATE TABLE EMPLEADO(
    ID_EMPLEADO NUMBER PRIMARY KEY,
    NOMNRE NVARCHAR2(100),
    APP NVARCHAR2(100),
    EDAD NUMBER,
    PUESTO NVARCHAR2(100),
    DEPARTAMENTO NVARCHAR2(100)
);

--Crear una entidad con PRIMARY KEY -- Segunda Forma
CREATE TABLE EMPLEADO(
    ID_EMPLEADO NUMBER,
    NOMNRE NVARCHAR2(100),
    APP NVARCHAR2(100),
    EDAD NUMBER,
    PUESTO NVARCHAR2(100),
    DEPARTAMENTO NVARCHAR2(100,
    PRIMARY KEY(ID_EMPLEADO)
);

--Crear una entidad con PRIMARY KEY -- TERCERA Forma
CREATE TABLE EMPLEADO(
    ID_EMPLEADO NUMBER,
    NOMNRE NVARCHAR2(100),
    APP NVARCHAR2(100),
    EDAD NUMBER,
    PUESTO NVARCHAR2(100),
    DEPARTAMENTO NVARCHAR2(100)
);


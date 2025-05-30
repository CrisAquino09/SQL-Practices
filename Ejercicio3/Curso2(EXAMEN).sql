//EXAMEN PRACTICO

//PARTE 1. CREACION DE TABLAS
CREATE TABLE AUTOR (
    ID_AUTOR NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(100),
    NACIONALIDAD VARCHAR2(50)
);

CREATE TABLE LIBRO (
    ID_LIBRO NUMBER PRIMARY KEY,
    TITULO VARCHAR2(150),
    ID_AUTOR NUMBER,
    PRECIO NUMBER(7,2),
    FECHA_PUBLICACION DATE,
    CONSTRAINT FK_AUTOR FOREIGN KEY (ID_AUTOR) REFERENCES AUTOR(ID_AUTOR)
);

CREATE TABLE LOG_PRECIOS_INVALIDOS (
    ID_LOG NUMBER GENERATED ALWAYS AS IDENTITY,
    ID_LIBRO NUMBER,
    PRECIO_INVALIDO NUMBER,
    FECHA_REGISTRO DATE,
    MENSAJE_ERROR VARCHAR2(100)
);

//PARTE 2. INSERCION DE DATOS
INSERT INTO AUTOR VALUES (1, 'Gabriel García Márquez', 'Colombiana');
INSERT INTO AUTOR VALUES (2, 'Isabel Allende', 'Chilena');
INSERT INTO LIBRO VALUES (1, 'Cien Años de Soledad', 1, 250.00, TO_DATE('1967-06-05','YYYY-MM-DD'));
INSERT INTO LIBRO VALUES (2, 'La Casa de los Espíritus', 2, 180.00, TO_DATE('1982-01-01','YYYY-MM-DD'));
INSERT INTO LIBRO VALUES (3, 'El Amor en los Tiempos del Cólera', 1,220.00, TO_DATE('1985-10-10','YYYY-MM-DD'));

//PARTE 3. CONSULTAS BASICAS
//a) Mostrar todos los libros del autor “Gabriel García Márquez”.
SELECT * FROM LIBRO WHERE ID_AUTOR=1;

SELECT TITULO, NOMBRE FROM LIBRO L
INNER JOIN AUTOR T
ON L.ID_AUTOR = T.ID_AUTOR
WHERE NOMBRE = 'Gabriel García Márquez';

//b) Mostrar el título, nombre del autor y precio de cada libro.
SELECT TITULO, NOMBRE, PRECIO FROM LIBRO L
INNER JOIN AUTOR T
ON L.ID_AUTOR = T.ID_AUTOR;

//c) Mostrar los libros publicados después del año 1980.
SELECT * FROM LIBRO WHERE FECHA_PUBLICACION > TO_DATE('1980-12-31','YYYY-MM-DD');

//d) Mostrar el número total de libros registrados.
SELECT COUNT(ID_LIBRO) AS LIBROS_REGISTRADOS FROM LIBRO; 

//e) Mostrar los libros con precio mayor a $200.
SELECT * FROM LIBRO WHERE PRECIO > 200;

//PARTE 4. Funciones DE AGREGACION:
//a) Calcular el precio promedio de los libros por autor.
SELECT A.NOMBRE, AVG(PRECIO) FROM LIBRO L
INNER JOIN AUTOR A
ON L.ID_AUTOR = A.ID_AUTOR
GROUP BY NOMBRE;

SELECT ID_AUTOR, AVG (PRECIO) FROM LIBRO GROUP BY ID_AUTOR;

//b) Mostrar el precio máximo y mínimo de los libros.
SELECT MAX(PRECIO) AS PRECIO_MAXINO, MIN (PRECIO) AS PRECIO_MINIMO FROM LIBRO;

//c) Contar cuántos libros tiene cada autor.
SELECT A.NOMBRE, COUNT(ID_LIBRO) AS NUM_LIBROS FROM LIBRO L
INNER JOIN AUTOR A
ON L.ID_AUTOR = A.ID_AUTOR
GROUP BY NOMBRE;

SELECT ID_AUTOR, COUNT(ID_LIBRO) AS NUM_LIBROS FROM LIBRO GROUP BY ID_AUTOR;

//d) Mostrar el precio promedio general de los libros.
SELECT COUNT(ID_LIBRO) AS TOTAL_LIBROS, SUM(PRECIO) AS PRECIO_TOTAL, ROUND(AVG(PRECIO),2) AS PRECIO_PROMEDIO FROM LIBRO;

//PARTE 5. BLOQUES ANONIMOS EN PL/SQL
//a) Mostrar nombre del libro y año de publicación:
DECLARE
    v_titulo LIBRO.TITULO%TYPE;
    v_fecha LIBRO.FECHA_PUBLICACION%TYPE;
BEGIN
    FOR rec IN (SELECT TITULO, FECHA_PUBLICACION FROM LIBRO) LOOP
        v_titulo := rec.TITULO;
        v_fecha := rec.FECHA_PUBLICACION;
        DBMS_OUTPUT.PUT_LINE('Libro: ' || v_titulo || ', Año: ' || TO_CHAR(v_fecha, 'YYYY'));
    END LOOP;
END;
/

//b) Verificar si un autor (ID = 1) tiene más de un libro registrado:
DECLARE
    V_COUNT NUMBER;
BEGIN
    SELECT COUNT(*) INTO V_COUNT FROM LIBRO WHERE ID_AUTOR = 1;
    IF V_COUNT > 1 THEN
        DBMS_OUTPUT.PUT_LINE('Autor con múltiples libros.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Autor con un solo libro o ninguno.');
    END IF;
END;
/

//PARTE 6: TRIGGER
//6. Crea una tabla de log llamada LOG_PRECIOS_INVALIDOS que almacene advertencias sobre precios mayores a $500.

//7. Crea un trigger tipo AFTER INSERT OR UPDATE en la tabla LIBRO que haga lo siguiente:
//Cuando se inserte o actualice un libro y su precio sea mayor a $500, el trigger debe insertar un
//registro en la tabla LOG_PRECIOS_INVALIDOS indicando el ID del libro, el precio inválido, la
//fecha del evento y el mensaje 'Precio mayor a $500 detectado'
CREATE OR REPLACE TRIGGER TRG_AFTER_PRECIO_LIBRO
AFTER INSERT OR UPDATE ON LIBRO
FOR EACH ROW
BEGIN
    IF :NEW.PRECIO > 500 THEN
        INSERT INTO LOG_PRECIOS_INVALIDOS (ID_LIBRO, PRECIO_INVALIDO, FECHA_REGISTRO, MENSAJE_ERROR)
        VALUES (:NEW.ID_LIBRO, :NEW.PRECIO, SYSDATE, 'Precio mayor a $500 detectado');
    END IF;
END;
/

//8. Inserta un libro con precio inválido y verifica que el trigger funcione correctamente:
INSERT INTO LIBRO VALUES (4, 'Libro Premium', 2, 800.00, TO_DATE('2023-01-01','YYYY-MM-DD'));
SELECT * FROM LOG_PRECIOS_INVALIDOS;
select * from libro;

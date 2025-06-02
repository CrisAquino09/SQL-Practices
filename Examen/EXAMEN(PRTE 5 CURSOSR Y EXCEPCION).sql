//Actividad 6: Cursor FOR y manejo de excepciones
//Crea un procedimiento que:
//Use un cursor FOR para recorrer todos los proyectos.
//Imprima su nombre y duración.
//Si la duración es negativa (fecha_fin < fecha_inicio), lance una excepción y registre un mensaje: 'Error en proyecto: [NOMBRE]'.

CREATE OR REPLACE PROCEDURE PR_DURACION_PROYECTOS IS
    E_DURACION_NEGATIVA EXCEPTION;
BEGIN
    DBMS_OUTPUT.PUT_LINE('<<<<<<<<<<<<<<<<<<<<<REPORTE DE PROYECTOS>>>>>>>>>>>>>>>>>>>>>');
    
    FOR PROY IN (
        SELECT ID_PROYECTO, NOMBRE, FECHA_INICIO,FECHA_FIN, NVL(FECHA_FIN - FECHA_INICIO, 0) AS DURACION
        FROM PROYECTO
        ORDER BY NOMBRE
    ) LOOP
        BEGIN 
            
            -- Validar duración negativa
            IF PROY.FECHA_FIN < PROY.FECHA_INICIO THEN
                RAISE E_DURACION_NEGATIVA;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('NOMBRE: ' || PROY.NOMBRE || 'INICIA: ' || 
            TO_CHAR(PROY.FECHA_INICIO, 'DD/MM/YYYY')|| ' TERMINA: ' || TO_CHAR(PROY.FECHA_FIN, 'DD/MM/YYYY')|| 
            ' CON UNA DURACION: ' || PROY.DURACION || ' DIAS');
            
        EXCEPTION
            WHEN E_DURACION_NEGATIVA THEN
                DBMS_OUTPUT.PUT_LINE('NOMBRE: ' || PROY.NOMBRE || ' ERROR EN LAS FECHAS DEL PROYECTO');
        END;
    END LOOP;
END PR_DURACION_PROYECTOS;
/

BEGIN
    PR_DURACION_PROYECTOS;
END;
/

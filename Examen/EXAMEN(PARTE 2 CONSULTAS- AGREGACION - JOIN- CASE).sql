//Parte 2: Consultas con Funciones de Agregación
//1. El salario promedio de los empleados en cada departamento.
SELECT D.NOMBRE ,ROUND(AVG(E.SALARIO),2) AS SALARIO_DEPARTAMNTO FROM DEPARTAMENTO D
INNER JOIN EMPLEADO E
ON E.DEPARTAMENTO_ID = D.ID_DEPARTAMENTO
GROUP BY D.NOMBRE;

//2. El número total de proyectos asignados a cada empleado.
SELECT E.NOMBRE, COUNT(A.PROYECTO_ID) AS TOTAL_PROYECTOS FROM ASIGNACION A
INNER JOIN EMPLEADO E
ON A.EMPLEADO_ID = E.ID_EMPLEADO
GROUP BY NOMBRE;

//3. La duración total de cada proyecto (diferencia entre la fecha de inicio y la fecha de fin).
SELECT NOMBRE , 'TIENE UNA DURACION DE ' || (FECHA_FIN - FECHA_INICIO) || ' DIAS' AS DIFERENCIA_DIAS FROM PROYECTO;

//PARTE 3. Consultas con JOINs
//1. Los nombres de los empleados junto con el nombre del departamento al que pertenecen.
SELECT E.ID_EMPLEADO, E.NOMBRE, D.NOMBRE AS DEPARTAMENTO, E.SALARIO, E.FECHA_INGRESO FROM EMPLEADO E
INNER JOIN DEPARTAMENTO D
ON E.DEPARTAMENTO_ID = D.ID_DEPARTAMENTO
ORDER BY E.ID_EMPLEADO;

//2. Los nombres de los proyectos junto con los nombres de los empleados asignados a esos proyectos y las horas trabajadas.
SELECT E.ID_EMPLEADO, E.NOMBRE AS EMPLEADO, P.NOMBRE AS PROYECTO, A.HORAS_TRABAJADAS
FROM ASIGNACION A
INNER JOIN EMPLEADO E 
    ON A.EMPLEADO_ID = E.ID_EMPLEADO
INNER JOIN PROYECTO P 
    ON A.PROYECTO_ID = P.ID_PROYECTO
ORDER BY 
    P.ID_PROYECTO;

//PARTE 4. Consultas con CASE
//1. Mostrar el salario de los empleados junto con una etiqueta que indique si el salario es "Alto" (> 5000), "Medio" (2000-5000) o "Bajo" (< 2000).
SELECT ID_EMPLEADO, NOMBRE, DEPARTAMENTO_ID, SALARIO,(
    CASE 
        WHEN SALARIO < 2000 THEN 'SALARIO BAJO'
        WHEN SALARIO BETWEEN 2000 AND 5000 THEN 'SALARIO MEDIO'
        WHEN SALARIO > 5000 THEN 'SALARIO ALTO'
        ELSE 'SIN CLASIFICAR'
    END 
)AS TIPO_SALARIO 
FROM EMPLEADO;

//2. Mostrar el nombre del proyecto y la duración del proyecto, junto con una etiqueta que indique si el proyecto está "Activo" (si la fecha actual está dentro del rango) o "Inactivo".
SELECT ID_PROYECTO, NOMBRE, FECHA_INICIO, FECHA_FIN,('DURA ' || (FECHA_FIN - FECHA_INICIO) || ' DIAS') AS DURACION,
(
    CASE 
        WHEN FECHA_FIN < SYSDATE THEN 'INACTIVO'
        ELSE 'ACTIVO'
    END
) 
AS ESTADO FROM PROYECTO;
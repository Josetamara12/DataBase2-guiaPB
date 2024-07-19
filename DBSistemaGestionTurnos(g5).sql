--Creacion Base de Datos
CREATE DATABASE DBSistemaGestionTurnos;
--Usar Base de Datos
USE DBSistemaGestionTurnos
--CREACION DE TABLAS

-- Crear tabla Estudiantes
--Esta tabla almacenar� la informaci�n de los estudiantes que utilizan la sala de computadoras. 
CREATE TABLE Estudiantes (
Id_Estudiante INT PRIMARY KEY NOT NULL,
Nombre_Estudiante VARCHAR(30)NOT NULL,
Apellidos_Estudiante VARCHAR(30)NOT NULL,
Correo_Estudiante VARCHAR(100)NOT NULL,
FechaNacimiento_Estudiante DATE NOT NULL,
Telefono_Estudiante INT NOT NULL,
);

-- Crear tabla Computadoras
--Aqu� se almacenar� la informaci�n de las computadoras disponibles en la sala. 
CREATE TABLE Computadoras (
Id_Computadora VARCHAR(20) PRIMARY KEY NOT NULL,
Serie_Computadora VARCHAR(50) NOT NULL,
Estado_Computadora VARCHAR(20) NOT NULL--(disponible, ocupado, en mantenimiento)
); 

-- Crear tabla Turnos
--Esta tabla registrar� los turnos asignados a cada estudiante para usar las computadoras.

CREATE TABLE Turnos (
Id_Turno VARCHAR(20) PRIMARY KEY NOT NULL,
Id_Estudiante INT NOT NULL,
Id_Computadora VARCHAR(20) NOT NULL,
FechayHoraInicio_Turno DATETIME NOT NULL,
FechayHoraFin_Turno DATETIME NOT NULL,
Estado_Turno VARCHAR(30) NOT NULL, --(activo, completado, cancelado)
FOREIGN KEY (Id_Estudiante) REFERENCES Estudiantes(Id_Estudiante),
FOREIGN KEY (Id_Computadora) REFERENCES Computadoras(Id_Computadora)
);


-- Crear tabla Ocupaciones
--Esta tabla registrar� el historial de ocupaci�n de las computadoras en la sala.
CREATE TABLE Ocupaciones (
Id_Ocupacion VARCHAR(20) PRIMARY KEY NOT NULL, 
Id_Estudiante INT NOT NULL,--(si est� ocupada por un estudiante)
Id_Computadora VARCHAR(20) NOT NULL,
Id_Turno VARCHAR(20)NOT NULL,
FechayHoraInicio_Ocupacion DATETIME NOT NULL,
FechayHoraFin_Ocupacion DATETIME,
Duracion_Ocupacion TIME,
FOREIGN KEY (Id_Estudiante) REFERENCES Estudiantes(Id_Estudiante),
FOREIGN KEY (Id_Computadora) REFERENCES Computadoras(Id_Computadora),
FOREIGN KEY (Id_Turno) REFERENCES Turnos(Id_Turno)
);


-- Crear tabla SolicitudesSoporteTecnico
--Esta tabla registrar� si se necesita solicitar soporte t�cnico para problemas con las computadoras.
CREATE TABLE SolicitudesSoporteTecnico (
Id_Solicitud  VARCHAR(20) PRIMARY KEY NOT NULL, 
Id_Computadora VARCHAR(20) NOT NULL,
Fecha_Solicitud DATE NOT NULL,
Descripci�n_Solicitud VARCHAR(50)NOT NULL,
Prioridad_Solicitud VARCHAR(50),
FOREIGN KEY (Id_Computadora) REFERENCES Computadoras(Id_Computadora)
);

-- Crear tabla Mantenimientos
--Esta tabla registrar� los mantenimientos que se hacen a las computadoras de la sala
CREATE TABLE Mantenimientos (
Id_Mantenimiento  VARCHAR(20) PRIMARY KEY NOT NULL, 
Id_Computadora VARCHAR(20) NOT NULL,
Id_Solicitud  VARCHAR(20) NOT NULL,
Fecha_Mantenimiento DATE NOT NULL,
Tipo_Mantenimiento VARCHAR(50)NOT NULL,--(preventivo, correctivo, actualizaci�n de software)
Descripci�n_Mantenimiento VARCHAR(50)NOT NULL,
Costo_Mantenimiento INT NOT NULL,
FOREIGN KEY (Id_Computadora) REFERENCES Computadoras(Id_Computadora ),
FOREIGN KEY (Id_Solicitud) REFERENCES SolicitudesSoporteTecnico(Id_Solicitud )
);

--INSERTAR DATOS EN LAS TABLAS

/*Insertar 10 registros en la tabla Estudiantes*/
INSERT INTO Estudiantes (
Id_Estudiante, 
Nombre_Estudiante, 
Apellidos_Estudiante, 
Correo_Estudiante, 
FechaNacimiento_Estudiante, 
Telefono_Estudiante)
VALUES
(10001,'Carlos','Garc�a','carlos@gmail.com','1990-05-15',12345),
(10002,'Ana','Rodr�guez','ana@gmail.com','1992-08-20',98765),
(10003,'Martin','L�pez','martin@gmail.com','1995-03-10',55512),
(10004,'Luisa','Mart�nez','luisa@gmail.com','1988-11-25',11122),
(10005,'Juan','Hern�ndez','juan@gmail.com','1997-07-01',44455),
(10006,'Laura','S�nchez','laura@gmail.com','1993-12-18',77788),
(10007,'Pedro','G�mez','pedro@gmail.com','1994-09-05',99988),
(10008,'Mar�a','Torres','maria@gmail.com','2001-06-30',12398),
(10009,'Sof�a','Ram�rez','sofia@gmail.com','2002-11-16',65432),
(10010,'Javier','Jim�nez','javier@gmail.com','2000-02-22',33322
);
SELECT*FROM Estudiantes

/*Insertar 10 registros en la tabla Computadoras*/
INSERT INTO Computadoras (
Id_Computadora,
Serie_Computadora,
Estado_Computadora)
VALUES
('C1','AA01','Disponible'),
('C2','AA02','Disponible'),
('C3','AA03','Mantenimiento'),
('C4','AA04','Mantenimiento'),
('C5','AA05','Disponible'),
('C6','AA06','Mantenimiento'),
('C7','AA07','Mantenimiento'),
('C8','AA08','Disponible'),
('C9','AA09','Mantenimiento'),
('C10','AA10','Disponible'
);
SELECT*FROM Computadoras

--PARA LLENAR LAS TABLAS DE TURNOS Y OPERACIONES NECESITAMOS LOS SIGUIENTES COMANDOS:


--OPERACIONES DE LA MANIPULACION EN LA BASE DE DATOS

/*Consultar qu� computadoras est�n disponibles al momento de insertar un nuevo 
turno en la base de datos*/

SELECT c.Id_computadora, c.Estado_Computadora
FROM Computadoras c
WHERE c.Estado_Computadora = 'Disponible'
AND NOT EXISTS (
    SELECT 1
    FROM Turnos t
    WHERE t.Id_Computadora = c.Id_Computadora
    AND ((t.FechayHoraInicio_Turno < CAST('2024-03-01 10:59:00' AS DATETIME) 
	AND t.FechayHoraFin_Turno > CAST('2024-03-01 09:00:00' AS DATETIME)))
)

/*Insertar 10 registros en la tabla Turnos*/
INSERT INTO Turnos VALUES
('TUR1',10001,'C1','2024-03-01 09:00:00','2024-03-01 10:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR2',10002,'C2','2024-03-01 10:00:00','2024-03-01 11:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR3',10003,'C10','2024-03-01 09:00:00','2024-03-01 10:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR4',10004,'C5','2024-03-01 10:00:00','2024-03-01 11:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR5',10005,'C1','2024-03-01 11:00:00','2024-03-01 12:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR6',10006,'C2','2024-03-01 08:00:00','2024-03-01 09:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR7',10007,'C2','2024-03-01 12:00:00','2024-03-01 13:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR8',10008,'C1','2024-03-01 06:00:00','2024-03-01 07:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR9',10009,'C2','2024-03-01 14:00:00','2024-03-01 16:59:00','Activo')
INSERT INTO Turnos VALUES
('TUR10',10010,'C8','2024-03-01 09:00:00','2024-03-01 10:59:00','Activo')
SELECT*FROM Turnos


/*Consultar si un estudiante tiene un turno activo en la base de datos*/

SELECT * FROM Turnos
WHERE Id_Estudiante = 10010
AND Estado_Turno = 'activo';

/*Insertar 10 registros en la tabla Ocupaciones*/
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP1',10001,'C1','TUR1','2024-03-01 09:20:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP2',10002,'C2','TUR2','2024-03-01 10:05:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP3',10003,'C10','TUR3','2024-03-01 09:00:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP4',10004,'C5','TUR4','2024-03-01 10:32:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP5',10005,'C1','TUR5','2024-03-01 11:17:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP6',10006,'C2','TUR6','2024-03-01 08:05:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP7',10007,'C2','TUR7','2024-03-01 12:28:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP8',10008,'C1','TUR8','2024-03-01 06:30:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP9',10009,'C2','TUR9','2024-03-01 15:10:00')
INSERT INTO Ocupaciones (
Id_Ocupacion,Id_Estudiante,Id_Computadora,Id_Turno,FechayHoraInicio_Ocupacion)VALUES
('OCUP10',10010,'C8','TUR10','2024-03-01 09:03:00')
SELECT*FROM Ocupaciones

/*Insertar 10 registros en la tabla SolicitudesSoporteTecnico*/
INSERT INTO SolicitudesSoporteTecnico (Id_Solicitud, Id_Computadora, Fecha_Solicitud, Descripci�n_Solicitud, Prioridad_Solicitud)
VALUES
('SOL1', 'C9', '2024-02-28', 'La computadora no enciende', 'Alta'),
('SOL2', 'C9', '2024-02-28', 'La computadora est� lenta', 'Media'),
('SOL3', 'C9', '2024-02-28', 'El monitor no muestra imagen', 'Alta'),
('SOL4', 'C9', '2024-02-28', 'Problemas de conectividad a Internet', 'Baja'),
('SOL5', 'C4', '2024-03-05', 'El teclado no funciona correctamente', 'Alta'),
('SOL6', 'C6', '2024-03-06', 'El equipo emite ruidos extra�os', 'Media'),
('SOL7', 'C7', '2024-03-07', 'La impresora no imprime correctamente', 'Alta'),
('SOL8', 'C4', '2024-03-08', 'Se necesita instalar nuevo software', 'Media'),
('SOL9', 'C4', '2024-03-09', 'El sistema operativo no responde', 'Alta'),
('SOL10', 'C4', '2024-03-10', 'El equipo muestra errores al arrancar', 'Alta');
SELECT*FROM SolicitudesSoporteTecnico


/*Insertar 10 registros en la tabla Mantenimientos*/
INSERT INTO  Mantenimientos (Id_Mantenimiento, Id_Computadora,Id_Solicitud, Fecha_Mantenimiento, Tipo_Mantenimiento, Descripci�n_Mantenimiento, Costo_Mantenimiento)
VALUES
('MAN1', 'C9','SOL1', '2024-03-01', 'Correctivo', 'Reemplazo de disco duro', 150000),
('MAN2', 'C9','SOL2', '2024-03-02', 'Preventivo', 'Limpieza interna y mantenimiento preventivo', 80000),
('MAN3', 'C9','SOL3', '2024-03-03', 'Correctivo', 'Reparaci�n de la tarjeta gr�fica', 200000),
('MAN4', 'C9','SOL4', '2024-03-04', 'Actualizaci�n de software', 'Actualizaci�n del sistema operativo', 100000),
('MAN5', 'C4','SOL5', '2024-03-05', 'Correctivo', 'Reemplazo de teclado defectuoso', 50000),
('MAN6', 'C6','SOL6', '2024-03-06', 'Preventivo', 'Revisi�n y lubricaci�n de ventiladores', 70000),
('MAN7', 'C7','SOL7', '2024-03-07', 'Correctivo', 'Reparaci�n del alimentador de papel impresora', 120000),
('MAN8', 'C4','SOL8', '2024-03-08', 'Actualizaci�n de software', 'Instalaci�n de nuevas aplicaciones', 90000),
('MAN9', 'C4','SOL9', '2024-03-09', 'Correctivo', 'Reemplazo de la fuente de alimentaci�n', 80000),
('MAN10', 'C4','SOL10', '2024-03-10', 'Preventivo', 'Revisi�n y limpieza general del equipo', 100000);
SELECT*FROM Mantenimientos

---�MANIPULACI�N DE LA BASE DE DATOS:

/*1. Una con group by y having en una sola tabla.*/

/*Contar cu�ntas solicitudes de soporte t�cnico tiene cada computadora
y filtrar aquellas computadoras que tienen m�s de una solicitud*/

SELECT Id_Computadora, COUNT(*) AS Total_Solicitudes
FROM SolicitudesSoporteTecnico
GROUP BY Id_Computadora
HAVING COUNT(*) > 1;

/*2. Una con group by y having con dos o m�s tablas.*/

/*Encontrar las computadoras que han tenido m�s de un mantenimiento
y obtener el costo total de esos mantenimientos*/

SELECT m.Id_Computadora, COUNT(*) AS Total_Mantenimientos, SUM(m.Costo_Mantenimiento) AS Costo_Total
FROM Mantenimientos m
GROUP BY m.Id_Computadora
HAVING COUNT(*) > 1;

/*3. Una subconsulta de una sola tabla.*/

/*Obtener todos los estudiantes cuyo nombre empieza con la letra "A". */

SELECT *
FROM Estudiantes
WHERE Id_Estudiante IN (
    SELECT Id_Estudiante
    FROM Estudiantes
    WHERE Nombre_Estudiante LIKE 'A%'
);

/*4. Una subconsulta de tres niveles.*/
/*obtener los nombres de los estudiantes que tienen un turno activo 
en una computadora que actualmente est� en estado "disponible*/
SELECT Nombre_Estudiante
FROM Estudiantes
WHERE Id_Estudiante IN (
    SELECT Id_Estudiante
    FROM Turnos
    WHERE Estado_Turno = 'Activo'
    AND Id_Computadora IN (
        SELECT Id_Computadora
        FROM Computadoras
        WHERE Estado_Computadora = 'Disponible'
    )
);

/*5. Una diferencia con not in.*/
/*Encontrar los Id_Computadora que no est�n presentes en la tabla de Mantenimientos:*/
SELECT Id_Computadora
FROM Computadoras
WHERE Id_Computadora NOT IN (
    SELECT Id_Computadora
    FROM Mantenimientos
)
EXCEPT
SELECT Id_Computadora
FROM SolicitudesSoporteTecnico;

/*6. Una intersecci�n con not in.*/
/* buscar identificar computadoras que est�n actualmente en mantenimiento pero no han 
sido usadas por estudiantes que tienen turnos activos. */
SELECT Id_Computadora
FROM Mantenimientos

INTERSECT

-- Encuentra todas las computadoras asignadas en turnos
SELECT Id_Computadora
FROM Turnos;

-- encontrar las computadoras en mantenimiento que no est�n en turnos activos
SELECT Id_Computadora
FROM Mantenimientos
WHERE Id_Computadora NOT IN (
    SELECT Id_Computadora
    FROM Turnos
    WHERE Estado_Turno = 'activo'
);


/*7. Una diferencia con in. *//* */
/*encontrar las Id_Computadora que est�n presentes en la tabla de Computadoras
pero que no est�n presentes en la tabla de Mantenimientos*/
SELECT Id_Computadora
FROM Computadoras
WHERE Id_Computadora IN (
    SELECT Id_Computadora
    FROM Computadoras

EXCEPT

SELECT Id_Computadora
FROM Mantenimientos
);

/*8. Una intersecci�n con in. */
/* Encontrar las Id_Computadora que est�n presentes tanto en la tabla de 
Computadoras como en la tabla de Mantenimientos:*/
SELECT Id_Computadora
FROM Computadoras
WHERE Id_Computadora IN (
    SELECT Id_Computadora
    FROM Mantenimientos
)
INTERSECT
SELECT Id_Computadora
FROM Computadoras;

/*9. Una diferencia con not �exists.*/
/* encontrar las Id_Computadora que est�n presentes en la tabla de Computadoras
pero que no est�n presentes en la tabla de Mantenimientos: */
SELECT Id_Computadora
FROM Computadoras AS C
WHERE NOT EXISTS (
    SELECT *
    FROM Mantenimientos AS M
    WHERE M.Id_Computadora = C.Id_Computadora
)
EXCEPT
SELECT Id_Computadora
FROM Mantenimientos;

/*10. Una intersecci�n con not �exists.*/
/* Encuentra las computadoras que est�n asignadas para turnos
y que no han sido sujetas a ning�n mantenimiento registrado.  */
SELECT Id_Computadora
FROM Computadoras
WHERE NOT EXISTS (
    SELECT 1
    FROM Mantenimientos
    WHERE Mantenimientos.Id_Computadora = Computadoras.Id_Computadora
)
INTERSECT
SELECT Id_Computadora
FROM Turnos;


/*11. Una diferencia con exists.*/
/*obtener la diferencia entre dos conjuntos de datos, en este caso, las Id_Computadora */

SELECT Id_Computadora
FROM Computadoras AS C
WHERE NOT EXISTS (
    SELECT 1
    FROM Mantenimientos AS M
    WHERE C.Id_Computadora = M.Id_Computadora
)

EXCEPT

SELECT Id_Computadora
FROM Mantenimientos

UNION

SELECT Id_Computadora
FROM Mantenimientos AS M
WHERE NOT EXISTS (
    SELECT 1
    FROM Computadoras AS C
    WHERE C.Id_Computadora = M.Id_Computadora
);

/*12. Unaintersecci�n con exists.*/
/*encontrar las Id_Computadora que est�n presentes tanto en la tabla Computadoras 
como en la tabla Mantenimientos */
SELECT Id_Computadora
FROM Computadoras AS C
WHERE  EXISTS (
    SELECT 1
    FROM Mantenimientos AS M
    WHERE C.Id_Computadora = M.Id_Computadora
)

INTERSECT

SELECT Id_Computadora
FROM Mantenimientos AS M
WHERE  EXISTS (
    SELECT 1
    FROM Computadoras AS C
    WHERE C.Id_Computadora = M.Id_Computadora
);
/*13. Una con m�s de dos tablas y con un c�lculo aritm�tico en el select �(+, -, *, /).*/
/* elecciona el nombre y apellidos del estudiante, el identificador de la computadora, 
la fecha y hora de inicio y fin del turno, as� como la duraci�n del turno en minutos, 
para cada registro en el conjunto de datos combinado de las tablas */
SELECT 
    e.Nombre_Estudiante,
    e.Apellidos_Estudiante,
    c.Id_Computadora,
    t.FechayHoraInicio_Turno,
    t.FechayHoraFin_Turno,
    DATEDIFF(MINUTE, t.FechayHoraInicio_Turno, t.FechayHoraFin_Turno) AS Duracion_Minutos
FROM 
    Estudiantes e
INNER JOIN 
    Turnos t ON e.Id_Estudiante = t.Id_Estudiante
INNER JOIN 
    Computadoras c ON t.Id_Computadora = c.Id_Computadora;

/*14. Una consulta con las 6 cl�usulas.*/
/* mostrar los detalles sobre los estudiantes que actualmente tienen turnos
activos en las computadoras, incluyendo informaci�n sobre las computadoras y, si existe, 
tambi�n sobre las solicitudes de soporte t�cnico asociadas a esas computadoras.*/
SELECT 
    E.Nombre_Estudiante,
    E.Apellidos_Estudiante,
    C.Serie_Computadora,
    T.FechayHoraInicio_Turno,
    T.FechayHoraFin_Turno,
    S.Fecha_Solicitud
FROM 
    Estudiantes E
INNER JOIN 
    Turnos T ON E.Id_Estudiante = T.Id_Estudiante
INNER JOIN 
    Computadoras C ON T.Id_Computadora = C.Id_Computadora
LEFT JOIN 
    SolicitudesSoporteTecnico S ON C.Id_Computadora = S.Id_Computadora
WHERE 
    T.Estado_Turno = 'activo' AND (S.Prioridad_Solicitud = 'alta' OR S.Prioridad_Solicitud IS NULL)
ORDER BY 
    T.FechayHoraInicio_Turno DESC;
	------------------------------------------------------------------------------------------------------
/*15. Consultar los turnos de una computadora espec�fica */
SELECT * FROM Turnos WHERE Id_Computadora = 'C1';

/*16. Consultar los estudiantes que no han salido de la sala */
SELECT e.Id_Estudiante, e.Nombre_Estudiante, e.Apellidos_Estudiante
FROM Estudiantes e
INNER JOIN Ocupaciones ON e.Id_Estudiante = Ocupaciones.Id_Estudiante
WHERE Ocupaciones.FechayHoraFin_Ocupacion IS NULL;

/*17. Consultar las computadoras que estan en mantenimiento */
SELECT * FROM Computadoras WHERE Estado_Computadora = 'Mantenimiento';

/*18. Actualizar el estado de una computadora despues de repararla
de 'Mantenimiento' a 'Disponible' */

UPDATE Computadoras
SET Estado_Computadora = 'Disponible'
WHERE Id_Computadora = 'C7' AND Estado_Computadora = 'Mantenimiento';
SELECT * FROM Computadoras


/*19. Borrar una computadora que esta mala */
DELETE FROM Mantenimientos
WHERE Id_Computadora = 'C9';
DELETE FROM SolicitudesSoporteTecnico
WHERE Id_Computadora = 'C9';
DELETE FROM Computadoras
WHERE Id_Computadora = 'C9'AND Estado_Computadora = 'Mantenimiento';
SELECT*FROM Computadoras

/*20. Borrar un estudiante */
-- Luego eliminamos los registros de la tabla Ocupaciones
DELETE FROM Ocupaciones
WHERE Id_Estudiante = 10010;

-- Primero eliminamos los registros de la tabla Turnos
DELETE FROM Turnos
WHERE Id_Estudiante = 10010;

-- Finalmente, eliminamos el registro de la tabla Estudiantes
DELETE FROM Estudiantes
WHERE Id_Estudiante = 10010;
SELECT*FROM Estudiantes

/*21. Insertar hora de salida de un estudiante */

UPDATE Ocupaciones
SET FechayHoraFin_Ocupacion = '2024-03-01 10:30:00'
WHERE Id_Estudiante = 10001 AND FechayHoraFin_Ocupacion IS NULL;
SELECT*FROM Ocupaciones

/*22. Actualizar el estado del turno de 'Activo' a 'Completado' 
para un estudiante en el momento en que sale de la sala */

UPDATE Turnos
SET Estado_Turno = 'Completado'
WHERE Id_Estudiante = 10001 AND Estado_Turno = 'Activo';
SELECT*FROM Turnos

/*23. Actualizar la duracion de ocupacion de la computadora en la tabla de Ocupaciones */

UPDATE Ocupaciones
SET Duracion_Ocupacion = CAST(FechayHoraFin_Ocupacion - FechayHoraInicio_Ocupacion AS TIME)
WHERE Duracion_Ocupacion IS NULL;
SELECT*FROM Ocupaciones

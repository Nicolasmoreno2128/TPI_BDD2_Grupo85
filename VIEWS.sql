USE TPI_BDD2_Grupo85

GO

-- vista_turnosFuturos:
-- Muestra los turnos agendados con fecha mayor a hoy, junto con nombre del cliente, patente, empleado asignado y estado.

CREATE VIEW Vw_turnosFuturos AS
SELECT
    T.IdTurno,
    T.FechaTurno,
    T.Estado AS EstadoTurno,
    V.Patente,
    M.Nombre AS Modelo,
    MA.Nombre AS Marca,

    -- Cliente
    C.IdCliente,
    PC.Nombre  AS NombreCliente,
    PC.Apellido AS ApellidoCliente,

    -- Empleado asignado
    E.IdEmpleado,
    PE.Nombre  AS NombreEmpleado,
    PE.Apellido AS ApellidoEmpleado

FROM Turno T
INNER JOIN Vehiculo V       ON T.IdVehiculo = V.IdVehiculo
INNER JOIN Modelo M         ON V.IdModelo = M.IdModelo
INNER JOIN Marca MA         ON M.IdMarca = MA.IdMarca
INNER JOIN Cliente C        ON V.IdCliente = C.IdCliente
INNER JOIN Persona PC       ON C.IdPersona = PC.IdPersona
INNER JOIN Empleado E       ON T.IdEmpleado = E.IdEmpleado
INNER JOIN Persona PE       ON E.IdPersona = PE.IdPersona

WHERE T.FechaTurno > GETDATE();

GO

SELECT * FROM Vw_turnosFuturos;

-- Vista RepuestosMasUsados:
-- Muestra los Repuestos Más Usados

CREATE VIEW Vw_RepuestosMasUsados AS
SELECT
    R.IdRepuesto,
    R.Nombre AS NombreRepuesto,
    R.Stock AS StockActual,
    SUM(SR.Cantidad) AS CantidadTotalUsada
FROM
    Repuesto R
JOIN
    ServiceDetalle_X_Repuestos SR ON R.IdRepuesto = SR.IdRepuesto
GROUP BY
    R.IdRepuesto, R.Nombre, R.Stock;
GO

-- Ordeno la vista por los repuestos más usados de forma descendente
SELECT *
FROM Vw_RepuestosMasUsados
ORDER BY CantidadTotalUsada DESC;


GO

-- Vista ServicesPorVehiculo
-- Muestra el top de services realizados por vehículos por rango de fecha

CREATE VIEW Vw_ServicesPorVehiculo
AS
SELECT
    S.IdService,
    S.FechaInicio     AS FechaService,
    V.IdVehiculo,
    V.Patente,
    M.Nombre          AS Modelo,
    MA.Nombre         AS Marca
FROM Service_ S
INNER JOIN Turno   T ON S.IdTurno    = T.IdTurno
INNER JOIN Vehiculo V ON T.IdVehiculo = V.IdVehiculo
INNER JOIN Modelo  M ON V.IdModelo   = M.IdModelo
INNER JOIN Marca   MA ON M.IdMarca   = MA.IdMarca;

GO

-- Se declara e agrupa por el rango de fechas que queramos para ver el top de vehiculos 

DECLARE @FechaDesde DATE = '2024-01-01';
DECLARE @FechaHasta DATE = '2024-12-31';

SELECT TOP 10
    V.IdVehiculo,
    V.Patente,
    V.Modelo,
    V.Marca,
    COUNT(*) AS TotalServices
FROM Vw_ServicesPorVehiculo V
WHERE V.FechaService BETWEEN @FechaDesde AND @FechaHasta
GROUP BY
    V.IdVehiculo,
    V.Patente,
    V.Modelo,
    V.Marca
ORDER BY
    TotalServices DESC;
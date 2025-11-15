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
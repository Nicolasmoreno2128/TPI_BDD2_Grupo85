--------------------------------
-- PROCEDIMIENTOS ALMACENADOS --
--------------------------------

-- SP: Obtener historial de cliente

CREATE PROCEDURE sp_Obtener_Historial_Cliente
    @IdCliente INT
AS
BEGIN

    SELECT 
        C.IdCliente,
        P.Nombre + ' ' + P.Apellido AS Cliente,
        V.IdVehiculo,
        V.Patente,
        M.Nombre AS Modelo,
        MA.Nombre AS Marca,
        T.IdTurno,
        T.FechaTurno,
        T.Estado AS EstadoTurno,
        S.IdService,
        S.FechaInicio,
        S.FechaFinal,
        S.Estado AS EstadoService,
        TS.Nombre AS TipoService,
        PAGO.Monto AS MontoPagado,
        PAGO.MetodoPago
    FROM Cliente C
    INNER JOIN Persona P ON C.IdPersona = P.IdPersona
    INNER JOIN Vehiculo V ON V.IdCliente = C.IdCliente
    INNER JOIN Modelo M ON V.IdModelo = M.IdModelo
    INNER JOIN Marca MA ON M.IdMarca = MA.IdMarca
    LEFT JOIN Turno T ON T.IdVehiculo = V.IdVehiculo
    LEFT JOIN Service_ S ON S.IdTurno = T.IdTurno
    LEFT JOIN TipoService TS ON S.IdTipoService = TS.IdTipoService
    LEFT JOIN Pago PAGO ON S.IdPago = PAGO.IdPago
    WHERE C.IdCliente = @IdCliente
    ORDER BY T.FechaTurno DESC, S.FechaInicio DESC;
END;
GO

exec sp_Obtener_Historial_Cliente 1;



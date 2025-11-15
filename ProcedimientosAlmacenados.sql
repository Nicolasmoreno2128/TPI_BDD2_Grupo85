use TPI_BDD2_Grupo85
--------------------------------
-- PROCEDIMIENTOS ALMACENADOS --
--------------------------------

CREATE PROCEDURE sp_AgregarVehiculo
    @IdCliente INT,
    @IdModelo INT,
    @Patente VARCHAR(10),
    @Kilometraje INT
AS
BEGIN

    -- Validar que exista el cliente
    IF NOT EXISTS(SELECT 1 FROM Cliente WHERE IdCliente = @IdCliente)
    BEGIN
        RAISERROR('El cliente no existe.', 16, 1);
        RETURN;
    END;

    -- Validar que exista el modelo
    IF NOT EXISTS(SELECT 1 FROM Modelo WHERE IdModelo = @IdModelo)
    BEGIN
        RAISERROR('El modelo no existe.', 16, 1);
        RETURN;
    END;

    -- Validar patente única
    IF EXISTS(SELECT 1 FROM Vehiculo WHERE Patente = @Patente)
    BEGIN
        RAISERROR('La patente ya se encuentra registrada.', 16, 1);
        RETURN;
    END;

    -- Validar kilometraje
    IF (@Kilometraje < 0)
    BEGIN
        RAISERROR('El kilometraje no puede ser negativo.', 16, 1);
        RETURN;
    END;

    INSERT INTO Vehiculo(IdCliente, IdModelo, Patente, Kilometraje)
    VALUES (@IdCliente, @IdModelo, @Patente, @Kilometraje);

    PRINT 'Vehículo agregado correctamente.';
END;
GO


drop procedure sp_Obtener_Historial_Cliente
-- SP: Obtener historial de cliente

CREATE PROCEDURE sp_Obtener_Historial_Cliente
    @IdCliente INT
AS
BEGIN
    -- SE VALIDA QUE PRIMERO EXISTA EL CLIENTE --

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE IdCliente = @IdCliente)
    BEGIN
        RAISERROR('El cliente con el Id especificado no existe.', 16, 1);
        RETURN;
    END

    -- SI EXISTE, SE VALIDA QUE TENGA VEHICULOS --

        IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE IdCliente = @IdCliente)
    BEGIN
        PRINT 'El cliente existe, pero no tiene vehículos registrados.';
        RETURN;
    END;

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

exec sp_AgregarVehiculo 6, 4, 'abc123', 25000

select * from Modelo


-- Procedimiento almacenado: Agregar turno

CREATE PROCEDURE sp_AgregarTurno
    @pIdVehiculo INT,
    @pIdEmpleado INT,
    @pFechaTurno DATETIME,
    @pObservaciones TEXT = NULL
AS
BEGIN
    -- VALIDACION DE DATOS

    -- Valido que exista el vehiculo --
    IF NOT EXISTS (SELECT 1 FROM Vehiculo WHERE IdVehiculo = @pIdVehiculo)
    BEGIN
        RAISERROR ('Error: El vehiculo no existe', 16, 1);
        RETURN -1;
    END

    -- Valido que exista el empleado --
    IF NOT EXISTS (SELECT 1 FROM Empleado WHERE IdEmpleado = @pIdEmpleado)
    BEGIN
        RAISERROR ('Error: El empleado no existe', 16, 1);
        RETURN -1;
    END

    -- Valido fecha -- 

    -- Valido que la fecha no sea del pasado
    IF @pFechaTurno < GETDATE()
    BEGIN
        RAISERROR ('Error: No se puede crear un turno en una fecha pasada', 16, 1);
        RETURN -1;
    END

    -- INSERCION DE DATOS

    -- Inserto nuevo turno
    BEGIN TRY
        INSERT INTO Turno (IdVehiculo, IdEmpleado, FechaTurno, Estado, Observaciones)
        VALUES (@pIdVehiculo, @pIdEmpleado, @pFechaTurno, 'Pendiente', @pObservaciones)

        PRINT 'Turno agregado exitosamente.';
        RETURN 0;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE()
        RETURN -99; 
    END CATCH
END
GO


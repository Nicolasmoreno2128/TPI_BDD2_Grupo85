use TPI_BDD2_Grupo85
--------------
-- TRIGGERS --
--------------


CREATE TRIGGER trg_EvitarTurnosDuplicados
ON Turno
INSTEAD OF INSERT
AS
BEGIN

        IF EXISTS (SELECT 1 FROM Turno T 
        INNER JOIN inserted I ON T.IdVehiculo = I.IdVehiculo AND T.FechaTurno = I.FechaTurno
        )
        BEGIN
            RAISERROR('Ya existe un turno asignado para este vehículo en esa fecha y hora.', 16, 1);
            RETURN;
        END;

        INSERT INTO Turno (IdVehiculo, IdEmpleado, FechaTurno, Estado, Observaciones)
        SELECT IdVehiculo, IdEmpleado, FechaTurno, Estado, Observaciones
        FROM inserted;
END;
GO

-- Actualizar Stock de repuestos

CREATE TRIGGER TRG_ActualizarStockRepuestos ON ServiceDetalle_X_Repuestos
AFTER INSERT
AS
BEGIN

    --  Intento actualizar tabla Repuesto
    UPDATE R SET R.Stock = R.Stock - I.Cantidad FROM Repuesto R
    INNER JOIN INSERTED I ON R.IdRepuesto = I.IdRepuesto

    -- Verifico si queda en stock negativo
    IF EXISTS (
        SELECT 1 FROM Repuesto R
        INNER JOIN INSERTED I ON R.IdRepuesto = I.IdRepuesto
        WHERE R.Stock < 0
    )
    BEGIN
        -- Si queda negativo vuelvo atras
        ROLLBACK TRANSACTION

        RAISERROR('Error: No hay suficiente stock.',16,1)
    END
END
GO

INSERT INTO ServiceDetalle_X_Repuestos (IdServiceDetalle, IdRepuesto, Cantidad, PrecioUnitario)
VALUES (1,10,1000000, 3800.00)



    
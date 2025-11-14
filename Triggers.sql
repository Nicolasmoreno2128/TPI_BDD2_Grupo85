use TPI_BDD2_Grupo85
--------------
-- TRIGGERS --
--------------

CREATE TRIGGER trg_EvitarTurnosDuplicados
ON Turno
INSTEAD OF INSERT
AS
BEGIN

    BEGIN TRY
        BEGIN TRANSACTION;

        IF EXISTS (SELECT 1 FROM Turno T 
        INNER JOIN inserted I ON T.IdVehiculo = I.IdVehiculo AND T.FechaTurno = I.FechaTurno
        )
        BEGIN
            RAISERROR('Ya existe un turno asignado para este vehículo en esa fecha y hora.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;


        INSERT INTO Turno (IdVehiculo, IdEmpleado, FechaTurno, Estado, Observaciones)
        SELECT IdVehiculo, IdEmpleado, FechaTurno, Estado, Observaciones
        FROM inserted;

        COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO


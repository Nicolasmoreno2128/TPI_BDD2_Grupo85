Create database TPI_BDD2_Grupo85

go

use TPI_BDD2_Grupo85

go

------------------------
-- CREACION DE TABLAS --
------------------------

create table Marca(
IdMarca int identity (1,1) primary key,
Nombre Varchar (50) not null
)
go

create table ManoDeObra(
IdManoDeObra int identity (1,1) primary key,
Descripcion varchar (255) not null,
PrecioPorHora decimal (10,2) not null
)
go

CREATE TABLE TipoService (
    IdTipoService INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255)
)
GO

CREATE TABLE Repuesto(
    IdRepuesto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Stock INT NOT NULL,
    PrecioUnitario DECIMAL (10,2) NOT NULL
)
go

CREATE TABLE Pago (
    IdPago INT PRIMARY KEY IDENTITY (1,1),
    FechaPago DATETIME NOT NULL,
    Monto DECIMAL (10,2) CHECK (Monto > 0),
    MetodoPago VARCHAR (100) NOT NULL
)

go

CREATE TABLE Rol (
    IdRol INT PRIMARY KEY IDENTITY (1,1),
    Tipo VARCHAR (100) NOT NULL UNIQUE
);
go

CREATE TABLE Modelo (
    IdModelo INT IDENTITY(1,1) PRIMARY KEY,
    IdMarca INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (IdMarca) REFERENCES Marca(IdMarca)
)
GO


CREATE TABLE Persona(
    IdPersona INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    DNI VARCHAR(13) NOT NULL,
    Direccion VARCHAR(200) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    Email VARCHAR(100) NOT NULL
)
go


CREATE TABLE Usuario (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY,
    IdPersona INT NOT NULL,
    Usuario VARCHAR(255) NOT NULL,
    Contraseña VARCHAR(255) NOT NULL,
    IdRol INT NOT NULL,
    FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona),
    FOREIGN KEY (IdRol) REFERENCES Rol(IdRol)
)
GO

--Nico
CREATE TABLE Cliente(
IdCliente int identity (1,1) primary key,
IdPersona int not null,
FechaAlta datetime not null,
foreign key (IdPersona) references Persona(IdPersona)

)

go


CREATE TABLE Empleado (
    IdEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    IdPersona INT NOT NULL,
    Puesto VARCHAR(100) NOT NULL,
    Sueldo DECIMAL(10,2) NOT NULL,
    FechaIngreso DATETIME NOT NULL,
    FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona)
)
GO


CREATE TABLE Vehiculo (
    IdVehiculo INT PRIMARY KEY IDENTITY (1,1),
    IdCliente INT NOT NULL,
    IdModelo INT NOT NULL,
    Patente VARCHAR (10) UNIQUE NOT NULL,
    Kilometraje INT NOT NULL,
    FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente),
    FOREIGN KEY (IdModelo) REFERENCES Modelo(IdModelo)
);
go


CREATE TABLE Turno(
IdTurno int identity (1,1) primary key,
IdVehiculo int not null,
IdEmpleado int not null,
FechaTurno datetime not null,
Estado varchar(20) not null,
Observaciones text not null,
foreign key (IdVehiculo) references Vehiculo(IdVehiculo),
foreign key (IdEmpleado) references Empleado(IdEmpleado)
)

go 

CREATE TABLE Service_(
    IdService INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    IdTurno INT NOT NULL FOREIGN KEY REFERENCES Turno(IdTurno), 
    IdEmpleado INT NOT NULL FOREIGN KEY REFERENCES Empleado(IdEmpleado), 
    IdTipoService INT NOT NULL FOREIGN KEY REFERENCES TipoService(IdTipoService), 
    FechaInicio DATETIME,
    FechaFinal DATETIME,
    Estado VARCHAR(200) NOT NULL,
    IdPago INT NOT NULL FOREIGN KEY REFERENCES Pago(IdPago)
)
go

CREATE TABLE Service_Detalle(
    IdServiceDetalle INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    IdService INT NOT NULL FOREIGN KEY REFERENCES Service_(IdService),
    IdManoDeObra INT NOT NULL FOREIGN KEY REFERENCES ManoDeObra(IdManoDeObra),
    Horas DECIMAL(8,2) NOT NULL,
    PrecioPorHora DECIMAL(10,2) NOT NULL
)
go

CREATE TABLE ServiceDetalle_X_Repuestos (
    IdServiceDetalle INT NOT NULL,
    IdRepuesto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (IdServiceDetalle, IdRepuesto),
    FOREIGN KEY (IdServiceDetalle) REFERENCES Service_Detalle (IdServiceDetalle),
    FOREIGN KEY (IdRepuesto) REFERENCES Repuesto (IdRepuesto)
);

go

CREATE TABLE Service_Detalle_x_Tipo_Service (
IdServiceDetalle int not null,
IdTipoService int not null,
primary key (IdServiceDetalle,IdTipoService),
foreign key (IdServiceDetalle) references Service_Detalle (IdServiceDetalle),
foreign key (IdTipoService) references TipoService (IdTipoService)

)



------------------------
-- INSERCION DE DATOS --
------------------------

INSERT INTO Rol (Tipo) VALUES 
('Administrador'),
('Mecánico'),
('Recepcionista'),
('Cliente');

INSERT INTO Persona (Nombre, Apellido, DNI, Direccion, FechaNacimiento, Email) VALUES 
('Julian', 'Lopez', '40333111', 'Av. Rivadavia 1200', '1998-03-14', 'julian@gmail.com'),
('Maia', 'Perez', '39222444', 'Mitre 550', '1999-05-20', 'maia@gmail.com'),
('Santiago', 'Morales', '37555777', 'Belgrano 820', '1995-07-10', 'santi@gmail.com'),
('Nicolas', 'Fernandez', '38888999', 'Lavalle 1020', '2000-02-01', 'nico@gmail.com'),
('Rocio', 'Acosta', '40111222', 'Roca 800', '1997-08-12', 'rocio@gmail.com'),
('Matias', 'Gomez', '35555444', 'Sarmiento 100', '1993-12-03', 'matias@gmail.com'),
('Carla', 'Diaz', '36666777', 'Belgrano 450', '1994-11-15', 'carla@gmail.com'),
('Lucas', 'Benitez', '39999111', 'Alsina 200', '1999-01-24', 'lucas@gmail.com'),
('Tomas', 'Farias', '37777111', 'Rivadavia 620', '1996-06-30', 'tomas@gmail.com'),
('Lautaro', 'Mendez', '38888555', 'San Martin 90', '1998-09-10', 'lautaro@gmail.com');

INSERT INTO Usuario (IdPersona, Usuario, Contraseña, IdRol) VALUES 
(1, 'julianadmin', '1234', 1),
(2, 'maiarecepcion', '1234', 3),
(3, 'santimeca', '1234', 2),
(4, 'nicomeca', '1234', 2),
(5, 'rociocliente', '1234', 4),
(6, 'matiascliente', '1234', 4),
(7, 'carlacliente', '1234', 4),
(8, 'lucascliente', '1234', 4),
(9, 'tomascliente', '1234', 4),
(10, 'lautaroempleado', '1234', 2);

INSERT INTO Cliente (IdPersona, FechaAlta) VALUES
(5, '2023-05-01'),
(6, '2023-06-10'),
(7, '2023-06-15'),
(8, '2023-07-05'),
(9, '2023-07-10');

INSERT INTO Empleado (IdPersona, Puesto, Sueldo, FechaIngreso) VALUES
(1, 'Administrador', 250000, '2022-03-01'),
(2, 'Recepcionista', 180000, '2023-01-15'),
(3, 'Mecánico', 220000, '2021-08-10'),
(4, 'Mecánico', 215000, '2022-02-20'),
(10, 'Ayudante', 160000, '2023-10-01');

INSERT INTO Marca (Nombre) VALUES 
('Ford'),
('Chevrolet'),
('Volkswagen'),
('Toyota'),
('Peugeot');

INSERT INTO Modelo (IdMarca, Nombre) VALUES
(1, 'Fiesta'),
(1, 'Focus'),
(2, 'Onix'),
(3, 'Gol Trend'),
(4, 'Corolla'),
(5, '208');

INSERT INTO Vehiculo (IdCliente, IdModelo, Patente, Kilometraje) VALUES
(1, 1, 'AA123BB', 55000),
(2, 3, 'AC456CD', 72000),
(3, 4, 'AD789EF', 48000),
(4, 5, 'AE321GH', 35000),
(5, 6, 'AF654IJ', 61000);

INSERT INTO Pago (FechaPago, Monto, MetodoPago) VALUES
('2024-05-01', 25000, 'Efectivo'),
('2024-05-02', 30000, 'Tarjeta Débito'),
('2024-06-15', 45000, 'Transferencia'),
('2024-07-10', 18000, 'Efectivo'),
('2024-07-20', 60000, 'Tarjeta Crédito');

INSERT INTO TipoService (Nombre, Descripcion) VALUES
('Cambio de Aceite', 'Reemplazo de aceite y filtro'),
('Revisión General', 'Chequeo de frenos, luces y fluidos'),
('Cambio de Filtro de Aire', 'Reemplazo del filtro de aire'),
('Alineación y Balanceo', 'Ajuste de ruedas y balanceo'),
('Cambio de Batería', 'Sustitución de batería por una nueva');

INSERT INTO ManoDeObra (Descripcion, PrecioPorHora) VALUES
('Cambio de aceite y filtro', 3500.00),
('Alineación y balanceo', 4000.00),
('Revisión general', 4500.00),
('Cambio de pastillas de freno', 3800.00),
('Cambio de batería', 3000.00),
('Cambio de filtro de aire', 2500.00),
('Diagnóstico electrónico', 5000.00),
('Limpieza de inyectores', 4200.00),
('Cambio de bujías', 2800.00),
('Control de luces', 2000.00);

INSERT INTO Turno (IdVehiculo, IdEmpleado, FechaTurno, Estado, Observaciones) VALUES
(1, 3, '2024-05-05', 'Completado', 'Service completo realizado sin novedades'),
(2, 4, '2024-05-08', 'Cancelado', 'Cliente reprogramó por viaje'),
(3, 3, '2024-06-01', 'Completado', 'Revisión y cambio de frenos'),
(4, 4, '2024-07-10', 'En Proceso', 'Esperando repuesto'),
(5, 3, '2024-07-20', 'Completado', 'Alineación y balanceo realizado');

INSERT INTO Service_ (IdTurno, IdEmpleado, IdTipoService, FechaInicio, FechaFinal, Estado, IdPago) VALUES
(1, 3, 1, '2024-05-05', '2024-05-06', 'Finalizado', 1),
(3, 3, 2, '2024-06-01', '2024-06-02', 'Finalizado', 2),
(4, 4, 5, '2024-07-10', NULL, 'En Proceso', 3),
(5, 3, 4, '2024-07-20', '2024-07-21', 'Finalizado', 4);

INSERT INTO Service_Detalle (IdService, IdManoDeObra, Horas, PrecioPorHora) VALUES
(1, 1, 1.0, 3500.00), -- service 1 - cambio aceite, $3500, 1 hora
(1, 3, 2.5, 4500.00), -- service 1 - revision general, $4500, 2.5 hora
(2, 4, 1.5, 3800.00), -- service 2 - frenos, $3800, 1.5 hora
(3, 5, 0.5, 3000.00),
(4, 2, 1.2, 4000.00);

INSERT INTO Repuesto (Nombre, Stock, PrecioUnitario) VALUES
('Filtro de aceite', 50, 2500.00),
('Aceite sintético 5W30', 40, 8500.00),
('Pastillas de freno', 60, 7800.00),
('Batería Moura 65Ah', 25, 45000.00),
('Filtro de aire', 45, 3200.00),
('Bujías NGK', 80, 1500.00),
('Líquido de frenos DOT4', 30, 2200.00),
('Aceite caja ATF', 20, 9500.00),
('Filtro de combustible', 35, 4100.00),
('Limpiador inyectores', 15, 3800.00);

INSERT INTO ServiceDetalle_X_Repuestos (IdServiceDetalle, IdRepuesto, Cantidad, PrecioUnitario) VALUES
(1, 1, 1, 2500.00),
(1, 2, 4, 8500.00),
(2, 3, 1, 7800.00),
(3, 4, 1, 45000.00),
(4, 5, 1, 3200.00),
(4, 6, 4, 1500.00),
(5, 2, 3, 2200.00);

INSERT INTO Service_Detalle_x_Tipo_Service (IdServiceDetalle, IdTipoService) VALUES
(1, 1),
(2, 2),
(3, 5),
(4, 4),
(5, 3);

-------------------------
-- CONSULTAS DE PRUEBA --
-------------------------

SELECT * FROM Service_

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
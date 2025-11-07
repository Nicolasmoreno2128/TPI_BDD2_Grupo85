Create database TPI_BDD2_Grupo85

go

use TPI_BDD2_Grupo85

go

--Nico
create table Marca(
IdMarca int identity (1,1) primary key,
Nombre Varchar (50) not null
)
go
--Nico
create table ManoDeObra(
IdManoDeObra int identity (1,1) primary key,
Descripcion varchar (255) not null,
PrecioPorHora decimal (10,2) not null
)
go
--Maia
CREATE TABLE TipoService (
    IdTipoService INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255)
)
GO

CREATE TABLE Repuestos(
    IdRepuesto INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Stock INT NOT NULL,
    PrecioUnitario DECIMAL (10,2) NOT NULL
)
go

CREATE TABLE Pagos (
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

-- Santiago
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

--Maia
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

--Maia
CREATE TABLE Empleado (
    IdEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    IdPersona INT NOT NULL,
    Puesto VARCHAR(100) NOT NULL,
    Sueldo DECIMAL(10,2) NOT NULL,
    FechaIngreso DATETIME NOT NULL,
    FOREIGN KEY (IdPersona) REFERENCES Persona(IdPersona)
)
GO

--Julian
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

--Nico
CREATE TABLE Turnos(
IdTurno int identity (1,1) primary key,
IdVehiculo int not null,
IdEmpleados int not null,
FechaTurno datetime not null,
Estado varchar(20) not null,
Observaciones text not null,
foreign key (IdVehiculo) references Vehiculo(IdVehiculo),
foreign key (IdEmpleados) references Empleado(IdEmpleado)
)

go 

CREATE TABLE Service_(
    IdService INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    IdTurno INT NOT NULL FOREIGN KEY REFERENCES Turnos(IdTurno), 
    IdEmpleado INT NOT NULL FOREIGN KEY REFERENCES Empleado(IdEmpleado), 
    IdTipoService INT NOT NULL FOREIGN KEY REFERENCES TipoService(IdTipoService), 
    FechaInicio DATETIME,
    FechaFinal DATETIME,
    Estado VARCHAR(200) NOT NULL,
    IdPago INT NOT NULL FOREIGN KEY REFERENCES Pagos(IdPago)
)
go

CREATE TABLE Service_Detalle(
    IdServiceDetalle INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    IdService INT NOT NULL FOREIGN KEY REFERENCES Service_(IdService),
    IdManoDeObra INT NOT NULL FOREIGN KEY REFERENCES ManoDeObra(IdManoDeObra)
)
go

CREATE TABLE ServiceDetalle_X_Repuestos (
    IdServiceDetalle INT NOT NULL,
    IdRepuesto INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PRIMARY KEY (IdServiceDetalle, IdRepuesto),
    FOREIGN KEY (IdServiceDetalle) REFERENCES Service_Detalle (IdServiceDetalle),
    FOREIGN KEY (IdRepuesto) REFERENCES Repuestos (IdRepuesto)
);

go

CREATE TABLE Service_Detalle_x_Tipo_Service (
IdServiceDetalle int not null,
IdTipoService int not null,
primary key (IdServiceDetalle,IdTipoService),
foreign key (IdServiceDetalle) references Service_Detalle (IdServiceDetalle),
foreign key (IdTipoService) references TipoService (IdTipoService),


)




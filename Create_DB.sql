--Create database TPI_BDD2_Grupo85

--go

use TPI_BDD2_Grupo85

go

--Nico
create table Marca(
IdMarca int identity (1,1) primary key,
Nombre Varchar (50) not null
)
go
--Nico
create table Mano_De_Obra(
IdManoDeObra int identity (1,1) primary key,
Descripcion varchar (255) not null,
PrecioPorHora decimal not null
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
--Maia
CREATE TABLE Modelo (
    IdModelo INT IDENTITY(1,1) PRIMARY KEY,
    IdMarca INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    FOREIGN KEY (IdMarca) REFERENCES Marca(IdMarca)
)
GO
--Maia
CREATE TABLE TipoService (
    IdTipoService INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Descripcion VARCHAR(255)
)
GO




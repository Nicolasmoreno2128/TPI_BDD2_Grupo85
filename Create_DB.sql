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






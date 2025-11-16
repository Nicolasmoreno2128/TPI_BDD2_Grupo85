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
(5, 6, 'AF654IJ', 61000),
(1, 2, 'AA987CD', 45000),  
(2, 5, 'AC222EF', 38000),  
(3, 1, 'AD333GH', 52000),  
(4, 4, 'AE444IJ', 69000),  
(5, 6, 'AF555KL', 41000);  

INSERT INTO Pago (FechaPago, Monto, MetodoPago) VALUES
('2024-05-01', 25000, 'Efectivo'),
('2024-05-02', 30000, 'Tarjeta Débito'),
('2024-06-15', 45000, 'Transferencia'),
('2024-07-10', 18000, 'Efectivo'),
('2024-07-20', 60000, 'Tarjeta Crédito'),
('2024-08-01', 32000, 'Efectivo'),       
('2024-08-10', 48000, 'Transferencia'), 
('2024-09-05', 22000, 'Efectivo'),       
('2024-09-20', 15000, 'Tarjeta Débito'); 


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
(5, 3, '2024-07-20', 'Completado', 'Alineación y balanceo realizado'),
(1, 3, '2025-11-20', 'Pendiente', 'Service programado: cambio de aceite y revisión general'),
(2, 4, '2025-12-02', 'Pendiente', 'Revisión general antes de viaje largo'),
(3, 3, '2025-12-10', 'Programado', 'Chequeo de frenos y alineación'),
(4, 5, '2025-12-18', 'Pendiente', 'Cambio de batería y diagnóstico electrónico'),
(5, 4, '2026-01-15', 'Pendiente', 'Service completo post vacaciones'),
(6, 3, '2024-08-01', 'Completado', 'Cambio de aceite y control general'),
(7, 4, '2024-08-10', 'Completado', 'Revisión general antes de viaje'),
(8, 3, '2024-09-05', 'Completado', 'Cambio de pastillas de freno'),
(9, 5, '2024-09-20', 'Completado', 'Alineación y balanceo'),
(10, 4, '2024-10-01', 'Completado', 'Cambio de batería');


INSERT INTO Service_ (IdTurno, IdEmpleado, IdTipoService, FechaInicio, FechaFinal, Estado, IdPago) VALUES
(1, 3, 1, '2024-05-05', '2024-05-06', 'Finalizado', 1),
(3, 3, 2, '2024-06-01', '2024-06-02', 'Finalizado', 2),
(4, 4, 5, '2024-07-10', NULL, 'En Proceso', 3),
(5, 3, 4, '2024-07-20', '2024-07-21', 'Finalizado', 4),
(6, 3, 1, '2024-08-01', '2024-08-02', 'Finalizado', 6),
(7, 4, 2, '2024-08-10', '2024-08-11', 'Finalizado', 7), 
(8, 3, 4, '2024-09-05', '2024-09-06', 'Finalizado', 8),
(9, 5, 3, '2024-09-20', '2024-09-21', 'Finalizado', 9), 
(10, 4, 5, '2024-10-01', '2024-10-02', 'Finalizado', 5); 


INSERT INTO Service_Detalle (IdService, IdManoDeObra, Horas, PrecioPorHora) VALUES
(1, 1, 1.0, 3500.00), -- service 1 - cambio aceite, $3500, 1 hora
(1, 3, 2.5, 4500.00), -- service 1 - revision general, $4500, 2.5 hora
(2, 4, 1.5, 3800.00), -- service 2 - frenos, $3800, 1.5 hora
(3, 5, 0.5, 3000.00),
(4, 2, 1.2, 4000.00),
(6, 1, 1.0, 3500.00),
(7, 3, 2.0, 4500.00),
(8, 4, 1.5, 3800.00),
(9, 2, 1.2, 4000.00),
(10, 5, 0.8, 3000.00);

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
(5, 2, 3, 2200.00),
(6, 1, 1, 2500.00),
(7, 3, 1, 7800.00),
(8, 2, 4, 8500.00),
(9, 5, 1, 3200.00),
(10, 4, 1, 45000.00);

INSERT INTO Service_Detalle_x_Tipo_Service (IdServiceDetalle, IdTipoService) VALUES
(1, 1),
(2, 2),
(3, 5),
(4, 4),
(5, 3),
(6, 1), 
(7, 2), 
(8, 4), 
(9, 3), 
(10, 5);
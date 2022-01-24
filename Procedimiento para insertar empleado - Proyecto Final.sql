select*from Empleado
Select*from PuestoEmpleado

Insert into PuestoEmpleado(Descripcion)
values('Programador')

--PROCEDIMIENTO PARA INSERTAR EMPLEADO

create procedure spInsertarEmpleado
@Nombre VARCHAR(100),
@Apellido VARCHAR(100),
@Direccion VARCHAR(500),
@PuestoID int,
@FechaNacimiento Date,
@SueldoHora money
as
begin
	insert into Empleado(Nombre, Apellido, Direccion, PuestoID, FechaNacimiento, SueldoHora)
	Values (@Nombre, @Apellido, @Direccion, @PuestoID, @FechaNacimiento, @SueldoHora)
end

exec spInsertarEmpleado 'Sergio', 'Sanchez', 'Av Amazonas', 1, '2001-08-14', 5.3
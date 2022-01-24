select*from Marca
exec spActualizarHoras 1, '2022-01-23', 'EF', '2022-01-23 14:05:00'

CREATE PROCEDURE spActualizarHoras
@EmpleadoID int,
@Fecha DATE,
@Tipo VARCHAR(2),
@FechaNueva DATETIME
AS
BEGIN
	UPDATE Marca SET Fecha = @FechaNueva where CONVERT(Date, Fecha) = @Fecha AND EmpleadoID = @EmpleadoID
	AND Tipo = @Tipo
END
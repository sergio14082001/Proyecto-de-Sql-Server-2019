--CREATE TABLE LogFechasModifico(
--	LogID int primary key identity(1,1),
--	Fecha DateTime,
--	Usuario VARCHAR(100),
--	EmpleadoID int,
--	FechaAnterior DATETIME,
--)

--Se coloco ese after, porque quiero que justo antes de actualizar se ejecute este trigger
CREATE TRIGGER trLogFechasModifico ON Marca AFTER Update
as
begin

	Declare @EmpleadoID int, @FechaAnterior DATETIME
	SET @EmpleadoID = (SELECT EmpleadoID from deleted)
	SET @FechaAnterior = (SELECT Fecha from deleted)
	INSERT INTO LogFechasModifico(Fecha, Usuario, EmpleadoID, FechaAnterior)
	Values (GETDATE(), SUSER_NAME(), @EmpleadoID, @FechaAnterior)
end
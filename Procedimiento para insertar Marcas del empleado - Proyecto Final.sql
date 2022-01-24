select*from Marca


Create Procedure spInsertarMarca
@EmpleadoID int
as
begin	
	Declare @Marcas INT = (Select COUNT(*) from Marca where EmpleadoID = @EmpleadoID AND CONVERT(Date, Fecha) = CONVERT(Date, GETDATE()))
	IF (@Marcas < 4) 
	begin
		insert into Marca(Fecha, EmpleadoID)
		Values(GETDATE(), @EmpleadoID)
	end
	else
	begin
		PRINT('Este usuario ya marco las 4 veces')
	end
end

exec spInsertarMarca 1
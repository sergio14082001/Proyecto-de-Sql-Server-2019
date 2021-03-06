USE [ControlMarcas]
GO
/****** Object:  StoredProcedure [dbo].[spInsertarMarca]    Script Date: 23/01/2022 22:35:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Procedure [dbo].[spInsertarMarca]
@EmpleadoID int
as
begin	
	Declare @Marcas INT = (Select COUNT(*) from Marca where EmpleadoID = @EmpleadoID AND CONVERT(Date, Fecha) = CONVERT(Date, GETDATE()))
	IF (@Marcas < 4) 
	begin
		IF (@Marcas = 0)
		BEGIN
			insert into Marca(Fecha, EmpleadoID, Tipo)
			Values(GETDATE(), @EmpleadoID, 'EI')--Entrada Inicial
		END
		IF (@Marcas = 1)
		BEGIN
			insert into Marca(Fecha, EmpleadoID, Tipo)
			Values(GETDATE(), @EmpleadoID, 'SI')--Salida Inicial
		END
		IF(@Marcas = 2)
		BEGIN
			insert into Marca(Fecha, EmpleadoID, Tipo)
			Values(GETDATE(), @EmpleadoID, 'EF')--Entrada Final
		END
		IF(@Marcas = 3)
		BEGIN
			insert into Marca(Fecha, EmpleadoID, Tipo)
			Values(GETDATE(), @EmpleadoID, 'SF')--Salida Final
		END
	end
	else
	begin
		PRINT('Este usuario ya marco las 4 veces')
	end
end
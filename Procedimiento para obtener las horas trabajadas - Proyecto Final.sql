USE [ControlMarcas]
GO
/****** Object:  StoredProcedure [dbo].[spObtenerHorasTrabajadas]    Script Date: 24/01/2022 00:01:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spObtenerHorasTrabajadas]
@FechaInicial Date,
@FechaFinal Date
as
begin
	Select EmpleadoID, CONVERT(Date, Fecha) Fecha, MAX(Case When Tipo = 'EI' THEN Fecha END) EI,
	MAX(Case When Tipo = 'SI' THEN Fecha END) SI,
	MAX(Case When Tipo = 'EF' THEN Fecha END) EF,
	MAX(Case When Tipo = 'SF' THEN Fecha END) SF
	INTO #Marcas from Marca GROUP BY EmpleadoID, CONVERT(Date, Fecha)

	Select EmpleadoID, Fecha, (ISNULL(DATEDIFF(HOUR, EI, SI),0)) + (ISNULL(DATEDIFF(HOUR, EF, SF), 0)) HorasTrabajadas INTO #HorasTrabajadas from #Marcas

	Select E.EmpleadoID, E.Nombre, E.Apellido, MAX(E.SueldoHora) SueldoHora, SUM(H.HorasTrabajadas) Horas INTO #HorasTotales
	from #HorasTrabajadas H 
	inner join Empleado E on H.EmpleadoID = E.EmpleadoID 
	Where H.Fecha between @FechaInicial AND @FechaFinal --Aqui establecemos entre que fechas se hace esto
	group by E.EmpleadoID, E.Nombre, E.Apellido 

	
	ALTER TABLE #HorasTotales ADD TotalPagar Money

	UPDATE #HorasTotales SET TotalPagar = Case when Horas<= 80 THEN (Horas-0.5) ELSE Horas end*SueldoHora
	Select*from #HorasTotales 


	DROP TABLE #HorasTotales
	DROP TABLE #HorasTrabajadas
	DROP TABLE #Marcas
end

--Aqui llego el momento de pasar todo lo de las tablas temporales a un procedimiento:
CREATE PROCEDURE spObtenerHorasTrabajadas
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

	Select*from #HorasTotales 
	ALTER TABLE #HorasTotales ADD TotalPagar Money

	UPDATE #HorasTotales SET TotalPagar = Case when Horas<= 80 THEN (Horas-0.5) ELSE Horas end*SueldoHora
 
	DROP TABLE #HorasTotales
	DROP TABLE #HorasTrabajadas
	DROP TABLE #Marcas
end


exec spObtenerHorasTrabajadas '2022-01-01', '2022-01-24'



-------------------------------------------------------------------------------------------------
Declare @FechaInicial Date = '2022-01-01'
Declare @FechaFinal Date = GETDATE()


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

Select*from #HorasTotales 
ALTER TABLE #HorasTotales ADD TotalPagar Money

UPDATE #HorasTotales SET TotalPagar = Case when Horas<= 80 THEN (Horas-0.5) ELSE Horas end*SueldoHora
 
DROP TABLE #HorasTotales
DROP TABLE #HorasTrabajadas
DROP TABLE #Marcas


UPDATE Marca SET Fecha = '2022-01-23 08:10:21.873' Where MarcaID = 6
UPDATE Marca SET Fecha = '2022-01-23 11:59:21.873' Where MarcaID = 7
UPDATE Marca SET Fecha = '2022-01-23 13:15:21.873' Where MarcaID = 8
UPDATE Marca SET Fecha = '2022-01-23 17:59:21.873' Where MarcaID = 9
UPDATE Marca SET Fecha = '2022-01-23 08:11:21.873' Where MarcaID = 10
UPDATE Marca SET Fecha = '2022-01-23 12:29:21.873' Where MarcaID = 11
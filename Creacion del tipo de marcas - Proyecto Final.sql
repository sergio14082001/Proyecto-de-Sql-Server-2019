select*from Marca

Update Marca set Fecha = '2022-01-23 08:01:29.720' where MarcaID = 1
Update Marca set Fecha = '2022-01-23 12:05:29.720' where MarcaID = 2
Update Marca set Fecha = '2022-01-23 13:04:29.720' where MarcaID = 3
Update Marca set Fecha = '2022-01-23 17:08:29.720' where MarcaID = 4

Update Marca set Tipo = 'EI' where MarcaID = 1
Update Marca set Tipo = 'SI' where MarcaID = 2
Update Marca set Tipo = 'EF' where MarcaID = 3
Update Marca set Tipo = 'SF' where MarcaID = 4

create table TipoMarca(
	Tipo Varchar(2) primary Key,
	Descripcion VARCHAR(100)
)
Insert into TipoMarca (Tipo, Descripcion)
Values('EI', 'Entrada Inicial')
Insert into TipoMarca (Tipo, Descripcion)
Values('SI', 'Salida Inicial')
Insert into TipoMarca (Tipo, Descripcion)
Values('EF', 'Entrada Final')
Insert into TipoMarca (Tipo, Descripcion)
Values('SF', 'Salida Final')


Select*from Empleado E inner join Marca M ON E.EmpleadoID = M.EmpleadoID 
inner join TipoMarca T on M.Tipo = T.Tipo


Select EmpleadoID, CONVERT(Date, Fecha) Fecha, MAX(Case When Tipo = 'EI' THEN Fecha END) EI,
MAX(Case When Tipo = 'SI' THEN Fecha END) SI,
MAX(Case When Tipo = 'EF' THEN Fecha END) EF,
MAX(Case When Tipo = 'SF' THEN Fecha END) SF
from Marca GROUP BY EmpleadoID, CONVERT(Date, Fecha)
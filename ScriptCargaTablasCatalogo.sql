-----** Script para la carga de datos [Catalogo.xml] en tablas **-----

USE [TareaProgramada2]

-----/ Carga de datos [Tipo Movimiento] /-----

INSERT INTO [dbo].[TipoMovimiento]
SELECT
	A.TipoMovimiento.value('@Nombre', 'varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/TipodeMovimientoLecturadeMedidores/TipodeMovimientoLecturadeMedidor') as A(TipoMovimiento)
GO

SELECT * FROM [dbo].[TipoMovimiento]
GO
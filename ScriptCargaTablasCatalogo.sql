-----** Script para la carga de datos [Catalogo.xml] en tablas **-----

USE [TareaProgramada2]


-----/ Carga de datos [Tipo Movimiento] /-----

DELETE [dbo].[TipoMovimiento]
DBCC CHECKIDENT ('TareaProgramada2.dbo.TipoMovimiento', RESEED, 0)

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

-----/ Carga de datos [Tipo Propiedad] /-----

DELETE [dbo].[TipoPropiedad]
DBCC CHECKIDENT ('TareaProgramada2.dbo.TipoPropiedad', RESEED, 0)

INSERT INTO [dbo].[TipoPropiedad]
SELECT
	A.TipoPropiedad.value('@Nombre', 'varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/TipoUsoPropiedades/TipoUsoPropiedad') as A(TipoPropiedad)
GO

SELECT * FROM [dbo].[TipoPropiedad]
GO

-----/ Carga de datos [TipoUsoSuelo] /-----

DELETE [dbo].[TipoUsoSuelo]
DBCC CHECKIDENT ('TareaProgramada2.dbo.TipoUsoSuelo', RESEED, 0)

INSERT INTO [dbo].[TipoUsoSuelo]
SELECT
	A.TipoUsoSuelo.value('@Nombre', 'varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/TipoZonaPropiedades/TipoZonaPropiedad') as A(TipoUsoSuelo)
GO

SELECT * FROM [dbo].[TipoUsoSuelo]
GO

-----/ Carga de datos [TipoDocumentoIdentidad] /-----

DELETE [dbo].[TipoIdentificacion]
DBCC CHECKIDENT ('TareaProgramada2.dbo.TipoIdentificacion', RESEED, 0)

INSERT INTO [dbo].[TipoIdentificacion]
SELECT
	A.TipoIdentificacion.value('@Nombre', 'varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/TipoDocumentoIdentidades/TipoDocumentoIdentidad') as A(TipoIdentificacion)
GO

SELECT * FROM [dbo].[TipoIdentificacion]
GO

-----/ Carga de datos [MedioPago] /-----

DELETE [dbo].[MedioPago]
DBCC CHECKIDENT ('TareaProgramada2.dbo.MedioPago', RESEED, 0)

INSERT INTO [dbo].[MedioPago]
SELECT
	A.MedioPago.value('@Nombre', 'varchar(128)') as Tipo
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/TipoMedioPagos/TipoMedioPago') as A(MedioPago)
GO

SELECT * FROM [dbo].[MedioPago]
GO



-----/ Carga de datos [PeridoPago] /-----

DELETE [dbo].[PeriodoMontoCC]
DBCC CHECKIDENT ('TareaProgramada2.dbo.PeriodoMontoCC', RESEED, 0)

INSERT INTO [dbo].[PeriodoMontoCC]
SELECT
	A.Periodo.value('@Nombre', 'varchar(128)') as Tipo
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/PeriodoMontoCCs/PeriodoMontoCC') as A(Periodo)
GO

SELECT * FROM [dbo].[PeriodoMontoCC]
GO

-----/ Carga de datos [TipoMontoCC] /-----

DELETE [dbo].[TipoMontoCC]
DBCC CHECKIDENT ('TareaProgramada2.dbo.TipoMontoCC', RESEED, 0)

INSERT INTO [dbo].[TipoMontoCC]
SELECT
	A.Tipo.value('@Nombre', 'varchar(128)') as Nombre
from (
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/TipoMontoCCs/TipoMontoCC') as A(Tipo)
GO

SELECT * FROM [dbo].[TipoMontoCC]
GO


-----/ Carga de datos [TipoCC] /-----

DELETE [dbo].[ConceptoCobro]
DBCC CHECKIDENT ('TareaProgramada2.dbo.ConceptoCobro', RESEED, 0)

INSERT INTO [dbo].[ConceptoCobro]
SELECT
	A.ConceptoCobro.value('@Nombre', 'varchar(128)') as Nombre,
	PM.id as idPeriodoMonto,
	TM.id as idTipoMonto,
	A.ConceptoCobro.value('@ValorMinimo','int') as ValorMinimo,
	A.ConceptoCobro.value('@ValorMinimoM3','int') as ValorMinimoM3,
	A.ConceptoCobro.value('@Valorm3','int') as ValorM3,
	A.ConceptoCobro.value('@ValorPorcentual','float') as ValorPorcentual,
	A.ConceptoCobro.value('@ValorFijo','int') as ValorFijo,
	A.ConceptoCobro.value('@ValorM2Minimo','int') as ValorM2Minimo,
	A.ConceptoCobro.value('@ValorTractosM2','int') as ValorTractosM2,
	A.ConceptoCobro.value('@ValorFijoM3Adicional','int') as ValorFijoM3Adicional
FROM(
	select cast(c as xml) from 
	openrowset(
		BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Catalogo.xml',
		SINGLE_BLOB
	) as T(c)
) as S(c)
CROSS APPLY c.nodes('Catalogo/CCs/CC') as A(ConceptoCobro),
[dbo].[PeriodoMontoCC] PM, [dbo].[TipoMontoCC] TM 
WHERE A.ConceptoCobro.value('@PeriodoMontoCC','int')=PM.id AND A.ConceptoCobro.value('@TipoMontoCC','int')=TM.id
GO

SELECT * FROM [dbo].[ConceptoCobro]
GO


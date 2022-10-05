USE [TareaProgramada2]
GO

ALTER TABLE dbo.PropiedadesxPersona
DROP CONSTRAINT FK_Personas
GO

ALTER TABLE dbo.Propiedades
DROP CONSTRAINT FK_Tipo_Propiedad,FK_Tipo_Uso_Suelo,FK_Usuario_Prop
GO

ALTER TABLE dbo.MovimientoConsumo
DROP CONSTRAINT FK_Concepto_CAgua,FK_Tipo_Mov
GO


ALTER TABLE dbo.PropiedadxConceptoCobro
DROP CONSTRAINT FK_Prop_CC
GO

ALTER TABLE dbo.PropiedadxConceptoCobro
DROP CONSTRAINT FK_CC
GO

ALTER TABLE dbo.Propiedades
DROP CONSTRAINT FK_Propiedades_Persona
GO

ALTER TABLE dbo.Usuario
DROP CONSTRAINT FK_Usuario_Persona


DELETE FROM dbo.Persona
DBCC CHECKIDENT ('TareaProgramada2.dbo.Persona', RESEED, 0)

DELETE FROM dbo.Propiedades
DBCC CHECKIDENT ('TareaProgramada2.dbo.Propiedades', RESEED, 0)

DELETE FROM dbo.PropiedadesxPersona
DBCC CHECKIDENT ('TareaProgramada2.dbo.PropiedadesxPersona', RESEED, 0)

DELETE FROM dbo.PropiedadxConceptoCobro
DBCC CHECKIDENT ('TareaProgramada2.dbo.PropiedadxConceptoCobro', RESEED, 0)

DELETE FROM dbo.Usuario
DBCC CHECKIDENT ('TareaProgramada2.dbo.Usuario', RESEED, 0)

DELETE FROM dbo.MovimientoConsumo
DBCC CHECKIDENT ('TareaProgramada2.dbo.MovimientoConsumo', RESEED, 0)


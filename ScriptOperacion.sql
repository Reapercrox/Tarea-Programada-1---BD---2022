-----** Script para la simulación de operaciones **-----
SET NOCOUNT ON

USE [TareaProgramada2]

-----* Script carga personas por fecha *-----

DECLARE @datosXml XML
SET @datosXml = (
	SELECT *
	FROM OPENROWSET(BULK 'C:\Users\memis\Documents\Bases_de_Datos\Segunda Tarea Programada\Operaciones.xml', SINGLE_BLOB)
	AS datosXml
);

DECLARE @Fechas TABLE(
	sec INT IDENTITY (1,1),
	FechaOperacion DATE
	);


DECLARE @PersonasAInsertar TABLE (
	sec [int] IDENTITY(1,1),
	Nombre [varchar] (128),
	TipoIdentificacion [varchar] (128),
	NumeroIdentificacion [int],
	Telefono1 [int],
	Telefono2 [int],
	Email [varchar] (128)
);

DECLARE @PropiedadesAInsertar TABLE (
	sec [int] IDENTITY (1,1),
	NumeroFinca [int],
	Area [int],
	TipoUsoSuelo [varchar] (128),
	TipoPropiedad [varchar] (128),
	NumeroMedidor [int],
	ValorFiscal [bigint]
);

DECLARE @PersonasXPropiedadesInsertar TABLE (
	sec [int] IDENTITY (1,1),
	ValorDocumentoIdentidad [int],
	NumeroFinca [int],
	TipoAsociacion [varchar] (128)
);

DECLARE @UsuarioOperacion TABLE(
	sec [int] IDENTITY (1,1),
	ValorDocumentoIdentidad [int],
	TipoUsuario [varchar] (128),
	TipoAsociacion [varchar] (128),
	Username [varchar] (128),
	Password [varchar] (128)
);

DECLARE @PropiedadesXUsuarios TABLE (
	sec [int] IDENTITY (1,1),
	ValorDocumentoIdentidad [int],
	NumeroFinca [int],
	TipoAsociacion [varchar] (128)
);

DECLARE @Lecturas TABLE (
	sec [int] IDENTITY (1,1),
	NumeroMedidor [int],
	TipoMovimiento [varchar] (128),
	Valor [int]
);
	


DECLARE @FechaItera DATE
DECLARE @FechaFin DATE
DECLARE @diaFlag INT
DECLARE @FechaFinSemana DATE
DECLARE @RecorrerSemanas DATE
DECLARE @FechaEntrada DATETIME
DECLARE @FechaSalida DATETIME
DECLARE @ValorDocumentoIdentidad INT
DECLARE @Secuencia INT


INSERT INTO @Fechas
SELECT T.Item.value('@Fecha', 'date') AS FechaOperacion
FROM @datosXML.nodes('Datos/Operacion') AS T(Item)


SET @FechaItera = (SELECT MIN(f.FechaOperacion)
					FROM @Fechas f)
SET @FechaFin  = (SELECT MAX(f.FechaOperacion)
					FROM @Fechas f)


SET @diaFlag = 1


DELETE FROM dbo.Persona
DBCC CHECKIDENT ('TareaProgramada2.dbo.Persona', RESEED, 0)

DELETE FROM dbo.Propiedades
DBCC CHECKIDENT ('TareaProgramada2.dbo.Propiedades', RESEED, 0)

DELETE FROM dbo.PropiedadesxPersona
DBCC CHECKIDENT ('TareaProgramada2.dbo.PropiedadesxPersona', RESEED, 0)

DELETE FROM dbo.Usuario
DBCC CHECKIDENT ('TareaProgramada2.dbo.Usuario', RESEED, 0)


SELECT * FROM dbo.TipoIdentificacion


WHILE (@FechaItera < @FechaFin)
BEGIN
	
	INSERT INTO @PersonasAInsertar
	SELECT 
		T.Objeto.value('@Nombre','varchar(128)') as Nombre,
		T.Objeto.value('@TipoDocumentoIdentidad','varchar(128)') as TipoIdentificacion,
		T.Objeto.value('@ValorDocumentoIdentidad','int') as NumeroIdentificacion,
		T.Objeto.value('@Telefono1','int') as Telefono1,
		T.Objeto.value('@Telefono2','int') as Telefono2,
		T.Objeto.value('@Email','varchar(128)') as Email
	FROM
		@datosXml.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/Personas/Persona') as T(Objeto);


	INSERT INTO @PropiedadesAInsertar
	SELECT
		T.Objeto.value('@NumeroFinca','int') as NumeroFinca,
		T.Objeto.value('@MetrosCuadrados','int') as Area,
		T.Objeto.value('@tipoUsoPropiedad','varchar(128)') as TipoUsoSuelo,
		T.Objeto.value('@tipoZonaPropiedad','varchar(128)') as TipoPropiedad,
		T.Objeto.value('@NumeroMedidor','int') as NumeroMedidor,
		T.Objeto.value('@ValorFiscal','bigint') as ValorFiscal
	FROM
		@datosXml.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/Propiedades/Propiedad') as T(Objeto);



	INSERT INTO @PersonasXPropiedadesInsertar
	SELECT
		T.Objeto.value('@ValorDocumentoIdentidad','int') as ValorDocumentoIdentidad,
		T.Objeto.value('@NumeroFinca','int') as NumeroFinca,
		T.Objeto.value('@TipoAsociacion','varchar(128)') as TipoAsociacion
	FROM
		@datosXml.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/PersonasyPropiedades/PropiedadPersona') as T(Objeto);

	INSERT INTO @UsuarioOperacion
	SELECT
		T.Objeto.value('@ValorDocumentoIdentidad','int') as ValorDocumentoIdentidad,
		T.Objeto.value('@TipoUsuario','varchar(128)') as TipoUsuario,
		T.Objeto.value('@TipoAsociacion','varchar(128)') as TipoAsociacion,
		T.Objeto.value('@Password','varchar(128)') as Password,
		T.Objeto.value('@Username','varchar(128)') as Username
	FROM
		@datosXml.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/Usuario/Usuario') as T(Objeto);

	INSERT INTO @PropiedadesXUsuarios
	SELECT
		T.Objeto.value('@ValorDocumentoIdentidad','int') as ValorDocumentoIdentidad,
		T.Objeto.value('@NumeroFinca','int') as NumeroFinca,
		T.Objeto.value('@TipoAsociacion','varchar(128)') as TipoAsociacion
	FROM
		@datosXml.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/PropiedadesyUsuarios/UsuarioPropiedad') as T(Objeto);

	INSERT INTO @Lecturas
	SELECT
		T.Objeto.value('@NumeroMedidor','int') as NumeroMedidor,
		T.Objeto.value('@TipoMovimiento','varchar(128)') as TipoMovimiento,
		T.Objeto.value('@Valor','int') as Valor
	FROM
		@datosXml.nodes('Datos/Operacion[@Fecha = sql:variable("@FechaItera")]/Lecturas/LecturaMedidor') as T(Objeto);



-------------------------------------------------------------------------------------------------------------------------------------------------

	INSERT INTO dbo.Persona ([Nombre],[idTipoIdentificacion],[NumeroIdentificacion],[Telefono],[Celular],[Email])
	SELECT
		E.Nombre,
		TI.id as idTipoIdentificacion,
		E.NumeroIdentificacion,
		E.Telefono1,
		E.Telefono2,
		E.Email
	FROM
		[dbo].[TipoIdentificacion] TI, @PersonasAInsertar E
	WHERE
		 TI.Tipo = E.TipoIdentificacion
	

	SELECT * FROM [dbo].[Persona]


	INSERT INTO [dbo].[Propiedades] ([NumeroFinca],[Area],[idTipoUsoSuelo],[idTipoPropiedad],[NumeroMedidor],[ValorFiscal])
	SELECT
		E.NumeroFinca,
		E.Area,
		TS.id as idTipoUsoSuelo,
		TP.id as idTipoUsoPropiedad,
		E.NumeroMedidor,
		E.ValorFiscal
	FROM
		[dbo].[TipoUsoSuelo] TS, [dbo].[TipoPropiedad] TP, @PropiedadesAInsertar E
	WHERE
		TP.Nombre = E.TipoUsoSuelo AND TS.TipoUsoSuelo = E.TipoPropiedad -----HAY QUE CAMBIAR EL ORDEN

	


	SELECT * FROM [dbo].[Propiedades]

 --------AQUI INSERT PropiedadesXPersonas--------

	DECLARE @TipoAsocPP VARCHAR (128)
	SELECT @TipoAsocPP = TipoAsociacion
	FROM @PersonasXPropiedadesInsertar


	IF (@TipoAsocPP = 'Agregar')
	BEGIN
		INSERT INTO [dbo].[PropiedadesxPersona] ([idPersona],[FechaInicio])
		SELECT
			P.id as idPersona,
			@FechaItera
		FROM
			[dbo].[Persona] P INNER JOIN @PersonasXPropiedadesInsertar A ON A.ValorDocumentoIdentidad = P.NumeroIdentificacion
			INNER JOIN [dbo].[Propiedades] PR ON A.NumeroFinca = PR.NumeroFinca
		WHERE
			A.ValorDocumentoIdentidad = P.NumeroIdentificacion AND A.NumeroFinca = PR.NumeroFinca
		

		INSERT INTO [dbo].[Propiedades] ([idPropiedadesxPersona])
		SELECT
			PP.id as idPropiedadesxPersona
		FROM
			[dbo].[PropiedadesxPersona] PP INNER JOIN [dbo].[Propiedades] P ON P.idPropiedadesxPersona = PP.id 
			INNER JOIN @PersonasXPropiedadesInsertar A ON A.NumeroFinca = P.NumeroFinca
		WHERE
			P.idPropiedadesxPersona = PP.id AND A.NumeroFinca = P.NumeroFinca
	END
	ELSE IF (@TipoAsocPP = 'Eliminar')
	BEGIN
		IF(NOT EXISTS(SELECT 1 FROM [dbo].[PropiedadesxPersona]))
		BEGIN
			INSERT INTO [dbo].[PropiedadesxPersona] ([idPersona],[FechaInicio],[FechaFin])
		SELECT
			P.id as idPersona,
			@FechaItera,
			@FechaItera
		FROM
			[dbo].[Persona] P INNER JOIN @PersonasXPropiedadesInsertar A ON A.ValorDocumentoIdentidad = P.NumeroIdentificacion
			INNER JOIN [dbo].[Propiedades] PR ON A.NumeroFinca = PR.NumeroFinca
		WHERE
			A.ValorDocumentoIdentidad = P.NumeroIdentificacion AND A.NumeroFinca = PR.NumeroFinca

		END
		ELSE
		BEGIN
			UPDATE [dbo].[PropiedadesxPersona]
			SET
				FechaFin = @FechaItera
			FROM
				[dbo].[PropiedadesxPersona] PP INNER JOIN [dbo].[Persona] P ON P.id = PP.idPersona 
				INNER JOIN [dbo].[Propiedades] PR ON PR.idPropiedadesxPersona = PP.id
			WHERE
				P.id = PP.idPersona AND PR.idPropiedadesxPersona = PP.id
		END
	END

	SELECT * FROM [dbo].[PropiedadesxPersona]


	INSERT INTO [dbo].[Usuario] ([NombreUsuario],[Password],[TipoUsuario])
	SELECT
		E.Username,
		E.Password,
		E.TipoUsuario
	FROM
		@UsuarioOperacion E INNER JOIN [dbo].[Persona] P ON E.ValorDocumentoIdentidad = P.NumeroIdentificacion

	SELECT * FROM Usuario



	SET @FechaItera = DATEADD(DAY,1,@FechaItera)
END

		
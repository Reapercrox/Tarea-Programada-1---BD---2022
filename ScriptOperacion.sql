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
DECLARE @Secuencia INT


INSERT INTO @Fechas
SELECT T.Item.value('@Fecha', 'date') AS FechaOperacion
FROM @datosXML.nodes('Datos/Operacion') AS T(Item)


SET @FechaItera = (SELECT MIN(f.FechaOperacion)
					FROM @Fechas f)
SET @FechaFin  = (SELECT MAX(f.FechaOperacion)
					FROM @Fechas f)


SET @diaFlag = 1


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
		T.Objeto.value('@Username','varchar(128)') as Username,
		T.Objeto.value('@Password','varchar(128)') as Password
		
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

-------------------------------------------------------------------------PERSONA

	INSERT INTO dbo.Persona ([Nombre],[idTipoIdentificacion],[NumeroIdentificacion],[Telefono],[Celular],[Email])
	SELECT
		E.Nombre,
		TI.id as idTipoIdentificacion,
		E.NumeroIdentificacion,
		E.Telefono1,
		E.Telefono2,
		E.Email
	FROM
		[dbo].[TipoIdentificacion] TI INNER JOIN @PersonasAInsertar E ON TI.Tipo = E.TipoIdentificacion

	

-------------------------------------------------------------------------PROPIEDADES

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
		TP.Nombre = E.TipoUsoSuelo AND TS.TipoUsoSuelo = E.TipoPropiedad


	INSERT INTO [dbo].[PropiedadxConceptoCobro] ([idPropiedad],[idConceptoCobro],[FechaInicio])
	SELECT
		PR.id as idPropiedad,
		CC.id as idConceptoCobro,
		@FechaItera
	FROM
		[dbo].[Propiedades] PR, [dbo].[ConceptoCobro] CC, @PropiedadesAInsertar E
	WHERE
		E.NumeroFinca = PR.NumeroFinca AND CC.id = 2


	


 -------------------------------------------------------------------------PROPIEDADESXPERSONA

	DECLARE @TipoAsocPP varchar(128)
	SELECT @TipoAsocPP = TipoAsociacion
	FROM @PersonasXPropiedadesInsertar

	DECLARE @VDocId int
	SELECT @VDocId = NumeroIdentificacion
	FROM @PersonasAInsertar 


	IF (@TipoAsocPP = 'Agregar')
	BEGIN

		INSERT INTO [dbo].[PropiedadesxPersona] ([idPersona],[FechaInicio])
		SELECT
			P.id as idPersona,
			@FechaItera
		FROM
			[dbo].[Persona] P INNER JOIN @PersonasXPropiedadesInsertar A ON A.ValorDocumentoIdentidad = P.NumeroIdentificacion
			INNER JOIN [dbo].[Propiedades] PR ON A.NumeroFinca = PR.NumeroFinca
		

		UPDATE [dbo].[Propiedades] 
		SET
			idPropiedadesxPersona= PP.id
		FROM
			[dbo].[PropiedadesxPersona] PP ,@PersonasXPropiedadesInsertar A, [dbo].[Propiedades] P
		WHERE
			A.NumeroFinca = P.NumeroFinca AND PP.FechaInicio = @FechaItera

	END
	ELSE
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
														 

		END
		ELSE
		BEGIN

			UPDATE [dbo].[PropiedadesxPersona]
			SET
				FechaFin = @FechaItera
			FROM
				[dbo].[PropiedadesxPersona] PP INNER JOIN [dbo].[Persona] P ON P.id = PP.idPersona 
				INNER JOIN [dbo].[Propiedades] PR ON PR.idPropiedadesxPersona = PP.id

		END
	END

	

-------------------------------------------------------------------------USUARIO

	DECLARE @TipoAsocU VARCHAR (128)
	SELECT @TipoAsocU = TipoAsociacion
	FROM @UsuarioOperacion
	
	DECLARE @Usuario VARCHAR (128)
	SELECT @Usuario = Username
	FROM @UsuarioOperacion


	IF (@TipoAsocU = 'Agregar')
	BEGIN
		INSERT INTO [dbo].[Usuario] ([NombreUsuario],[Password],[TipoUsuario],[idPersona])
		SELECT
			E.Username,
			E.Password,
			E.TipoUsuario,
			P.id as idPersona
		FROM
			@UsuarioOperacion E INNER JOIN [dbo].[Persona] P ON E.ValorDocumentoIdentidad = P.NumeroIdentificacion

	END
	ELSE
	BEGIN

		IF(NOT EXISTS(SELECT 1 FROM [dbo].[Usuario]))
		BEGIN
			INSERT INTO [dbo].[Usuario] ([NombreUsuario],[Password],[TipoUsuario],[idPersona])
			SELECT
				E.Username,
				E.Password,
				E.TipoUsuario,
				P.id as idPersona
			FROM
				@UsuarioOperacion E INNER JOIN [dbo].[Persona] P ON E.ValorDocumentoIdentidad = P.NumeroIdentificacion

			DELETE FROM [dbo].[Usuario]
			WHERE
				[dbo].[Usuario].NombreUsuario = (SELECT E.Username 
												 FROM @UsuarioOperacion E, [dbo].[Usuario] U
												 WHERE E.Username = U.NombreUsuario)

		END


		ELSE
		BEGIN

			DELETE FROM [dbo].[Usuario]
			WHERE
				[dbo].[Usuario].NombreUsuario = (SELECT E.Username 
												 FROM @UsuarioOperacion E, [dbo].[Usuario] U
												 WHERE E.Username = U.NombreUsuario)

		END

	END

-------------------------------------------------------------------------USUARIOSXPROPIEDADES
	DECLARE @TipoAsocUP varchar(128)
	SELECT @TipoAsocUP = TipoAsociacion
	FROM @PropiedadesXUsuarios

	IF (@TipoAsocUP = 'Agregar')
	BEGIN
		
		UPDATE [dbo].[Propiedades]
		SET
			idUsuario = U.id
		FROM
			@PropiedadesXUsuarios E, [dbo].[Propiedades] P, [dbo].[Usuario] U, [dbo].[Persona] PER 
		WHERE
			E.NumeroFinca = P.NumeroFinca AND PER.NumeroIdentificacion = E.ValorDocumentoIdentidad AND U.idPersona = PER.id

	END
	--ELSE
	--BEGIN

	--		DELETE FROM [dbo].[Propiedades]
	--		WHERE
	--			[dbo].[Propiedades].idUsuario = (SELECT U.id 
	--											 FROM [dbo].[Usuario] U INNER JOIN [dbo].[Persona] PR ON U.idPersona = PR.id INNER JOIN @PropiedadesXUsuarios PU ON PR.NumeroIdentificacion = PU.ValorDocumentoIdentidad JOIN [dbo].[Propiedades] P ON PU.NumeroFinca = P.NumeroFinca)

	--END

-------------------------------------------------------------------------LECTURAS

	INSERT INTO [dbo].[MovimientoConsumo]([Fecha],[NumeroMedidor],[idTipoMovimiento],[SaldoAPagar],[Monto])
	SELECT
		@FechaItera,
		E.NumeroMedidor,
		TM.id as idTipoMovimiento,
		E.Valor,
		E.Valor
	FROM
		[dbo].[TipoMovimiento] TM, @Lecturas E
	WHERE
		E.TipoMovimiento = TM.Nombre


	DELETE FROM @Lecturas
	DELETE FROM @PersonasAInsertar
	DELETE FROM @PersonasXPropiedadesInsertar
	DELETE FROM @PropiedadesAInsertar
	DELETE FROM @PropiedadesXUsuarios
	DELETE FROM @UsuarioOperacion

	SET @FechaItera = DATEADD(DAY,1,@FechaItera)
END

SELECT * FROM [dbo].[Persona]
SELECT * FROM [dbo].[Propiedades]
SELECT * FROM [dbo].[PropiedadesxPersona]
SELECT * FROM [dbo].[Usuario]
SELECT * FROM [dbo].[MovimientoConsumo]
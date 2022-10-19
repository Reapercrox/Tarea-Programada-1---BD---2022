
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Nueva_Persona]

	 @InNombre varchar(128),
	 @InTipoIdentificacion varchar(128),
	 @InNumeroIdentificacion int,
	 @InTelefono1 int,
	 @InTelefono2 int,
	 @InEmail varchar(128)

AS

	DECLARE @inIdTipoID int

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @inIdTipoID = (SELECT TI.id
						FROM [dbo].[TipoMovimiento] TI
						WHERE TI.Nombre = @InTipoIdentificacion)

	INSERT INTO [dbo].[Persona](Nombre,idTipoIdentificacion,NumeroIdentificacion,Telefono,Celular,Email)
	VALUES (@InNombre,@inIdTipoID,@InNumeroIdentificacion,@InTelefono1,@InTelefono2,@InEmail)

	SET NOCOUNT OFF;


END
GO

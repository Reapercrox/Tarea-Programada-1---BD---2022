-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE SP_Nuevo_Usuario 
	-- Add the parameters for the stored procedure here
	@inUserName varchar(128),
	@inPassword varchar(128),
	@inTipoUsuario varchar(128),
	@inIdPersona int

AS

	DECLARE @inIdUsuarioPersona int

BEGIN
	
	SET NOCOUNT ON;

	SET @inIdUsuarioPersona = (SELECT P.id
							   FROM [dbo].[Persona] P
							   WHERE P.NumeroIdentificacion = @inIdPersona)

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Usuario] ([idPersona],[NombreUsuario],[Password],[TipoUsuario])
	VALUES (@inIdUsuarioPersona,@inUserName,@inPassword,@inPassword)

	SET NOCOUNT OFF

END
GO

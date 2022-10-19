USE [TareaProgramada2]
GO
CREATE PROCEDURE [dbo].[SP_LoginAdmin]
	@inUsuario varchar(16),
	@inPassword varchar(16),
	@outResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON	
	BEGIN TRY
	SET @outResult=0;
		SELECT NombreUsuario FROM [dbo].[Usuario] WHERE NombreUsuario = @inUsuario AND Password = @inPassword AND TipoUsuario = 'Administrador'
	END TRY
	 	BEGIN CATCH		
		/*INSERT INTO [dbo].[DBErrors] VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE());*/
		Set @outResult=50005;	
	END CATCH
	SET NOCOUNT OFF
END
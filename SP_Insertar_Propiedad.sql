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
CREATE PROCEDURE SP_Inserta_Propiedades
	
	@inNumeroFinca int,
	@inArea int,
	@inTipoUsoSuelo varchar(128),
	@inTipoUsoPropiedad varchar(128),
	@inNumeroMed int,
	@inValorFiscal int

AS

	DECLARE @inIdTipoUsoSuelo int,
			@inIdTipoUsoPropiedad int,
			@inIdPropiedad int,
			@inIdConcepto int

BEGIN
	
	SET NOCOUNT ON;

    BEGIN TRANSACTION
		
		SET @inIdTipoUsoPropiedad = (SELECT TS.id
									 FROM [dbo].[TipoUsoSuelo] TS
									 WHERE TS.TipoUsoSuelo = @inTipoUsoSuelo)

		SET @inIdTipoUsoSuelo = (SELECT TP.id
								 FROM [dbo].[TipoPropiedad] TP
								 WHERE TP.Nombre = @inTipoUsoPropiedad)

		INSERT INTO [dbo].[Propiedades] ([NumeroFinca],[Area],[idTipoPropiedad],[idTipoUsoSuelo],[NumeroMedidor],[ValorFiscal])
		VALUES (@inNumeroFinca,@inArea,@inIdTipoUsoPropiedad,@inIdTipoUsoSuelo,@inNumeroMed,@inValorFiscal)

	COMMIT


END
GO

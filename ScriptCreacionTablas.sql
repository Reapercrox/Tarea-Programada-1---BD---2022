----- SCRIPT CREACION DE TABLAS -----

USE [TareaProgramada2]



-----/ Script creacion tabla [Persona] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Persona](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar](128) NOT NULL,
 [idTipoIdentificacion] [int] NOT NULL,
 [NumeroIdentificacion] [varchar] (128) NOT NULL,
 [Email] [varchar] (128) NOT NULL,
 [Telefono] [varchar] (128) NOT NULL,
 [Celular] [varchar] (128) NOT NULL,

CONSTRAINT [PK_Persona] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO


-----/ Script creacion tabla [TipoIdentificacion] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoIdentificacion](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Tipo] [varchar](128) NOT NULL,

CONSTRAINT [PK_TipoIdentificacion] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [TipoIdentificacion] | [Persona] *-----

ALTER TABLE [dbo].[Persona] WITH CHECK ADD CONSTRAINT [FK_TipoIdentificacion]
FOREIGN KEY([idTipoIdentificacion])
REFERENCES [dbo].[TipoIdentificacion] ([id])
GO

ALTER TABLE [dbo].[Persona] CHECK CONSTRAINT [FK_TipoIdentificacion]
GO

-----/ Script de la tabla [PropiedadesxPersona] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropiedadesxPersona](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [idPersona] [int] NOT NULL,
 [FechaInicio] [date] NOT NULL,
 [FechaFin] [date] NOT NULL,

CONSTRAINT [PK_PropiedadesxPersona] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Persona] | [PropiedadesxPersona] *-----

ALTER TABLE [dbo].[PropiedadesxPersona] WITH CHECK ADD CONSTRAINT [FK_Personas]
FOREIGN KEY([idPersona])
REFERENCES [dbo].[Persona] ([id])
GO

ALTER TABLE [dbo].[PropiedadesxPersona] CHECK CONSTRAINT [FK_Personas]
GO

-----/ Script creacion tabla [Propiedad] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Propiedades](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [NumeroFinca] [int] NOT NULL,
 [Area] [int] NOT NULL,
 [idTipoUsoSuelo] [int] NOT NULL,
 [idTipoPropiedad] [int] NOT NULL,
 [NumeroMedidor] [int] NOT NULL,
 [ValorFiscal] [money] NOT NULL,
 [FechaRegistro] [date] NOT NULL,
 [idPropiedadesxPersona] [int] NOT NULL,

CONSTRAINT [PK_Propiedades] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Propiedades]|[PropiedadesxPersona] *-----

ALTER TABLE [dbo].[Propiedades] WITH CHECK ADD CONSTRAINT [FK_Propiedades_Persona]
FOREIGN KEY([idPropiedadesxPersona])
REFERENCES [dbo].[PropiedadesxPersona] ([id])
GO

ALTER TABLE [dbo].[Propiedades] CHECK CONSTRAINT [FK_Propiedades_Persona]
GO

-----/ Script creacion tabla [TipoPropiedad] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoPropiedad](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar] (128) NOT NULL,

CONSTRAINT [PK_TipoPropiedad] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Propiedades]|[TipoPropiedad] *-----

ALTER TABLE [dbo].[Propiedades] WITH CHECK ADD CONSTRAINT [FK_Tipo_Propiedad]
FOREIGN KEY([idTipoPropiedad])
REFERENCES [dbo].[TipoPropiedad] ([id])
GO

ALTER TABLE [dbo].[Propiedades] CHECK CONSTRAINT [FK_Propiedades]
GO

-----/ Script creacion tabla [TipoUsoSuelo] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsoSuelo](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [TipoUsoSuelo] [varchar] (128) NOT NULL,

CONSTRAINT [PK_TipoUsoSuelo] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Propiedades]|[TipoUsoSuelo] *-----

ALTER TABLE [dbo].[Propiedades] WITH CHECK ADD CONSTRAINT [FK_Tipo_Uso_Suelo]
FOREIGN KEY([idTipoUsoSuelo])
REFERENCES [dbo].[TipoUsoSuelo] ([id])
GO

ALTER TABLE [dbo].[Propiedades] CHECK CONSTRAINT [FK_Tipo_Uso_Suelo]
GO

-----/ Script creacion tabla [Usuario] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [NombreUsuario] [varchar] (128) NOT NULL,
 [Password] [varchar] (128) NOT NULL,
 [TipoUsuario] [varchar] (128) NOT NULL,

CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Usuario]|[Persona] *-----

ALTER TABLE [dbo].[Usuario] WITH CHECK ADD CONSTRAINT [FK_Usuario]
FOREIGN KEY([id])
REFERENCES [dbo].[Persona] ([id])
GO

ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario]
GO


-----/ Script de creacion de tablas [PropiedadxConceptoCobro] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PropiedadxConceptoCobro](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [idPropiedad] [int] NOT NULL,
 [idConceptoCobro] [int] NOT NULL,
 [FechaInicio] [date] NOT NULL,
 [FechaFin] [date] NOT NULL,

CONSTRAINT [PK_PropiedadxConceptoCobro] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Propiedades]|[PropiedadxConceptoCobro] *-----

ALTER TABLE [dbo].[PropiedadxConceptoCobro] WITH CHECK ADD CONSTRAINT [FK_Prop_CC]
FOREIGN KEY([idPropiedad])
REFERENCES [dbo].[Propiedades] ([id])
GO

ALTER TABLE [dbo].[PropiedadxConceptoCobro] CHECK CONSTRAINT [FK_Prop_CC]
GO

-----/ Script creacion tablas [ConceptoCobro] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConceptoCobro](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [idPeriodoMonto] [int]  NOT NULL,

CONSTRAINT [PK_ConceptoCobro] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [PropiedadxConceptoCobro]|[ConceptoCobro] *-----

ALTER TABLE [dbo].[PropiedadxConceptoCobro] WITH CHECK ADD CONSTRAINT [FK_CC]
FOREIGN KEY([idConceptoCobro])
REFERENCES [dbo].[ConceptoCobro] ([id])
GO

ALTER TABLE [dbo].[PropiedadxConceptoCobro] CHECK CONSTRAINT [FK_CC]
GO

-----/ Script creacion de tablas [CCAgua] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CCAgua](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [NumeroMedidor] [int] NOT NULL,
 [SaldoAcumulado] [int] NOT NULL,

CONSTRAINT [PK_CCAgua] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script nueva columna [CCAgua] *-----

ALTER TABLE [dbo].[CCAgua]
ADD [idMovimientoConsumo] [int] NOT NULL
GO

-----* Script ligar tablas [CCAgua]|[ConceptoCobro] *-----

ALTER TABLE [dbo].[CCAgua] WITH CHECK ADD CONSTRAINT [FK_CCAgua]
FOREIGN KEY([id])
REFERENCES [dbo].[ConceptoCobro] ([id])
GO

ALTER TABLE [dbo].[CCAgua] CHECK CONSTRAINT [FK_CCAgua]
GO


-----/ Script creacion de tablas [Facturas] /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Fecha] [date] NOT NULL,
 [FechaVencimiento] [date] NOT NULL,
 [TotalOriginal] [int] NOT NULL,
 [TotalAPagar] [int] NOT NULL,
 [Estado] [binary] NOT NULL,
 [idPropiedades] [int] NOT NULL

CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [Factura]|[Propiedades] *-----

ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [FK_Propiedad]
FOREIGN KEY([idPropiedades])
REFERENCES [dbo].[Propiedades] ([id])
GO

ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Propiedad]
GO

-----/ Añadir nueva conexion /-----
ALTER TABLE [dbo].[Propiedades]
ADD [idUsuario] [int] NOT NULL
GO

-----* Script ligar tablas [Propiedades]|[TipoPropiedad] *-----

ALTER TABLE [dbo].[Propiedades] WITH CHECK ADD CONSTRAINT [FK_Usuario_Prop]
FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([id])
GO

ALTER TABLE [dbo].[Propiedades] CHECK CONSTRAINT [FK_Usuario_Prop]
GO


-----/ Script creacion de tablas [TipoMovimiento] /-----


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MovimientoConsumo](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Fecha] [date] NOT NULL,
 [FechaVencimiento] [date] NOT NULL,
 [Monto] [int] NOT NULL,
 [SaldoAPagar] [int] NOT NULL,
 [idTipoMovimiento] [int] NOT NULL

CONSTRAINT [PK_MovimientoConsumo] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----/ Script creacion de tablas [TipoMovimiento] /-----


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMovimiento](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar] (128) NOT NULL

CONSTRAINT [PK_TipoMovimiento] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO


-----* Script ligar tablas [MontoMovimiento]|[TipoMovimiento] *-----

ALTER TABLE [dbo].[MovimientoConsumo] WITH CHECK ADD CONSTRAINT [FK_Tipo_Mov]
FOREIGN KEY([idTipoMovimiento])
REFERENCES [dbo].[TipoMovimiento] ([id])
GO

ALTER TABLE [dbo].[MovimientoConsumo] CHECK CONSTRAINT [FK_Tipo_Mov]
GO

-----* Script ligar tablas [CCAgua]|[MovimientoConsumo] *-----

ALTER TABLE [dbo].[CCAgua] WITH CHECK ADD CONSTRAINT [FK_Movimiento_Consumo]
FOREIGN KEY([idMovimientoConsumo])
REFERENCES [dbo].[MovimientoConsumo] ([id])
GO

ALTER TABLE [dbo].[CCAgua] CHECK CONSTRAINT [FK_Movimiento_Consumo]
GO


-----/ Script creacion tablas [DetalleCC] /-----


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleCC](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar] (128) NOT NULL,
 [idDetalleCCAgua] [int] NOT NULL

CONSTRAINT [PK_DetalleCC] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----/ Script creacion tablas [DetalleCCAgua]  /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleCCAgua](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [idMovimientoConsumo] [int] NOT NULL

CONSTRAINT [PK_DetalleCCAgua] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO


-----* Script ligar tablas [DetalleCC]|[DetalleCCAgua] *-----

ALTER TABLE [dbo].[DetalleCC] WITH CHECK ADD CONSTRAINT [FK_Detalle_Agua]
FOREIGN KEY([idDetalleCCAgua])
REFERENCES [dbo].[DetalleCCAgua] ([id])
GO

ALTER TABLE [dbo].[DetalleCC] CHECK CONSTRAINT [FK_Detalle_Agua]
GO

-----/ Añadir nueva conexion [Factura] /-----

ALTER TABLE [dbo].[Factura]
ADD [idDetalleCC] [int] NOT NULL
GO

-----* Script ligar tablas [Factura]|[DetalleCC] *-----

ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [FK_Detalle_CC]
FOREIGN KEY([idDetalleCC])
REFERENCES [dbo].[DetalleCC] ([id])
GO

ALTER TABLE [dbo].[DetalleCC] CHECK CONSTRAINT [FK_Detalle_CC]
GO

-----/ Añadir nueva conexion [MovimientoConsumo] /-----

ALTER TABLE [dbo].[DetalleCCAgua]
ADD [idMovimientoConsumo] [int] NOT NULL
GO

-----* Script ligar tablas [DetalleCCAgua]|[MovimientoConsumo] *-----

ALTER TABLE [dbo].[DetalleCCAgua] WITH CHECK ADD CONSTRAINT [FK_Movimiento_Agua]
FOREIGN KEY ([idMovimientoConsumo])
REFERENCES [dbo].[MovimientoConsumo] ([id])
GO

ALTER TABLE [dbo].[DetalleCCAgua] CHECK CONSTRAINT [FK_Movimiento_Agua]
GO

-----/ Añadir nueva conexion [Factura] /-----

ALTER TABLE [Factura]
ADD [idTipoMedioPago] [int] NOT NULL
GO

-----/ Script creacion tablas [MedioPago]  /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedioPago](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Tipo] [varchar] (128) NOT NULL

CONSTRAINT [PK_MedioPago] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO


-----* Script ligar tablas [Factura]|[MedioPago] *-----

ALTER TABLE [dbo].[Factura] WITH CHECK ADD CONSTRAINT [FK_Medio_Pago]
FOREIGN KEY([idTipoMedioPago])
REFERENCES [dbo].[MedioPago] ([id])
GO

ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Medio_Pago]
GO


-----/ Añadir nueva conexion [ConceptoCobro] /-----

ALTER TABLE [dbo].[ConceptoCobro]
ADD [idPeriodoMonto] [int] NOT NULL
GO

-----/ Script creacion tablas [PeriodoMontoCC]  /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeriodoMontoCC](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar] (128) NOT NULL

CONSTRAINT [PK_PeriodoMonto] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----* Script ligar tablas [ConceptoCobro]|[PeriodoMontoCC] *-----

ALTER TABLE [dbo].[ConceptoCobro] WITH CHECK ADD CONSTRAINT [FK_Periodo_Monto_CC]
FOREIGN KEY([idPeriodoMonto])
REFERENCES [dbo].[PeriodoMontoCC] ([id])
GO

ALTER TABLE [dbo].[ConceptoCobro] CHECK CONSTRAINT [FK_Periodo_Monto_CC]
GO


-----/ Añadir nueva conexion [ConceptoCobro] /-----

ALTER TABLE [dbo].[ConceptoCobro]
ADD [Nombre] [varchar] (128) NOT NULL,
	[ValorMinimo] [int],
	[ValorMinimoM3] [int],
	[ValorM3] [int],
	[ValorPorcentual] [float],
	[ValorFijo] [int],
	[ValorM2Minimo] [int],
	[ValorTractosM2] [int],
	[ValorFijoM3Adicional] [int],
	[idTipoMonto] [int] NOT NULL
GO

-----/ Script creacion tablas [TipoMontoCC]  /-----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoMontoCC](

 [id] [int] IDENTITY(1,1) NOT NULL,
 [Nombre] [varchar] (128) NOT NULL

CONSTRAINT [PK_TipoMonto] PRIMARY KEY CLUSTERED (

	[id] ASC

) WITH (

	PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
	ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF

) ON
	[PRIMARY] 
) ON 
	[PRIMARY] 
GO

-----/ Añadir nueva conexion [ConceptoCobro] /-----

ALTER TABLE [dbo].[ConceptoCobro]
ADD [idTipoMonto] [int]
GO

-----* Script ligar tablas [ConceptoCobro]|[PeriodoMontoCC] *-----

ALTER TABLE [dbo].[ConceptoCobro] WITH CHECK ADD CONSTRAINT [FK_Tipo_Monto_CC]
FOREIGN KEY([idTipoMonto])
REFERENCES [dbo].[TipoMontoCC] ([id])
GO

ALTER TABLE [dbo].[ConceptoCobro] CHECK CONSTRAINT [FK_Tipo_Monto_CC]
GO
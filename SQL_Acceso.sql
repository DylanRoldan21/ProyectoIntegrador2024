USE [DB_ACCESO]
GO
/****** Object:  Table [dbo].[Acceso]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Acceso](
	[idRol] [int] NULL,
	[idOpcion] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Opcion]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Opcion](
	[IdOpcion] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Opcion] PRIMARY KEY CLUSTERED 
(
	[IdOpcion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prestamo]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prestamo](
	[idPrestamo] [int] NOT NULL,
	[monto] [varchar](50) NULL,
	[estado] [varchar](50) NULL,
	[IdUsuario] [int] NOT NULL,
	[IdTipodeprestamo] [int] NOT NULL,
	[IdTipodepago] [int] NOT NULL,
 CONSTRAINT [PK_Prestamo] PRIMARY KEY CLUSTERED 
(
	[idPrestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[IdRol] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[IdRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDePago]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDePago](
	[idTipodepago] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoDePago] PRIMARY KEY CLUSTERED 
(
	[idTipodepago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDePrestamo]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDePrestamo](
	[IdTipodeprestamo] [int] NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_TipoDePrestamo] PRIMARY KEY CLUSTERED 
(
	[IdTipodeprestamo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/04/2024 14:58:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[IdUsuario] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[correo] [varchar](50) NOT NULL,
	[clave] [varchar](50) NOT NULL,
	[IdRol] [int] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Acceso]  WITH CHECK ADD  CONSTRAINT [FK_Acceso_Opcion] FOREIGN KEY([idOpcion])
REFERENCES [dbo].[Opcion] ([IdOpcion])
GO
ALTER TABLE [dbo].[Acceso] CHECK CONSTRAINT [FK_Acceso_Opcion]
GO
ALTER TABLE [dbo].[Acceso]  WITH CHECK ADD  CONSTRAINT [FK_Acceso_Rol] FOREIGN KEY([idRol])
REFERENCES [dbo].[Rol] ([IdRol])
GO
ALTER TABLE [dbo].[Acceso] CHECK CONSTRAINT [FK_Acceso_Rol]
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD  CONSTRAINT [FK_Prestamo_TipoDePago] FOREIGN KEY([IdTipodepago])
REFERENCES [dbo].[TipoDePago] ([idTipodepago])
GO
ALTER TABLE [dbo].[Prestamo] CHECK CONSTRAINT [FK_Prestamo_TipoDePago]
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD  CONSTRAINT [FK_Prestamo_TipoDePrestamo] FOREIGN KEY([IdTipodeprestamo])
REFERENCES [dbo].[TipoDePrestamo] ([IdTipodeprestamo])
GO
ALTER TABLE [dbo].[Prestamo] CHECK CONSTRAINT [FK_Prestamo_TipoDePrestamo]
GO
ALTER TABLE [dbo].[Prestamo]  WITH CHECK ADD  CONSTRAINT [FK_Prestamo_Usuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO
ALTER TABLE [dbo].[Prestamo] CHECK CONSTRAINT [FK_Prestamo_Usuario]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([IdRol])
REFERENCES [dbo].[Rol] ([IdRol])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO

create proc sp_RegistrarUsuario (
	@correo  varchar (50),
	@clave  varchar (50),
	@Registrado bit output,
	@Mensaje varchar (100) output) 
	as 
	 begin
	  if(not exists(select * from USUARIO where correo =@correo))
	  begin
	   insert into USUARIO(Correo, clave) values(@Correo,@Clave)
	   set @Registrado =1
	   set @Mensaje = 'ususrio registrado'
	   end
	    else
		begin
		 set @Registrado = 0
		 set @Mensaje = 'correo ya esta registrado'
		 end
		  end

	 
	  create proc sp_ValidarUsuario(
	  @correo  varchar (50) ,
	  @clave  varchar (50)
	  )
	   as 
	    begin
		  if(exists(select * from USUARIO where Correo = @Correo and Clave = @Clave))
		  select Idusuario  from  USUARIO where Correo = @Correo and Clave = @Clave
		  else 
		    select '0'
	  end


	  select*from USUARIO
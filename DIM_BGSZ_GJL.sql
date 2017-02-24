USE [PT_STORE_YYPT_LC_0718]
GO

/****** Object:  Table [dbo].[DIM_BGSZ_GJL]    Script Date: 02/24/2017 13:53:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DIM_BGSZ_GJL](
	[ANDM] [varchar](10) NOT NULL,
	[ANMC] [varchar](20) NOT NULL,
	[ANFF] [varchar](50) NOT NULL,
	[JLZT] [varchar](2) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 在用， 1停用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BGSZ_GJL', @level2type=N'COLUMN',@level2name=N'JLZT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字典表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BGSZ_GJL'
GO


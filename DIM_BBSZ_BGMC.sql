USE [PT_STORE_YYPT_LC_0718]
GO

/****** Object:  Table [dbo].[DIM_BBSZ_BGMC]    Script Date: 02/24/2017 13:52:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DIM_BBSZ_BGMC](
	[ID] [varchar](36) NOT NULL,
	[JGDM] [varchar](22) NOT NULL,
	[JGMC] [varchar](50) NULL,
	[BGDM] [varchar](36) NOT NULL,
	[BGMC] [varchar](50) NULL,
	[LB] [varchar](2) NULL,
	[FL] [varchar](2) NULL,
	[URL] [varchar](200) NULL,
	[CXTJXS] [varchar](2) NULL,
	[JLZT] [varchar](2) NULL,
	[BGLX] [varchar](2) NULL,
	[TBBMC] [varchar](100) NULL,
 CONSTRAINT [PK_DIM_BBSZ_BGMC] PRIMARY KEY CLUSTERED 
(
	[BGDM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 是， 1否' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_BGMC', @level2type=N'COLUMN',@level2name=N'CXTJXS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0启用， 1停用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_BGMC', @level2type=N'COLUMN',@level2name=N'JLZT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0查询， 1填报' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_BGMC', @level2type=N'COLUMN',@level2name=N'BGLX'
GO


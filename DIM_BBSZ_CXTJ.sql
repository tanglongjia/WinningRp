USE [PT_STORE_YYPT_LC_0718]
GO

/****** Object:  Table [dbo].[DIM_BBSZ_CXTJ]    Script Date: 02/24/2017 13:53:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DIM_BBSZ_CXTJ](
	[ID] [varchar](36) NOT NULL,
	[BGDM] [varchar](36) NOT NULL,
	[TJMC] [varchar](30) NOT NULL,
	[KJMC] [varchar](30) NULL,
	[KJLX] [varchar](2) NULL,
	[KJZT] [varchar](2) NULL,
	[KJZ] [varchar](1000) NULL,
	[MRZ] [varchar](500) NULL,
	[KJLXGS] [varchar](20) NULL,
	[SY] [varchar](30) NULL,
	[KJSJ] [varchar](100) NULL,
	[KJSJYXSX] [varchar](2) NULL,
	[KJSX] [varchar](2) NULL,
 CONSTRAINT [PK_DIM_BBSZ_CXTJ] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 文本， 2 标签， 3下拉框， 4下拉多选， 5 日期， 6 下拉树， 0 无' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_CXTJ', @level2type=N'COLUMN',@level2name=N'KJLX'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 显示， 1隐藏' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_CXTJ', @level2type=N'COLUMN',@level2name=N'KJZT'
GO


USE [PT_STORE_YYPT_LC_0718]
GO

/****** Object:  Table [dbo].[DIM_BBSZ_XSJG]    Script Date: 02/24/2017 13:53:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[DIM_BBSZ_XSJG](
	[ID] [varchar](36) NOT NULL,
	[BGDM] [varchar](36) NOT NULL,
	[BTMC] [varchar](60) NOT NULL,
	[BQSJYL] [varchar](50) NULL,
	[BCSJYL] [varchar](50) NULL,
	[KJMC] [varchar](30) NULL,
	[KJLX] [varchar](2) NULL,
	[KJZT] [varchar](2) NULL,
	[KJZ] [varchar](1000) NULL,
	[MRZ] [varchar](30) NULL,
	[KJLXGS] [varchar](20) NULL,
	[SY] [varchar](30) NULL,
	[BT] [varchar](2) NULL,
	[YXBJ] [varchar](2) NULL,
	[JYLX] [varchar](50) NULL,
	[JYDM] [varchar](200) NULL,
	[TSXX] [varchar](100) NULL,
	[XSWZ] [varchar](2) NULL,
	[LJDZ] [varchar](200) NULL,
	[ZXFS] [varchar](2) NULL,
	[KZFX] [varchar](2) NULL,
	[HZLX] [varchar](2) NULL,
	[SJYDM] [varchar](36) NULL,
	[SX] [int] NULL,
	[ISZJ] [varchar](1) NULL,
 CONSTRAINT [PK_DIM_BBSZ_XSJG] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'取数据源列字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'BQSJYL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'存数据源列字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'BCSJYL'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 文本， 2 标签， 3下拉框， 4下拉多选， 5 日期， 6 下拉树， 0 无' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'KJLX'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 显示， 1隐藏' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'KJZT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0否， 1是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'BT'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0否， 1是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'YXBJ'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0左， 1中， 2右' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'XSWZ'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 自动扩展， 1 固定格式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'ZXFS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0无，1纵向， 2横线' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'KZFX'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0无，1合计， 2平均' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIM_BBSZ_XSJG', @level2type=N'COLUMN',@level2name=N'HZLX'
GO


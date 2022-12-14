USE [Academy]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 09.05.2020 15:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Financing] [money] NOT NULL,
	[Name_Departments] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Departments_1] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 09.05.2020 15:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name_Faculties] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Faculties] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Faculties_1] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 09.05.2020 15:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[Rating] [int] NOT NULL,
	[Year] [int] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_1] UNIQUE NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 09.05.2020 15:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentDate] [datetime] NOT NULL,
	[Name_Teachers] [nvarchar](max) NOT NULL,
	[Premium] [money] NOT NULL,
	[Salary] [money] NOT NULL,
	[Surname] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments] ADD  CONSTRAINT [DF_Departments_Financing]  DEFAULT ((0)) FOR [Financing]
GO
ALTER TABLE [dbo].[Teachers] ADD  CONSTRAINT [DF_Teachers_Premium]  DEFAULT ((0)) FOR [Premium]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Financing] CHECK  (([Financing]>=(0)))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Financing]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Name_Departments] CHECK  (([Name_Departments]>(0)))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Name_Departments]
GO
ALTER TABLE [dbo].[Faculties]  WITH CHECK ADD  CONSTRAINT [Name_Faculties] CHECK  (([Name_Faculties]>(0)))
GO
ALTER TABLE [dbo].[Faculties] CHECK CONSTRAINT [Name_Faculties]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [Name] CHECK  (([Name]>(0)))
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [Name]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [Rating] CHECK  (([Rating]>=(0) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [Rating]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [Year] CHECK  (([Year]>=(1) AND [Year]<=(5)))
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [Year]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [EmploymentDate] CHECK  (([EmploymentDate]>=(((1)-(1))-(1990))))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [EmploymentDate]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Name_Teachers] CHECK  (([Name_Teachers]>(0)))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Name_Teachers]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Premium] CHECK  (([Premium]>=(0)))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Premium]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Salary] CHECK  (([Salary]>(0)))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Salary]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Surname] CHECK  (([Surname]>(0)))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Surname]
GO

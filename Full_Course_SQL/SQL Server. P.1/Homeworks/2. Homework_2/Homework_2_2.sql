USE [Academy]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 11.05.2020 19:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id_Departments] [int] IDENTITY(1,1) NOT NULL,
	[Financing_Departments] [money] NOT NULL,
	[Name_Departments] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Id_Departments] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Departments_1] UNIQUE NONCLUSTERED 
(
	[Id_Departments] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Faculties]    Script Date: 11.05.2020 19:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculties](
	[Id_Faculties] [int] IDENTITY(1,1) NOT NULL,
	[Name_Faculties] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Faculties] PRIMARY KEY CLUSTERED 
(
	[Id_Faculties] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Faculties_1] UNIQUE NONCLUSTERED 
(
	[Id_Faculties] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 11.05.2020 19:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id_Groups] [int] IDENTITY(1,1) NOT NULL,
	[Name_Groups] [nvarchar](10) NOT NULL,
	[Rating_Groups] [int] NOT NULL,
	[Year_Groups] [int] NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id_Groups] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Groups_1] UNIQUE NONCLUSTERED 
(
	[Id_Groups] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 11.05.2020 19:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[Id_Teachers] [int] IDENTITY(1,1) NOT NULL,
	[EmploymentDate_Teachers] [datetime] NOT NULL,
	[Name_Teachers] [nvarchar](max) NOT NULL,
	[Premium_Teachers] [money] NOT NULL,
	[Salary_Teachers] [money] NOT NULL,
	[Surname_Teachers] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED 
(
	[Id_Teachers] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments] ADD  CONSTRAINT [DF_Departments_Financing_Departments]  DEFAULT ((0)) FOR [Financing_Departments]
GO
ALTER TABLE [dbo].[Teachers] ADD  CONSTRAINT [DF_Teachers_Premium_Teachers]  DEFAULT ((0)) FOR [Premium_Teachers]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Financing_Departments] CHECK  (([Financing_Departments]>=(0)))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Financing_Departments]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Name_Departments] CHECK  (([Name_Departments]<>''))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Name_Departments]
GO
ALTER TABLE [dbo].[Faculties]  WITH CHECK ADD  CONSTRAINT [Name_Faculties] CHECK  (([Name_Faculties]<>''))
GO
ALTER TABLE [dbo].[Faculties] CHECK CONSTRAINT [Name_Faculties]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [Name_Groups] CHECK  (([Name_Groups]<>''))
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [Name_Groups]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [Rating_Groups] CHECK  (([Rating_Groups]>=(0) AND [Rating_Groups]<=(5)))
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [Rating_Groups]
GO
ALTER TABLE [dbo].[Groups]  WITH CHECK ADD  CONSTRAINT [Year_Groups] CHECK  (([Year_Groups]>=(1) AND [Year_Groups]<=(5)))
GO
ALTER TABLE [dbo].[Groups] CHECK CONSTRAINT [Year_Groups]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [EmploymentDate_Teachers] CHECK  (([EmploymentDate_Teachers]>=(((1)-(1))-(1990))))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [EmploymentDate_Teachers]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Name_Teachers] CHECK  (([Name_Teachers]<>''))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Name_Teachers]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Premium_Teachers] CHECK  (([Premium_Teachers]>=(0)))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Premium_Teachers]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Salary_Teachers] CHECK  (([Salary_Teachers]>(0)))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Salary_Teachers]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [Surname_Teachers] CHECK  (([Surname_Teachers]<>''))
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [Surname_Teachers]
GO

USE [Hospital]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 13.05.2020 0:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id_Departments] [int] IDENTITY(1,1) NOT NULL,
	[Building_Departments] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Diseases]    Script Date: 13.05.2020 0:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diseases](
	[Id_Diseases] [int] IDENTITY(1,1) NOT NULL,
	[Name_Diseases] [nvarchar](100) NOT NULL,
	[Severity_Diseases] [int] NOT NULL,
 CONSTRAINT [PK_Diseases] PRIMARY KEY CLUSTERED 
(
	[Id_Diseases] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Diseases_1] UNIQUE NONCLUSTERED 
(
	[Id_Diseases] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 13.05.2020 0:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[Id_Doctors] [int] IDENTITY(1,1) NOT NULL,
	[Name_Doctors] [nvarchar](max) NOT NULL,
	[Phone_Doctors] [char](10) NULL,
	[Salary_Doctors] [money] NOT NULL,
	[Surname_Doctors] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Doctors] PRIMARY KEY CLUSTERED 
(
	[Id_Doctors] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Examinations]    Script Date: 13.05.2020 0:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Examinations](
	[Id_Examinations] [int] IDENTITY(1,1) NOT NULL,
	[DayOfWeek_Examinations] [int] NOT NULL,
	[EndTime_Examinations] [time](7) NOT NULL,
	[Name_Examinations] [nvarchar](100) NOT NULL,
	[StartTime_Examinations] [time](7) NOT NULL,
 CONSTRAINT [PK_Examinations] PRIMARY KEY CLUSTERED 
(
	[Id_Examinations] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Name_Examinations_1] UNIQUE NONCLUSTERED 
(
	[Id_Examinations] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Departments] ADD  CONSTRAINT [DF_Departments_Financing_Departments]  DEFAULT ((0)) FOR [Financing_Departments]
GO
ALTER TABLE [dbo].[Diseases] ADD  CONSTRAINT [DF_Diseases_Severity_Diseases]  DEFAULT ((1)) FOR [Severity_Diseases]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Building_Departments] CHECK  (([Building_Departments]>=(1) AND [Building_Departments]<=(5)))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Building_Departments]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Financing_Departments] CHECK  (([Financing_Departments]>=(0)))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Financing_Departments]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [Name_Departments] CHECK  (([Name_Departments]<>''))
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [Name_Departments]
GO
ALTER TABLE [dbo].[Diseases]  WITH CHECK ADD  CONSTRAINT [Name_Diseases] CHECK  (([Name_Diseases]<>''))
GO
ALTER TABLE [dbo].[Diseases] CHECK CONSTRAINT [Name_Diseases]
GO
ALTER TABLE [dbo].[Diseases]  WITH CHECK ADD  CONSTRAINT [Severity_Diseases] CHECK  (([Severity_Diseases]>=(1)))
GO
ALTER TABLE [dbo].[Diseases] CHECK CONSTRAINT [Severity_Diseases]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [Name_Doctors] CHECK  (([Name_Doctors]<>''))
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [Name_Doctors]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [Salary_Doctors] CHECK  (([Salary_Doctors]>(0)))
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [Salary_Doctors]
GO
ALTER TABLE [dbo].[Doctors]  WITH CHECK ADD  CONSTRAINT [Surname_Doctors] CHECK  (([Surname_Doctors]<>''))
GO
ALTER TABLE [dbo].[Doctors] CHECK CONSTRAINT [Surname_Doctors]
GO
ALTER TABLE [dbo].[Examinations]  WITH CHECK ADD  CONSTRAINT [DayOfWeek_Examinations] CHECK  (([DayOfWeek_Examinations]>=(1) AND [DayOfWeek_Examinations]<=(7)))
GO
ALTER TABLE [dbo].[Examinations] CHECK CONSTRAINT [DayOfWeek_Examinations]
GO
ALTER TABLE [dbo].[Examinations]  WITH CHECK ADD  CONSTRAINT [EndTime_Examinations] CHECK  (([EndTime_Examinations]>[StartTime_Examinations]))
GO
ALTER TABLE [dbo].[Examinations] CHECK CONSTRAINT [EndTime_Examinations]
GO
ALTER TABLE [dbo].[Examinations]  WITH CHECK ADD  CONSTRAINT [Name_Examinations] CHECK  (([Name_Examinations]<>''))
GO
ALTER TABLE [dbo].[Examinations] CHECK CONSTRAINT [Name_Examinations]
GO
ALTER TABLE [dbo].[Examinations]  WITH CHECK ADD  CONSTRAINT [StartTime_Examinations] CHECK  (([StartTime_Examinations]>='08:00:00.0000000' AND [StartTime_Examinations]<='18:00:00.0000000'))
GO
ALTER TABLE [dbo].[Examinations] CHECK CONSTRAINT [StartTime_Examinations]
GO

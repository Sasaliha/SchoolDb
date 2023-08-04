USE [master]
GO
/****** Object:  Database [SchoolDb]    Script Date: 4.08.2023 17:09:11 ******/
CREATE DATABASE [SchoolDb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SchoolDb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolDb.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SchoolDb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\SchoolDb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [SchoolDb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SchoolDb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SchoolDb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SchoolDb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SchoolDb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SchoolDb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SchoolDb] SET ARITHABORT OFF 
GO
ALTER DATABASE [SchoolDb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SchoolDb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SchoolDb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SchoolDb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SchoolDb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SchoolDb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SchoolDb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SchoolDb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SchoolDb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SchoolDb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SchoolDb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SchoolDb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SchoolDb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SchoolDb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SchoolDb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SchoolDb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SchoolDb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SchoolDb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SchoolDb] SET  MULTI_USER 
GO
ALTER DATABASE [SchoolDb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SchoolDb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SchoolDb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SchoolDb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SchoolDb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SchoolDb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SchoolDb] SET QUERY_STORE = ON
GO
ALTER DATABASE [SchoolDb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [SchoolDb]
GO
/****** Object:  Table [dbo].[Lessons]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lessons](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[UserId] [int] NOT NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoneAttendances]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoneAttendances](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[LessonId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
 CONSTRAINT [PK_StudentAttendances] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[IdentityNumber] [varchar](150) NOT NULL,
	[PhoneNumber] [varchar](150) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[ClassId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[UserId] [int] NOT NULL,
	[EnrollmentDate] [datetime] NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Students] UNIQUE NONCLUSTERED 
(
	[IdentityNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ClassName] [varchar](10) NOT NULL,
	[GradeLevelId] [int] NOT NULL,
	[TeacherId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Classes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[noneAttandancesView]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[noneAttandancesView] as
select format(a.Date,'dd-MM-yyyy') 'Bugün Gelmeyenler', 
s.Name 'Öğrenci Adı Soyadı',
l.Name 'Ders Adı', 
c.ClassName  'Şube'
from NoneAttendances as a left join Students as s on s.Id=a.StudentId
left join Lessons as l on l.Id=a.LessonId
left join Classes as c on c.Id=s.ClassId WHERE CAST(a.Date AS DATE)= CAST (GETDATE() AS DATE);



GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IdentityNumber] [char](11) NOT NULL,
	[PhoneNumber] [varchar](150) NOT NULL,
	[Eposta] [varchar](max) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[Password] [varchar](max) NOT NULL,
	[UserId] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[Image] [xml] NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Teachers] UNIQUE NONCLUSTERED 
(
	[IdentityNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_Teachers_1] UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exams]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[StudentId] [int] NOT NULL,
	[ExamDate] [date] NOT NULL,
	[ExamHour] [time](7) NOT NULL,
	[Exam1] [int] NULL,
	[Exam2] [int] NULL,
	[Exam3] [int] NULL,
	[LessonId] [int] NOT NULL,
	[AttendTheExam] [bit] NOT NULL,
	[TeacherId] [int] NULL,
 CONSTRAINT [PK_Exams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ExamStatuListsView]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ExamStatuListsView] as

select c.ClassName,  s.Name   , s.IdentityNumber, e.ExamDate, e.ExamHour, 
e.Exam1, e.Exam2, e.Exam3,((e.Exam1+e.Exam2+e.Exam3 )/3) 'Öğrenci ortalaması',
CASE
	WHEN ((e.Exam1+e.Exam2+e.Exam3 )/3)  > 70 then 'BAŞARILI'
	WHEN ((e.Exam1+e.Exam2+e.Exam3 )/3) <70 then 'BAŞARISIZ'
END as 'DURUM',

l.Name 'Dersin Adı', t.Name 'Öğretmen Adı'

from  Classes as c left join Students as s on c.Id=s.ClassId
left join Exams as e on e.StudentId=s.Id
left join Lessons as l on l.Id=e.LessonId
left join Teachers as t on t.Id=e.TeacherId
where not s.Name is null



GO
/****** Object:  Table [dbo].[AdministrativeStaff]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdministrativeStaff](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IdentityNumber] [char](11) NOT NULL,
	[PhoneNumber] [varchar](150) NOT NULL,
	[Eposta] [varchar](max) NOT NULL,
	[Address] [varchar](max) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	[DepartmentId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Image] [xml] NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_AdministrativeStaff] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminUser]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Eposta] [varchar](50) NOT NULL,
	[Password] [varchar](max) NOT NULL,
 CONSTRAINT [PK_AdminUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[UserId] [int] NULL,
 CONSTRAINT [PK_Departments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GradeLevel]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GradeLevel](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GradeLevel] [int] NOT NULL,
 CONSTRAINT [PK_GradeLevel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SchoolContactInformation]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SchoolContactInformation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Web] [varchar](max) NULL,
	[Eposta] [varchar](max) NULL,
	[Phone] [varchar](150) NULL,
	[Fax] [varchar](150) NULL,
	[Address] [varchar](255) NULL,
	[UserId] [int] NOT NULL,
	[Map] [varchar](max) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_SchoolContactInformation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SchoolStatistics]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SchoolStatistics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeacherCount] [int] NOT NULL,
	[StudentCount] [int] NOT NULL,
	[ClassCount] [int] NULL,
	[UserId] [int] NOT NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_Statistics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StudentParents]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StudentParents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[StudentId] [int] NOT NULL,
	[PhoneNumber] [varchar](150) NOT NULL,
	[ProximityLevel] [varchar](50) NOT NULL,
 CONSTRAINT [PK_StudentParents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdministrativeStaff]  WITH CHECK ADD  CONSTRAINT [FK_AdministrativeStaff_AdminUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdminUser] ([Id])
GO
ALTER TABLE [dbo].[AdministrativeStaff] CHECK CONSTRAINT [FK_AdministrativeStaff_AdminUser]
GO
ALTER TABLE [dbo].[AdministrativeStaff]  WITH CHECK ADD  CONSTRAINT [FK_AdministrativeStaff_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO
ALTER TABLE [dbo].[AdministrativeStaff] CHECK CONSTRAINT [FK_AdministrativeStaff_Departments]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_AdminUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdminUser] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_AdminUser]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_GradeLevel] FOREIGN KEY([GradeLevelId])
REFERENCES [dbo].[GradeLevel] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_GradeLevel]
GO
ALTER TABLE [dbo].[Classes]  WITH CHECK ADD  CONSTRAINT [FK_Classes_Teachers] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teachers] ([Id])
GO
ALTER TABLE [dbo].[Classes] CHECK CONSTRAINT [FK_Classes_Teachers]
GO
ALTER TABLE [dbo].[Departments]  WITH CHECK ADD  CONSTRAINT [FK_Departments_AdminUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdminUser] ([Id])
GO
ALTER TABLE [dbo].[Departments] CHECK CONSTRAINT [FK_Departments_AdminUser]
GO
ALTER TABLE [dbo].[Exams]  WITH CHECK ADD  CONSTRAINT [FK_Exams_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[Exams] CHECK CONSTRAINT [FK_Exams_Students]
GO
ALTER TABLE [dbo].[Exams]  WITH CHECK ADD  CONSTRAINT [FK_Exams_Teachers] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teachers] ([Id])
GO
ALTER TABLE [dbo].[Exams] CHECK CONSTRAINT [FK_Exams_Teachers]
GO
ALTER TABLE [dbo].[NoneAttendances]  WITH CHECK ADD  CONSTRAINT [FK_NoneAttendances_Teachers] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teachers] ([Id])
GO
ALTER TABLE [dbo].[NoneAttendances] CHECK CONSTRAINT [FK_NoneAttendances_Teachers]
GO
ALTER TABLE [dbo].[NoneAttendances]  WITH CHECK ADD  CONSTRAINT [FK_StudentAttendances_Lessons] FOREIGN KEY([LessonId])
REFERENCES [dbo].[Lessons] ([Id])
GO
ALTER TABLE [dbo].[NoneAttendances] CHECK CONSTRAINT [FK_StudentAttendances_Lessons]
GO
ALTER TABLE [dbo].[NoneAttendances]  WITH CHECK ADD  CONSTRAINT [FK_StudentAttendances_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[NoneAttendances] CHECK CONSTRAINT [FK_StudentAttendances_Students]
GO
ALTER TABLE [dbo].[NoneAttendances]  WITH CHECK ADD  CONSTRAINT [FK_StudentAttendances_Teachers] FOREIGN KEY([TeacherId])
REFERENCES [dbo].[Teachers] ([Id])
GO
ALTER TABLE [dbo].[NoneAttendances] CHECK CONSTRAINT [FK_StudentAttendances_Teachers]
GO
ALTER TABLE [dbo].[SchoolContactInformation]  WITH CHECK ADD  CONSTRAINT [FK_SchoolContactInformation_AdminUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdminUser] ([Id])
GO
ALTER TABLE [dbo].[SchoolContactInformation] CHECK CONSTRAINT [FK_SchoolContactInformation_AdminUser]
GO
ALTER TABLE [dbo].[StudentParents]  WITH CHECK ADD  CONSTRAINT [FK_StudentParents_Students] FOREIGN KEY([StudentId])
REFERENCES [dbo].[Students] ([Id])
GO
ALTER TABLE [dbo].[StudentParents] CHECK CONSTRAINT [FK_StudentParents_Students]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_AdminUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdminUser] ([Id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_AdminUser]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK_Students_Classes] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([Id])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK_Students_Classes]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [FK_Teachers_AdminUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[AdminUser] ([Id])
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [FK_Teachers_AdminUser]
GO
/****** Object:  StoredProcedure [dbo].[ClassStudentsProcedure]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[ClassStudentsProcedure] @className varchar(10)

as
begin

select ClassName 'Sınıf Şubesi', s.Name 'Öğrenci Adı', t.Name 'Öğretmen Adı' from Classes as c inner join Students as s on c.Id=s.ClassId 
inner join Teachers as t on c.TeacherId=t.Id
where ClassName=@className 

end
GO
/****** Object:  StoredProcedure [dbo].[LessonAverageProcedure]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[LessonAverageProcedure]  @className varchar(10) , @lessonName varchar(100)=null

AS
BEGIN

select c.ClassName,  s.Name   , s.IdentityNumber, e.ExamDate, e.ExamHour, 
e.Exam1, e.Exam2, e.Exam3,((e.Exam1+e.Exam2+e.Exam3 )/3) 'Öğrenci ortalaması',
l.Name 'Dersin Adı', t.Name 'Öğretmen Adı'  from  Classes as c left join Students as s on c.Id=s.ClassId
left join Exams as e on e.StudentId=s.Id
left join Lessons as l on l.Id=e.LessonId
left join Teachers as t on t.Id=e.TeacherId
where not s.Name is null and c.ClassName=@className

select AVG(((e.Exam1+e.Exam2+e.Exam3 )/3)) 'Sınıfın Ortalaması' FROM Exams as e left join Students as s on s.Id=e.StudentId
left join Classes as c on c.Id=s.ClassId
left join Lessons as l on l.Id=e.LessonId
where c.ClassName=@className and l.name=@lessonName


END
GO
/****** Object:  StoredProcedure [dbo].[SchoolStatisticsProcedure]    Script Date: 4.08.2023 17:09:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SchoolStatisticsProcedure] @userId int=1
as
begin
insert into SchoolStatistics  values((select count(*) from Teachers), (select count(*) from Students),(select count(*) from Classes), @userId,getdate())

select*from SchoolStatistics
end
GO
USE [master]
GO
ALTER DATABASE [SchoolDb] SET  READ_WRITE 
GO

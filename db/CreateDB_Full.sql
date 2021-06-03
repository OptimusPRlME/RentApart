USE [master]
GO

CREATE DATABASE [RentApart]
GO
ALTER DATABASE [RentApart] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RentApart].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RentApart] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RentApart] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RentApart] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RentApart] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RentApart] SET ARITHABORT OFF 
GO
ALTER DATABASE [RentApart] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RentApart] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RentApart] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RentApart] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RentApart] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RentApart] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RentApart] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RentApart] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RentApart] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RentApart] SET  ENABLE_BROKER 
GO
ALTER DATABASE [RentApart] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RentApart] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RentApart] SET TRUSTWORTHY ON 
GO
ALTER DATABASE [RentApart] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RentApart] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RentApart] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RentApart] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RentApart] SET RECOVERY FULL 
GO
ALTER DATABASE [RentApart] SET  MULTI_USER 
GO
ALTER DATABASE [RentApart] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RentApart] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RentApart] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RentApart] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RentApart] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RentApart] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'RentApart', N'ON'
GO
ALTER DATABASE [RentApart] SET QUERY_STORE = OFF
GO
USE [RentApart]
GO
/****** Object:  UserDefinedFunction [dbo].[Computus]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE   FUNCTION [dbo].[Computus]
			(
				@Y INT -- The year we are calculating easter sunday for
			)
			RETURNS DATETIME
			AS
			BEGIN

				DECLARE
					@a INT,
					@b INT,
					@c INT,
					@d INT,
					@e INT,
					@f INT,
					@g INT,
					@h INT,
					@i INT,
					@k INT,
					@L INT,
					@m INT

				SET @a = @Y % 19
				SET @b = @Y / 100
				SET @c = @Y % 100
				SET @d = @b / 4
				SET @e = @b % 4
				SET @f = (@b + 8) / 25
				SET @g = (@b - @f + 1) / 3
				SET @h = (19 * @a + @b - @d - @g + 15) % 30
				SET @i = @c / 4
				SET @k = @c % 4
				SET @L = (32 + 2 * @e + 2 * @i - @h - @k) % 7
				SET @m = (@a + 11 * @h + 22 * @L) / 451
				RETURN(DATEADD(month, ((@h + @L - 7 * @m + 114) / 31)-1, cast(cast(@Y AS VARCHAR) AS Datetime)) + ((@h + @L - 7 * @m + 114) % 31))
			END
	
GO
/****** Object:  UserDefinedFunction [dbo].[ComputusOrthodox]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

		CREATE   FUNCTION  [dbo].[ComputusOrthodox]
			(
				@Y INT -- The year we are calculating easter sunday for
			)
			RETURNS DATETIME
			AS
			BEGIN

				DECLARE
					@a INT,
					@b INT,
					@c INT,
					@d INT,
					@e INT,
					@f INT

				SET @a = @Y % 19
				SET @b = @Y % 4
				SET @c = @Y % 7
				SET @d = (19 * @a + 15) % 30
				SET @e = (2 * @b + 4 * @c + 6 * @d + 6) % 7
				SET @f = @d + @e
				RETURN(case when @f <= 26  then cast(@Y as VARCHAR(4))+'-04-'+cast(@f+4 as VARCHAR(4)) when @f > 26 then cast(@Y as VARCHAR(4))+'-05-'+cast(@f-26 as VARCHAR(4)) else null end)
			END
	
GO
/****** Object:  Table [dbo].[country]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Country] [nvarchar](50) NULL,
	[CountryCyr] [nvarchar](50) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[region]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[region](
	[Id] [int] NOT NULL,
	[Region] [nvarchar](50) NULL,
	[RegionCyr] [nvarchar](50) NULL,
	[CountryId] [int] NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[district]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[district](
	[Id] [int] NOT NULL,
	[District] [nvarchar](50) NULL,
	[DistrictCyr] [nvarchar](50) NULL,
	[RegionId] [int] NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[municipality]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[municipality](
	[Id] [int] NOT NULL,
	[Municipality] [nvarchar](50) NULL,
	[MunicipalityCyr] [nvarchar](50) NULL,
	[DistrictId] [int] NULL,
 CONSTRAINT [PK_municipality] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[location]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[location](
	[Id] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](50) NULL,
	[LocationCyr] [nvarchar](50) NULL,
	[MunicipalityId] [int] NULL,
 CONSTRAINT [PK_location] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[address]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[Id] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](150) NULL,
	[AddressCyr] [nvarchar](150) NULL,
	[LocationId] [nvarchar](50) NULL,
 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[addressNumber]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[addressNumber](
	[Id] [nvarchar](50) NOT NULL,
	[Number] [nvarchar](10) NULL,
	[NumberCyr] [nvarchar](10) NULL,
	[PlotNumberFull] [nvarchar](50) NULL,
	[PlotNumber] [nvarchar](50) NULL,
	[PlotSubNumber] [nvarchar](5) NULL,
	[geo] [geography] NULL,
	[lat] [decimal](8, 6) NULL,
	[lng] [decimal](9, 6) NULL,
	[AddressId] [nvarchar](50) NULL,
 CONSTRAINT [PK_addressNumber] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[FullAddress]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[FullAddress]
as

SELECT 
	   a.Address
	  ,an.[Number]
	  ,l.Location
	  ,m.Municipality
	  ,d.District
	  ,r.Region
	  ,c.Country
      --,an.[PlotNumberFull]
  FROM [RentApart].[dbo].[addressNumber] an
  left join address a
  on an.AddressId = a.Id
  left join location l
  on a.LocationId = l.Id
  left join municipality m
  on l.MunicipalityId = m.id
  left join district d
  on m.DistrictId = d.Id
  left join region r
  on d.RegionId = r.Id
  left join country c
  on r.CountryId = c.id
GO
/****** Object:  Table [dbo].[apartment]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apartment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[type] [nvarchar](50) NULL,
	[Rooms] [int] NULL,
	[Area] [int] NULL,
	[Floor] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [decimal](10, 0) NULL,
	[Status] [nvarchar](50) NULL,
	[NumberOfFloors] [int] NULL,
	[YearOfConstruction] [int] NULL,
	[Furnishing] [nvarchar](50) NULL,
	[NumberOfBedrooms] [int] NULL,
	[NumberOfBathrooms] [int] NULL,
	[DistanceFromCenter] [decimal](10, 0) NULL,
	[Renovated] [bit] NULL,
	[Heating] [nvarchar](50) NULL,
	[Deposit] [decimal](10, 0) NULL,
	[MinimumLeaseLength] [int] NULL,
	[PaymentDue] [nvarchar](50) NULL,
	[Available] [nvarchar](50) NULL,
	[MaximumNumberOfTenants] [int] NULL,
	[AddressNumberId] [nvarchar](50) NULL,
	[UserId] [int] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_apartment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[apartmentOptions]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apartmentOptions](
	[ApartmentId] [int] NOT NULL,
	[OptionId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[apartmentPictures]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apartmentPictures](
	[ApartmentId] [int] NOT NULL,
	[PictureId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Calendar]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calendar](
	[CalendarId] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [int] NOT NULL,
	[Month] [int] NOT NULL,
	[MonthName] [varchar](9) NOT NULL,
	[Week] [int] NOT NULL,
	[Day] [int] NOT NULL,
	[DayName] [varchar](9) NOT NULL,
	[DayOfYear] [int] NOT NULL,
	[Weekday] [int] NOT NULL,
	[KindOfDay] [varchar](10) NOT NULL,
	[Description] [varchar](50) NULL,
	[RentUserId] [int] NULL,
	[RentalUserId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CalendarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedback]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[ApartmentId] [int] NULL,
	[Comment] [nvarchar](max) NULL,
	[mark] [int] NULL,
 CONSTRAINT [PK_feedback] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[options]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[options](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[option] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_options] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pictures]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pictures](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[picture] [varbinary](max) NULL,
	[extension] [nvarchar](max) NULL,
	[base6] [nvarchar](max) NULL,
 CONSTRAINT [PK_pictures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user]    Script Date: 6/3/2021 11:18:53 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](256) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[UserId] [nvarchar](128) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [RoleNameIndex]    Script Date: 6/3/2021 11:18:53 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 6/3/2021 11:18:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 6/3/2021 11:18:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_RoleId]    Script Date: 6/3/2021 11:18:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserId]    Script Date: 6/3/2021 11:18:53 AM ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UserNameIndex]    Script Date: 6/3/2021 11:18:53 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UserNameIndex] ON [dbo].[AspNetUsers]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[apartment] ADD  CONSTRAINT [DF_apartment_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
ALTER TABLE [dbo].[address]  WITH CHECK ADD  CONSTRAINT [FK_Location_Address] FOREIGN KEY([LocationId])
REFERENCES [dbo].[location] ([Id])
GO
ALTER TABLE [dbo].[address] CHECK CONSTRAINT [FK_Location_Address]
GO
ALTER TABLE [dbo].[addressNumber]  WITH CHECK ADD  CONSTRAINT [FK_Address_AddressNumber] FOREIGN KEY([AddressId])
REFERENCES [dbo].[address] ([Id])
GO
ALTER TABLE [dbo].[addressNumber] CHECK CONSTRAINT [FK_Address_AddressNumber]
GO
ALTER TABLE [dbo].[apartment]  WITH CHECK ADD  CONSTRAINT [FK_apartment_addressNumber] FOREIGN KEY([AddressNumberId])
REFERENCES [dbo].[addressNumber] ([Id])
GO
ALTER TABLE [dbo].[apartment] CHECK CONSTRAINT [FK_apartment_addressNumber]
GO
ALTER TABLE [dbo].[apartment]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[user] ([Id])
GO
ALTER TABLE [dbo].[apartment] CHECK CONSTRAINT [FK_Apartment_User]
GO
ALTER TABLE [dbo].[apartmentOptions]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_Option1] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].[apartment] ([Id])
GO
ALTER TABLE [dbo].[apartmentOptions] CHECK CONSTRAINT [FK_Apartment_Option1]
GO
ALTER TABLE [dbo].[apartmentOptions]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_Option2] FOREIGN KEY([OptionId])
REFERENCES [dbo].[options] ([Id])
GO
ALTER TABLE [dbo].[apartmentOptions] CHECK CONSTRAINT [FK_Apartment_Option2]
GO
ALTER TABLE [dbo].[apartmentPictures]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_Picture1] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].[apartment] ([Id])
GO
ALTER TABLE [dbo].[apartmentPictures] CHECK CONSTRAINT [FK_Apartment_Picture1]
GO
ALTER TABLE [dbo].[apartmentPictures]  WITH CHECK ADD  CONSTRAINT [FK_Apartment_Picture2] FOREIGN KEY([PictureId])
REFERENCES [dbo].[pictures] ([Id])
GO
ALTER TABLE [dbo].[apartmentPictures] CHECK CONSTRAINT [FK_Apartment_Picture2]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[Calendar]  WITH CHECK ADD  CONSTRAINT [FK_Calendar_user] FOREIGN KEY([RentUserId])
REFERENCES [dbo].[user] ([Id])
GO
ALTER TABLE [dbo].[Calendar] CHECK CONSTRAINT [FK_Calendar_user]
GO
ALTER TABLE [dbo].[Calendar]  WITH CHECK ADD  CONSTRAINT [FK_Calendar_user1] FOREIGN KEY([RentalUserId])
REFERENCES [dbo].[user] ([Id])
GO
ALTER TABLE [dbo].[Calendar] CHECK CONSTRAINT [FK_Calendar_user1]
GO
ALTER TABLE [dbo].[district]  WITH CHECK ADD  CONSTRAINT [FK_Region_District] FOREIGN KEY([RegionId])
REFERENCES [dbo].[region] ([Id])
GO
ALTER TABLE [dbo].[district] CHECK CONSTRAINT [FK_Region_District]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Apartment] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].[apartment] ([Id])
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK_Feedback_Apartment]
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[user] ([Id])
GO
ALTER TABLE [dbo].[feedback] CHECK CONSTRAINT [FK_Feedback_User]
GO
ALTER TABLE [dbo].[location]  WITH CHECK ADD  CONSTRAINT [FK_Municipality_Location] FOREIGN KEY([MunicipalityId])
REFERENCES [dbo].[municipality] ([Id])
GO
ALTER TABLE [dbo].[location] CHECK CONSTRAINT [FK_Municipality_Location]
GO
ALTER TABLE [dbo].[municipality]  WITH CHECK ADD  CONSTRAINT [FK_District_Municipality] FOREIGN KEY([DistrictId])
REFERENCES [dbo].[district] ([Id])
GO
ALTER TABLE [dbo].[municipality] CHECK CONSTRAINT [FK_District_Municipality]
GO
ALTER TABLE [dbo].[region]  WITH CHECK ADD  CONSTRAINT [FK_Country_Region] FOREIGN KEY([CountryId])
REFERENCES [dbo].[country] ([Id])
GO
ALTER TABLE [dbo].[region] CHECK CONSTRAINT [FK_Country_Region]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD  CONSTRAINT [FK_user_user] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_user]
GO
ALTER TABLE [dbo].[Calendar]  WITH CHECK ADD  CONSTRAINT [Calendar_ck] CHECK  (([Year]>(1900) AND ([Quarter]>=(1) AND [Quarter]<=(4)) AND ([Month]>=(1) AND [Month]<=(12)) AND ([MonthName]='December' OR [MonthName]='November' OR [MonthName]='October' OR [MonthName]='September' OR [MonthName]='August' OR [MonthName]='July' OR [MonthName]='June' OR [MonthName]='May' OR [MonthName]='April' OR [MonthName]='March' OR [MonthName]='February' OR [MonthName]='January') AND ([Week]>=(1) AND [Week]<=(53)) AND ([Day]>=(1) AND [Day]<=(31)) AND ([DayName]='Sunday' OR [DayName]='Saturday' OR [DayName]='Friday' OR [DayName]='Thursday' OR [DayName]='Wednesday' OR [DayName]='Tuesday' OR [DayName]='Monday') AND ([DayOfYear]>=(1) AND [DayOfYear]<=(366)) AND ([Weekday]>=(1) AND [Weekday]<=(7)) AND ([KindOfDay]='Workday' OR [KindOfDay]='Sunday' OR [KindOfDay]='Saturday' OR [KindOfDay]='Holiday')))
GO
ALTER TABLE [dbo].[Calendar] CHECK CONSTRAINT [Calendar_ck]
GO
USE [master]
GO
ALTER DATABASE [RentApart] SET  READ_WRITE 
GO

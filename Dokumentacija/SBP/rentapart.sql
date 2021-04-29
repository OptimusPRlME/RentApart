IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'RentApart')
BEGIN
    CREATE DATABASE [RentApart]
END
GO

USE [RentApart]
GO

ALTER DATABASE [RentApart] set TRUSTWORTHY ON; 
GO 
EXEC dbo.sp_changedbowner @loginame = N'sa', @map = false 
GO 
sp_configure 'show advanced options', 1; 
GO 
RECONFIGURE; 
GO 
sp_configure 'clr enabled', 1; 
GO 
RECONFIGURE; 
GO


/*** AspNetUsers ***/
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO


/*** AspNetRoles ***/
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO


/*** AspNetRoleClaims ***/
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO


/*** AspNetUserClaims ***/
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
)ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO

/*** AspNetUserLogins ***/
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO


/*** AspNetUserRoles ***/
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO


/*** AspNetUserTokens ***/
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO


/*** country ***/
CREATE TABLE [dbo].country (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Country] [varchar](50) NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO


/*** region ***/
CREATE TABLE [dbo].region (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Region] [varchar](50) NULL,
	[CountryId] INT NULL,
 CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].region WITH CHECK ADD  CONSTRAINT [FK_Country_Region] FOREIGN KEY([CountryId])
REFERENCES [dbo].country (Id)
GO

ALTER TABLE [dbo].region CHECK CONSTRAINT [FK_Country_Region]
GO


/*** district ***/
CREATE TABLE [dbo].district (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [District] VARCHAR(50) NULL,
	[RegionId] INT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].district WITH CHECK ADD CONSTRAINT [FK_Region_District] FOREIGN KEY([RegionId])
REFERENCES [dbo].region ([Id])
GO

ALTER TABLE [dbo].district CHECK CONSTRAINT [FK_Region_District]
GO


/*** municipality ***/
CREATE TABLE [dbo].municipality (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [Municipality] VARCHAR(50) NULL,
	[DistrictId] INT NULL,
 CONSTRAINT [PK_municipality] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].municipality WITH CHECK ADD CONSTRAINT [FK_District_Municipality] FOREIGN KEY([DistrictId])
REFERENCES [dbo].district ([Id])
GO

ALTER TABLE [dbo].municipality CHECK CONSTRAINT [FK_District_Municipality]
GO


/*** location ***/
CREATE TABLE [dbo].location (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [Location] VARCHAR(50) NULL,
    [zip] INT NULL,
	[MunicipalityId] INT NULL,
 CONSTRAINT [PK_location] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].location WITH CHECK ADD CONSTRAINT [FK_Municipality_Location] FOREIGN KEY([MunicipalityId])
REFERENCES [dbo].municipality ([Id])
GO

ALTER TABLE [dbo].location CHECK CONSTRAINT [FK_Municipality_Location]
GO


/*** address ***/
CREATE TABLE [dbo].address (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [Address] VARCHAR(150) NULL,
    [Number] INT NULL,
	[geo] geography NULL,
	[LocationId] INT NULL,
 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].address WITH CHECK ADD CONSTRAINT [FK_Location_Address] FOREIGN KEY([LocationId])
REFERENCES [dbo].location ([Id])
GO

ALTER TABLE [dbo].address CHECK CONSTRAINT [FK_Location_Address]
GO


/*** user ***/
CREATE TABLE [dbo].[user] (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [email] VARCHAR(50) NULL,
	[FirstName] VARCHAR(50) NULL,
	[LastName] VARCHAR(50) NULL,
	[Mobile] VARCHAR(50) NULL,
	[UserId] NVARCHAR(450) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[user] WITH CHECK ADD CONSTRAINT [FK_user_user] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO

ALTER TABLE [dbo].[user] CHECK CONSTRAINT [FK_user_user]
GO


/*** apartment ***/
CREATE TABLE [dbo].apartment (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[type] varchar(30) NULL,
    [Rooms] int NULL,
    [Area] int NULL,
    [Floor] int NULL,
    [Description] nvarchar(max) NULL,
    [Price] decimal(10,0) NULL,
    [Status] varchar(20) NULL,
	[NumberOfFloors] int NULL,
	[YearOfConstruction] int NULL,
	[Furnishing] varchar(20) NULL,
	[NumberOfBedrooms] int NULL,
	[NumberOfBathrooms] int NULL,
	[DistanceFromCenter] decimal(10,0) NULL,
	[Renovated] bit NULL,
	[Heating] varchar(20) NULL,
	[Deposit] decimal(10,0) NULL,
	[MinimumLeaseLength] int NULL,
	[PaymentDue] varchar(20) NULL,
	[Available] varchar(20) NULL,
	[MaximumNumberOfTenants] int NULL,
	[AddressId] INT NULL,
	[UserId] INT NULL,
 CONSTRAINT [PK_apartment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].apartment WITH CHECK ADD CONSTRAINT [FK_Apartment_Address] FOREIGN KEY([AddressId])
REFERENCES [dbo].address ([Id])
GO

ALTER TABLE [dbo].apartment CHECK CONSTRAINT [FK_Apartment_Address]
GO

ALTER TABLE [dbo].apartment WITH CHECK ADD CONSTRAINT [FK_Apartment_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[user] ([Id])
GO

ALTER TABLE [dbo].apartment CHECK CONSTRAINT [FK_Apartment_User]
GO


/*** options ***/
CREATE TABLE [dbo].options (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [option] VARCHAR(50) NOT NULL,
 CONSTRAINT [PK_options] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO


/*** apartmentOptions ***/
CREATE TABLE [dbo].apartmentOptions (
	[ApartmentId] [int] NOT NULL,
    [OptionId] [int] NOT NULL)

ALTER TABLE [dbo].apartmentOptions WITH CHECK ADD CONSTRAINT [FK_Apartment_Option1] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].apartment ([Id])
GO

ALTER TABLE [dbo].apartmentOptions CHECK CONSTRAINT [FK_Apartment_Option1]
GO

ALTER TABLE [dbo].apartmentOptions WITH CHECK ADD CONSTRAINT [FK_Apartment_Option2] FOREIGN KEY([OptionId])
REFERENCES [dbo].options ([Id])
GO

ALTER TABLE [dbo].apartmentOptions CHECK CONSTRAINT [FK_Apartment_Option2]
GO


/*** pictures ***/
CREATE TABLE [dbo].pictures (
	[Id] [int] IDENTITY(1,1) NOT NULL,
    [picture] NVARCHAR(max) NULL,
	[extension] NVARCHAR(max) NULL,
	[base6] NVARCHAR(max) NULL
 CONSTRAINT [PK_pictures] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].apartmentPictures (
	[ApartmentId] [int] NOT NULL,
    [PictureId] [int] NOT NULL)

ALTER TABLE [dbo].apartmentPictures WITH CHECK ADD CONSTRAINT [FK_Apartment_Picture1] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].apartment ([Id])
GO

ALTER TABLE [dbo].apartmentPictures CHECK CONSTRAINT [FK_Apartment_Picture1]
GO

ALTER TABLE [dbo].apartmentPictures WITH CHECK ADD CONSTRAINT [FK_Apartment_Picture2] FOREIGN KEY([PictureId])
REFERENCES [dbo].pictures ([Id])
GO

ALTER TABLE [dbo].apartmentPictures CHECK CONSTRAINT [FK_Apartment_Picture2]
GO


/*** feedback ***/
CREATE TABLE [dbo].feedback (
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] INT NULL,
	[ApartmentId] INT NULL,
	[Comment] nvarchar(max) Null,
	[mark] int NULL,
 CONSTRAINT [PK_feedback] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
) ON [PRIMARY] 
GO

ALTER TABLE [dbo].feedback WITH CHECK ADD CONSTRAINT [FK_Feedback_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[user] ([Id])
GO

ALTER TABLE [dbo].feedback CHECK CONSTRAINT [FK_Feedback_User]
GO

ALTER TABLE [dbo].feedback WITH CHECK ADD CONSTRAINT [FK_Feedback_Apartment] FOREIGN KEY([ApartmentId])
REFERENCES [dbo].apartment ([Id])
GO

ALTER TABLE [dbo].feedback CHECK CONSTRAINT [FK_Feedback_Apartment]
GO




/*** calendar ***/
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

ALTER TABLE [dbo].[Calendar]  WITH CHECK ADD  CONSTRAINT [Calendar_ck] CHECK  (([Year]>(1900) AND ([Quarter]>=(1) AND [Quarter]<=(4)) AND ([Month]>=(1) AND [Month]<=(12)) AND ([MonthName]='December' OR [MonthName]='November' OR [MonthName]='October' OR [MonthName]='September' OR [MonthName]='August' OR [MonthName]='July' OR [MonthName]='June' OR [MonthName]='May' OR [MonthName]='April' OR [MonthName]='March' OR [MonthName]='February' OR [MonthName]='January') AND ([Week]>=(1) AND [Week]<=(53)) AND ([Day]>=(1) AND [Day]<=(31)) AND ([DayName]='Sunday' OR [DayName]='Saturday' OR [DayName]='Friday' OR [DayName]='Thursday' OR [DayName]='Wednesday' OR [DayName]='Tuesday' OR [DayName]='Monday') AND ([DayOfYear]>=(1) AND [DayOfYear]<=(366)) AND ([Weekday]>=(1) AND [Weekday]<=(7)) AND ([KindOfDay]='Workday' OR [KindOfDay]='Sunday' OR [KindOfDay]='Saturday' OR [KindOfDay]='Holiday')))
GO

ALTER TABLE [dbo].[Calendar] CHECK CONSTRAINT [Calendar_ck]
GO
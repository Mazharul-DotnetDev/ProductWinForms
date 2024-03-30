USE [master]
GO
/****** Object:  Database [SampleStore]    Script Date: 3/30/2024 2:10:47 PM ******/
CREATE DATABASE [SampleStore]
go
ALTER DATABASE [SampleStore] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SampleStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SampleStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SampleStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SampleStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SampleStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SampleStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [SampleStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SampleStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SampleStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SampleStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SampleStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SampleStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SampleStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SampleStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SampleStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SampleStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SampleStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SampleStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SampleStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SampleStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SampleStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SampleStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SampleStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SampleStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SampleStore] SET  MULTI_USER 
GO
ALTER DATABASE [SampleStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SampleStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SampleStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SampleStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SampleStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SampleStore] SET QUERY_STORE = OFF
GO
USE [SampleStore]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [SampleStore]
GO
/****** Object:  Table [dbo].[InvoiceMaster]    Script Date: 3/30/2024 2:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceMaster](
	[InvoiceId] [int] NOT NULL,
	[InvoiceDate] [date] NOT NULL,
	[CustomerName] [varchar](100) NOT NULL,
	[CustomerAddress] [varchar](250) NULL,
	[PhoneNo] [varchar](50) NULL,
 CONSTRAINT [PK_InvoiceMaster] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 3/30/2024 2:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[InvoiceId] [int] NOT NULL,
	[ItemName] [varchar](50) NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ItemTotal]  AS ([UnitPrice]*[Quantity]),
 CONSTRAINT [PK_InvoiceDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC,
	[ItemName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwInvoiceInfo]    Script Date: 3/30/2024 2:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vwInvoiceInfo]
as
select a.InvoiceId, a.InvoiceDate,a.CustomerName, a.CustomerAddress, a.PhoneNo,   
b.ItemName, b.UnitPrice, b.Quantity, b.ItemTotal

from InvoiceMaster as a
join InvoiceDetails as b
on a.InvoiceId = b.InvoiceId
GO
/****** Object:  Table [dbo].[Products]    Script Date: 3/30/2024 2:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[UnitPrice] [money] NULL,
	[Quantity] [smallint] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table1]    Script Date: 3/30/2024 2:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table1](
	[InvoiceID] [int] NULL,
	[VendorID] [int] NULL,
	[InvoiceNumber] [varchar](50) NULL,
	[InvoiceDate] [date] NULL,
	[InvoiceTotal] [money] NULL,
	[PaymentTotal] [money] NULL,
	[CreditTotal] [money] NULL,
	[TermsID] [money] NULL,
	[InvoiceDueDate] [date] NULL,
	[PaymentDate] [date] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (1, N'Desktop computer', 50000.0000, 5)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (1, N'Laptop', 150000.0000, 2)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (1, N'UPS', 5000.0000, 5)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (2, N'Computer table ', 4500.0000, 5)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (2, N'Desktop computer', 50000.0000, 5)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (2, N'Laptop', 150000.0000, 2)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (2, N'Pendrive', 1500.0000, 8)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (3, N'item 2', 4000.0000, 5)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (3, N'item 3', 6000.0000, 3)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (3, N'item1', 15000.0000, 2)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (5, N'CPU', 500000.0000, 4)
GO
INSERT [dbo].[InvoiceDetails] ([InvoiceId], [ItemName], [UnitPrice], [Quantity]) VALUES (5, N'Laptop', 5.0000, 8)
GO
INSERT [dbo].[InvoiceMaster] ([InvoiceId], [InvoiceDate], [CustomerName], [CustomerAddress], [PhoneNo]) VALUES (1, CAST(N'2001-01-01' AS Date), N'kjbsfgs', N'Ctg. , BD', N'01654654')
GO
INSERT [dbo].[InvoiceMaster] ([InvoiceId], [InvoiceDate], [CustomerName], [CustomerAddress], [PhoneNo]) VALUES (2, CAST(N'2023-06-05' AS Date), N'xfgxcfvb', N'Ctg. , BD', N'4654654')
GO
INSERT [dbo].[InvoiceMaster] ([InvoiceId], [InvoiceDate], [CustomerName], [CustomerAddress], [PhoneNo]) VALUES (3, CAST(N'2023-10-14' AS Date), N'invoice 3 customer', N'ctg.', N'0133333333333333')
GO
INSERT [dbo].[InvoiceMaster] ([InvoiceId], [InvoiceDate], [CustomerName], [CustomerAddress], [PhoneNo]) VALUES (5, CAST(N'2023-10-13' AS Date), N'ddddddszds', N'Bangladesh', N'6541651')
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (1, N'Chai', 18.0000, 39)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (2, N'Chang', 19.0000, 17)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (3, N'Aniseed Syrup', 10.0000, 13)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (4, N'Chef Anton''s Cajun Seasoning', 22.0000, 53)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (5, N'Chef Anton''s Gumbo Mix', 21.3500, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (6, N'Grandma''s Boysenberry Spread', 25.0000, 120)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (7, N'Uncle Bob''s Organic Dried Pears', 30.0000, 15)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (8, N'Northwoods Cranberry Sauce', 40.0000, 6)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (9, N'Mishi Kobe Niku', 97.0000, 29)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (10, N'Ikura', 31.0000, 31)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (11, N'Queso Cabrales', 42.0000, 40)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (12, N'Queso Manchego La Pastora', 38.0000, 86)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (13, N'vhnjgvhnjfv', 6.0000, 51)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (14, N'Tofu', 23.2500, 35)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (15, N'Genen Shouyu', 15.5000, 39)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (16, N'Pavlova', 17.4500, 29)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (17, N'Alice Mutton', 39.0000, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (18, N'Carnarvon Tigers', 62.5000, 42)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (19, N'Teatime Chocolate Biscuits', 9.2000, 25)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (20, N'Sir Rodney''s Marmalade', 81.0000, 40)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (21, N'Sir Rodney''s Scones', 10.0000, 3)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (22, N'Gustaf''s Knäckebröd', 21.0000, 104)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (23, N'Tunnbröd', 9.0000, 61)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (24, N'Guaraná Fantástica', 4.5000, 20)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (25, N'NuNuCa Nuß-Nougat-Creme', 14.0000, 76)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (26, N'Gumbär Gummibärchen', 31.2300, 15)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (27, N'Schoggi Schokolade', 43.9000, 49)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (28, N'Rössle Sauerkraut', 45.6000, 26)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (29, N'Thüringer Rostbratwurst', 123.7900, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (30, N'Nord-Ost Matjeshering', 25.8900, 10)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (31, N'Gorgonzola Telino', 12.5000, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (32, N'Mascarpone Fabioli', 32.0000, 9)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (33, N'Geitost', 2.5000, 112)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (34, N'Sasquatch Ale', 14.0000, 111)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (35, N'Steeleye Stout', 18.0000, 20)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (36, N'Inlagd Sill', 19.0000, 112)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (37, N'Gravad lax', 26.0000, 11)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (38, N'Côte de Blaye', 263.5000, 17)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (39, N'Chartreuse verte', 18.0000, 69)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (40, N'Boston Crab Meat', 18.4000, 123)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (41, N'Jack''s New England Clam Chowder', 9.6500, 85)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (42, N'Singaporean Hokkien Fried Mee', 14.0000, 26)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (43, N'Ipoh Coffee', 46.0000, 17)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (44, N'Gula Malacca', 19.4500, 27)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (45, N'Rogede sild', 9.5000, 5)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (46, N'Spegesild', 12.0000, 95)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (47, N'Zaanse koeken', 9.5000, 36)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (48, N'Chocolade', 12.7500, 15)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (49, N'Maxilaku', 20.0000, 10)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (50, N'Valkoinen suklaa', 16.2500, 65)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (51, N'Manjimup Dried Apples', 53.0000, 20)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (52, N'Filo Mix', 7.0000, 38)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (53, N'Perth Pasties', 32.8000, 0)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (54, N'Tourtière', 7.4500, 21)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (55, N'Pâté chinois', 24.0000, 115)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (56, N'Gnocchi di nonna Alice', 38.0000, 21)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (57, N'Ravioli Angelo', 19.5000, 36)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (58, N'Escargots de Bourgogne', 13.2500, 62)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (59, N'Raclette Courdavault', 55.0000, 79)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (60, N'Camembert Pierrot', 34.0000, 19)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (61, N'Sirop d''érable', 28.5000, 113)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (62, N'Tarte au sucre', 49.3000, 17)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (63, N'Vegie-spread', 43.9000, 24)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (64, N'Wimmers gute Semmelknödel', 33.2500, 22)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (65, N'Louisiana Fiery Hot Pepper Sauce', 21.0500, 76)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (66, N'Louisiana Hot Spiced Okra', 17.0000, 4)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (67, N'Laughing Lumberjack Lager', 14.0000, 52)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (68, N'Scottish Longbreads', 12.5000, 6)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (69, N'Gudbrandsdalsost', 36.0000, 26)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (70, N'Outback Lager', 15.0000, 15)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (71, N'Flotemysost', 21.5000, 26)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (72, N'Mozzarella di Giovanni', 34.8000, 14)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (73, N'Röd Kaviar', 15.0000, 101)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (74, N'Longlife Tofu', 10.0000, 4)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (75, N'Rhönbräu Klosterbier', 7.7500, 125)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (76, N'Lakkalikööri', 18.0000, 57)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (77, N'Original Frankfurter grüne Soße', 13.0000, 32)
GO
INSERT [dbo].[Products] ([ProductID], [ProductName], [UnitPrice], [Quantity]) VALUES (78, N'new product', 50.0000, 20)
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (1, 122, N'989319-457', CAST(N'2015-12-08' AS Date), 3813.3300, 3813.3300, 0.0000, 3.0000, CAST(N'2016-01-08' AS Date), CAST(N'2016-01-07' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (2, 123, N'263253241', CAST(N'2015-12-10' AS Date), 40.2000, 40.2000, 0.0000, 3.0000, CAST(N'2016-01-10' AS Date), CAST(N'2016-01-14' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (3, 123, N'963253234', CAST(N'2015-12-13' AS Date), 138.7500, 138.7500, 0.0000, 3.0000, CAST(N'2016-01-13' AS Date), CAST(N'2016-01-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (4, 123, N'2-000-2993', CAST(N'2015-12-16' AS Date), 144.7000, 144.7000, 0.0000, 3.0000, CAST(N'2016-01-16' AS Date), CAST(N'2016-01-12' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (5, 123, N'963253251', CAST(N'2015-12-16' AS Date), 15.5000, 15.5000, 0.0000, 3.0000, CAST(N'2016-01-16' AS Date), CAST(N'2016-01-11' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (6, 123, N'963253261', CAST(N'2015-12-16' AS Date), 42.7500, 42.7500, 0.0000, 3.0000, CAST(N'2016-01-16' AS Date), CAST(N'2016-01-21' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (7, 123, N'963253237', CAST(N'2015-12-21' AS Date), 172.5000, 172.5000, 0.0000, 3.0000, CAST(N'2016-01-21' AS Date), CAST(N'2016-01-22' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (8, 89, N'125520-1', CAST(N'2015-12-24' AS Date), 95.0000, 95.0000, 0.0000, 1.0000, CAST(N'2016-01-04' AS Date), CAST(N'2016-01-01' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (9, 121, N'97/488', CAST(N'2015-12-24' AS Date), 601.9500, 601.9500, 0.0000, 3.0000, CAST(N'2016-01-24' AS Date), CAST(N'2016-01-21' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (10, 123, N'263253250', CAST(N'2015-12-24' AS Date), 42.6700, 42.6700, 0.0000, 3.0000, CAST(N'2016-01-24' AS Date), CAST(N'2016-01-22' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (11, 123, N'963253262', CAST(N'2015-12-25' AS Date), 42.5000, 42.5000, 0.0000, 3.0000, CAST(N'2016-01-25' AS Date), CAST(N'2016-01-20' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (12, 96, N'I77271-O01', CAST(N'2015-12-26' AS Date), 662.0000, 662.0000, 0.0000, 2.0000, CAST(N'2016-01-16' AS Date), CAST(N'2016-01-13' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (13, 95, N'111-92R-10096', CAST(N'2015-12-30' AS Date), 16.3300, 16.3300, 0.0000, 2.0000, CAST(N'2016-01-20' AS Date), CAST(N'2016-01-23' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (14, 115, N'25022117', CAST(N'2016-01-01' AS Date), 6.0000, 6.0000, 0.0000, 4.0000, CAST(N'2016-02-10' AS Date), CAST(N'2016-02-10' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (15, 48, N'P02-88D77S7', CAST(N'2016-01-03' AS Date), 856.9200, 856.9200, 0.0000, 3.0000, CAST(N'2016-02-02' AS Date), CAST(N'2016-01-30' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (16, 97, N'21-4748363', CAST(N'2016-01-03' AS Date), 9.9500, 9.9500, 0.0000, 2.0000, CAST(N'2016-01-23' AS Date), CAST(N'2016-01-22' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (17, 123, N'4-321-2596', CAST(N'2016-01-05' AS Date), 10.0000, 10.0000, 0.0000, 3.0000, CAST(N'2016-02-04' AS Date), CAST(N'2016-02-05' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (18, 123, N'963253242', CAST(N'2016-01-06' AS Date), 104.0000, 104.0000, 0.0000, 3.0000, CAST(N'2016-02-05' AS Date), CAST(N'2016-02-05' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (19, 34, N'QP58872', CAST(N'2016-01-07' AS Date), 116.5400, 116.5400, 0.0000, 1.0000, CAST(N'2016-01-17' AS Date), CAST(N'2016-01-19' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (20, 115, N'24863706', CAST(N'2016-01-10' AS Date), 6.0000, 6.0000, 0.0000, 4.0000, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-15' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (21, 119, N'10843', CAST(N'2016-01-11' AS Date), 4901.2600, 4901.2600, 0.0000, 2.0000, CAST(N'2016-01-31' AS Date), CAST(N'2016-01-29' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (22, 123, N'963253235', CAST(N'2016-01-11' AS Date), 108.2500, 108.2500, 0.0000, 3.0000, CAST(N'2016-02-10' AS Date), CAST(N'2016-02-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (23, 97, N'21-4923721', CAST(N'2016-01-13' AS Date), 9.9500, 9.9500, 0.0000, 2.0000, CAST(N'2016-02-02' AS Date), CAST(N'2016-01-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (24, 113, N'77290', CAST(N'2016-01-13' AS Date), 1750.0000, 1750.0000, 0.0000, 5.0000, CAST(N'2016-03-02' AS Date), CAST(N'2016-03-05' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (25, 123, N'963253246', CAST(N'2016-01-13' AS Date), 129.0000, 129.0000, 0.0000, 3.0000, CAST(N'2016-02-12' AS Date), CAST(N'2016-02-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (26, 123, N'4-342-8069', CAST(N'2016-01-14' AS Date), 10.0000, 10.0000, 0.0000, 3.0000, CAST(N'2016-02-13' AS Date), CAST(N'2016-02-13' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (27, 88, N'972110', CAST(N'2016-01-15' AS Date), 207.7800, 207.7800, 0.0000, 1.0000, CAST(N'2016-01-25' AS Date), CAST(N'2016-01-27' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (28, 123, N'963253263', CAST(N'2016-01-16' AS Date), 109.5000, 109.5000, 0.0000, 3.0000, CAST(N'2016-02-15' AS Date), CAST(N'2016-02-10' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (29, 108, N'121897', CAST(N'2016-01-19' AS Date), 450.0000, 450.0000, 0.0000, 4.0000, CAST(N'2016-02-28' AS Date), CAST(N'2016-03-03' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (30, 123, N'1-200-5164', CAST(N'2016-01-20' AS Date), 63.4000, 63.4000, 0.0000, 3.0000, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (31, 104, N'P02-3772', CAST(N'2016-01-21' AS Date), 7125.3400, 7125.3400, 0.0000, 3.0000, CAST(N'2016-02-20' AS Date), CAST(N'2016-02-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (32, 121, N'97/486', CAST(N'2016-01-21' AS Date), 953.1000, 953.1000, 0.0000, 3.0000, CAST(N'2016-02-20' AS Date), CAST(N'2016-02-22' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (33, 105, N'94007005', CAST(N'2016-01-23' AS Date), 220.0000, 220.0000, 0.0000, 3.0000, CAST(N'2016-02-22' AS Date), CAST(N'2016-02-26' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (34, 123, N'963253232', CAST(N'2016-01-23' AS Date), 127.7500, 127.7500, 0.0000, 3.0000, CAST(N'2016-02-22' AS Date), CAST(N'2016-02-18' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (35, 107, N'RTR-72-3662-X', CAST(N'2016-01-25' AS Date), 1600.0000, 1600.0000, 0.0000, 4.0000, CAST(N'2016-03-04' AS Date), CAST(N'2016-03-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (36, 121, N'97/465', CAST(N'2016-01-25' AS Date), 565.1500, 565.1500, 0.0000, 3.0000, CAST(N'2016-02-24' AS Date), CAST(N'2016-02-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (37, 123, N'963253260', CAST(N'2016-01-25' AS Date), 36.0000, 36.0000, 0.0000, 3.0000, CAST(N'2016-02-24' AS Date), CAST(N'2016-02-26' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (38, 123, N'963253272', CAST(N'2016-01-26' AS Date), 61.5000, 61.5000, 0.0000, 3.0000, CAST(N'2016-02-25' AS Date), CAST(N'2016-02-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (39, 110, N'0-2058', CAST(N'2016-01-28' AS Date), 37966.1900, 37966.1900, 0.0000, 3.0000, CAST(N'2016-02-27' AS Date), CAST(N'2016-02-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (40, 121, N'97/503', CAST(N'2016-01-30' AS Date), 639.7700, 639.7700, 0.0000, 3.0000, CAST(N'2016-02-28' AS Date), CAST(N'2016-02-25' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (41, 123, N'963253255', CAST(N'2016-01-31' AS Date), 53.7500, 53.7500, 0.0000, 3.0000, CAST(N'2016-02-28' AS Date), CAST(N'2016-02-27' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (42, 123, N'94007069', CAST(N'2016-01-31' AS Date), 400.0000, 400.0000, 0.0000, 3.0000, CAST(N'2016-02-28' AS Date), CAST(N'2016-03-01' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (43, 72, N'40318', CAST(N'2016-02-01' AS Date), 21842.0000, 21842.0000, 0.0000, 3.0000, CAST(N'2016-03-01' AS Date), CAST(N'2016-02-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (44, 95, N'111-92R-10094', CAST(N'2016-02-01' AS Date), 19.6700, 19.6700, 0.0000, 2.0000, CAST(N'2016-02-21' AS Date), CAST(N'2016-02-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (45, 122, N'989319-437', CAST(N'2016-02-01' AS Date), 2765.3600, 2765.3600, 0.0000, 3.0000, CAST(N'2016-03-01' AS Date), CAST(N'2016-02-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (46, 37, N'547481328', CAST(N'2016-02-03' AS Date), 224.0000, 224.0000, 0.0000, 3.0000, CAST(N'2016-03-03' AS Date), CAST(N'2016-03-04' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (47, 83, N'31359783', CAST(N'2016-02-03' AS Date), 1575.0000, 1575.0000, 0.0000, 2.0000, CAST(N'2016-02-23' AS Date), CAST(N'2016-02-21' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (48, 123, N'1-202-2978', CAST(N'2016-02-03' AS Date), 33.0000, 33.0000, 0.0000, 3.0000, CAST(N'2016-03-03' AS Date), CAST(N'2016-03-05' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (49, 95, N'111-92R-10097', CAST(N'2016-02-04' AS Date), 16.3300, 16.3300, 0.0000, 2.0000, CAST(N'2016-02-24' AS Date), CAST(N'2016-02-26' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (50, 37, N'547479217', CAST(N'2016-02-07' AS Date), 116.0000, 116.0000, 0.0000, 3.0000, CAST(N'2016-03-07' AS Date), CAST(N'2016-03-07' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (51, 122, N'989319-477', CAST(N'2016-02-08' AS Date), 2184.1100, 2184.1100, 0.0000, 3.0000, CAST(N'2016-03-08' AS Date), CAST(N'2016-03-08' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (52, 34, N'Q545443', CAST(N'2016-02-09' AS Date), 1083.5800, 1083.5800, 0.0000, 1.0000, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-23' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (53, 95, N'111-92R-10092', CAST(N'2016-02-09' AS Date), 46.2100, 46.2100, 0.0000, 2.0000, CAST(N'2016-02-28' AS Date), CAST(N'2016-03-02' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (54, 121, N'97/553B', CAST(N'2016-02-10' AS Date), 313.5500, 313.5500, 0.0000, 3.0000, CAST(N'2016-03-10' AS Date), CAST(N'2016-03-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (55, 123, N'963253245', CAST(N'2016-02-10' AS Date), 40.7500, 40.7500, 0.0000, 3.0000, CAST(N'2016-03-10' AS Date), CAST(N'2016-03-12' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (56, 86, N'367447', CAST(N'2016-02-11' AS Date), 2433.0000, 2433.0000, 0.0000, 1.0000, CAST(N'2016-02-21' AS Date), CAST(N'2016-02-17' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (57, 103, N'75C-90227', CAST(N'2016-02-11' AS Date), 1367.5000, 1367.5000, 0.0000, 5.0000, CAST(N'2016-03-31' AS Date), CAST(N'2016-03-31' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (58, 123, N'963253256', CAST(N'2016-02-11' AS Date), 53.2500, 53.2500, 0.0000, 3.0000, CAST(N'2016-03-11' AS Date), CAST(N'2016-03-07' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (59, 123, N'4-314-3057', CAST(N'2016-02-11' AS Date), 13.7500, 13.7500, 0.0000, 3.0000, CAST(N'2016-03-11' AS Date), CAST(N'2016-03-15' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (60, 122, N'989319-497', CAST(N'2016-02-12' AS Date), 2312.2000, 2312.2000, 0.0000, 3.0000, CAST(N'2016-03-12' AS Date), CAST(N'2016-03-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (61, 115, N'24946731', CAST(N'2016-02-15' AS Date), 25.6700, 25.6700, 0.0000, 4.0000, CAST(N'2016-03-25' AS Date), CAST(N'2016-03-26' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (62, 123, N'963253269', CAST(N'2016-02-15' AS Date), 26.7500, 26.7500, 0.0000, 3.0000, CAST(N'2016-03-15' AS Date), CAST(N'2016-03-11' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (63, 122, N'989319-427', CAST(N'2016-02-16' AS Date), 2115.8100, 2115.8100, 0.0000, 3.0000, CAST(N'2016-03-16' AS Date), CAST(N'2016-03-19' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (64, 123, N'963253267', CAST(N'2016-02-17' AS Date), 23.5000, 23.5000, 0.0000, 3.0000, CAST(N'2016-03-17' AS Date), CAST(N'2016-03-19' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (65, 99, N'509786', CAST(N'2016-02-18' AS Date), 6940.2500, 6940.2500, 0.0000, 3.0000, CAST(N'2016-03-18' AS Date), CAST(N'2016-03-15' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (66, 123, N'263253253', CAST(N'2016-02-18' AS Date), 31.9500, 31.9500, 0.0000, 3.0000, CAST(N'2016-03-18' AS Date), CAST(N'2016-03-21' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (67, 122, N'989319-487', CAST(N'2016-02-20' AS Date), 1927.5400, 1927.5400, 0.0000, 3.0000, CAST(N'2016-03-20' AS Date), CAST(N'2016-03-18' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (68, 81, N'MABO1489', CAST(N'2016-02-21' AS Date), 936.9300, 936.9300, 0.0000, 2.0000, CAST(N'2016-03-11' AS Date), CAST(N'2016-03-10' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (69, 80, N'133560', CAST(N'2016-02-22' AS Date), 175.0000, 175.0000, 0.0000, 2.0000, CAST(N'2016-03-12' AS Date), CAST(N'2016-03-16' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (70, 115, N'24780512', CAST(N'2016-02-22' AS Date), 6.0000, 6.0000, 0.0000, 4.0000, CAST(N'2016-04-01' AS Date), CAST(N'2016-03-29' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (71, 123, N'963253254', CAST(N'2016-02-22' AS Date), 108.5000, 108.5000, 0.0000, 3.0000, CAST(N'2016-03-22' AS Date), CAST(N'2016-03-20' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (72, 123, N'43966316', CAST(N'2016-02-22' AS Date), 10.0000, 10.0000, 0.0000, 3.0000, CAST(N'2016-03-22' AS Date), CAST(N'2016-03-17' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (73, 114, N'CBM9920-M-T77109', CAST(N'2016-02-23' AS Date), 290.0000, 290.0000, 0.0000, 1.0000, CAST(N'2016-03-03' AS Date), CAST(N'2016-02-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (74, 102, N'109596', CAST(N'2016-02-24' AS Date), 41.8000, 41.8000, 0.0000, 4.0000, CAST(N'2016-04-03' AS Date), CAST(N'2016-04-04' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (75, 123, N'7548906-20', CAST(N'2016-02-24' AS Date), 27.0000, 27.0000, 0.0000, 3.0000, CAST(N'2016-03-24' AS Date), CAST(N'2016-03-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (76, 123, N'963253248', CAST(N'2016-02-24' AS Date), 241.0000, 241.0000, 0.0000, 3.0000, CAST(N'2016-03-24' AS Date), CAST(N'2016-03-25' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (77, 121, N'97/553', CAST(N'2016-02-25' AS Date), 904.1400, 904.1400, 0.0000, 3.0000, CAST(N'2016-03-25' AS Date), CAST(N'2016-03-25' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (78, 121, N'97/522', CAST(N'2016-02-28' AS Date), 1962.1300, 1762.1300, 200.0000, 3.0000, CAST(N'2016-03-28' AS Date), CAST(N'2016-03-30' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (79, 100, N'587056', CAST(N'2016-02-28' AS Date), 2184.5000, 2184.5000, 0.0000, 4.0000, CAST(N'2016-04-09' AS Date), CAST(N'2016-04-07' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (80, 122, N'989319-467', CAST(N'2016-03-01' AS Date), 2318.0300, 2318.0300, 0.0000, 3.0000, CAST(N'2016-03-31' AS Date), CAST(N'2016-03-29' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (81, 123, N'263253265', CAST(N'2016-03-02' AS Date), 26.2500, 26.2500, 0.0000, 3.0000, CAST(N'2016-04-01' AS Date), CAST(N'2016-03-28' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (82, 94, N'203339-13', CAST(N'2016-03-05' AS Date), 17.5000, 17.5000, 0.0000, 2.0000, CAST(N'2016-03-25' AS Date), CAST(N'2016-03-27' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (83, 95, N'111-92R-10093', CAST(N'2016-03-06' AS Date), 39.7700, 39.7700, 0.0000, 2.0000, CAST(N'2016-03-26' AS Date), CAST(N'2016-03-22' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (84, 123, N'963253258', CAST(N'2016-03-06' AS Date), 111.0000, 111.0000, 0.0000, 3.0000, CAST(N'2016-04-05' AS Date), CAST(N'2016-04-05' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (85, 123, N'963253271', CAST(N'2016-03-07' AS Date), 158.0000, 158.0000, 0.0000, 3.0000, CAST(N'2016-04-06' AS Date), CAST(N'2016-04-11' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (86, 123, N'963253230', CAST(N'2016-03-07' AS Date), 739.2000, 739.2000, 0.0000, 3.0000, CAST(N'2016-04-06' AS Date), CAST(N'2016-04-06' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (87, 123, N'963253244', CAST(N'2016-03-08' AS Date), 60.0000, 60.0000, 0.0000, 3.0000, CAST(N'2016-04-07' AS Date), CAST(N'2016-04-09' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (88, 123, N'963253239', CAST(N'2016-03-08' AS Date), 147.2500, 147.2500, 0.0000, 3.0000, CAST(N'2016-04-07' AS Date), CAST(N'2016-04-11' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (89, 72, N'39104', CAST(N'2016-03-10' AS Date), 85.3100, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-09' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (90, 123, N'963253252', CAST(N'2016-03-12' AS Date), 38.7500, 38.7500, 0.0000, 3.0000, CAST(N'2016-04-11' AS Date), CAST(N'2016-04-11' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (91, 95, N'111-92R-10095', CAST(N'2016-03-15' AS Date), 32.7000, 32.7000, 0.0000, 2.0000, CAST(N'2016-04-04' AS Date), CAST(N'2016-04-06' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (92, 117, N'111897', CAST(N'2016-03-15' AS Date), 16.6200, 16.6200, 0.0000, 3.0000, CAST(N'2016-04-14' AS Date), CAST(N'2016-04-14' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (93, 123, N'4-327-7357', CAST(N'2016-03-16' AS Date), 162.7500, 162.7500, 0.0000, 3.0000, CAST(N'2016-04-15' AS Date), CAST(N'2016-04-11' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (94, 123, N'963253264', CAST(N'2016-03-18' AS Date), 52.2500, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-17' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (95, 82, N'C73-24', CAST(N'2016-03-19' AS Date), 600.0000, 600.0000, 0.0000, 2.0000, CAST(N'2016-04-08' AS Date), CAST(N'2016-04-13' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (96, 110, N'P-0259', CAST(N'2016-03-19' AS Date), 26881.4000, 26881.4000, 0.0000, 3.0000, CAST(N'2016-04-18' AS Date), CAST(N'2016-04-20' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (97, 90, N'97-1024A', CAST(N'2016-03-20' AS Date), 356.4800, 356.4800, 0.0000, 2.0000, CAST(N'2016-04-09' AS Date), CAST(N'2016-04-07' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (98, 83, N'31361833', CAST(N'2016-03-21' AS Date), 579.4200, 0.0000, 0.0000, 2.0000, CAST(N'2016-04-10' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (99, 123, N'263253268', CAST(N'2016-03-21' AS Date), 59.9700, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-20' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (100, 123, N'263253270', CAST(N'2016-03-22' AS Date), 67.9200, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-21' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (101, 123, N'263253273', CAST(N'2016-03-22' AS Date), 30.7500, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-21' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (102, 110, N'P-0608', CAST(N'2016-03-23' AS Date), 20551.1800, 0.0000, 1200.0000, 3.0000, CAST(N'2016-04-22' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (103, 122, N'989319-417', CAST(N'2016-03-23' AS Date), 2051.5900, 2051.5900, 0.0000, 3.0000, CAST(N'2016-04-22' AS Date), CAST(N'2016-04-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (104, 123, N'263253243', CAST(N'2016-03-23' AS Date), 44.4400, 44.4400, 0.0000, 3.0000, CAST(N'2016-04-22' AS Date), CAST(N'2016-04-24' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (105, 106, N'9982771', CAST(N'2016-03-24' AS Date), 503.2000, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-23' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (106, 110, N'0-2060', CAST(N'2016-03-24' AS Date), 23517.5800, 21221.6300, 2295.9500, 3.0000, CAST(N'2016-04-23' AS Date), CAST(N'2016-04-27' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (107, 122, N'989319-447', CAST(N'2016-03-24' AS Date), 3689.9900, 3689.9900, 0.0000, 3.0000, CAST(N'2016-04-23' AS Date), CAST(N'2016-04-19' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (108, 123, N'963253240', CAST(N'2016-03-24' AS Date), 67.0000, 67.0000, 0.0000, 3.0000, CAST(N'2016-04-23' AS Date), CAST(N'2016-04-23' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (109, 121, N'97/222', CAST(N'2016-03-25' AS Date), 1000.4600, 1000.4600, 0.0000, 3.0000, CAST(N'2016-04-24' AS Date), CAST(N'2016-04-22' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (110, 80, N'134116', CAST(N'2016-03-28' AS Date), 90.3600, 0.0000, 0.0000, 2.0000, CAST(N'2016-04-17' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (111, 123, N'263253257', CAST(N'2016-03-30' AS Date), 22.5700, 22.5700, 0.0000, 3.0000, CAST(N'2016-04-29' AS Date), CAST(N'2016-05-03' AS Date))
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (112, 110, N'0-2436', CAST(N'2016-03-31' AS Date), 10976.0600, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-30' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (113, 37, N'547480102', CAST(N'2016-04-01' AS Date), 224.0000, 0.0000, 0.0000, 3.0000, CAST(N'2016-04-30' AS Date), NULL)
GO
INSERT [dbo].[Table1] ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]) VALUES (114, 123, N'963253249', CAST(N'2016-04-02' AS Date), 127.7500, 127.7500, 0.0000, 3.0000, CAST(N'2016-05-01' AS Date), CAST(N'2016-05-04' AS Date))
GO
ALTER TABLE [dbo].[InvoiceMaster] ADD  CONSTRAINT [DF_InvoiceMaster_InvoiceDate]  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[InvoiceMaster] ADD  CONSTRAINT [DF_InvoiceMaster_CustomerName]  DEFAULT ('n/a') FOR [CustomerName]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetails_InvoiceMaster] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[InvoiceMaster] ([InvoiceId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_InvoiceMaster]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetInvoices]    Script Date: 3/30/2024 2:10:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[SP_GetInvoices]

@invoiceId int = 0 
as 
select *
from InvoiceMaster
where InvoiceId = @invoiceId or @invoiceId = 0

select *
from InvoiceDetails
where InvoiceId = @invoiceId 
GO
USE [master]
GO
ALTER DATABASE [SampleStore] SET  READ_WRITE 
GO

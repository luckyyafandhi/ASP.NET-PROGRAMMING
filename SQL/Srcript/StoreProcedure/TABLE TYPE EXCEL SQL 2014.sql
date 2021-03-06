/****** Object:  UserDefinedTableType [dbo].[DataFromExcel]    Script Date: 23/10/2020 09:35:45 ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'DataFromExcel' AND ss.name = N'dbo')
DROP TYPE [dbo].[DataFromExcel]
GO
/****** Object:  UserDefinedTableType [dbo].[DataFromExcel]    Script Date: 23/10/2020 09:35:45 ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'DataFromExcel' AND ss.name = N'dbo')
CREATE TYPE [dbo].[DataFromExcel] AS TABLE(
	[Insurance] [nvarchar](max) NULL,
	[Workshop] [nvarchar](max) NULL,
	[Policy_No] [nvarchar](max) NULL,
	[Date_Of_Loss] [nvarchar](max) NULL,
	[Plat_No] [nvarchar](max) NULL,
	[Vehicle_Type] [nvarchar](max) NULL,
	[Chassis_No] [nvarchar](max) NULL,
	[Engine_No] [nvarchar](max) NULL,
	[Tanggal_Masuk_Bengkel] [nvarchar](max) NULL,
	[Repairer_Estimate] [nvarchar](max) NULL,
	[Amoun_Approved] [nvarchar](max) NULL,
	[Tanggal_Selesai_Perbaikan] [nvarchar](max) NULL,
	[Status_Perbaikan] [nvarchar](max) NULL
)
GO

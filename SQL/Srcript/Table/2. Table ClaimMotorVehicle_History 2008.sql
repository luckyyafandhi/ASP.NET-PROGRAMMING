/****** Object:  Table [dbo].[ClaimMotorVehicle_History]    Script Date: 03/11/2020 09:58:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimMotorVehicle_History]') AND type in (N'U'))
DROP TABLE [dbo].[ClaimMotorVehicle_History]
GO
/****** Object:  Table [dbo].[ClaimMotorVehicle_History]    Script Date: 03/11/2020 09:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ClaimMotorVehicle_History]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ClaimMotorVehicle_History](
	[Pid] [bigint] NOT NULL,
	[CdateTime] [datetime] NULL CONSTRAINT [DF_ClaimMotorVehicle_History_CdateTime]  DEFAULT (getdate()),
	[InsuranceCode] [varchar](10) NULL,
	[InsuranceName] [varchar](200) NULL,
	[Workshop] [varchar](200) NULL,
	[PolID] [int] NULL,
	[PolMainID] [int] NULL,
	[PolicyNo] [varchar](100) NULL,
	[DateOfLoss] [date] NULL,
	[PoliceNumber] [varchar](10) NULL,
	[VehicleModel] [varchar](200) NULL,
	[ChasisNumber] [varchar](150) NULL,
	[EngineNumber] [varchar](150) NULL,
	[WorkshopEntryDate] [date] NULL,
	[RepairerEstimate] [date] NULL,
	[AmountApproved] [float] NULL,
	[FinishDate] [date] NULL,
	[RepairingStatus] [varchar](200) NULL,
	[CreateBy] [varchar](150) NULL,
	[Type_Input] [varchar](150) NULL,
 CONSTRAINT [PK_ClaimMotorVehicle_History_1] PRIMARY KEY CLUSTERED 
(
	[Pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO

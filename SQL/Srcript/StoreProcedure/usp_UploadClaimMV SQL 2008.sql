USE [IndosuranceApp_back]
GO
/****** Object:  StoredProcedure [dbo].[usp_UploadClaimMV]    Script Date: 17/11/2020 08:28:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lucky Ya Fandhi>
-- Create date: <20-10-2020>
-- Description:	<Upload For ClaimMotorV>
-- =============================================
ALTER PROCEDURE [dbo].[usp_UploadClaimMV]		
	@DataExcel DataFromExcel READONLY,
	@session [varchar](100),
	@Type_Input [varchar](100)
AS
BEGIN

	SET NOCOUNT ON;
	
/*-----------------------------------------GENERATE TRANSACTION NUMBER------------------------------------------------*/
	DECLARE	@TransactionNumber [nvarchar](max) = (SELECT MAX(SUBSTRING(TransactionNumber,21,5)) from ClaimMotorVehicle );
	DECLARE @DateTransactionNew [nvarchar](max) = SUBSTRING(convert(varchar,getdate(),111),1,7)
	DECLARE @DateTransactionOld [nvarchar](max) = (SELECT DISTINCT SUBSTRING(TransactionNumber,13,7) from ClaimMotorVehicle WHERE SUBSTRING(TransactionNumber,21,5) = Convert(int,@TransactionNumber))
	DECLARE	@LastTransactionNumber [int] = 0;
	DECLARE @LastTransactionNumberNew [nvarchar](max) = ''
	DECLARE @TransactionNumberFull [nvarchar](max) = ''
	DECLARE @ConvertParamTransaction [int] = CONVERT(int,@TransactionNumber)
	
		IF NULLIF(@TransactionNumber , '') IS NULL
		BEGIN
			SET @TransactionNumber = 0;
			SET @LastTransactionNumber = @ConvertParamTransaction + 1;
			SET @TransactionNumberFull = 'ClaimApp-MV' + SUBSTRING(convert(varchar,getdate(),111),1,7) + '-' + @LastTransactionNumber
		END
		ELSE
		BEGIN
			SET @LastTransactionNumber = Convert(int,@TransactionNumber) + 1;
			IF (@DateTransactionNew = @DateTransactionOld)
			BEGIN
				IF (@LastTransactionNumber < 10)
				BEGIN
					SET @LastTransactionNumberNew = '0000' + Convert(varchar,@LastTransactionNumber)
					SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransactionNew + '-' + @LastTransactionNumberNew
					
				END
				IF (@LastTransactionNumber > 10)
				BEGIN
					SET @LastTransactionNumberNew = '000' + Convert(varchar,@LastTransactionNumber)
					SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransactionNew + '-' + @LastTransactionNumberNew
				END
				IF (@LastTransactionNumber > 100)
				BEGIN
					SET @LastTransactionNumberNew = '00' + Convert(varchar,@LastTransactionNumber)
					SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransactionNew + '-' + @LastTransactionNumberNew
				END
				IF(@LastTransactionNumber > 1000)
				BEGIN
					SET @LastTransactionNumberNew = '0' + Convert(varchar,@LastTransactionNumber)
					SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransactionNew + '-' + @LastTransactionNumberNew
				END
				IF(@LastTransactionNumber > 10000)
				BEGIN
					SET @LastTransactionNumberNew = '0' + Convert(varchar,@LastTransactionNumber)
					SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransactionNew + '-' + @LastTransactionNumberNew
				END
			END
			ELSE
			BEGIN
				SET @TransactionNumber = 0
				SET @LastTransactionNumber = @TransactionNumber + 1
				SET @LastTransactionNumberNew = '0000' + Convert(varchar,@LastTransactionNumber)
				SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransactionNew + '-' + @LastTransactionNumberNew
				
			END
			
		END
/*-----------------------------------------GENERATE TRANSACTION NUMBER------------------------------------------------*/
/*-----------------------------------------CREATE DATA TABLE TEMP FROM Excel ------------------------------------------------*/
		IF OBJECT_ID('tempdb..#DATA_EXCEL') IS NOT NULL 
		BEGIN 
			DROP TABLE #DATA_EXCEL
		END
		IF OBJECT_ID('tempdb..#DATA_QUERY') IS NOT NULL 
		BEGIN 
			DROP TABLE #DATA_QUERY
		END
	CREATE TABLE #DATA_QUERY
			(
			[ID] [INT] IDENTITY(1,1) NOT NULL,
			[POLID_A][int] NULL,
			[POLICY_NO][varchar](max) NULL,
			[POLMAINID][int] NULL,
			[POLID_B][int] NULL,
			[CLIENT_TYPE][nvarchar](max) NULL,
			[CHASSIS_NO][nvarchar](max) NULL,
			[ENGINE_NO][nvarchar](max) NULL,
			[TYPE][nvarchar](max) NULL,
			[NAME][nvarchar](max) NULL,
			)

	CREATE TABLE #DATA_EXCEL
	(
			[ID] [INT] IDENTITY(1,1) NOT NULL,
			[Insurance] [nvarchar](max) NULL,
			[Workshop] [nvarchar](max) NULL,
			[Policy_No] [nvarchar](max) NULL,
			[Date_Of_Loss] [date] NULL,
			[Plat_No] [nvarchar](max) NULL,
			[Vehicle_Type] [nvarchar](max) NULL,
			[Chassis_No] [nvarchar](max) NULL,
			[Engine_No] [nvarchar](max) NULL,
			[Tanggal_Masuk_Bengkel] [date] NULL,
			[Repairer_Estimate] [date] NULL,
			[Amoun_Approved] [nvarchar](max) NULL,
			[Tanggal_Selesai_Perbaikan] [date] NULL,
			[Status_Perbaikan] [nvarchar](max) NULL
	)

	INSERT INTO #DATA_EXCEL
	(
			
			[Insurance] ,
			[Workshop] ,
			[Policy_No] ,
			[Date_Of_Loss] ,
			[Plat_No] ,
			[Vehicle_Type] ,
			[Chassis_No] ,
			[Engine_No] ,
			[Tanggal_Masuk_Bengkel] ,
			[Repairer_Estimate] ,
			[Amoun_Approved] ,
			[Tanggal_Selesai_Perbaikan] ,
			[Status_Perbaikan] 
	) 
	select  
			SUBSTRING(Insurance,4,100),
			Workshop,
			Policy_No,
			Convert(datetime, Date_Of_Loss,105),
			
			Plat_No,
			Vehicle_Type,
			Chassis_No,
			Engine_No,
			Convert(datetime, Tanggal_Masuk_Bengkel,105),
			Convert(datetime,Repairer_Estimate,105),
			--Repairer_Estimate,
			SUBSTRING(Amoun_Approved,3,20),
			Convert(datetime, Tanggal_Selesai_Perbaikan,105),
			
			Status_Perbaikan
			from @DataExcel

/*-----------------------------------------CREATE DATA TABLE TEMP FROM Excel ------------------------------------------------*/	


/*-----------------------------------------CREATE LOOPING FOR VALIDATE ------------------------------------------------*/	
DECLARE @MaxDataExcel int = (Select Count(ID) from #DATA_EXCEL),
		@LoopCounter int = 1;

		WHILE (@LoopCounter <= @MaxDataExcel)
		BEGIN
			
			DECLARE @Policy_No [nvarchar](max) = (Select DISTINCT REPLACE(REPLACE(Policy_No, CHAR(13),''), CHAR(10),'') From #DATA_EXCEL Where ID = @LoopCounter),
			@Chassis_No [nvarchar](max) = (Select DISTINCT REPLACE(REPLACE(Chassis_No, CHAR(13),''), CHAR(10),'') From #DATA_EXCEL Where ID = @LoopCounter),
			@Engine_No [nvarchar](max) = (Select DISTINCT REPLACE(REPLACE(Engine_No, CHAR(13),''), CHAR(10),'') From #DATA_EXCEL Where ID = @LoopCounter),
			@Insurance [nvarchar](max) = (Select DISTINCT REPLACE(REPLACE(Insurance, CHAR(13),''), CHAR(10),'') from #DATA_EXCEL Where ID = @LoopCounter),
			@Workshop [nvarchar](max) = (Select DISTINCT Workshop from #DATA_EXCEL Where ID = @LoopCounter),
			@DateOfLoss [date] = (Select DISTINCT Date_Of_Loss from #DATA_EXCEL Where ID = @LoopCounter),
			@Vehicle_Type [nvarchar](max) = (Select DISTINCT Vehicle_Type from #DATA_EXCEL Where ID = @LoopCounter),
			@Tanggal_Masuk_Bengkel [date] = (Select DISTINCT Tanggal_Masuk_Bengkel from #DATA_EXCEL Where ID = @LoopCounter),
			@Repairer_Estimate [date] = (Select DISTINCT Repairer_Estimate from #DATA_EXCEL Where ID = @LoopCounter),
			@Amoun_Approved [float] = (Select DISTINCT CONVERT(float,REPLACE(Amoun_Approved,',','') )Amoun_Approved  from #DATA_EXCEL Where ID = @LoopCounter),
			@Tanggal_Selesai_Perbaikan [date] = (Select DISTINCT Tanggal_Selesai_Perbaikan from #DATA_EXCEL Where ID = @LoopCounter),
			@Status_Perbaikan [nvarchar](max) = (Select DISTINCT Status_Perbaikan from #DATA_EXCEL Where ID = @LoopCounter),
			@Plat_No [nvarchar](max) = (Select DISTINCT Plat_No from #DATA_EXCEL Where ID = @LoopCounter)
/*-----------------------------------------CHECK DATA BENGKEL ------------------------------------------------*/	
			DECLARE @NameBengkel [int] = (Select DISTINCT Count(Name) From Master_Bengkel Where Name = @Workshop)
			IF (@NameBengkel < 1)
			BEGIN
				INSERT INTO Master_Bengkel (Name,Alamat,NoTelp,Status,CreateBy) Values(@Workshop,'-','-','True','System')
							
			END
/*-----------------------------------------CHECK DATA BENGKEL ------------------------------------------------*/	


			INSERT INTO ClaimMotorVehicle_History (CdateTime,InsuranceCode,InsuranceName,Workshop,PolID,PolMainID,PolicyNo,DateOfLoss,PoliceNumber,VehicleModel,ChasisNumber,EngineNumber,WorkshopEntryDate,RepairerEstimate,AmountApproved,FinishDate,RepairingStatus,CreateBy,Type_Input,TransactionNumber)
			SELECT CdateTime,InsuranceCode,InsuranceName,Workshop,PolID,PolMainID,PolicyNo,DateOfLoss,PoliceNumber,VehicleModel,ChasisNumber,EngineNumber,WorkshopEntryDate,RepairerEstimate,AmountApproved,FinishDate,RepairingStatus,CreateBy,Type_Input,TransactionNumber FROM ClaimMotorVehicle
			WHERE PolicyNo = @Policy_No AND ChasisNumber = @Chassis_No AND DateOfLoss = Convert(datetime,@DateOfLoss,103) AND EngineNumber = @Engine_No
			AND Type_Input = 'Upload Input'
			DELETE FROM ClaimMotorVehicle
			WHERE PolicyNo = @Policy_No AND ChasisNumber = @Chassis_No AND DateOfLoss = Convert(datetime,@DateOfLoss,103) AND EngineNumber = @Engine_No
			AND Type_Input = 'Upload Input'
			
			INSERT INTO #DATA_QUERY
			
			SELECT DISTINCT A.PolID AS POLID_A,
				   A.PolNo AS POLICY_NO,
				   A.PolMainID AS POLMAINID,
				   B.PolID AS POLID_B,
				   C.ClientType AS CLIENT_TYPE,
				   B.ChassisNo AS CHASSIS_NO,
				   B.EngineNo AS ENGINE_NO,
				   C.Type,
				   C.Name
			FROM IBOS.indoins_back.dbo.POLMain A
			LEFT OUTER JOIN IBOS.indoins_back.dbo.POLDetail_3 B ON A.PolID = B.PolID
			LEFT OUTER JOIN IBOS.indoins_back.dbo.MSTClient C ON B.CompanyID = C.CompanyID
			WHERE A.PolNo = @Policy_No
			AND B.ChassisNo = @Chassis_No 
			AND B.EngineNo = @Engine_No  
			AND C.Name = @Insurance
			AND C.ClientType = 'U'
			
			DECLARE @MaxDataQuery int = (Select Count(ID) FROM #DATA_QUERY),
					@LoopingQuery int = 1

				WHILE (@LoopingQuery <= @MaxDataQuery)
				BEGIN
					DECLARE @POLICYQUERY [nvarchar](max) = (Select DISTINCT REPLACE(REPLACE(POLICY_NO, CHAR(13),''), CHAR(10),'') FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@CHASSISQUERY [nvarchar](max) = (SELECT DISTINCT REPLACE(REPLACE(CHASSIS_NO, CHAR(13),''), CHAR(10),'') FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@ENGINEQUERY [nvarchar](max) = (SELECT DISTINCT REPLACE(REPLACE(ENGINE_NO, CHAR(13),' '), CHAR(10),'') FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@INSURANCEQUERY [nvarchar](max) = (SELECT DISTINCT REPLACE(REPLACE(NAME, CHAR(13),''), CHAR(10),'') FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@POLID_A [int] = (SELECT DISTINCT POLID_A FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@POLMAINID [int] = (SELECT DISTINCT POLMAINID FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@CLIENT_TYPE [nvarchar](max) = (SELECT DISTINCT CLIENT_TYPE FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@TYPE [nvarchar](max) = (SELECT DISTINCT TYPE FROM #DATA_QUERY WHERE ID = @LoopingQuery),
							@POLID_B [nvarchar](max) = (SELECT DISTINCT POLID_B FROM #DATA_QUERY WHERE ID = @LoopingQuery)

					DECLARE @InsuranceNameFull [nvarchar](max) = (Upper(@TYPE + @Insurance))
							IF(@Policy_No = @POLICYQUERY)
							BEGIN
								IF (@Chassis_No = @CHASSISQUERY)
								BEGIN
									IF(@Engine_No = @ENGINEQUERY)
									BEGIN
										IF(@Insurance = @INSURANCEQUERY)
										BEGIN
											
														INSERT INTO ClaimMotorVehicle 
														(
														InsuranceCode,
														InsuranceName,
														Workshop,
														PolID,
														PolMainID,
														PolicyNo,
														DateOfLoss,
														PoliceNumber,
														VehicleModel,
														ChasisNumber,
														EngineNumber,
														WorkshopEntryDate,
														RepairerEstimate,
														AmountApproved,
														FinishDate,
														RepairingStatus,
														CreateBy,
														Type_Input,
														TransactionNumber
														)
														VALUES
														(
														  @CLIENT_TYPE,
														  @InsuranceNameFull ,
														  @Workshop,
														  @POLID_A,
														  @POLMAINID,
														  @Policy_No,
														  @DateOfLoss,
														  @Plat_No,
														  @Vehicle_Type,
														  @Chassis_No,
														  @Engine_No,
														  @Tanggal_Masuk_Bengkel,
														  @Repairer_Estimate,
														  @Amoun_Approved,
														  @Tanggal_Selesai_Perbaikan,
														  @Status_Perbaikan,
														  @session,
														  @Type_Input,
														  @TransactionNumberFull
														)
										END
									END
								END
							END
					
					SET @LoopingQuery = @LoopingQuery + 1
				END
			SET @LoopCounter  = @LoopCounter  + 1 
			truncate table #DATA_QUERY
		END
/*-----------------------------------------CREATE LOOPING FOR VALIDATE ------------------------------------------------*/	
END

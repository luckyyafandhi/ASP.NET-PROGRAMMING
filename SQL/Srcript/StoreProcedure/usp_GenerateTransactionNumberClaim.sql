USE [IndosuranceApp_back]
GO
/****** Object:  StoredProcedure [dbo].[usp_UploadClaimMV]    Script Date: 17/11/2020 08:28:24 ******/
-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Lucky Ya Fandhi>
-- Create date: <17-11-2020>
-- Description:	<Auto Generate For Input Manual ClaimMV>
-- =============================================
ALTER PROCEDURE [dbo].[usp_GenerateTransactionNumberClaim]	

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
	--PRINT @DateTransactionNew = 2020/11
	--PRINT Convert(int,@TransactionNumber) 
	--PRINT @DateTransactionOld = 2020/11
	--PRINT @TransactionNumber = 00004
	--Print Convert(int,@TransactionNumber) + 1 = 5
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
					--PRINT @TransactionNumberFull 
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
				--PRINT @TransactionNumberFull
			END
			--SET @LastTransactionNumber = @ConvertParamTransaction + 1;
			--SET @TransactionNumberFull = 'ClaimApp-MV-' + @DateTransaction + '-' +  + Convert(nvarchar,@LastTransactionNumber)
			--Print @TransactionNumberFull 
		END
		
/*-----------------------------------------GENERATE TRANSACTION NUMBER------------------------------------------------*/
		IF OBJECT_ID('tempdb..#DATA_GENERATE') IS NOT NULL 
		BEGIN 
			DROP TABLE #DATA_GENERATE
		END
		CREATE TABLE #DATA_GENERATE
		(
		[TransactionNumber][varchar](max) NULL
		)
		INSERT INTO #DATA_GENERATE([TransactionNumber])
		VALUES (@TransactionNumberFull)

		
		select [TransactionNumber] from #DATA_GENERATE
		
END
GO

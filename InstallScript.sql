Exec sp_configure 'clr enabled', '1';
Go

--if required
alter database TRX set trustworthy on;
--ALTER AUTHORIZATION ON DATABASE::APXFirm TO sa

go

--Drop  assembly ExportSql
create assembly ExportSql
from 'C:\Dev\Utility\ExportSql.dll'
with permission_set = UNSAFE;

Go

--DROP  PROCEDURE [dbo].[Sql2Csv]
CREATE PROCEDURE [dbo].[Sql2Csv]
	@sql NVARCHAR (MAX), 
	@filePath NVARCHAR (MAX), 
	@fileName NVARCHAR (MAX), 
	@includeHeader INT, 
	@delimeter NVARCHAR (MAX), 	
	@UseQuoteIdentifier INT, 
	@overWriteExisting INT,
	@Encoding NVARCHAR(20)=''
AS EXTERNAL NAME [ExportSql].[ExportSql.StoredProcedures].[Sql2Csv]
GO

--TEST
Exec [Sql2Csv] 
	@sql = 'SELECT  1 as A, 2 as B',
	@filePath = 'C:\Temp',
	@fileName = 'Test.csv',
	@includeHeader = 1,
	@delimeter = ',',
	@UseQuoteIdentifier = 0,
	@overWriteExisting = 1,
	@Encoding = '' --Unicode, UTF-8
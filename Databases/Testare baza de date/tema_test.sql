use ChampionsLeague
go

select * from Tables

INSERT INTO Tables(Name) VALUES ('Antrenor')
INSERT INTO Tables(Name) VALUES ('Fotbalist')
INSERT INTO Tables(Name) VALUES ('Indicatie')

delete from tables

go
CREATE OR ALTER VIEW viewAntrenor AS 
	SELECT * FROM Antrenor 
	WHERE Varsta >= 50
GO

CREATE OR ALTER VIEW viewFotbalisti AS
	
	--Afiseaza fotbalistii care au primit indicatie
	
	SELECT f.Nume, f.Pozitie
	FROM Fotbalist f
	INNER JOIN Indicatie i on i.FotbalistID=f.FotbalistID
GO

CREATE OR ALTER VIEW viewNrIndicatii AS

	--numarul de indicatii dat de fiecare antrenor

	SELECT Antrenor.Nume, COUNT(Indicatie.AntrenorID) as n from Indicatie
	LEFT JOIN Antrenor on Indicatie.AntrenorID = Antrenor.AntrenorID
	Group by Nume;

GO

select * from Views
INSERT INTO Views(Name) VALUES ('viewAntrenor')
INSERT INTO Views(Name) VALUES ('viewFotbalisti')
INSERT INTO Views(Name) VALUES ('viewNrIndicatii')


select * from Tests

INSERT INTO Tests(Name) VALUES ('delete_insert_10')
INSERT INTO Tests(Name) VALUES ('delete_insert_100')
INSERT INTO Tests(Name) VALUES ('select_view')

delete from Tests



select * from TestTables

INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES ('1','3','10','1')
INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES ('1','2','10','2')
INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES ('1','1','10','3')
INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES ('2','3','100','1')
INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES ('2','2','100','2')
INSERT INTO TestTables(TestID,TableID,NoOfRows,Position) VALUES ('2','1','100','3')



select * from TestViews

INSERT INTO TestViews(TestID,ViewID) VALUES ('3','1')
INSERT INTO TestViews(TestID,ViewID) VALUES ('3','2')
INSERT INTO TestViews(TestID,ViewID) VALUES ('3','3')


go
CREATE OR ALTER PROCEDURE insert_to_Antrenor @numar_inregistrari INT AS
BEGIN
	DECLARE @n int
	DECLARE @t VARCHAR(50)
	DECLARE @t2 VARCHAR(50)
	SET @n=1
	
	WHILE @n<@numar_inregistrari
	--WHILE @numar_inregistrari > 0
	BEGIN
		SET @t = 'nume' + CONVERT (VARCHAR(50), @n)
		SET @t2 = 'rol' + CONVERT (VARCHAR(50), @n)
		INSERT INTO Antrenor(Nume,Varsta,Rol) VALUES (@t, @n+40, @t2)
		set @n=@n+1
	END

END
GO


CREATE OR ALTER PROCEDURE insert_to_Fotbalist @numar_inregistrari INT AS
BEGIN
	DECLARE @n int
	DECLARE @t VARCHAR(50)
	DECLARE @t2 VARCHAR(50)
	SET @n=1
	DECLARE @fk int
	DECLARE @fk1 int

	WHILE @n<@numar_inregistrari
	BEGIN
		SET @t = 'nume' + CONVERT (VARCHAR(50), @n)
		SET @t2 = 'pozitie' + CONVERT (VARCHAR(50), @n)
		SELECT TOP 1 @fk = EchipaID FROM Echipa ORDER BY NEWID()
		SELECT TOP 1 @fk1 = EchipamentID FROM Echipament ORDER BY NEWID()
		INSERT INTO Fotbalist(Nume,Varsta,Pozitie,EchipamentID,EchipaID) VALUES (@t, @n+20, @t2, @fk1 , @fk)
		set @n=@n+1
	END

END
GO



CREATE OR ALTER PROCEDURE insert_to_Indicatie @numar_inregistrari INT AS
BEGIN

	INSERT INTO Indicatie(FotbalistID, AntrenorID)
	SELECT TOP (@numar_inregistrari) Fotbalist.FotbalistID, Antrenor.AntrenorID FROM Fotbalist CROSS JOIN Antrenor

END
GO


/*SELECT Pid, Cid
INTO ShopsTeas
FROM Shops CROSS JOIN Teas*/ 


CREATE OR ALTER PROCEDURE execute_view_viewAntrenor AS
BEGIN
	SELECT * FROM viewAntrenor
END
GO

CREATE OR ALTER PROCEDURE execute_view_viewFotbalisti AS
BEGIN
	SELECT * FROM viewFotbalisti
END
GO

CREATE OR ALTER PROCEDURE execute_view_viewNrIndicatii AS
BEGIN
	SELECT * FROM viewNrIndicatii
END
GO
-----------------------------


CREATE OR ALTER PROCEDURE test1 @NumeTest varchar(50) AS
	BEGIN
		DECLARE @NumeTabel VARCHAR(50)
		DECLARE @TestID INT
		DECLARE @NumeProcedura VARCHAR(50)
		DECLARE @NrInregistrari INT
		DECLARE @TabelID INT
		DECLARE @IncepTest DATETIME
		DECLARE @TerminTest DATETIME


		IF NOT EXISTS(SELECT TOP 1 TestID FROM Tests WHERE Name = @NumeTest)
		BEGIN
			RAISERROR('Nu exista acest test!', 11, 1);
		END

		DECLARE testTableCursor CURSOR SCROLL FOR
			SELECT TestTables.TableID, TestTables.NoOfRows
			FROM TestTables
			WHERE TestTables.TestID = (SELECT Tests.TestID FROM Tests WHERE Tests.Name = @NumeTest)
			ORDER BY TestTables.Position ASC

		OPEN testTableCursor;
	
		SET @IncepTest = GETDATE()
		INSERT INTO TestRuns(Description,StartAt) VALUES (@NumeTest,@IncepTest)
		SET @TestID = (SELECT TestRunID FROM TestRuns WHERE StartAt = @IncepTest)

		FETCH FIRST FROM testTableCursor INTO @TabelID, @NrInregistrari
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			DECLARE @command VARCHAR(50)
			SET @NumeTabel = (SELECT TOP 1 Name FROM Tables WHERE Tables.TableID = @TabelID)
			SET @command = 'DELETE FROM '+ @NumeTabel
			EXEC (@command)

			FETCH NEXT FROM testTableCursor INTO @TabelID, @NrInregistrari

		END
		
		FETCH LAST FROM testTableCursor INTO @TabelID, @NrInregistrari
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			DECLARE @insertStartTime DATETIME
			DECLARE @insertFinishTime DATETIME

			SET @NumeTabel = (SELECT TOP 1 Name FROM Tables WHERE Tables.TableID = @TabelID)
			SET @NumeProcedura = 'insert_to_' + @NumeTabel

			SET @insertStartTime = GETDATE()
			EXEC @NumeProcedura @NrInregistrari
			SET @insertFinishTime = GETDATE()

			INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt)
			VALUES(@TestID, @TabelID, @insertStartTime, @insertFinishTime)

			FETCH PRIOR FROM testTableCursor INTO @TabelID, @NrInregistrari

		END

		CLOSE testTableCursor;
		DEALLOCATE testTableCursor;

		DECLARE testViewCursor CURSOR FOR
			SELECT TestViews.ViewID FROM TestViews
			WHERE TestViews.TestID = (SELECT TestID FROM Tests WHERE Name = @NumeTest)
		OPEN testViewCursor
		DECLARE @ViewID INT
		DECLARE @NumeView VARCHAR(50)

		FETCH NEXT FROM testViewCursor INTO @ViewID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			DECLARE @insertStartTimeView DATETIME
			DECLARE @insertFinishTimeView DATETIME

			SET @NumeView = (SELECT TOP 1 Name FROM Views WHERE Views.ViewID = @ViewID)
			SET @NumeProcedura = 'execute_view_' + @NumeView

			SET @insertStartTimeView = GETDATE()
			EXEC @NumeProcedura
			SET @insertFinishTimeView = GETDATE()

			INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt)
			VALUES(@TestID, @ViewID, @insertStartTimeView, @insertFinishTimeView)

			FETCH NEXT FROM testViewCursor INTO @ViewID

		END

		CLOSE testViewCursor;
		DEALLOCATE testViewCursor;

		SET @TerminTest = GETDATE()
		UPDATE TestRuns SET EndAt = @TerminTest WHERE TestRunID = @TestID

	END
GO

EXEC test1 'select_view'
EXEC test1 'delete_insert_10'
EXEC test1 'delete_insert_100'

select * from TestRunViews
select * from TestRunTables
select * from TestRuns

delete from TestRunViews
delete from TestRunTables
delete from TestRuns


DROP PROCEDURE test1


SET NOCOUNT ON
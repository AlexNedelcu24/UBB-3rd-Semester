use ChampionsLeague
go

create or alter function ValidateVarstaAntrenor(@varsta int)
returns varchar(50)
as
begin
	if (@varsta > 99 or @varsta < 1)
		return 'invalid';
	return 'valid';
end
go

create or alter procedure CreateAntrenor(@nume varchar(50), @varsta int, @rol varchar(50))
as
begin
	if ((select count(Nume) from Antrenor where Nume = @nume) = 0 and [dbo].ValidateVarstaAntrenor(@varsta) = 'valid')
	begin
		insert into Antrenor(Nume, Varsta, Rol) values (@nume, @varsta, @rol);
	end
	else
		print 'Nu s-a putut insera';
end
go


create or alter procedure ReadAntrenor(@nume varchar(50))
as
begin
	select AntrenorID, Nume, Varsta, Rol from Antrenor where @nume = Nume;
end
go


create or alter procedure UpdateAntrenor(@nume varchar(50), @varsta int, @rol varchar(50))
as
begin
	if((select count(Nume) from Antrenor where Nume = @nume) > 0 and [dbo].ValidateVarstaAntrenor(@varsta) = 'valid')
		update Antrenor set Varsta=@varsta, Rol=@rol where @nume = Nume;
	else
		print 'Nu se poate face update';
end
go


create or alter procedure DeleteAntrenor(@nume varchar(50))
as
begin
	delete from Antrenor where Nume = @nume;
end
go

-----------------------------------

create or alter function ValidateFotbalist(@nume varchar(50), @pozitie varchar(50), @varsta int, @echipamentID int, @echipaID int )
returns varchar(50)
as
begin
	if (@nume = '' or @pozitie = '' or @varsta < 14 or @echipaID = 0 or @echipamentID = 0)
		return 'invalid';
	return 'valid';
end
go


create or alter procedure CreateFotbalist(@nume varchar(50), @pozitie varchar(50), @varsta int, @echipamentID int, @echipaID int)
as
begin
	if((select count(Nume) from Fotbalist where Nume = @nume) = 0 and [dbo].ValidateFotbalist(@nume, @pozitie, @varsta, @echipamentID, @echipaID) = 'valid')
	begin
		insert into Fotbalist(Nume, Varsta, Pozitie, EchipaID, EchipamentID) values (@nume, @varsta, @pozitie, @echipaID, @echipamentID);
	end
	else
		print 'Nu s-a putut insera';
end
go


create or alter procedure ReadFotbalist(@nume varchar(50))
as
begin
	select FotbalistID, Nume, Varsta, Pozitie, EchipaID, EchipamentID from Fotbalist where @nume = Nume;
end
go


create or alter procedure UpdateFotbalist(@nume varchar(50), @pozitie varchar(50), @varsta int, @echipamentID int, @echipaID int)
as
begin
	if((select count(Nume) from Fotbalist where Nume = @nume) > 0 and [dbo].ValidateFotbalist(@nume, @pozitie, @varsta, @echipamentID, @echipaID)='valid')
		update Fotbalist set Varsta = @varsta, Pozitie = @pozitie, EchipaID = @echipaID, EchipamentID = @echipamentID where Nume = @nume;
	else
		print 'Nu se poate updata';
end
go


create or alter procedure DeleteFotbalist(@nume varchar(50))
as
begin
	delete from Fotbalist where @nume = Nume;
end
go

--------------------------------------

create or alter function ValidateIndicatie(@fotbalistID int, @antrenorID int)
returns varchar(50)
as
begin
	if (@fotbalistID = 0 or @antrenorID = 0)
		return 'invalid';
	return 'valid';
end
go


create or alter procedure CreateIndicatie(@fotbalistID int, @antrenorID int)
as
begin
	if ((select count(FotbalistID) from Indicatie where FotbalistID = @fotbalistID and AntrenorID = @antrenorID) = 0 and [dbo].ValidateIndicatie(@fotbalistID, @antrenorID) = 'valid')
	begin
		insert into Indicatie(FotbalistID, AntrenorID) values (@fotbalistID, @antrenorID);
	end
	else
		print 'Nu s-a putut insera';
end
go


create or alter procedure ReadIndicatie(@fotbalistID int, @antrenorID int)
as
begin
	select FotbalistID, AntrenorID from Indicatie where FotbalistID = @fotbalistID and AntrenorID = @antrenorID;
end
go


create or alter procedure UpdateIndicatie(@fotbalistID int, @oldFotbalistID int, @antrenorID int)
as
begin
	if((select count(FotbalistID) from Indicatie where FotbalistID = @fotbalistID and AntrenorID = @antrenorID) = 0 and [dbo].ValidateIndicatie(@fotbalistID, @antrenorID)='valid')
		update Indicatie set FotbalistID = @fotbalistID where FotbalistID = @oldFotbalistID and AntrenorID = @antrenorID;
	else
		print 'Nu se poate updata';
end
go


create or alter procedure DeleteIndicatie(@fotbalistID int, @antrenorID int)
as
begin
	delete from Indicatie where FotbalistID = @fotbalistID and AntrenorID = @antrenorID;
end
go

-------------------------

create or alter function ValidateEchipa(@nume varchar(50), @tara varchar(50), @coeficient int, @stadionID int)
returns varchar(50)
as
begin
	if (@nume = '' or @tara = '' or @coeficient = 0 or @stadionID = 0)
		return 'invalid';
	return 'valid';
end
go


create or alter procedure CreateEchipa(@nume varchar(50), @tara varchar(50), @coeficient int, @stadionID int)
as
begin
	if ((select count(EchipaID) from Echipa where Nume = @nume) = 0 and [dbo].ValidateEchipa(@nume, @tara, @coeficient, @stadionID) = 'valid')
	begin
		insert into Echipa(Nume, Tara, Coeficient, StadionID) values (@nume, @tara, @coeficient, @stadionID);
	end
	else
		print 'Nu s-a putut insera';
end
go


create or alter procedure ReadEchipa(@nume varchar(50))
as
begin
	select EchipaID, Nume, Tara, Coeficient, StadionID from Echipa where @nume = Nume;
end
go


create or alter procedure UpdateEchipa(@nume varchar(50), @tara varchar(50), @coeficient int, @stadionID int)
as
begin
	if((select count(Nume) from Echipa where Nume = @nume) > 0 and [dbo].ValidateEchipa(@nume, @tara, @coeficient, @stadionID)='valid')
		update Echipa set Tara = @tara, Coeficient = @coeficient, StadionID = @stadionID where Nume = @nume;
	else
		print 'Nu se poate updata';
end
go


create or alter procedure DeleteEchipa(@nume varchar(50))
as
begin
	delete from Echipa where Nume = @nume;
end
go


--------------------------------------

create or alter function ValidateStadion(@nume varchar(50), @locatie varchar(50), @capacitate int)
returns varchar(50)
as
begin
	if (@nume != '' and @locatie != '' and @capacitate  > 1000)
		return 'valid';
	return 'invalid';
end
go


create or alter procedure CreateStadion(@nume varchar(50), @locatie varchar(50), @capacitate int)
as
begin
	if((select count(Nume) from Stadion where Nume = @nume) = 0)
	begin
		insert into Stadion(Nume, Locatie, Capacitate) values (@nume, @locatie, @capacitate);
	end
	else
		print 'Nu s-a putut insera';
end
go


create or alter procedure ReadStadion(@nume varchar(50))
as
begin
	select * from Stadion where Nume = @nume;
end
go


create or alter procedure UpdateStadion(@nume varchar(50), @locatie varchar(50), @capacitate int)
as
begin
	if((select StadionID from Stadion where Nume = @nume) > 0)
		update Stadion set Locatie = @locatie, Capacitate = @capacitate where Nume = @nume;
	else
		print 'Nu se poate updata';
end
go


create or alter procedure DeleteStadion(@nume varchar(50))
as
begin
	delete from Stadion where Nume = @nume;
end
go


-------------------------------------

create or alter view View1 as

SELECT Fotbalist.Nume, Echipa.Nume as Nume2, Stadion.Nume as Nume3 FROM Fotbalist 
	INNER JOIN Echipa ON Echipa.EchipaID = Fotbalist.EchipaID 
	INNER JOIN Stadion ON Stadion.StadionID = Echipa.StadionID
go


create or alter view View2 as

SELECT Fotbalist.Nume, Antrenor.Nume as Nume2 FROM Fotbalist 
	INNER JOIN Indicatie ON Indicatie.FotbalistID = Fotbalist.FotbalistID 
	INNER JOIN Antrenor ON Antrenor.AntrenorID = Indicatie.AntrenorID
go


------------------------------------------

CREATE NONCLUSTERED INDEX index_fotbalist_nume ON Fotbalist (Nume);

CREATE NONCLUSTERED INDEX index_echipa_nume ON Echipa (Nume);

CREATE NONCLUSTERED INDEX index_stadion_nume ON Stadion (Nume);

CREATE NONCLUSTERED INDEX index_indicatie_fotbalistid ON Indicatie (FotbalistID);

CREATE NONCLUSTERED INDEX index_antrenor_nume ON Antrenor (Nume);

---------------------------------------------

--va returna numele tabelului, ID-ul indexului, numãrul de cãutãri de utilizator (user seeks), numãrul de scanãri de utilizator (user scans) ?i numãrul de cãutãri de utilizator (user lookups) pentru toate indexurile create pentru tabelele men?ionate.
SELECT OBJECT_NAME(object_id) AS TableName, index_id, user_seeks, user_scans, user_lookups
FROM sys.dm_db_index_usage_stats
WHERE OBJECT_NAME(object_id) IN ('Fotbalist', 'Echipa', 'Stadion', 'Indicatie', 'Antrenor');

select * from Fotbalist order by Nume
---------------------------------------------

EXEC ReadAntrenor @nume = 'Scaloni'
EXEC CreateAntrenor @nume = 'Scaloni', @varsta = 45, @rol = 'principal'
EXEC UpdateAntrenor @nume = 'Scaloni', @varsta = 62, @rol = 'secundar'
EXEC DeleteAntrenor @nume = 'Scaloni'



EXEC ReadFotbalist @nume = 'Messi'
EXEC CreateFotbalist @nume = 'Messi', @pozitie = 'CF', @varsta = 35, @echipamentID = 1, @echipaID = 8
EXEC UpdateFotbalist @nume = 'Messi', @pozitie = 'LW', @varsta = 36, @echipamentID = 2, @echipaID = 8
EXEC DeleteFotbalist @nume = 'Messi'



EXEC ReadIndicatie @fotbalistID =  123, @antrenorID = 123
EXEC CreateIndicatie @fotbalistID =  123, @antrenorID = 123
EXEC UpdateIndicatie @fotbalistID =  124, @oldFotbalistID = 123, @antrenorID = 123
EXEC ReadIndicatie @fotbalistID =  124, @antrenorID = 123
EXEC DeleteIndicatie @fotbalistID =  124, @antrenorID = 123


SELECT OBJECT_NAME(A.[OBJECT_ID]) AS [OBJECT NAME],
 I.[NAME] AS [INDEX NAME],
 A.LEAF_INSERT_COUNT,
 A.LEAF_UPDATE_COUNT,
 A.LEAF_DELETE_COUNT
FROM SYS.DM_DB_INDEX_OPERATIONAL_STATS (NULL,NULL,NULL,NULL ) A INNER JOIN SYS.INDEXES AS I
 ON I.[OBJECT_ID] = A.[OBJECT_ID] AND I.INDEX_ID = A.INDEX_ID
WHERE OBJECTPROPERTY(A.[OBJECT_ID],'IsUserTable') = 1
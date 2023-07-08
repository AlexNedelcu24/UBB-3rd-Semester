use ChampionsLeague
go


CREATE PROCEDURE modifica_tip
AS
BEGIN
ALTER TABLE Echipa
ALTER COLUMN Coeficient float NOT NULL
PRINT N'Tipul coloanei a fost modificat!';
ENDgo


CREATE PROCEDURE modifica_tip_inapoi
AS
BEGIN
ALTER TABLE Echipa
ALTER COLUMN Coeficient int NOT NULL
PRINT N'Tipul coloanei a fost modificat inapoi!';
ENDgo


EXEC modifica_tip;
EXEC modifica_tip_inapoi;
go


CREATE PROCEDURE adauga_constrangere
AS
BEGIN
ALTER TABLE Antrenor
ADD CONSTRAINT df_principal DEFAULT 'principal'
FOR Rol
PRINT N'Constrangerea a fost adaugata!';
END
go


CREATE PROCEDURE sterge_constrangere
AS
BEGIN
ALTER TABLE Antrenor
DROP CONSTRAINT df_principal;
PRINT N'Constrangerea a fost stearsa!';
END
go

exec adauga_constrangere;
exec sterge_constrangere;
go


CREATE PROCEDURE creare_tabela
AS
BEGIN
CREATE TABLE Tactica(
TacticaID int PRIMARY KEY IDENTITY,
PID int,
Descriere varchar(50),
Tip varchar(50));
PRINT N'Tabel creat cu succes!';
END
go

CREATE PROCEDURE sterge_tabela
AS
BEGIN
DROP TABLE Tactica;
PRINT N'Tabel sters cu succes!';
END
go

exec creare_tabela;
exec sterge_tabela;
go


CREATE PROCEDURE adauga_coloana
AS
BEGIN
ALTER TABLE Tactica
ADD Prioritate varchar(50)
PRINT N'Coloana adaugata cu succes!';
END
go

CREATE PROCEDURE sterge_coloana
AS
BEGIN
ALTER TABLE Tactica
DROP COLUMN Prioritate
PRINT N'Coloana stearsa cu succes!';
END
go

exec adauga_coloana;
exec sterge_coloana;
go


CREATE PROCEDURE adauga_fk
AS
BEGIN
ALTER TABLE Tactica
ADD CONSTRAINT fk_Tactica_Antrenor FOREIGN KEY(PID) REFERENCES Antrenor(AntrenorID)
PRINT N'Cheie straina adaugata cu succes!';
END
go

CREATE PROCEDURE sterge_fk
AS
BEGIN
ALTER TABLE Tactica
DROP CONSTRAINT fk_Tactica_Antrenor;
PRINT N'Cheie straina stearsa cu succes!';
END
go

exec adauga_fk;
exec sterge_fk;
go


CREATE TABLE Varianta(
v int);
insert into Varianta(v) values ('0');

select * from Varianta

go
CREATE PROCEDURE ex_proc
@n int
AS
BEGIN
 IF @n = 1
	exec modifica_tip

 IF @n = 2
	exec adauga_constrangere

 IF @n = 3
	exec creare_tabela

 IF @n = 4
	exec adauga_coloana

 IF @n = 5
	exec adauga_fk
ENDgo

go
CREATE PROCEDURE undo_proc
@n int
AS
BEGIN
 IF @n = 1
	exec modifica_tip_inapoi

 IF @n = 2
	exec sterge_constrangere

 IF @n = 3
	exec sterge_tabela

 IF @n = 4
	exec sterge_coloana

 IF @n = 5
	exec sterge_fk
ENDgo

CREATE PROCEDURE main
@ver int
AS
BEGIN
 IF @ver > 5 or @ver < 0
 BEGIN
	RAISERROR('Nu exista o astfel de versiune!', 11, 1);
	RETURN
 END
 /*IF ISNUMERIC(@ver) = 0
 BEGIN
	RAISERROR('Parametrul trebuie sa fie un numar!', 11, 1);
	RETURN
 END*/
 ELSE
 BEGIN
	DECLARE @curent as int;
	set @curent = (select max(v) from Varianta);
	
	while @curent <> @ver
	BEGIN
		IF @curent < @ver
		BEGIN
			set @curent = @curent+1
			insert into Varianta(v) values (@curent);
			exec ex_proc @curent;
		END
		IF @curent > @ver
		BEGIN
			delete from Varianta where v = @curent;
			exec undo_proc @curent;
			set @curent = @curent-1;
		END
	END
 END
ENDgodrop procedure mainexec main -1
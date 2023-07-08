CREATE database ChampionsLeague
go
use ChampionsLeague
go

CREATE TABLE Echipament
(EchipamentID INT PRIMARY KEY IDENTITY,
Culoare varchar(50),
Marime varchar(50))

CREATE TABLE Sponsor
(SponsorID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
Investitie int,
EchipamentID int FOREIGN KEY REFERENCES Echipament(EchipamentID))

CREATE TABLE Stadion
(StadionID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
Locatie varchar(50),
Capacitate int)

CREATE TABLE Echipa
(EchipaID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
Tara varchar(50),
Coeficient int,
StadionID int FOREIGN KEY REFERENCES Stadion(StadionID))

CREATE TABLE Fotbalist
(FotbalistID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
Varsta int,
Pozitie varchar(50),
EchipamentID int FOREIGN KEY REFERENCES Echipament(EchipamentID),
EchipaID int FOREIGN KEY REFERENCES Echipa(EchipaID))

CREATE TABLE Antrenor
(AntrenorID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
Varsta int,
Rol varchar(50))

CREATE TABLE Indicatie
(FotbalistID int FOREIGN KEY REFERENCES Fotbalist(FotbalistID),
AntrenorID int FOREIGN KEY REFERENCES Antrenor(AntrenorID),
CONSTRAINT pk_Indicatie PRIMARY KEY (FotbalistID, AntrenorID),
/*Pozitie_noua varchar(50),
Strategie_de_joc varchar(50)*/)


CREATE TABLE Imn
(ImnID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
An_aparitie varchar(50))

CREATE TABLE Suporter
(SuporteID INT PRIMARY KEY IDENTITY,
Nume varchar(50),
Prenume varchar(50),
EchipaID int FOREIGN KEY REFERENCES Echipa(EchipaID),
ImnID int FOREIGN KEY REFERENCES Imn(ImnID))

CREATE TABLE MagazinOficial
(MagazinOficialID INT PRIMARY KEY IDENTITY,
Locatie varchar(50),
NrArticole int,
StadionID int FOREIGN KEY REFERENCES Stadion(StadionID))

ALTER TABLE Fotbalist
ADD CONSTRAINT constr_unic_nume UNIQUE (Nume);

ALTER TABLE Antrenor
ADD CONSTRAINT constr_unic_nume_antrenor UNIQUE (Nume);

ALTER TABLE Echipa
ADD CONSTRAINT constr_unic_nume_echipa UNIQUE (Nume);

ALTER TABLE Stadion
ADD CONSTRAINT constr_unic_nume_stadion UNIQUE (Nume);


select * from MagazinOficial
select * from Echipa
select * from Stadion
select * from Fotbalist
select * from Echipament
select * from Antrenor
select * from Indicatie
select * from Sponsor
select * from Imn

INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Camp Nou','Barcelona','99354')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Santiago Bernabeu','Madrid','81044')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('San Siro','Milano','80018')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Allianz Arena','Munchen','75024')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Signal Iduna Park','Dortmund','81365')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Anfield','Liverpool','53394')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Old Trafford','Manchester','74310')
INSERT INTO Stadion(Nume,Locatie,Capacitate) VALUES ('Amsterdam Arena','Amsterdam','55865')

INSERT INTO MagazinOficial(Locatie,NrArticole,StadionID) VALUES ('Barcelona','100000',1)
INSERT INTO MagazinOficial(Locatie,NrArticole,StadionID) VALUES ('Madrid','80000',2)
INSERT INTO MagazinOficial(Locatie,NrArticole,StadionID) VALUES ('Milano','67200',3)
INSERT INTO MagazinOficial(Locatie,NrArticole,StadionID) VALUES ('Liverpool','37000',6)
INSERT INTO MagazinOficial(Locatie,NrArticole,StadionID) VALUES ('Amsterdam','6900',8)


INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('FC Liverpool','Anglia','34',6)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('Manchester United','Anglia','15',7)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('FC Ajax','Olanda','21',8)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('AC Milan','Italia','9',3)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('Bayern Munchen','Germania','55',4)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('Borussia Dortmund','Germania','29',5)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('Real Madrid','Spania','70',2)
INSERT INTO Echipa(Nume,Tara,Coeficient,StadionID) VALUES ('FC Barcelona','Spania','40',1)


INSERT INTO Echipament(Culoare,Marime) VALUES ('rosu','45')
INSERT INTO Echipament(Culoare,Marime) VALUES ('albastru','54')
INSERT INTO Echipament(Culoare,Marime) VALUES ('alb','62')
INSERT INTO Echipament(Culoare,Marime) VALUES ('rosu','55')
INSERT INTO Echipament(Culoare,Marime) VALUES ('alb','40')
INSERT INTO Echipament(Culoare,Marime) VALUES ('galben','47')


INSERT INTO Sponsor(Nume,Investitie,EchipamentID) VALUES ('Spotify','200',4)
INSERT INTO Sponsor(Nume,Investitie,EchipamentID) VALUES ('Standard Chartered','50',1)
INSERT INTO Sponsor(Nume,Investitie,EchipamentID) VALUES ('Telekom','100',3)
INSERT INTO Sponsor(Nume,Investitie,EchipamentID) VALUES ('Evonik','35',6)


INSERT INTO Fotbalist(Nume,Varsta,Pozitie,EchipamentID,EchipaID) VALUES ('Salah','30','RW',1,1)
INSERT INTO Fotbalist(Nume,Varsta,Pozitie,EchipamentID,EchipaID) VALUES ('Lewandowski','34','ST',4,8)
INSERT INTO Fotbalist(Nume,Varsta,Pozitie,EchipamentID,EchipaID) VALUES ('Modric','37','CM',3,7)
INSERT INTO Fotbalist(Nume,Varsta,Pozitie,EchipamentID,EchipaID) VALUES ('Musiala','19','CAM',5,5)
INSERT INTO Fotbalist(Nume,Varsta,Pozitie,EchipamentID,EchipaID) VALUES ('Reus','32','CAM',6,6)


INSERT INTO Antrenor(Nume,Varsta,Rol) VALUES ('Ancelotti','63','principal')
INSERT INTO Antrenor(Nume,Varsta,Rol) VALUES ('Klopp','55','principal')
INSERT INTO Antrenor(Nume,Varsta,Rol) VALUES ('Terzic','40','secund')


/*INSERT INTO Indicatie(FotbalistID,AntrenorID,Pozitie_noua,Strategie_de_joc) VALUES (1,2,'CF','ofensiva')
INSERT INTO Indicatie(FotbalistID,AntrenorID,Pozitie_noua,Strategie_de_joc) VALUES (3,1,'CDM','defensiva')
INSERT INTO Indicatie(FotbalistID,AntrenorID,Pozitie_noua,Strategie_de_joc) VALUES (4,3,'LM','contraatac')*/
INSERT INTO Indicatie(FotbalistID,AntrenorID) VALUES (1,2)
INSERT INTO Indicatie(FotbalistID,AntrenorID) VALUES (3,1)
INSERT INTO Indicatie(FotbalistID,AntrenorID) VALUES (4,3)


INSERT INTO Imn(Nume,An_aparitie) VALUES ('You will never walk alone','1980')
INSERT INTO Imn(Nume,An_aparitie) VALUES ('El cant del Barca','1960')
INSERT INTO Imn(Nume,An_aparitie) VALUES ('Milan! Milan!','1977')


INSERT INTO Suporter(Nume,Prenume,EchipaID,ImnID) VALUES ('Popescu','Marcel',1,1)
INSERT INTO Suporter(Nume,Prenume,EchipaID,ImnID) VALUES ('Toma','Alex',8,2)
INSERT INTO Suporter(Nume,Prenume,EchipaID,ImnID) VALUES ('Pop','Mircea',4,3)
INSERT INTO Suporter(Nume,Prenume,EchipaID,ImnID) VALUES ('Ionescu','Vlad',1,1)



/*Afiseaza un tabel cu forbalistii mai tineri de 35 de ani care au primit indicatie si antrenorii lor*/
SELECT f.Nume, a.Nume FROM Fotbalist f
INNER JOIN Indicatie i on f.FotbalistID=i.FotbalistID
INNER JOIN Antrenor a on i.AntrenorID=a.AntrenorID
WHERE f.Varsta < 35


/*Afiseaza jucatorii care sunt mijlocasi si rolul antrenorului lor */
SELECT f.Nume, A.Rol FROM Fotbalist f
LEFT OUTER JOIN Indicatie i on f.FotbalistID=i.FotbalistID
LEFT OUTER JOIN Antrenor a on i.AntrenorID=a.AntrenorID
WHERE f.Pozitie LIKE 'C%'


/*Afiseaza jucatorii, culoarea tricourilor pe care le poarta si sponsorul trecut pe acesta care a facut o investitie intre 40 si 150 de milioane*/
SELECT f.Nume, e.Culoare, s.Nume FROM Fotbalist f
INNER JOIN Echipament e on f.EchipamentID=e.EchipamentID
INNER JOIN Sponsor s on e.EchipamentID=s.EchipamentID
WHERE S.Investitie BETWEEN 40 AND 150


/*Afiseaza marimea si culoarea echipamentelor(diferita de galben si alb) + investitia sponsorului pentru fotbalistii mai tineri de 37 de ani */
SELECT e.Marime, e.Culoare, s.Investitie FROM Fotbalist f
INNER JOIN Echipament e on f.EchipamentID=e.EchipamentID
INNER JOIN Sponsor s on e.EchipamentID=s.EchipamentID
WHERE f.Varsta < 37 AND e.Culoare NOT IN ('galben', 'alb')


/*Afiseaza tara, locatia si nr de articole pentru fiecare echipa de fotbal al carei stadion nu are o capacitate mai mica de 60000 de locuri*/
SELECT e.Tara, s.Locatie, m.NrArticole FROM Echipa e
INNER JOIN Stadion s on e.StadionID=s.StadionID
INNER JOIN MagazinOficial m on s.StadionID=m.StadionID
WHERE s.Capacitate !< 60000


/*Afiseaza coeficientul mediu al fiecarei tari, mai mare de 20*/
SELECT AVG(e.Coeficient) AS Coeficient_mediu, e.Tara
FROM Echipa e
GROUP BY e.Tara
HAVING AVG(Coeficient) > 20


/*Afiseaza varsta minima a unui antrenor de un anumit tip, care este mai mica de 60 de ani*/
SELECT a.Rol,
MIN(Varsta) AS Varsta_minima
FROM Antrenor a
GROUP BY a.Rol
HAVING MIN(Varsta) < 60


/*Afiseaza suma capacitatilor stadioanelor din fiecare tara*/
SELECT DISTINCT SUM(s.Capacitate) AS Capacitate_suma
FROM Stadion s
INNER JOIN Echipa e on e.StadionID=s.StadionID
GROUP BY e.Tara
ORDER BY Capacitate_suma


/*Afiseza pozitiile jucatorilor si culoarea echipamentelor purtare pentru fiecare fotbalist*/
SELECT  e.Tara, f.Pozitie, ec.Culoare
FROM Fotbalist f
LEFT OUTER JOIN Echipa e on f.EchipaID=e.EchipaID
LEFT OUTER JOIN Echipament ec on ec.EchipamentID=e.EchipaID


/*Afiseaza jucatorii care au primit indicatie, indicatia si echipele lor*/
SELECT  e.Nume, f.Nume
FROM Echipa e
INNER JOIN Fotbalist f on f.EchipaID=e.EchipaID
INNER JOIN Indicatie i on i.FotbalistID=f.FotbalistID


/*Afiseaza numele echipei, suporterul ei si imnul pe care il canta acesta*/
SELECT DISTINCT e.Nume, s.Nume, i.Nume
FROM Echipa e
INNER JOIN	Suporter s on s.EchipaID=e.EchipaID
INNER JOIN Imn i on i.ImnID=s.ImnID
ORDER BY s.Nume


/*Afiseaza tara, prenumele si anul aparitiei pentru echipele care au imnuri*/
SELECT e.Tara, s.Prenume, i.An_aparitie
FROM Echipa e, Imn i, Suporter s
WHERE e.EchipaID=s.EchipaID AND s.ImnID=i.ImnID AND e.Tara NOT LIKE 'A%'




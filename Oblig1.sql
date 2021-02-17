/*Sletter Tabeller sann scriptet kan kjøres flere ganger*/
DROP TABLE Prishistorikk;
DROP TABLE OrdreLinje;
DROP TABLE Ordre;
DROP TABLE Kunde;
DROP TABLE Vare;
DROP TABLE Ansatt;
DROP TABLE Poststed;
DROP TABLE Kategori;

/*Oppretter Tabellene*/
CREATE TABLE Kategori (
    KatNr SMALLINT UNIQUE ,
    Navn VARCHAR(20) NOT NULL ,
    CONSTRAINT kategori_pkey PRIMARY KEY (KatNr)
);

CREATE TABLE Poststed (
    PostNr SMALLINT,
    Poststed VARCHAR(50) NOT NULL ,
    CONSTRAINT postnr_pkey PRIMARY KEY (PostNr)
);

CREATE TABLE Ansatt (
    AnsNr INTEGER,
    Fornavn VARCHAR(50) NOT NULL ,
    Etternavn VARCHAR(50) NOT NULL ,
    Adresse VARCHAR(50) ,
    Foodselsdato DATE NOT NULL ,
    Kjoonn CHAR(1) ,
    Stilling VARCHAR(50) NOT NULL ,
    Aarsloonn NUMERIC(8,2)  ,
    PostNr INTEGER  ,
    CONSTRAINT ansatt_pkey PRIMARY KEY (AnsNr) ,
    CONSTRAINT postnr_fkey FOREIGN KEY (PostNr) REFERENCES Poststed (PostNr) ON UPDATE CASCADE
);

CREATE TABLE Vare (
    VNr INTEGER ,
    Betegnelse VARCHAR(20) NOT NULL UNIQUE ,
    Pris NUMERIC(8,2)  NOT NULL ,
    Antall INTEGER NOT NULL ,
    Hylle CHAR(3) NOT NULL ,
    KatNr SMALLINT NOT NULL ,
    CONSTRAINT varenr_pkey PRIMARY KEY (VNr) ,
    CONSTRAINT kategorinr_fkey FOREIGN KEY (KatNr) REFERENCES Kategori (KatNr) ON UPDATE CASCADE
);

CREATE TABLE Kunde (
    KNr INTEGER  ,
    Fornavn VARCHAR(50) NOT NULL ,
    Etternavn VARCHAR(50) NOT NULL ,
    Adresse VARCHAR(50) NOT NULL ,
    PostNr INTEGER NOT NULL ,
    CONSTRAINT kundenr_pkey PRIMARY KEY (KNr) ,
    CONSTRAINT postnr_fkey FOREIGN KEY (PostNr) REFERENCES Poststed (PostNr)
);

/*Lar SendtDato og Betalt dato være null til de får en verdi når varen blir sendt eller betalt.*/
CREATE TABLE Ordre (
    OrdreNr  INTEGER ,
    OrdreDato DATE NOT NULL ,
    SendtDato DATE ,
    BetaltDato DATE ,
    KNr INTEGER NOT NULL ,
    CONSTRAINT ordrenr_pkey PRIMARY KEY (OrdreNr) ,
    CONSTRAINT kundenr_fkey FOREIGN KEY (KNr) REFERENCES Kunde (KNr) ON DELETE CASCADE
);

CREATE TABLE OrdreLinje (
    OrdreNr INTEGER ,
    VNr INTEGER NOT NULL ,
    PrisPrEnhet NUMERIC(8,2)  NOT NULL  ,
    Antall SMALLINT NOT NULL ,
    CONSTRAINT ordenlinje_pkey PRIMARY KEY (OrdreNr,VNr) ,
    CONSTRAINT varenr_fkey FOREIGN KEY (VNr) REFERENCES Vare (VNr) ON DELETE CASCADE,
    CONSTRAINT ordrenr_fkey FOREIGN KEY (OrdreNr) REFERENCES Ordre (OrdreNr) ON DELETE CASCADE
);

CREATE TABLE Prishistorikk (
    VNr INTEGER ,
    Dato DATE  ,
    GammelPris NUMERIC(8,2) NOT NULL ,
    CONSTRAINT varenrprishistorikk_pkey PRIMARY KEY (VNr) ,
    CONSTRAINT varenr_fkey FOREIGN KEY (VNr) REFERENCES Vare (VNr) ON DELETE CASCADE
);

/*Setter inn "en linje" i hver tabell*/
INSERT INTO Kategori VALUES (1, 'Kategori');
INSERT INTO Poststed VALUES (1337, 'PostSted');
INSERT INTO Ansatt VALUES (81840, 'Nordmann', 'Ola' , 'Svingen 1', '01-07-1997', 'J', 'Sjef', 500000, 1337);
INSERT INTO Vare VALUES (1, 'Banan', 5.50, 5 , 'H13', 1);
INSERT INTO Kunde VALUES (52135, 'Nordmann', 'Ole' , 'Svingen 2', 1337);
INSERT INTO Ordre VALUES (1,'02-02-2021', null, null, 52135);
INSERT INTO OrdreLinje VALUES (1, 1, 5.50, 1);
INSERT INTO Prishistorikk VALUES (1,'02-02-2021', 5.45);

/*Legger til en kolonne AnsattDato i Ansatt*/
ALTER TABLE Ansatt ADD Ansattdato DATE;
/*Kan ikke bruke NOT NULL ettersom vi legger til kolonnen etter vi har laget tabellen og satt inn verdier,
  hadde vi brukt AnsattDato fra begynnelsen hadde vi ikke tilatt nullmerker ettersom vi kommer alltid til å
   vite når en ansatt startet i jobben fra første dag.*/

/*Legger til linjer i flere tabeller for å teste spørringen*/
INSERT INTO Poststed VALUES (5032, 'Chicago');
INSERT INTO Poststed VALUES (2805, 'Anaheim');
INSERT INTO Poststed VALUES (5125, 'Pell');
INSERT INTO Poststed VALUES (2044, 'Jacksonville');

INSERT INTO Kunde VALUES (32165, 'Norvbember', 'Finn' , 'Svingen 2', 1337);
INSERT INTO Kunde VALUES (26332, 'Moore', 'Harry' , '1108 Tator Patch Road', 5032);
INSERT INTO Kunde VALUES (75234, 'Combs', 'Tiffany ' , '382 Parkview Drive', 2805);
INSERT INTO Kunde VALUES (23678, 'Martinez', 'Gary ' , '827 Brookside Drive', 5125);
INSERT INTO Kunde VALUES (03215, 'Perez', 'Ranae ' , '2262 Boundary Street', 2044);

INSERT INTO Vare VALUES (2, 'Egg', 5.50, 43 , 'A32', 1);
INSERT INTO Vare VALUES (3, 'Fisk', 30.00, 4 , 'H43', 1);
INSERT INTO Vare VALUES (4, 'Pasta', 10.64, 25 , 'K12', 1);
INSERT INTO Vare VALUES (5, 'Bolle', 2.50, 50 , 'C28', 1);
INSERT INTO Vare VALUES (6, 'Øl', 20.50, 5 , 'F24', 1);
INSERT INTO Vare VALUES (7, 'Sigg', 108.50, 200 , 'K41', 1);
INSERT INTO Vare VALUES (8, 'Giflar', 27.50, 12 , 'C65', 1);
INSERT INTO Vare VALUES (9, 'Tomat', 7.00, 76 , 'E23', 1);

INSERT INTO Ordre VALUES (2,'12-02-2020', '12-02-2020', '12-02-2020', 32165);
INSERT INTO Ordre VALUES (3,'01-02-2021', '01-02-2021', '01-03-2021', 26332);
INSERT INTO Ordre VALUES (4,'02-05-2021', '02-07-2021', '02-09-2021', 75234);
INSERT INTO Ordre VALUES (5,'02-05-2021', '02-05-2021', null, 23678);
INSERT INTO Ordre VALUES (6,'02-09-2021', '02-09-2021', '02-11-2021', 03215);
INSERT INTO Ordre VALUES (7,'02-11-2021', null, null, 32165);

INSERT INTO OrdreLinje VALUES (1, 5, 2.50, 1);
INSERT INTO OrdreLinje VALUES (1, 2, 5.50, 2);
INSERT INTO OrdreLinje VALUES (1, 4, 10.64, 1);
INSERT INTO OrdreLinje VALUES (2, 7, 108.50, 1);
INSERT INTO OrdreLinje VALUES (2, 2, 5.50, 6);
INSERT INTO OrdreLinje VALUES (3, 5, 2.50, 1);
INSERT INTO OrdreLinje VALUES (3, 2, 5.50, 1);
INSERT INTO OrdreLinje VALUES (3, 1, 5.50, 1);
INSERT INTO OrdreLinje VALUES (4, 6, 20.50, 6);
INSERT INTO OrdreLinje VALUES (4, 3, 30.00, 1);
INSERT INTO OrdreLinje VALUES (4, 9, 7.00, 5);
INSERT INTO OrdreLinje VALUES (4, 7, 5.50, 1);
INSERT INTO OrdreLinje VALUES (5, 3, 30.00, 1);
INSERT INTO OrdreLinje VALUES (5, 7, 108.50, 2);
INSERT INTO OrdreLinje VALUES (6, 9, 5.50, 1);
INSERT INTO OrdreLinje VALUES (6, 8, 27.50, 1);
INSERT INTO OrdreLinje VALUES (6, 7, 108.50, 1);
INSERT INTO OrdreLinje VALUES (6, 6, 5.50, 1);
INSERT INTO OrdreLinje VALUES (7, 1, 5.50, 1);

/*Viser alle salg og produkter for hvert salg, for hver enkelt kunde*/
SELECT KNr, Betegnelse, OrdreLinje.OrdreNr, Ordrelinje.VNr, PrisPrEnhet, Ordrelinje.Antall
FROM Ordre INNER JOIN (
    Vare INNER JOIN OrdreLinje
    ON Vare.VNr = Ordrelinje.VNr)
    ON Ordrelinje.ordrenr = Ordre.ordrenr;

/*Viser antall salg og total verdi av salg gruppert etter postnr, inkluder også poststed som egen kolonne,
  sorter etter poststed synkende*/
SELECT count(DISTINCT Ordre.OrdreNr) AS AntallSalg,
       sum(OrdreLinje.PrisPrEnhet * OrdreLinje.Antall) AS TotalVerdi, Poststed.Poststed
FROM Poststed INNER JOIN (
    Ordre INNER JOIN OrdreLinje
    ON Ordre.OrdreNr = Ordrelinje.OrdreNr)
    INNER JOIN Kunde ON Ordre.KNr = Kunde.KNr
    ON Kunde.PostNr = Poststed.PostNr
GROUP BY Poststed.Poststed
ORDER BY Poststed ASC;

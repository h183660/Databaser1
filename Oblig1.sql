/*Sletter Tabeller sann scriptet kan kjøres flere ganger*/
DROP TABLE Kategori;
DROP TABLE Poststed;
DROP TABLE Ansatt;
DROP TABLE Vare;
DROP TABLE Kunde;
DROP TABLE Ordre;
DROP TABLE OrdreLinje;
DROP TABLE Prishistorikk;

/*Oppretter Tabellene*/

CREATE TABLE Kategori (
    KatNr SMALLINT NOT NULL UNIQUE ,
    Navn VARCHAR(20) NOT NULL ,
    CONSTRAINT kategori_pkey PRIMARY KEY (KatNr)
);

CREATE TABLE Poststed (
    PostNr INTEGER,
    Poststed VARCHAR(50) NOT NULL UNIQUE ,
    CONSTRAINT postnr_pkey PRIMARY KEY (PostNr)
);

CREATE TABLE Ansatt (
    AnsNr INTEGER,
    Fornavn VARCHAR(50) NOT NULL ,
    Etternavn VARCHAR(50) NOT NULL ,
    Adresse VARCHAR(50) NOT NULL ,
    Foodselsdato DATE NOT NULL ,
    Kjoonn CHAR(1) ,
    Stilling VARCHAR(50) NOT NULL ,
    Aarsloonn INTEGER NOT NULL ,
    PostNr INTEGER NOT NULL ,
    CONSTRAINT ansatt_pkey PRIMARY KEY (AnsNr) ,
    CONSTRAINT postnr_fkey FOREIGN KEY (PostNr) REFERENCES Poststed (PostNr)
);

CREATE TABLE Vare (
    VNr INTEGER NOT NULL ,
    Betegnelse VARCHAR(20) NOT NULL UNIQUE ,
    Pris DECIMAL(8,2) NOT NULL ,
    Antall INTEGER NOT NULL ,
    Hylle CHAR(3) NOT NULL ,
    KatNr SMALLINT NOT NULL ,
    CONSTRAINT varenr_pkey PRIMARY KEY (VNr) ,
    CONSTRAINT kategorinr_fkey FOREIGN KEY (KatNr) REFERENCES Kategori (KatNr)
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
    CONSTRAINT kundenr_fkey FOREIGN KEY (KNr) REFERENCES Kunde (KNr)
);

CREATE TABLE OrdreLinje (
    OrdreNr INTEGER NOT NULL ,
    VNr INTEGER REFERENCES Vare (VNr) NOT NULL ,
    PrisPrEnhet DECIMAL(8,2) NOT NULL  ,
    Antall SMALLINT NOT NULL ,
    CONSTRAINT ordenlinje_pkey PRIMARY KEY (OrdreNr) ,
    CONSTRAINT varenr_fkey FOREIGN KEY (VNr) REFERENCES Vare (VNr),
    CONSTRAINT ordrenr_fkey FOREIGN KEY (OrdreNr) REFERENCES Ordre (OrdreNr)
);

CREATE TABLE Prishistorikk (
    VNr INTEGER ,
    Dato DATE  ,
    GammelPris DECIMAL(8,2) NOT NULL ,
    CONSTRAINT varenrprishistorikk_pkey PRIMARY KEY (VNr) ,
    CONSTRAINT varenr_fkey FOREIGN KEY (VNr) REFERENCES Vare (VNr)
);

/*Setter inn "en linje" i hver tabell*/
INSERT INTO Kategori VALUES (1, 'Kategori');
INSERT INTO Poststed VALUES (1337, 'PostSted');
INSERT INTO Ansatt VALUES (81840, 'Nordmann', 'Ola' , 'Svingen 1', 01-07-1997, 'J', 'Sjef', 500000, 1337);
INSERT INTO Vare VALUES (1, 'Banan', 5.50, 5 , 'H13', 1);
INSERT INTO Kunde VALUES (52135, 'Nordmann', 'Ole' , 'Svingen 2', 1337);
INSERT INTO Ordre VALUES (1,02-02-2021, null, null, 52135);
INSERT INTO OrdreLinje VALUES (1, 1, 5.50, 1);
INSERT INTO Prishistorikk VALUES (1,02-02-2021, 5.45);

/*Legger til en kolonne AnsattDato i Ansatt*/

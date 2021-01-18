CREATE DATABASE linia_lotnicza;
USE linia_lotnicza;

CREATE TABLE samoloty(
    id INT AUTO_INCREMENT NOT NULL,
    producent VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    numer_seryjny VARCHAR(50) NOT NULL,
    data_zakupu DATE NOT NULL,
    data_zakonczenia_eksploatacji DATE,
    available INT NOT NULL, -- to pole sprawdza, czy samolot jest wciąż wykorzystywany
    PRIMARY KEY(id)
);

CREATE TABLE personel(
    id INT AUTO_INCREMENT NOT NULL,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    stanowisko VARCHAR(50) NOT NULL,
    available INT NOT NULL,  -- to pole sprawdza, czy ta osoba jest wciąż zatrudniona
    PRIMARY KEY(id)
);

CREATE TABLE zaloga(
    id INT AUTO_INCREMENT NOT NULL,
    kapitan INT NOT NULL,
    pierwszy_oficer INT NOT NULL,
    steward_kelner INT NOT NULL,
    steward_przod INT NOT NULL,
    steward_tyl INT NOT NULL,
    available INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(kapitan) REFERENCES personel(id),
    FOREIGN KEY(pierwszy_oficer) REFERENCES personel(id),
    FOREIGN KEY(steward_kelner) REFERENCES personel(id),
    FOREIGN KEY(steward_przod) REFERENCES personel(id),
    FOREIGN KEY(steward_tyl) REFERENCES personel(id)
);


CREATE TABLE rejsy(
    id INT AUTO_INCREMENT NOT NULL,
    samolot INT NOT NULL,
    nr_zalogi INT NOT NULL,
    miejsce_wylotu VARCHAR(50) NOT NULL,
    kierunek_docelowy VARCHAR(50) NOT NULL,
    data_lotu DATE NOT NULL,
    odbyl_sie INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (samolot) REFERENCES samoloty(id),
    FOREIGN KEY (nr_zalogi) REFERENCES zaloga(id)
);


CREATE TABLE pasazerowie(
    id INT AUTO_INCREMENT NOT NULL,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    PESEL VARCHAR(11) NOT NULL,
    nr_telefonu VARCHAR(9) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE bilety(
    id INT AUTO_INCREMENT NOT NULL,
    pasazer INT NOT NULL,
    rejs INT NOT NULL,
    data_zakupu DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pasazer) REFERENCES pasazerowie(id),
    FOREIGN KEY (rejs) REFERENCES rejsy(id)
);


INSERT INTO samoloty(producent, model, numer_seryjny, data_zakupu, available) 
    VALUES ("Boeing", "737", "AGZ5432", "2017-10-05", 1);
INSERT INTO samoloty(producent, model, numer_seryjny, data_zakupu, data_zakonczenia_eksploatacji, available) 
    VALUES ("Airbus", "A320", "GDS8429", "2004-01-07", "2020-10-12", 0);
INSERT INTO samoloty(producent, model, numer_seryjny, data_zakupu, available) 
    VALUES ("Boeing", "777", "AZZ6543", "2019-08-22", 1);


INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Jan","Kowalski","2020-05-06", "kapitan", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Adam","Kowalski","2019-01-06", "kapitan", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Katarzyna","Kowalczyk","2018-02-01", "pierwszy_oficer", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Gabriela","Jaworska","2019-10-12", "pierwszy_oficer", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Małgorzata","Czarnecka","2019-03-10", "steward_kelner", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Borys","Wieczorek","2019-01-05", "steward_kelner", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Lucjusz","Kucharski","2019-01-05", "steward_przod", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Wisław","Wojciechowski","2019-05-01", "steward_przod", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Albin","Sawicki","2020-03-15", "steward_tyl", 1);
INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES("Wojciech","Jasiński","2020-05-05", "steward_tyl", 1);

INSERT INTO zaloga(kapitan,pierwszy_oficer,steward_kelner,steward_przod,steward_tyl,available)
    VALUES (1,3,5,7,9,1);
INSERT INTO zaloga(kapitan,pierwszy_oficer,steward_kelner,steward_przod,steward_tyl,available)
    VALUES (2,4,6,8,10,1);


INSERT INTO rejsy(samolot,nr_zalogi,miejsce_wylotu,kierunek_docelowy,data_lotu, odbyl_sie)
    VALUES (1,1,"Kraków", "Berlin", "2020-01-05",1);
INSERT INTO rejsy(samolot,nr_zalogi,miejsce_wylotu,kierunek_docelowy,data_lotu, odbyl_sie)
    VALUES (3,2,"Warszawa", "Rzym", "2020-12-20",0);

INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
    VALUES("Zofia","jasińska","60070422885","675756756");
INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
    VALUES("Henryk","Kowalczyk","72080138825","574574567");
INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
    VALUES("Lucyna","Dudek","69092384607","645653453");

INSERT INTO bilety(pasazer,rejs,data_zakupu)
    VALUES(2,1,"2020-01-02");
INSERT INTO bilety(pasazer,rejs,data_zakupu)
    VALUES(1,2,"2020-10-02");
INSERT INTO bilety(pasazer,rejs,data_zakupu)
    VALUES(3,2,"2020-10-03");

SELECT * FROM samoloty WHERE available = "1";
SELECT * from personel WHERE available = "1";
SELECT * from zaloga WHERE available = "1";
SELECT * from rejsy WHERE odbyl_sie = "0";
SELECT * from pasazerowie;
SELECT * from bilety;




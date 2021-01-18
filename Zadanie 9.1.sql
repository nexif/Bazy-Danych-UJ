CREATE DATABASE linia_lotnicza;
USE linia_lotnicza;

CREATE TABLE samoloty(
    id INT AUTO_INCREMENT NOT NULL,
    producent VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    numer_seryjny VARCHAR(50) NOT NULL,
    typ VARCHAR(50) NOT NULL,
    liczba_pasazerow INT NOT NULL,
    data_zakupu DATE NOT NULL,
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
    data_zakupu DATE NOT NULL,
    klasa VARCHAR(50) NOT NULL,
    pierwszenstwo_wejscia INT NOT NULL,
    skad VARCHAR(40) NOT NULL,
    dokad VARCHAR(40) NOT NULL,
    cena DECIMAL (6,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pasazer) REFERENCES pasazerowie(id)
);

CREATE TABLE rejsy(
    id INT AUTO_INCREMENT NOT NULL,
    samolot INT NOT NULL,
    nr_zalogi INT NOT NULL,
    miejsce_wylotu VARCHAR(50) NOT NULL,
    kierunek_docelowy VARCHAR(50) NOT NULL,
    nazwa_linii VARCHAR(50) NOT NULL,
    data_lotu DATE NOT NULL,
    czas_trwania INT NOT NULL,
    cargo INT NOT NULL,
    odbyl_sie INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (samolot) REFERENCES samoloty(id),
    FOREIGN KEY (nr_zalogi) REFERENCES zaloga(id)
);

CREATE TABLE karty_pokladowe(
    id INT AUTO_INCREMENT NOT NULL,
    bilet_id INT NOT NULL,
    rejs_id INT NOT NULL,
    PRIMARY KEY (id),
	FOREIGN KEY(bilet_id) REFERENCES bilety(id),
    FOREIGN KEY (rejs_id) REFERENCES rejsy(id)
);




INSERT INTO samoloty(producent, model, numer_seryjny, typ, liczba_pasazerow, data_zakupu, available) 
    VALUES ("Boeing", "737", "AGZ5432", "wąskokadługoby", 120, "2017-10-05", 1),
            ("Boeing", "747", "AGA5452", "szerokokadłubowy", 350, "2017-10-05", 1),
            ("Airbus", "A320", "GDS8429", "szerokokadłubowy", 280, "2004-01-07", 1),
            ("Airbus", "A310", "GGS8349", "wąskokadługoby", 100,  "2004-01-07", 1),
            ("Boeing", "777", "AZZ6543", "wąskokadłubowy", 140, "2019-08-22", 1);


INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
    VALUES ("Jan","Kowalski","2020-05-06", "kapitan", 1),
    ("Adam","Kowalski","2019-01-06", "kapitan", 1),
    ("Katarzyna","Kowalczyk","2018-02-01", "pierwszy_oficer", 1),
    ("Gabriela","Jaworska","2019-10-12", "pierwszy_oficer", 1),
    ("Małgorzata","Czarnecka","2019-03-10", "steward_kelner", 1),
    ("Borys","Wieczorek","2019-01-05", "steward_kelner", 1),
    ("Lucjusz","Kucharski","2019-01-05", "steward_przod", 1),
    ("Wisław","Wojciechowski","2019-05-01", "steward_przod", 1),
    ("Albin","Sawicki","2020-03-15", "steward_tyl", 1),
    ("Wojciech","Jasiński","2020-05-05", "steward_tyl", 1);

INSERT INTO zaloga(kapitan,pierwszy_oficer,steward_kelner,steward_przod,steward_tyl,available)
    VALUES (1,3,5,7,9,1), 
            (2,4,6,8,10,1);


INSERT INTO rejsy(samolot,nr_zalogi,miejsce_wylotu,kierunek_docelowy, nazwa_linii, data_lotu, czas_trwania, cargo, odbyl_sie)
    VALUES (1,1,"Warszawa", "Frankfurt", "FlyWell Airlines", "2020-12-05", 40, 200, 0),
            (2, 1, "Frankfurt", "Seul", "FlyWell Airlines", "2020-12-05", 660, 300, 0),
            (3, 1, "Kraków", "Chicago", "Good Airlines", "2020-12-20", 720, 400, 0),
            (4,2, "Rzeszów", "Monachium", "NotGoodAirlines", "2020-12-24", 60, 100, 0),
            (3,1,"Monachium", "Lizbona", "NotGoodAirlines", "2020-12-24", 360, 250, 0);

INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
    VALUES("Anna","Nowak","60070422885","675756756"),
    ("Jan","Kowalski","72080138825","574574567"),
    ("Piotr","Kwiatkowski","69092384607","645653453");

INSERT INTO bilety(pasazer,data_zakupu, klasa, pierwszenstwo_wejscia, skad, dokad, cena)
    VALUES(1,"2020-10-02", "pierwsza", 0, "Warszawa", "Seul", 436),
    (2,"2020-10-02", "ekonomiczna", 0, "Kraków", "Chicago", 470),
    (3,"2020-10-03", "ekonomiczna", 1, "Rzeszów", "Lizbona", 938);

INSERT INTO karty_pokladowe(bilet_id, rejs_id)
    VALUES (1,1),
            (1,2),
            (2,3),
            (3,4),
            (3,5);






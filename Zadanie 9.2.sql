CREATE DATABASE sklep_papierniczy;
USE sklep_papierniczy;

CREATE TABLE artykuly(
    id INT AUTO_INCREMENT NOT NULL,
    nazwa VARCHAR(50) NOT NULL,
    kategoria VARCHAR(50) NOT NULL,
    producent VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE magazyn(
    id INT AUTO_INCREMENT NOT NULL,
    id_artykulu INT NOT NULL,
    stawka_vat INT NOT NULL,
    ile_sztuk INT NOT NULL,
    cena DECIMAL(5,2) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_artykulu) REFERENCES artykuly(id)
);

CREATE TABLE klient(
    id INT AUTO_INCREMENT NOT NULL,
    nazwa VARCHAR(30) NOT NULL,
    NIP VARCHAR(12) UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE faktury(
    id INT AUTO_INCREMENT NOT NULL,
    klient_id INT NOT NULL,
    numer_faktury VARCHAR(50) NOT NULL,
    data_zamowienia DATE NOT NULL,
    wartosc DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (klient_id) REFERENCES klient(id)
);

CREATE TABLE elementyZamowienia (
    id INT AUTO_INCREMENT NOT NULL,
    id_faktury INT NOT NULL,
    id_produktu INT NOT NULL,
    ilosc INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_faktury) REFERENCES faktury(id),
    FOREIGN KEY (id_produktu) REFERENCES artykuly(id)
);

ALTER TABLE elementyZamowienia ADD column cena DECIMAL(5, 2);

INSERT INTO artykuly(nazwa, kategoria, producent) 
VALUES ("Pióro a10","piśmiennicze", "Schr"),
        ("Długopis vl30", "piśmiennicze", "Martn" ),
        ("Zeszyt A5", "notatniki", "Zet"),
        ("Pióro a20", "piśmiennicze", "Schr"),
        ("Naboje do piór", "piśmiennicze", "Changl"),
        ("Zeszyt A4", "notatniki", "Martin");


INSERT INTO magazyn(id_artykulu, stawka_vat, ile_sztuk, cena)
VALUES (1, 18, 23, 115),
        (2, 8, 15, 130),
        (3, 23, 300, 1.2),
        (4, 18, 10, 230),
        (5, 18, 500, 0.1),
        (6, 23, 100, 2);
        
INSERT INTO klient(nazwa, NIP)
VALUES ("ABC", "43656465454"),
        ("Papier", "43463743");

INSERT INTO faktury(klient_id, numer_faktury, data_zamowienia, wartosc)
VALUES (1,"1/2020","2020-10-05", 381),
        (2,"123/R/2020","2020-09-06", 330);


INSERT INTO elementyZamowienia(id_faktury, id_produktu, ilosc, cena)
VALUES (1, 1, 1, 115),
        (1, 2, 2, 260),
        (1, 3, 5, 6),
        (2, 4, 1, 230),
        (2, 5, 200, 20),
        (2, 6, 40, 80);
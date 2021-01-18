create database wypozyczalnia;
use wypozyczalnia;

CREATE TABLE przedmioty (
	id int not null auto_increment,
	tytul varchar(50) not null,
	rezyser varchar(50) not null,
	gatunek varchar(50) not null,
	rok_premiery int not null,
	cena float not null,			
	ilosc_dostepnych int not null,
	primary key(id)
);

CREATE TABLE klienci (
	id int not null auto_increment,
	imie varchar(50) not null,
	nazwisko varchar(50) not null,
	data_urodzenia date not null,
	numer_telefonu varchar(9) not null,
	primary key(id)
);

CREATE TABLE wypozyczenia(
	id	int not null auto_increment,
	id_klienta int not null,
	od_kiedy date not null,
	do_kiedy date,
	primary key(id),
	foreign key(id_klienta) references klienci(id)
);

CREATE TABLE dane_o_wypozyczeniu (
	id int NOT NULL auto_increment,
	id_wypozyczenia INT NOT NULL,
	id_plyty INT NOT NULL,
	liczba_sztuk INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY (id_wypozyczenia) REFERENCES wypozyczenia(id),
	FOREIGN KEY (id_plyty) REFERENCES przedmioty(id)
);

INSERT INTO przedmioty (tytul, rezyser, gatunek, rok_premiery, cena, ilosc_dostepnych) VALUES ("Zielona Mila", " Frank Darabont", "dramat", 1999, 40, 10);
INSERT INTO przedmioty (tytul, rezyser, gatunek, rok_premiery, cena, ilosc_dostepnych) VALUES ("Forrest Gump", "Robert Zemeckis", "komedia", 1994, 20, 12);
INSERT INTO przedmioty (tytul, rezyser, gatunek, rok_premiery, cena, ilosc_dostepnych) VALUES ("Leon Zawodowiec", "Luc Besson", "dramat", 1994, 30, 15);

INSERT INTO klienci (imie, nazwisko, data_urodzenia, numer_telefonu) VALUES ("Jan", "Kowalski", "1999-08-14", "537238234");
INSERT INTO klienci (imie, nazwisko, data_urodzenia, numer_telefonu) VALUES ("Joanna", "Mak", "1997-02-01", "573456345");
INSERT INTO klienci (imie, nazwisko, data_urodzenia, numer_telefonu) VALUES ("Dawid", "Dudek", "2003-03-12", "682039583");

INSERT INTO wypozyczenia (id_klienta, od_kiedy, do_kiedy) VALUES (1, "2020-11-01", "2020-11-07");
INSERT INTO wypozyczenia (id_klienta, od_kiedy, do_kiedy) VALUES (3, "2020-11-02", "2020-11-09");
INSERT INTO wypozyczenia (id_klienta, od_kiedy, do_kiedy) VALUES (2, "2020-11-05", "2020-11-15");
INSERT INTO wypozyczenia (id_klienta, od_kiedy) VALUES (1, "2020-11-11");


INSERT INTO dane_o_wypozyczeniu (id_wypozyczenia, id_plyty, liczba_sztuk) VALUES (1, 1, 5);
INSERT INTO dane_o_wypozyczeniu (id_wypozyczenia, id_plyty, liczba_sztuk) VALUES (3, 2, 1);
INSERT INTO dane_o_wypozyczeniu (id_wypozyczenia, id_plyty, liczba_sztuk) VALUES (2, 3, 1);
INSERT INTO dane_o_wypozyczeniu (id_wypozyczenia, id_plyty, liczba_sztuk) VALUES (1, 1, 3);

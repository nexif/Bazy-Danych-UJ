# Proszę zaprojektować bazę danych pracowników banku.
# Przy pomocy transakcji proszę podnieść pensje wszystkim pracownikom zarabiającym poniżej 2000,
# u których liczba nadgodzin wynosiła co najmniej 10% podstawowego czasu pracy.

drop database firma;
create database firma;
use firma;

create table pracownicy(
  id int not null auto_increment,
  imie varchar(25) not null,
  nazwisko varchar(25) not null,
  pesel varchar(11) not null,
  telefon varchar(9) not null,
  pensja int not null,
  available smallint not null,
  primary key (id)
);

insert into pracownicy(imie,nazwisko,pesel,telefon, pensja, available)
        values('Anna','Nowak','60070422885','675756756', 1500, 1),
        ('Jan','Kowalski','72080138825','574574567', 1400, 1),
        ('Piotr','Kwiatkowski','69092384607','645653453', 1450, 1),
        ('Wioletta', 'Chmielewska', '56031842528', '743912034', 1550, 1);

create table wyplaty(
  id int not null auto_increment,
  data_wyplaty date not null,
  pracownik int not null,
  podstawowy_czas_pracy int not null,
  przepracowane_godzin int not null,
  do_wyplaty int not null,
  primary key (id),
  foreign key (pracownik) references pracownicy(id)
);

insert into wyplaty(data_wyplaty, pracownik, podstawowy_czas_pracy, przepracowane_godzin, do_wyplaty)
    VALUES ('2020-01-10', 1, 160, 160, 1500),
           ('2020-01-10', 2, 140, 165,1640),
           ('2020-01-10', 3, 140, 160, 1657),
           ('2020-01-10', 4, 160, 240, 2325),
           ('2020-02-10', 1, 160, 220, 2062),
           ('2020-02-10', 2, 140, 140,1450),
           ('2020-02-10', 3, 140, 170, 1882),
           ('2020-02-10', 4, 160, 160, 1550);

# przed premią
select * from wyplaty;

# zwiększamy pensję o 10% premii pracownikom, których pensja jest niższa niż 2000zł i którzy wyrobili ponad 10% nadgodzin
START TRANSACTION;
    update wyplaty set do_wyplaty=1.1*do_wyplaty where przepracowane_godzin*100/wyplaty.podstawowy_czas_pracy >= 110 and do_wyplaty<2000;
COMMIT;

# po premii
select * from wyplaty;
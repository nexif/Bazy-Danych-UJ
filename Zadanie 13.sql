DROP DATABASE linia_lotnicza;
CREATE DATABASE linia_lotnicza;
USE linia_lotnicza;

CREATE TABLE samoloty(
    id INT AUTO_INCREMENT NOT NULL,
    producent VARCHAR(25) NOT NULL,
    model VARCHAR(50) NOT NULL,
    numer_seryjny VARCHAR(50) NOT NULL,
    typ VARCHAR(50) NOT NULL,
    liczba_pasazerow INT NOT NULL,
    data_zakupu DATE NOT NULL,
    zasieg INT NOT NULL,
    available INT NOT NULL, #czy samolot jest ciągle wykorzystywany
    PRIMARY KEY(id)
);

CREATE TABLE zaloga(
    id INT AUTO_INCREMENT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE personel(
    id INT AUTO_INCREMENT NOT NULL,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    data_zatrudnienia DATE NOT NULL,
    stanowisko VARCHAR(50),
    id_zalogi INT,
    available INT NOT NULL,  -- to pole sprawdza, czy ta osoba jest wciąż zatrudniona
    PRIMARY KEY(id),
    FOREIGN KEY (id_zalogi) REFERENCES zaloga(id)
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
    samolot INT,
    nr_zalogi INT,
    miejsce_wylotu VARCHAR(50) NOT NULL,
    kierunek_docelowy VARCHAR(50) NOT NULL,
    nazwa_linii VARCHAR(50) NOT NULL,
    data_lotu DATE NOT NULL,
    czas_trwania INT NOT NULL,
    cargo INT NOT NULL,
    odleglosc INT NOT NULL,
    odbyl_sie INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (samolot) REFERENCES samoloty(id),
    FOREIGN KEY (nr_zalogi) REFERENCES zaloga(id)
);

CREATE TABLE karty_pokladowe(
    id INT AUTO_INCREMENT NOT NULL,
    bilet_id INT NOT NULL,
    rejs_id INT,
    assigned int,
    PRIMARY KEY (id),
	FOREIGN KEY(bilet_id) REFERENCES bilety(id),
    FOREIGN KEY (rejs_id) REFERENCES rejsy(id)
);

#
#
#
# INSERT INTO samoloty(producent, model, numer_seryjny, typ, liczba_pasazerow, data_zakupu, available)
#     VALUES ('Boeing', '737', 'AGZ5432', 'wąskokadługoby', 120, '2017-10-05', 1),
#             ('Boeing', '747', 'AGA5452', 'szerokokadłubowy', 350, '2017-10-05', 1),
#             ('Airbus', 'A320', 'GDS8429', 'szerokokadłubowy', 280, '2004-01-07', 1),
#             ('Airbus', 'A310', 'GGS8349', 'wąskokadługoby', 100,  '2004-01-07', 1),
#             ('Boeing', '777', 'AZZ6543', 'wąskokadłubowy', 140, '2019-08-22', 1);


# INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
#     VALUES ('Jan','Kowalski','2020-05-06', 'kapitan', 1),
#     ('Adam','Kowalski','2019-01-06', 'kapitan', 1),
#     ('Katarzyna','Kowalczyk','2018-02-01', 'pierwszy_oficer', 1),
#     ('Gabriela','Jaworska','2019-10-12', 'pierwszy_oficer', 1),
#     ('Małgorzata','Czarnecka','2019-03-10', 'steward_kelner', 1),
#     ('Borys','Wieczorek','2019-01-05', 'steward_kelner', 1),
#     ('Lucjusz','Kucharski','2019-01-05', 'steward_przod', 1),
#     ('Wisław','Wojciechowski','2019-05-01', 'steward_przod', 1),
#     ('Albin','Sawicki','2020-03-15', 'steward_tyl', 1),
#     ('Wojciech','Jasiński','2020-05-05', 'steward_tyl', 1);

# INSERT INTO zaloga(kapitan,pierwszy_oficer,steward_kelner,steward_przod,steward_tyl,available)
#     VALUES (1,3,5,7,9,1),
#             (2,4,6,8,10,1);


# INSERT INTO rejsy(samolot,nr_zalogi,miejsce_wylotu,kierunek_docelowy, nazwa_linii, data_lotu, czas_trwania, cargo, odbyl_sie)
#     VALUES (1,1,'Warszawa', 'Frankfurt', 'FlyWell Airlines', '2020-12-05', 40, 200, 0),
#             (2, 1, 'Frankfurt', 'Seul', 'FlyWell Airlines', '2020-12-05', 660, 300, 0),
#             (3, 1, 'Kraków', 'Chicago', 'Good Airlines', '2020-12-20', 720, 400, 0),
#             (4,2, 'Rzeszów', 'Monachium', 'NotGoodAirlines', '2020-12-24', 60, 100, 0),
#             (3,1,'Monachium', 'Lizbona', 'NotGoodAirlines', '2020-12-24', 360, 250, 0);
#
# INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
#     VALUES('Anna','Nowak','60070422885','675756756'),
#     ('Jan','Kowalski','72080138825','574574567'),
#     ('Piotr','Kwiatkowski','69092384607','645653453');

# INSERT INTO bilety(pasazer,data_zakupu, klasa, pierwszenstwo_wejscia, skad, dokad, cena)
#     VALUES(1,'2020-10-02', 'pierwsza', 0, 'Warszawa', 'Seul', 436),
#     (2,'2020-10-02', 'ekonomiczna', 0, 'Kraków', 'Chicago', 470),
#     (3,'2020-10-03', 'ekonomiczna', 1, 'Rzeszów', 'Lizbona', 938);
#
# INSERT INTO karty_pokladowe(bilet_id, rejs_id)
#     VALUES (1,1),
#             (1,2),
#             (2,3),
#             (3,4),
#             (3,5);


# CREATE PROCEDURE samoloty_obslugujace_wiecej_niz_jedna_trase()
# BEGIN
#  SET @samolot_id = (SELECT samolot FROM rejsy GROUP BY samolot HAVING COUNT(samolot) > 1);
#  SELECT * FROM samoloty WHERE id=@samolot_id;
# END;
#
#
# CREATE PROCEDURE add_passengers()
# BEGIN
# 	INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
# 		VALUES('Rafał','Kowal','68520422885','479756756'),
# 		('Jan','Grzyb','82950138825','876574567'),
# 		('Paweł','Koza','92852384607','547653453');
#         SELECT * from pasazerowie;
# END;

DELIMITER //

create procedure add_planes()
begin
    insert into samoloty(producent, model, numer_seryjny, typ, liczba_pasazerow, data_zakupu, zasieg, available)
    values ('Airbus', 'A320', 'GDS8429', 'szerokokadłubowy', 280, '2004-01-07', 7700, 1),
    ('Airbus', 'A310', 'GGS8349', 'wąskokadługoby', 100, '2004-01-07', 9200, 1),
    ('Boeing', '777', 'AZZ6543', 'wąskokadłubowy', 140, '2019-08-22', 8400, 1);

    insert into zaloga()
    values(), (), ();
end //

call add_planes();

create procedure add_passengers()
begin
    INSERT INTO pasazerowie(imie,nazwisko,PESEL,nr_telefonu)
        VALUES('Anna','Nowak','60070422885','675756756'),
        ('Jan','Kowalski','72080138825','574574567'),
        ('Piotr','Kwiatkowski','69092384607','645653453'),
        ('Tobiasz', 'Zawadzki', '69032553636', '669740349'),
        ('Gracja', 'Woźniak', '45080429286', '574584472'),
        ('Konstancja', 'Michalska', '36021099280', '704682351'),
        ('Ludmiła', 'Zielińska', '99100540264', '671927304'),
        ('Klaudiusz', 'Sokołowski', '63122896854', '532623623'),
        ('Stanisław', 'Dąbrowski', '66120610891', '472263723'),
        ('Miłosław', 'Nowicki', '92040717695', '462236372'),
        ('Beata', 'Kowalczyk', '71061988727', '634723523'),
        ('Agnieszka', 'Jasińska', '40060762988', '743378347'),
        ('Ferdynand', 'Tomaszewski', '50120858191', '573734672'),
        ('Błażej', 'Wieczorek', '44072835597', '573834734'),
        ('Wioletta', 'Chmielewska', '56031842528', '743912034');
end //

call add_passengers();

create procedure add_personel()
begin
    INSERT INTO personel(imie, nazwisko, data_zatrudnienia, stanowisko, available)
        VALUES ('Jan','Kowalski','2020-05-06', 'kapitan', 1),
        ('Adam','Kowalski','2019-01-06', 'kapitan', 1),
        ('Katarzyna','Kowalczyk','2018-02-01', 'kapitan',  1),
        ('Małgorzata','Czarnecka','2019-03-10', 'kapitan',  1),
        ('Borys','Wieczorek','2019-01-05', 'pierwszy oficer', 1),
        ('Lucjusz','Kucharski','2019-01-05', 'pierwszy oficer', 1),
        ('Wisław','Wojciechowski','2019-05-01', 'steward',1),
        ('Albin','Sawicki','2020-03-15', 'steward', 1),
        ('Gabriela','Jaworska','2019-10-12', 'steward',1),
        ('Wojciech','Jasiński','2020-05-05', 'steward', 1),
        ('Wacław','Kowalczyk','2020-05-05', 'steward', 1),
        ('Paweł','Nowak','2020-05-05', 'steward', 1);
end //

call add_personel();

create procedure add_flights()
begin
    INSERT INTO rejsy(miejsce_wylotu,kierunek_docelowy, nazwa_linii, data_lotu, czas_trwania, cargo, odleglosc, odbyl_sie, nr_zalogi)
    VALUES('Warszawa', 'Moskwa', 'FlyWell Airlines', '2020-12-28', 40, 200, 7100, 0,1),
            ('Frankfurt', 'Monachium', 'FlyWell Airlines', '2020-12-28', 70, 300, 500, 0, 2),
            ('Kraków', 'Berlin', 'Good Airlines', '2020-12-30', 120, 400, 900, 0,3);
end //

call add_flights();

create procedure add_aircraft_crew()
begin
    SET @id = 1;
    SET @flights_nr = (SELECT COUNT(*) FROM rejsy);
    WHILE @id <= @flights_nr DO
        update personel set id_zalogi=@id, available=0 where personel.stanowisko='kapitan' and personel.available=1 limit 1;
        update personel set id_zalogi=@id, available=0 where personel.stanowisko='pierwszy oficer' and personel.available=1 limit 1;
        update personel set id_zalogi=@id, available=0 where personel.stanowisko='steward' and personel.available=1 limit 1;
        SET @id = @id + 1;
        end while;
end //

call add_aircraft_crew();

create procedure assign_planes()
begin
    set @id = 1;
    SET @flights_nr = (SELECT COUNT(*) FROM rejsy);
    WHILE @id <= @flights_nr DO
        update rejsy set samolot=@id where samolot is null limit 1;
        set @id = @id +1;
    end while;
end //

call assign_planes();

INSERT INTO bilety(pasazer,data_zakupu, klasa, pierwszenstwo_wejscia, skad, dokad, cena)
    VALUES(1,'2020-10-02', 'pierwsza', 0, 'Warszawa', 'Moskwa', 1436),
    (2,'2020-10-03', 'ekonomiczna', 0, 'Frankfurt', 'Monachium', 470),
    (3,'2020-10-08', 'ekonomiczna', 0, 'Krakow', 'Berlin', 470),
    (4,'2020-10-01', 'pierwsza', 0, 'Warszawa', 'Moskwa', 1370),
    (5,'2020-10-10', 'ekonomiczna', 0, 'Frankfurt', 'Monachium', 670),
    (6,'2020-10-03', 'ekonomiczna', 0, 'Krakow', 'Berlin', 571),
    (7,'2020-10-02', 'ekonomiczna', 0, 'Warszawa', 'Moskwa', 1471),
    (8,'2020-10-02', 'pierwsza', 0, 'Frankfurt', 'Monachium', 450),
    (9,'2020-10-02', 'ekonomiczna', 0, 'Krakow', 'Berlin', 770),
    (10,'2020-10-05', 'pierwsza', 0, 'Warszawa', 'Moskwa', 1270),
    (11,'2020-10-04', 'ekonomiczna', 0, 'Frankfurt', 'Monachium', 570),
    (12,'2020-10-01', 'ekonomiczna', 0, 'Krakow', 'Berlin', 678),
    (13,'2020-10-11', 'pierwsza', 0, 'Warszawa', 'Moskwa', 1350),
    (14,'2020-10-14', 'ekonomiczna', 0, 'Frankfurt', 'Berlin', 269),
    (15,'2020-10-16', 'pierwsza', 1, 'Krakow', 'Berlin', 938);

INSERT INTO karty_pokladowe(bilet_id, assigned)
    VALUES  (1, 0),
            (2,0),
            (3,0),
            (4,0),
            (5,0),
            (6,0),
            (7,0),
            (8,0),
            (9,0),
            (10,0),
            (11,0),
            (12,0),
            (13,0),
            (14,0),
            (15,0);

create procedure add_personel_member_for_every_long_haul_trip()
begin
    set @var = 0;
    create table long_hauls as (select id, odleglosc, nr_zalogi from rejsy where odleglosc > 5000);
    set @long_hauls_number = (select count(*) from long_hauls);
    if @long_hauls_number > 0 then
        set @dist = (select odleglosc from long_hauls limit 1);
        set @zaloga_id = (select nr_zalogi from long_hauls limit 1);
        update personel set id_zalogi=@zaloga_id where available=1 and stanowisko='steward';
        set @dist = @dist - 5000;
        if @dist > 1000 then
            while @dist > 1000 do
                update personel set id_zalogi=@zaloga_id where available=1 and stanowisko='steward';
                set @dist = @dist - 1000;
            end while;
        end if;
    end if;
end //

call add_personel_member_for_every_long_haul_trip();

create procedure add_additional_pilot_for_long_hauls()
begin
    set @var = 1;
    create table extra_long_hauls as (select id, odleglosc, nr_zalogi from rejsy where odleglosc > 7000);
    set @extra_long_hauls_nr = (select count(*) from extra_long_hauls);
    if @extra_long_hauls_nr > 0 then
        while @var <= @extra_long_hauls_nr do
            set @zaloga_id = (select nr_zalogi from extra_long_hauls where id=@var);
            update personel set id_zalogi=@zaloga_id where available = 1 and stanowisko='kapitan';
            set @var = @var + 1;
        end while;
    end if;

end //

call add_additional_pilot_for_long_hauls();

create procedure assign_tickets()
begin
    set @tickets_nr = (select count(*) from karty_pokladowe);
    set @var = 0;
    set @flight_nr = 1;
    while @var < @tickets_nr do
        update karty_pokladowe set rejs_id = @flight_nr, assigned = 1 where assigned = 0 limit 1;
        set @var = @var + 1;
        if @flight_nr < (select count(*) from rejsy) then
            set @flight_nr = @flight_nr + 1;
        else
            set @flight_nr = 1;
        end if;
    end while;
end //

call assign_tickets();


#  ZADANIE 13

set global log_bin_trust_function_creators = 1;

CREATE FUNCTION deletePlaneAndFlight()
returns varchar(10) modifies sql data
begin
    declare airplanesRows, airplaneID int;
    declare flightsRows, flightID int;
    set airplanesRows = (select count(*) from samoloty);
    set airplaneId = FLOOR( 1 + RAND( ) * (airplanesRows - 1));
    set flightsRows = (select count(*) from rejsy);
    set flightId = FLOOR( 1 + RAND( ) * (flightsRows - 1));
    update rejsy set samolot = null where samolot = airplaneId;
    delete from samoloty where id = airplaneId;
    update rejsy set samolot=null where samolot=airplaneID;
    update karty_pokladowe set rejs_id=null where rejs_id=flightID;

return 'success';
end;

# select deletePlaneAndFlight();

create function assignCaptain(flightID int)
returns int
begin
    set @crewID = (select nr_zalogi from rejsy where id=flightID);
    set @isAssigned = exists(select id from personel where id_zalogi=@crewID and stanowisko='kapitan');

    if @isAssigned <> 1 then
        set @captainID = (select id from personel where available=1 and stanowisko='kapitan' limit 1);
        update personel set id_zalogi=@crewID where id=@captainID;
        return 0;
    else
        return 1;
    end if;
end //

create function getFlightClass(biletID int)
returns varchar(30)
begin
    return (select klasa from bilety where id=biletID);
end //

create function calculateProfit(flightID int)
returns decimal(6,2)
begin
    create view v1 as select karty_pokladowe.rejs_id as rejs_id, bilety.cena as cena from karty_pokladowe join bilety on karty_pokladowe.bilet_id=bilety.id;
    return (select sum(cena) from v1 where rejs_id=flightID);
end //

create function showPassengersAndClass(flightID int)
returns varchar(30)
begin
    create view v1 as select karty_pokladowe.rejs_id as rejs_id, bilety.pasazer as pasazer, bilety.klasa as klasa from karty_pokladowe join bilety on karty_pokladowe.bilet_id=bilety.id;
    select pasazer,klasa from v1 where rejs_id = flightID;
    return 'success';
end //
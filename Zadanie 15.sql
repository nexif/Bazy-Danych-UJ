drop database if exists uklad_planetarny;
create database uklad_planetarny;
use uklad_planetarny;

create table planety(
  id int not null auto_increment,
  nazwa varchar(20) not null,
  czas_obiegu_w_dniach bigint,
  rodzaj varchar(30) not null,
  date_added date null,
  date_modified date null,
  valid smallint(1),
  primary key (id)
);

delimiter //

create trigger dodaj_date
    before insert on planety for each row
    begin
        set new.date_added=curdate();
    end //


create trigger zmodyfikowano
    before update on planety for each row
    begin
        set new.date_modified=curdate();
    end //


create trigger log_deletion
    before delete on planety for each row
    begin
        update planety set valid=0 where nazwa=old.nazwa;
        signal sqlstate '45000';
    end //



insert into planety(nazwa, czas_obiegu_w_dniach, rodzaj, valid)
VALUES ('Słońce', 0, 'gwiazda',1),
       ('Merkury', 88, 'skalista',1),
       ('Wenus', 225, 'skalista',1),
       ('Ziemia', 365, 'skalista',1),
       ('Mars', 687, 'skalista',1),
       ('Jowisz', 4333, 'gazowa',1),
       ('Saturn', 10756, 'gazowa',1),
       ('Uran', 30707, 'gazowo-skalista',1),
       ('Pluton', 90498, 'karłowata', 1);




insert into planety(nazwa, czas_obiegu_w_dniach, rodzaj, valid)
values ('Neptun', 60223, 'gazowo-skalista',1);

update planety set czas_obiegu_w_dniach=89 where nazwa='Merkury';

update planety set czas_obiegu_w_dniach=4334 where nazwa='Jowisz';

delete from planety where nazwa='Pluton';
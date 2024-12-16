create table ninja (
    id bigint not null primary key,
    nama varchar,
    desa varchar,
    regis_date date default now(),
    email varchar,
    nilai int default 90
);

insert into ninja (id, nama, desa, email, nilai) values (1, 'naruto', 'konoha', 'naruto@mail.com', 100);
insert into ninja (id, nama, desa, email, nilai) values (2, 'gaara', 'suna', 'gaara@mail.com', 90);
insert into ninja (id, nama, desa, email, nilai) values (3, 'sasuke', 'konoha', 'sasuke@mail.com', 100);
insert into ninja (id, nama, desa, email, nilai) values (4, 'kankuro', 'suna', 'kankuro@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (5, 'temari', 'suna', 'temari@mail.com', 75);
insert into ninja (id, nama, desa, email, nilai) values (6, 'shikamaru', 'cianjur', 'shikamaru@mail.com', 90);
insert into ninja (id, nama, desa, email, nilai) values (7, 'ino', 'cianjur', 'ino@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (8, 'choji', 'cianjur', 'choji@mail.com', 85);
insert into ninja (id, nama, desa, email, nilai) values (9, 'kiba', 'cianjur', 'kiba@mail.com', 88);
insert into ninja (id, nama, desa, email, nilai) values (10, 'hinata', 'citayam', 'hinata@mail.com', 80);
insert into ninja (id, nama, desa, email, nilai) values (11, 'shino', 'citayam', 'shino@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (12, 'neji', 'citayam', 'neji@mail.com', 95);
insert into ninja (id, nama, desa, email, nilai) values (13, 'tenten', 'citayam', 'tenten@mail.com', 65);
insert into ninja (id, nama, desa, email, nilai) values (14, 'sakura', 'konoha', 'sakura@mail.com', 70);
insert into ninja (id, nama, desa, email, nilai) values (15, 'kakashi', 'konoha', 'kakashi@mail.com', 96);
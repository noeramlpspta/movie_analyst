-- ====================================================================================
-- 2 sql schema
-- ddl --
-- create table
create table ninja (
    id int primary key,
    nama varchar,
    umur int,
    desa varchar,
    tgl_regis date
);

-- add/drop column
alter table ninja add column email varchar;
alter table ninja drop column umur;

-- alter data type
alter table ninja alter column id type bigint;

-- rename column
alter table ninja rename column tgl_regis to regis_date;

-- rename table 
alter table ninja rename to ninja_konoha;
alter table ninja_konoha rename to ninja;

-- set/drop not null
alter table ninja alter column desa set not null;
alter table ninja alter column desa drop not null;

-- set default
alter table ninja alter column regis_date set default now();

-- add constraint check
ALTER TABLE ninja ADD CONSTRAINT desa_check CHECK (desa = 'konoha');

insert into ninja (id, nama, desa, email) values (1, 'naruto', 'konoha', 'naruto@mail.com');
ALTER TABLE ninja DROP CONSTRAINT desa_check;
insert into ninja (id, nama, desa, email) values (2, 'gaara', 'suna', 'gaara@mail.com');


-- dml --
insert into ninja (id, nama, desa, email) values (3, 'sasuke', 'konoha', 'sasuke@mail.com');
update ninja set desa='gajelas' where nama='sasuke';
delete from ninja where nama='sasuke';

-- constraint --
ALTER TABLE ninja ADD CONSTRAINT nama_unik UNIQUE (nama);


-- ====================================================================================
-- 3 function 
-- date()
create table tesdate (tanggal varchar);
insert into tesdate values ('2023-01-01');
insert into tesdate values ('2023-04-10');
select * from tesdate where tanggal < now();
select * from tesdate where date(tanggal) < now();

-- exract()
select * from movie where extract(day from mov_dt_rel) = 11;

-- concat()
select act_id, concat(act_fname,' ',act_lname) nama_lengkap from actor;

-- string_agg()
select act_gender, string_agg(act_fname, ', ') from actor group by act_gender;

select 
    case 
        when rev_stars > 8 then 'film bagus'
        when rev_stars < 5 then 'film jelek'
    else 'film biasa'
    end as penilaian,
    string_agg(m.mov_title, ', ') judul_film
from movie m 
inner join rating r on r.mov_id = m.mov_id
group by penilaian;


-- coalesce()
select coalesce(rev_name, 'ga ada nama') from reviewer;
select coalesce(rev_name, rev_id, 'ga ada nama dan id') from reviewer;
select coalesce(rev_name, cast(rev_id as varchar), 'ga ada nama dan id') from reviewer;

-- left()
select left(mov_title, 10) from movie;

-- right()
select right(mov_title, 10) from movie;

-- length()
select mov_title, length(mov_title) panjang_judul from movie;

-- lower()
select mov_title, lower(mov_title) judul_huruf_kecil from movie;

-- json_agg()
select json_agg(mov_title) from movie;
select json_agg(film) from (select * from movie) film;

SELECT 'Tim' nama, 'Football' hobby
UNION
SELECT 'Tim' nama, 'Baseball' hobby
UNION
SELECT 'Tom' nama, 'Piano' hobby
UNION
SELECT 'Tom' nama, 'violin' hobby;

SELECT
    t.nama,
    json_agg(t.hobby) hobbies
FROM (
    SELECT 'Tim' nama, 'Football' hobby
    UNION
    SELECT 'Tim' nama, 'Baseball' hobby
    UNION
    SELECT 'Tom' nama, 'Piano' hobby
    UNION
    SELECT 'Tom' nama, 'violin' hobby
) t
GROUP BY t.nama;
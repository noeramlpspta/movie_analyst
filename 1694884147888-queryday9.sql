-- ====================================================================================
-- 4 store procedure
-- syntax SP
create [or replace] procedure procedure_name(parameter_list)
language plpgsql as $$
declare
-- variable declaration
begin
-- stored procedure body
end; $$;

create table kucing (
    id smallserial primary key,
    name varchar not null,
    balance numeric(15, 2) not null
);

insert into kucing(name, balance) values('ciki', 5000);
insert into kucing(name, balance) values('bella', 12000);

-- procedure untuk transfer duit 
create or replace procedure transfer_duit(
   sender int,
   receiver int, 
   amount dec
)
language plpgsql    
as $$
begin
    -- subtracting the amount from the sender's account 
    update kucing 
    set balance = balance - amount 
    where id = sender;

    -- adding the amount to the receiver's account
    update kucing 
    set balance = balance + amount 
    where id = receiver;

    commit;
end;$$;

select * from kucing;
call transfer_duit(2,1,3000);
select * from kucing;


-- functions
CREATE OR REPLACE FUNCTION add_numbers(
    num1 INTEGER,
    num2 INTEGER
)
RETURNS INTEGER AS $$
BEGIN
    RETURN num1 + num2;
END;
$$ LANGUAGE plpgsql;

-- call
select add_numbers(1,10);

--



-- ====================================================================================
-- 5 query optimization
-- revamp query --
-- never select data without where
select * from movie; 
select * from movie where mov_year=1990 and mov_lang='English' and id > 900;

-- never select long range of data
select * from movie where mov_year between 1500 and 2020;
select * from movie where mov_year between 2001 and 20002;

-- never use select *
select * from movie where mov_year=1990 and mov_lang='English' and id > 900;
select mov_title from movie where mov_year=1990 and mov_lang='English' and id > 900;

-- never use too many IN values
select * from movie where id in (901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 3245,345,345,2,5,6,6,7,432,12,354);
select * from movie where id in (901, 902, 903, 904);

-- never do processing data in the where filter
select * from movie where mov_year + 3 < 2000;
select * from movie where mov_year < 2000 - 3;


-- index --
-- explain analyze
explain select * from movie where mov_year = 2001;
explain analyze select * from movie where mov_year = 2001;

-- testing index
explain select * from movie where mov_year = 2001;
set enable_seqscan = off;
create index movie_year_idx on movie (mov_year);
\d movie
explain select * from movie where mov_year = 2001;


-- partition --
CREATE TABLE sales (id int, p_name text, amount int, sale_date date)
PARTITION BY RANGE (sale_date);

CREATE TABLE sales_2020_jan PARTITION OF sales FOR VALUES FROM ('2020-01-01') TO ('2020-01-31');
CREATE TABLE sales_2020_feb PARTITION OF sales FOR VALUES FROM ('2020-02-01') TO ('2020-02-29');
CREATE TABLE sales_2020_mar PARTITION OF sales FOR VALUES FROM ('2020-03-01') TO ('2020-03-31');

INSERT INTO sales VALUES (1,'baju',100,'2020-01-01');
INSERT INTO sales VALUES (2,'celana',50,'2020-01-04');
INSERT INTO sales VALUES (3,'kaos kaki',200,'2020-01-12');
INSERT INTO sales VALUES (4,'baju bola',22,'2020-01-16');
INSERT INTO sales VALUES (5,'baju kucing',77,'2020-01-23');

INSERT INTO sales VALUES (6,'laptop',124,'2020-02-01');
INSERT INTO sales VALUES (7,'hp',848,'2020-02-06');
INSERT INTO sales VALUES (8,'nutri sari',15,'2020-02-11');
INSERT INTO sales VALUES (9,'teh sisri',58,'2020-02-19');
INSERT INTO sales VALUES (10,'jasjus',124,'2020-02-27');

INSERT INTO sales VALUES (11,'bola basket',58,'2020-03-03');
INSERT INTO sales VALUES (12,'sepatu lari',29,'2020-03-15');
INSERT INTO sales VALUES (13,'tv lcd',102,'2020-03-17');
INSERT INTO sales VALUES (14,'bantal guling',54,'2020-03-19');
INSERT INTO sales VALUES (15,'selimut',98,'2020-03-30');

\d+ sales
select * from sales;
explain select * from sales;

select * from sales where sale_date = '2020-01-01';
explain select * from sales where sale_date = '2020-01-01';


-- ====================================================================================
-- 6 window function

alter table ninja add column nilai int default 90;
select * from ninja;

update ninja set nilai=100 where id=1;
update ninja set nilai=98 where id=3;
update ninja set nilai=90 where id=2;

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


-- rank ()
select  n.*, 
        rank() over (
            partition by desa 
            order by nilai desc) as ranking_ninja 
from ninja n;


select concat('si ranking satu dari ',table_ninja.desa), table_ninja.nama 
from (
    select  n.*, 
            rank() over (
                partition by desa 
                order by nilai desc) as ranking_ninja 
    from ninja n
) table_ninja
where table_ninja.ranking_ninja=1;


-- row_number()

update ninja set nilai =100 where nama='sasuke';

select  n.*, 
        row_number() over (
            partition by desa 
            order by nilai desc) as ranking_ninja 
from ninja n;


select concat('si urutan satu dari ',table_ninja.desa), table_ninja.nama 
from (
    select  n.*, 
            row_number() over (
                partition by desa 
                order by nilai desc) as ranking_ninja 
    from ninja n
) table_ninja
where table_ninja.ranking_ninja=1;

-- CTE
with actor_cewe as (
    select * from actor where act_gender='F'
)
select * 
from movie_cast r 
inner join actor_cewe on actor_cewe.act_id=r.act_id;
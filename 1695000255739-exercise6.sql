-- Cari movie id yang bahasa film nya bahasa Jepang
select m.mov_id from movie m where m.mov_lang = 'Japanese';

-- Cari judul film yang rilis sebelum tahun 2000
select mov_title from movie where mov_year < 2000;

-- Cari judul film yang durasi nya lebih dari 100 dan bahasa Inggris
select mov_title from movie where mov_time > 100 and mov_lang = 'English';

-- Cari asal negara film dari database movie
select mov_rel_country from movie;
select distinct mov_rel_country from movie;

-- Hitung jumlah movie yang punya kata “the” di judulnya
select count(*) from movie where mov_title like '%The%';
select mov_title from movie where mov_title like '%The%';

-- Cari durasi maksimal film yang ada di table movie
select max(mov_time) from movie;

-- Hitung jumlah total durasi kalau semua film di atas tahun 2000 digabungkan
select sum(mov_time) from movie where mov_year > 2000;
select *  from movie where mov_year > 2000;

-- Hitung jumlah film berdasarkan bahasanya (bahasa inggris = 3 film, bahasa jepang = 2 film, dst)
select mov_lang bahasa, count(mov_id) jumlah from movie group by mov_lang;

-- Hitung jumlah film berdasarkan bahasanya (bahasa inggris = 3 film, bahasa jepang = 2 film, dst) dan cari yg kurang dari 5 film
select mov_lang bahasa, count(mov_id) jumlah from movie group by mov_lang having count(mov_id) < 5;

-- Berikan label ke setiap film, kalau tahun rilis kurang dari 2000, labelnya “film lama”, kalau tahun rilis lebih dari 2000, labelnya “film baru”
select *, 
    case 
        when mov_year < 2000 then 'film lama' 
        else 'film baru' 
    end as label
from movie;
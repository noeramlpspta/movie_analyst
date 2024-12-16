
-- 1
select m.mov_title actor, mc.role
from movie m
inner join movie_cast mc on mc.mov_id = m.mov_id
where mc.role = 'Alice Harford';

-- 2
select m.mov_title title, g.gen_title genre
from movie m 
inner join movie_genres mg on mg.mov_id = m.mov_id
inner join genres g on g.gen_id = mg.gen_id;

-- 3
select g.gen_title title, avg(rev_stars) avg_rating
from movie m 
inner join movie_genres mg on mg.mov_id = m.mov_id
inner join genres g on g.gen_id = mg.gen_id
inner join rating r on r.mov_id = m.mov_id
group by g.gen_title
order by avg_rating desc;

-- 4
select m.mov_year, count(mov_id) jumlah_film
from movie m 
group by m.mov_year
order by jumlah_film desc;

-- 5
select *
from actor a 
inner join movie_cast mc on mc.act_id = a.act_id
where mc.role = 'Sean Maguire';

-- 6
select m.mov_title, r.rev_stars
from movie m 
inner join movie_genres mg on mg.mov_id = m.mov_id
inner join genres g on g.gen_id = mg.gen_id
inner join rating r on r.mov_id = m.mov_id
where r.rev_stars is not null
order by r.rev_stars;

-- 7
select count(a.act_id)
from movie m
inner join movie_cast mc on mc.mov_id = m.mov_id
inner join actor a on a.act_id = mc.act_id
where a.act_gender = 'F' and m.mov_year > 2000;

-- 8 
select count(a.act_id)
from movie m
inner join movie_cast mc on mc.mov_id = m.mov_id
inner join actor a on a.act_id = mc.act_id
group by a.act_id
having count(a.act_id) > 1;


-- 9
select mc.act_id, mc.mov_id, concat(a.act_fname, ' ', a.act_lname) as nama, r.rev_stars
from movie_cast mc
inner join actor a on mc.act_id = a.act_id
inner join rating r on mc.mov_id = r.mov_id
where act_gender = 'F'
order by rev_stars desc
limit 1;


-- 10
select rv.rev_name, rt.rev_stars
from reviewer rv 
inner join rating rt on rt.rev_id = rv.rev_id
where rt.rev_stars > 8 and rv.rev_name is not null;


-- 11
select g.gen_title, count(d.dir_id)
from movie m
inner join movie_direction md on md.mov_id = m.mov_id
inner join director d on d.dir_id = md.dir_id
inner join movie_genres mg on mg.mov_id = m.mov_id
inner join genres g on g.gen_id = mg.gen_id
where g.gen_title='Drama'
group by g.gen_title;

-- 12
select act_gender, count(act_id) from actor group by act_gender;

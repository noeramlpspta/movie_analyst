-- inner join
select * 
from movie m
inner join movie_cast mc on mc.mov_id = m.mov_id;

select * 
from movie m
left  join movie_cast mc on mc.mov_id = m.mov_id;

insert into movie_cast values (222, null, 'kucing lucu');

select * 
from movie m
right join movie_cast mc on mc.mov_id = m.mov_id;


-- union
select act_id id, act_fname fname, act_lname lname from actor
union all
select dir_id id, dir_fname fname, dir_lname lname from director;

insert into actor values (999, 'kucing', 'lucu');
insert into director values (999, 'kucing', 'lucu');

select act_id id, act_fname fname, act_lname lname from actor
union
select dir_id id, dir_fname fname, dir_lname lname from director;


-- subquery
select mov_id, mov_title from movie where mov_year > 2000;

select *
from (select mov_id, mov_title from movie where mov_year > 2000) as f2000an
inner join rating r on r.mov_id = f2000an.mov_id;

select f2000an.mov_title, rev_stars
from (select mov_id, mov_title from movie where mov_year > 2000) as f2000an
inner join rating r on r.mov_id = f2000an.mov_id;

select mov_id, rev_stars,
    case 
        when rev_stars between 0 and 5 then 'film jelek'
        when rev_stars between 6 and 7 then 'film lumayan'
        when rev_stars between 8 and 10 then 'film bagus'
    else 'blm ada rating'
    end as status_rating
from rating;


select f2000an.mov_title, rs.status_rating
from (select mov_id, mov_title from movie where mov_year > 2000) as f2000an
inner join 
    (
        select mov_id, rev_stars,
        case 
            when rev_stars between 0 and 5 then 'film jelek'
            when rev_stars between 5 and 7 then 'film lumayan'
            when rev_stars between 7 and 10 then 'film bagus'
        else 'blm ada rating'
        end as status_rating
    from rating
    ) as rs on rs.mov_id = f2000an.mov_id;


-- order by
select * from movie order by mov_year;
select * from movie order by mov_year desc;
select * from movie order by mov_title;

-- limit
select * from movie limit 5;
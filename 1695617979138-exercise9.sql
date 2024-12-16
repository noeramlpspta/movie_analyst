-- use ninja dataset, create stored procedure for inserting data
CREATE OR REPLACE PROCEDURE insert_data_into_table(
    p_name varchar(255),
    p_age integer,
    p_email varchar(255)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO your_table (name, age, email)
    VALUES (p_name, p_age, p_email);
END;
$$;

-- use ninja dataset, create stored procedure for deducting nilai to specific ninja
create procedure kurangin_nilai(siapa int, pengurangan int)
language plpgsql as $$
begin
    update ninja
    set nilai = nilai - pengurangan
    where siapa = id;
    commit;
end; $$;

call kurangin_nilai(8, 50);

-- use ninja dataset, give the row number based on name alphabet
select *, row_number() over (
    order by nama
) as nomor_urut_abjad
from ninja;


-- use movie dataset, find the most favorite director for each genre (rank)
select  g.gen_title, d.dir_fname, r.rev_stars, 
    rank() over (
        partition by g.gen_id
        order by r.rev_stars
    ) as ranking_dir
from movie m 
inner join movie_direction md on md.mov_id = m.mov_id
inner join director d on d.dir_id = md.dir_id
inner join movie_genres mg on mg.mov_id = m.mov_id
inner join genres g on g.gen_id = mg.gen_id
inner join rating r on r.mov_id = m.mov_id;


-- use movie dataset, find a movie title that has a character named Alice Harford, create an index for the query, show explain result before and after
select m.mov_title actor, mc.role
from movie m
inner join movie_cast mc on mc.mov_id = m.mov_id
where mc.role = 'Alice Harford';

create index on movie_cast (role);

-- use movie dataset, find actor that has played as Sean Maguire, create an index for the query, show explain result before and after
select *
from actor a 
inner join movie_cast mc on mc.act_id = a.act_id
where mc.role = 'Sean Maguire';

create index on movie_cast (role);


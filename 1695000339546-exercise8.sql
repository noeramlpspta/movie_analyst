-- data modeling exercise
-- 1
UNF:
Car Dealership(Salesperson, Manufacturer, Model, Year, Color, Price)

1NF:
Salespersons(SalespersonID, Salesperson)
Manufacturers(ManufacturerID, Manufacturer)
Cars(CarID, SalespersonID, ManufacturerID, Model, Year, Color, Price)

2NF:
Salespersons(SalespersonID, Salesperson)
Manufacturers(ManufacturerID, Manufacturer)
Cars(CarID, SalespersonID, ManufacturerID, Model, Year, Color)
CarPrices(CarID, Price)

3NF:
Salespersons(SalespersonID, Salesperson)
Manufacturers(ManufacturerID, Manufacturer)
Models(ModelID, Model, ManufacturerID)
Cars(CarID, SalespersonID, ModelID, Year, Color)
CarPrices(CarID, Price)

-- 2
UNF:
School(StudentID, StudentName, Address, Phone, TeacherName, Class, Grade)

1NF:
Students(StudentID, StudentName, Address, Phone)
Classes(TeacherName, Class, Grade, StudentID)

2NF:
Students(StudentID, StudentName, Address, Phone)
Classes(TeacherName, Class, Grade)
Enrollments(StudentID, TeacherName, Class)

3NF:
Students(StudentID, StudentName, Address, Phone)
Classes(TeacherName, Class, Grade)
Enrollments(StudentID, TeacherName, Class)

-- query exercise
-- create exercise 1
-- book
create table book (
    id serial primary key,
    title varchar not null,
    release_date date not null,
    genre varchar not null
);

-- publisher
create publisher (
    id serial primary key,
    name varchar not null,
    address varchar not null
);


-- mapping
create table book_publisher (
    book_id int,
    pub_id int
)


-- create exercise 2
-- students
create table students (
    id serial primary key,
    name varchar not null,
    dob date not null check (extract(year from dob) > 1900),
    email varchar unique default null
);

-- courses
create table courses (
    id serial primary key,
    course_title varchar not null,
    course_duration int not null default 45
);

-- mapping
create table student_courses (
    student_id int,
    course_id int
)

-- query practice
-- 1
select mov_dt_rel, extract(day from mov_dt_rel) from movie;

-- 2
select mov_dt_rel, coalesce(extract(day from mov_dt_rel), '0') from movie;

-- 3
select concat(act_fname, ' ', act_lname) full_name_act from actor;

-- 4
select max(length(mov_title)) from movie;

-- 5
select  act_gender, string_agg(act_fname, ', ')
from actor a 
group by act_gender;

-- 6
select *,coalesce(mov_dt_rel, now()::date) from movie;



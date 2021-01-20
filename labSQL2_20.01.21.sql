show databases;
use sakila;
show tables;

-- 1 Get release years.

select distinct release_year as Release_Years from film;

-- 2 Get all films with ARMAGEDDON in the title.

select title from film
where title like '%ARMAGEDDON%';

-- 3 Get all films which title ends with APOLLO.

select title from film
where title like '%APOLLO';

-- 4 Get 10 the longest films.

select title as Title, length as movie_length from film
order by length desc
limit 10;

-- 5 How many films include Behind the Scenes content?

select count(*) as extra_content from film
where special_features like '%Behind the Scenes%';

-- 6 Drop column picture from staff.

select * from staff limit 5;
alter table staff drop column picture;
select * from staff limit 5;

-- 7 A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

select * from customer
where first_name = 'TAMMY' and last_name = 'SANDERS';
insert into staff(first_name, last_name, address_id, email, store_id, active, username, password)
values('TAMMY','SANDERS', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'tammy', 'password123');
select * from staff;

-- 8 Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
 -- You can use current date for the rental_date column in the rental table. 
 -- Hint: Check the columns in the table rental and see what information you would need to add there.
--  You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
 -- To get that you can use the following query:

select * from rental limit 3;
 
select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- (130)
select film_id from film where title = 'ACADEMY DINOSAUR';
-- (1)
select * from staff;
-- (1) 

insert into rental(rental_date, inventory_id, customer_id, return_date, staff_id)
values ('2021-01-20 19:15',1, 130, NULL, 1);

select * from rental where customer_id = '130';
 
 -- 9 Delete non-active users, but first, create a backup table deleted_users to store customer_id, email,
 -- and the date for the users that would be deleted.
 -- Follow these steps:
-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Insert the non active users in the table backup table
-- Delete the non active users from the table customer

select * from customer
where active = 0;

drop table if exists deleted_users;

create table deleted_users (
customer_id INTEGER NOT NULL,
first_name varchar(30), 
last_name varchar(50),
email varchar(50),
delete_date varchar(20))
;

insert into deleted_users
select customer_id, first_name, last_name, email, '2021-01-21' from customer where active =0;

delete from customer where active = 0;

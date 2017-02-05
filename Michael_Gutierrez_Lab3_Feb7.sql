-- Michael Gutierrez
-- Lab 3

-- 1. List the order number and total dollars of all orders
select ordNumber, totalusd
from orders;


-- 2. List the name and city of agents named Smith.
select name, city
from agents
where name = 'Smith';


-- 3. List the id,	name, and price of products with quantity more than 200,100. 
Select pid, name, priceusd
from products
where quantity > 200100;


-- 4. List the names and cities	of customers in Duluth. 
select name, city
from customers
where city = 'Duluth';


-- 5. List the names of agents not in New York  and not in Duluth. 
select name
from agents
where aid not in (
    select aid
    from agents
    where city in ('New York', 'Duluth')
);


-- 6. List all data for products in neither Dallas nor Duluth that cost US$1 or more. 
select *
from products
where priceusd >= 1
    Intersect
select *
from products
where city not in ('Dallas','Duluth');


-- 7. List all data for orders in February or May. 
select *
from orders
where month in ('Feb','May');


-- 8. List all data for orders in February of US$600 or  more. 
select *
from orders
where month = 'Feb'
	Intersect
select *
from orders
where totalusd >= 600;


-- 9. List all orders from the customer	whose cid is C005.
select ordnumber 
from orders
where cid = 'c005';

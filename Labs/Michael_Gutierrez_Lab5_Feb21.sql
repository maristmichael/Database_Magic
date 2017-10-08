-- Michael Gutierrez
-- Lab 5
--
--
-- 1. The cities of agents booking an order for a customer whose id is 'c006'
select agents.city as "Agent City"
from orders inner join agents    on agents.aid = orders.aid
	    inner join customers on orders.cid = customers.cid 
where customers.cid = 'c006';


-- 2. The ids of products ordered through any agent who makes at least one order
-- for a customer in Kyoto, sorted by pid from high to low
select distinct orders.pid as "Product ID"
from orders inner join agents    on agents.aid    = orders.aid
	    inner join customers on customers.cid = orders.cid
where customers.city = 'Kyoto'
order by "Product ID" DESC;


-- 3. The names of customers who have not placed an order
select name as "Customer Name"
from customers 
where cid not in (
	select cid
	from orders
);


-- 4. The names of customers who have not placed an order
select customers.name as "Customer Name"
from customers left outer join orders on customers.cid = orders.cid
where orders.ordNumber is null;


-- 5. The names of customers who placed at least one order through an agent in their own city along with
-- the names of those agents

select distinct customers.name as "Customer Name",
		agents.name  	as "Agent Name"
from orders inner join agents    on agents.aid    = orders.aid
	    inner join customers on customers.cid = orders.cid
where customers.city = agents.city;


-- 6. The names of customers and agents living in the same city along with the name of the shared city,
-- regardless of whether or not the customer has ever placed an order with that agent
select customers.name as "Customer Name",
       agents.name    as "Agent Name",
       customers.city as "Shared City"
from customers inner join agents on agents.city = customers.city;


--7. The names and cities of customers who live in the city that makes fewest different kinds of products
select name as "Customer Name", 
       city as "Customer City"
from customers
where city in (
    select city
    from products
    group by city
    order by count(*) ASC
    limit 1
);


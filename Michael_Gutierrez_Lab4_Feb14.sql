-- 1. Cities of agents booking an order for a customer whose cid is 'c006'
select city
from agents
where aid in (
    select aid
    from orders
    where cid = 'c006'
);

-- 2. The distinct pids of products ordered through any agent who takes at
-- 	  at least one order from a customer in Kyoto, sorted by pid from high to low
select distinct pid
from orders
where aid in (
    select aid
    from orders
    where cid in (
        select cid
        from customers
        where city in ('Kyoto')
    )
)
order by "pid" DESC;

-- 3. The ids and names of customers who did not place an order through agent a01
select cid, name
from customers
where cid in (
    select cid 
    from orders
    where cid not in (
    	select cid 
    	from orders
    	where aid in ('a01')
    )
);

-- 4. The ids of customers who ordered product p01 and p07
select cid
from orders
where pid in ('p07')
and cid in (
    select cid
    from orders
    where pid in ('p01')
);

-- 5. The ids of products not ordered by any customers who placed any order
--    through agent a08 in pid order from high to low
select pid
from products
where pid not in (
    select pid
    from orders
    where aid in ('a08')
)
order by "pid" DESC;

-- 6. The names, discounts, and cities of all customers who place orders through
--    agents in Tokyo or New York
select name, discount, city
from customers
where cid in (
	select cid 
    from orders
    where aid in (
        select aid
        from agents 
        where city in ('Tokyo','New York')
    )
);

-- 7. All customers who have the same discount as that of any customers in Duluth
--    or London
select *
from customers
where discount in (
    select discount
	from customers
	where city in ('Duluth','London')
);

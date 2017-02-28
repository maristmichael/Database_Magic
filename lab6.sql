-- 1. 
select name as "Customer Name", 
       city as "Customer City"
from customers
where city in (
    select city
    from products
    group by city
    order by count(*) DESC
    limit 1
);

-- 2.
select name as "Product Name"
from products
where priceUSD > (
	select avg(priceUSD)
	from products
)
order by "Product Name" DESC;

-- 3.
select customers.name as "Customer Name",
	orders.pid    as "Product ID",
	sum(orders.totalUSD) as "Total Ordered USD"
from orders inner join customers on customers.cid = orders.cid
group by customers.name, orders.pid
order by "Total Ordered USD"

-- 4. 
select 
	COALESCE(customers.name, 'NO NAME') as "Customer Name", 
	COALESCE(sum(orders.totalUSD), '0') as "Total Orders USD"
from orders right outer join customers on customers.cid = orders.cid
group by "Customer Name"
order by "Customer Name" ASC;

-- 5.
select customers.name as "Customer Name",
       products.name  as "Product Name",
       agents.name    as "Agent Name"
from orders inner join customers on customers.cid = orders.cid
	    inner join agents    on agents.aid = orders.aid
	    inner join products  on products.pid = orders.pid
where orders.pid in (
	select pid
	from products
	where city = 'Newark'
)
 -- 6.
select orders.ordNumber, orders.month, orders.cid, orders.aid, orders.pid, orders.qty, orders.totalUSD
from orders inner join customers on customers.cid = orders.cid
	    inner join products  on products.pid  = orders.pid
where totalUSD not in (products.priceUSD * orders.qty * (1-customers.discount/100))

-- 7.
/* 
Left outer join compares two tables, keeping all records from the first table, and
returns the data where a match is available otherwise a corresponding null is returned.
Right outer join is the same except you are keeping all the records from the second table instead.

Using the CAP database as an example,

select distinct customers.cid, orders.cid
from customers left outer join orders on customers.cid = orders.cid
order by customers.cid ASC;

This query compares the cids orders made by customers against the cids of customers as the base.
The first column of the result set shows us all the customers. The second column shows us
whether or not the customer has placed an order. If a customer has not placed an order then null is shown.

select distinct orders.cid, customers.cid
from customers right outer join orders on customers.cid = orders.cid
order by orders.cid ASC;

This query compares the cids of customers against the cids of orders made by customers as the base.
The first column of the result set shows us all the customers who placed an order. The second column shows us
those same customers but from their matching cids in the customers table. There are no nulls because we are only
matching customers who have placed an order.


*/
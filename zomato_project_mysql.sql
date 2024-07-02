create database Zomato_project;
use zomato_project;
create table salespeople(snum int,sname char(30),city char(30),comm decimal(3,2));
desc salespeople;
insert into salespeople values(1001,'Peel','London','0.12'),
(1002,'Serres','San Jose','0.13'),
(1003,'Axelrod','New York','0.10'),
(1004,'Motika','London','0.11'),
(1007,'Rafkin','Barcelona','0.15');
select * from salespeople;
create table Cust(cnum int,cname char(30),city char(30),rating int,snum int);
desc cust;
insert into cust values(2001,'Hoffman','London',100,1001),(2002,'Giovanne','Rome',200,1003),
(2003,'Liu','San jose',300,1002),(2004,'Grass','Berlin',100,1002),
(2006,'Clemens','London',300,1007),(2007,'Pereira','Rome',100,1004),(2008,'James','London',200,1007);
select * from Cust;
create table orders(onum int,amt float,odate date,cnum int,snum int);
desc orders;
insert into orders values(3001,'18.69','1994-10-03',2008,1007),(3002,'1900.10','1994-10-03',2007,1004),
(3003,'767.19','1994-10-03',2001,1001),(3005,'5160.45','1994-10-03',2003,1002),
(3006,'1098.16','1994-10-04',2008,1007),(3007,'75.75','1994-10-05',2004,1002),
(3008,'4723.00','1994-10-05',2006,1001),(3009,'1713.23','1994-10-04',2002,1003),
(3010,'1309.95','1994-10-06',2004,1002),(3011,'9891.88','1994-10-06',2006,1001);
select * from orders;

-- 4. Write a query to match the salespeople to the customers according to the city they are living.
select cust.cname as customer_name,
salespeople.sname as salesperson_name,
cust.city as city from cust
join salespeople ON cust.city=salespeople.city;

-- 5. Write a query to select the names of customers and the salespersons who are providing service to them.
select cust.cname,salespeople.sname from cust,salespeople
 where salespeople.snum=cust.snum;
 
-- 6. Write a query to find out all orders by customers not located in the same cities as that of their salespeople.
select onum,cname,orders.cnum,orders.snum from salespeople,cust,orders
 where cust.city<>salespeople.city
 AND orders.cnum=cust.cnum
 AND orders.snum=salespeople.snum;

-- 7. Write a query that lists each order number followed by name of customer who made that order.
select orders.onum,cust.cname from orders
inner join cust ON orders.cnum=cust.cnum;

-- 8. Write a query that finds all pairs of customers having the same rating. 
select cust1.cname as costumer1, cust2.cname as customer2,cust1.rating from cust as cust1
inner join cust as cust2 on cust1.rating=cust2.rating
where cust1.cnum < cust2.cnum;

-- 9. Write a query to find out all pairs of customers served by a single salesperson.
Select cname from cust
 where snum in (select snum from cust
                group by snum
                having count(cname) > 1);	

Select distinct a.cname
from cust a ,cust b
where a.snum = b.snum and a.cnum <> b.cnum;
 
 -- 10.	Write a query that produces all pairs of salespeople who are living in same city. 
 SELECT m.sname,n.sname,m.city
FROM salespeople m,salespeople n
WHERE m.city=n.city
  AND m.sname<n.sname; -- (this avoids dublicate pairing)
  
-- 11. Write a Query to find all orders credited to the same salesperson who services Customer 2008. 
  select * from orders where snum = (select distinct snum from orders where cnum = 2008);
  
-- 12. Write a Query to find out all orders that are greater than the average for Oct 4th. 
select * from orders where amt > (select avg(amt) 
from orders where odate = '1994-10-04');

-- 13. Write a Query to find all orders attributed to salespeople in London.
select o. * from orders as o 
join salespeople as s ON o.snum=s.snum
where s.city = 'London';
select * from orders join salespeople on orders.snum=salespeople.snum
where salespeople.city = 'London';

-- 14. Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 
select * from cust
 where cnum = (select snum from salespeople where sname = 'Serres')+1000;
 
-- 15. Write a query to count customers with ratings above San Jose’s average rating.
select count(*) as total_count from cust
where rating > (select avg(rating) from cust where city = 'San Jose');

-- 16. Write a query to show each salesperson with multiple customers. 
SELECT * FROM salespeople a
WHERE 1 < (SELECT COUNT(*) FROM cust b
WHERE a.snum = b.snum);

Select snum from cust
group by snum having count(*) > 1;

 

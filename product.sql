			Product - Order System

Q1)Retrieve the customer ids of any product which has been ordered by agent "a06".
As)select distinct o.cid from Orders o,Product p where p.pid = o.pid and o.aid = 'a06';

Q2)Retrieve cities in which customers or agents located
As)select city from Customer union select city from Agent;

Q3)List product ids which have been ordered by agents from the cities “Dargeling” or 
“Srinagar”.
As) select distinct(o.pid) from Orders o, Agent a where o.aid = a.aid and a.city in('Darjeling','Srinagar');

Q4)Retrieve customer ids whose discounts are less than the maximum discount.
As)select cid from Customer where discount < (select max(discount) from Customer);

Q5)Retrieve product ids ordered by at least two customers.
As)select p.pid from Product p where 2 <= (select count(distinct cid) from Orders where pid = p.pid);

Q6)For each (aid,pid) pair get the sum of the orders aid has placed for pid.
As)select aid, pid, sum(qty) TOTAL from Orders where group by aid,pid;  

Q7)Retrieve product ids and total quantity ordered for each product when the total 
exceeds 1000.
As)select pid,aid,sum(qty) from Orders group by aid,pid having sum(qty)>1000;

Q8)List the names of the customers and agent who placed an order through that agent.
As)select distinct c.cname,a.aname from Customer c,Agent a,Order o where c.cid = o.cid and a.aid = o.aid;

Q9)Retrieve the order numbers placed by customers in "Dargeling" through agents 
in "NewDelhi".
As)select ordno from Orders where cid in(select cid from Customer where city = 'Darjeling') and aid in(select aid from Agent where city = 'New Delhi');

2j) Retrieve names of the customers who have the same discount as that of any (one) 
of the customers in "Dargeling" or "Bangalore".
SQL> select cname from customer where discount =any (select discount from customer
 where city = ’Darjeling’ or city = ’Bangalore’);

2bK) Retrieve customer ids with smaller discounts than every customer from "Srinagar"
SQL> select cid from customer
 where discount < all (select discount from customer 
 where city = ’Srinagar’);

2 B I) Retrieve names of the customers who have placed an order through agent 
"a05"
 (using exists )
SQL> select c.cname from customer c 
 where exists (select * from orders o
 where c.cid = o.cid and o.aid = ’a05’);

2 B m) Retrieve names of the customers who do not place orders through agent 
"a05". 
(using not exists)
select cname from customer 
 where cid not in (select cid from orders where orders.aid = 'a05');

2 B n) Retrieve customer ids whose orders placed through all the agents in "New 
Delhi".
 Get cid values of customers such that (the set of agents from " NewDelhi " through 
 whom the customer has NOT placed an order) is EMPTY.

SQL> select c.cid from customer c 
 where not exists (select * from agent a where a.city = ’NewDelhi’ 
and 
 not exists (select * from orders o,customer c ,agent a where 
 o.cid=c.cid and o.aid=a.aid));


2 b o). Retrieve agent ids either from "NewDelhi" or "Srinagar" who place orders for ALL products priced over fifteen rupee. Get aid values of agents from "New York" or "Duluth" such that (the set of products priced over one dollar that the agent has NOT ordered) is EMPTY.

SQL> select a.aid from agent a 
 where (a.city in (’NewDelhi’,’Srinagar’)) and 
 not exists (select p.pid from product p where p.price > 15.00 
 and
 not exists (select * from orders o 
 where o.pid = p.pid and o.aid = a.aid));

2b p).Retrieve names and ids of the customers and agents along with total sales for that pair. Order the result from largest to smallest total sales. Also retain only those pairs for which total rupee sales is at least 9000.00.
SQL> select c.cname, c.cid, a.aname, a.aid, sum(o.ordamount)
 from customer c, orders o, agent a
where c.cid = o.cid and o.aid = a.aid
group by c.cname, c.cid, a.aname, a.aid
 having sum(o.ordamount) >= 9000.00
 order by 5 desc;

2 B q) Increase the percent commission by 50% for all agents in "NewDelhi".
SQL> update agent
set percent = 1.5 * percent
where city = ’NewDelhi;

2 B r). Retrieve the total quantity that has been placed for each product 
SQL> select pid, sum(qty) TOTAL from orders group by pid;


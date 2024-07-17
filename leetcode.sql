use leetcode;

#181
create table employee(id int, name varchar(15),salary int, managerId int);
insert into employee values (1, 'Joe',70000,3),
                            (2,'Henry',80000,4),
                            (3,'Sam',60000,null),
                            (4,'Max',90000,null);
select * from employee;

select e.name from employee e join employee m where e.managerId = m.id and e.salary > m.salary;

update employee set salary = salary * 2;

select employee.salary from employee;

#1581
create table visits(visit_id varchar(10), customer_id varchar(10));
insert into visits values (1,23),(2,9),(4,30),(5,54),(6,96),(7,54),(8,54);

create table transactions(transaction_id varchar(10), visit_id varchar(10), amount int);
insert into transactions values (2,5,310),(3,5,300),(9,5,200),(12,1,910),(13,2,970);


#197
create table weather(id int, date date, temperature int);
insert into weather values (1, '2015-01-01',10), (2 , '2015-01-02' , 25 ),(3 ,  '2015-01-03' , 20 ),(4, '2015-01-04',30 );

select * from weather;
select w1.id from weather w1, weather w2 where datediff(w1.date, w2.date) = 1 and w1.temperature > w2.temperature;


#619
create table mynumbers(num int);
insert into mynumbers values (8),(8),(3),(3),(1),(4),(5),(6);
select * from mynumbers;
select m.num from mynumbers m group by m.num having count(*) = 1 order by m.num desc;

select max(num) as num from (select m.num from mynumbers m group by m.num having count(*) = 1 order by m.num desc) a;


#1045
create table customer(custom_id int, product_key int);
insert into customer values (1,5),(2,6),(3,5),(3,6),(1,6);

select min(customer.custom_id), product_key from customer;

create table product(product_key int);
insert into product value (5),(6);

select c.custom_id from customer c group by c.custom_id having count(distinct c.product_key) = (select count(*) from product);

select count(distinct custom_id) / (select count(*) from product) from customer;

select e1.reports_to as employee_id, e2.name, count(*) reports_count, round(avg(e1.age)) average_age from employees e1 join employees e2 on e1.reports_to = e2.employee_id group by e1.reports_to order by e1.reports_to;



#169
select * from person;
select p1.Id, p1.Email from person p1 join person p2 on p1.Email = p2.Email where p1.Id < p2.Id;
select Id, Email from person where Email not in (select p1.Email from person p1 join person p2 on p1.Email = p2.Email where p1.Id < p2.Id) union (select p1.Id, p1.Email from person p1 join person p2 on p1.Email = p2.Email where p1.Id < p2.Id) order by Id;


use leetcode;

#602
Create table If Not Exists RequestAccepted (requester_id int not null, accepter_id int null, accept_date date null)
Truncate table RequestAccepted
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '2', '2016/06/03')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('1', '3', '2016/06/08')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('2', '3', '2016/06/08')
insert into RequestAccepted (requester_id, accepter_id, accept_date) values ('3', '4', '2016/06/09');

select * from RequestAccepted
drop table RequestAccepted;

select t.id, t.num from (select m.requester_id as id, count(*) as num from ((select r.requester_id from RequestAccepted r) union all (select r.accepter_id from RequestAccepted r)) m group by m.requester_id) t where t.num = (select max(t.num) from (select m.requester_id as id, count(*) as num from ((select r.requester_id from RequestAccepted r) union all (select r.accepter_id from RequestAccepted r)) m group by m.requester_id) t);
use quang;
create table employees
(
    emp_id    int,
    emp_name  VARCHAR(30),
    dept_name varchar(30),
    salary    double
);
insert into employees
values (101, 'Mohan', 'Admin', 4000),
       (102, 'Rajkuma', 'HR', 3000),
       (103, 'Akbar', 'IT', 4000),
       (104, 'Dorvin', 'Finance', 6500),
       (105, 'Rohit', 'HR', 3000),
       (106, 'Rajesh', 'Finance', 5000);
select *
from employees;

create table department
(
    dept_id   varchar(30),
    dept_name varchar(30),
    location  varchar(30)
);
insert into department
values (1, 'Admin', 'Bangalore'),
       (2, 'HR', 'Bangalore'),
       (3, 'IT', 'Bangalore'),
       (4, 'Finance', 'Mumbai'),
       (5, 'Marketing', 'Bangalore');
select *
from department;
delete
from department
where dept_id = 5;

select avg(employees.salary) average
from employees;

select *
from employees
where salary > (select avg(salary) from employees);

#Kết bảng bằng sub query(ta phải đặt ten trong quá trình này)
#nếu ta kết với 1 vô hướng thì cả cột mới được thêm vào sẽ laf cột chứa toàn vô hướng đó

select *
from employees e
         join (select avg(employees.salary) sal from employees) avg_sal on e.salary > avg_sal.sal;


select *
from employees e
         join (select employees.emp_id, employees.emp_name from employees) e2 on e.emp_name = e2.emp_name;

#Với mỗi phòng ban tìm nhân viên có lương cao nhất của phòng ban đó
select *
from employees
where salary in (select max(salary) from employees group by dept_name);

#In có thể dùng cho nhiều cột
select *
from employees
where (dept_name, salary) in (select dept_name, max(salary) from employees group by dept_name);

#Timf phong ban ko co nhan vien
select *
from department
where dept_name not in (select distinct dept_name from employees);

select e.emp_name, e.salary, e.dept_name
from employees e
         join (select avg(salary) average from employees group by dept_name) sub
where e.salary > sub.average;

select avg(employees.salary)
from employees
where dept_name = 'IT';

select *
from employees
where dept_name = 'IT';

select *
from employees
where salary > (select avg(employees.salary) from employees where dept_name = 'IT')
  and dept_name = 'IT';

select *
from employees e2,
     employees e1
where e2.dept_name = e1.dept_name;


#Tim nhan vien co luong trung binh lon hon luong tai phong ban do
select *
from employees e1
where e1.salary > (select avg(salary) from employees e2 where e2.dept_name = e1.dept_name);



#Tim department ma ko co nhan vien nao
select *
from department d
where not exists(select 1 from employees e where e.dept_name = d.dept_name);

select 1 from employees join department d on employees.dept_name = 'Quant';

select * from department d where d.dept_name not in (select dept_name from employees);

use crashcourse;
select * from homies;
select ascii(homies.name) from homies;
select bin(homies.name) from homies;

select ascii('N');
select bin(null);
SELECT CHAR(77,121,83,81,'78');
SELECT CONCAT('My', 'S', 'QL');
SELECT CONCAT_WS(',','First name','Last Name' );
SELECT CONV('b',16,2);

SELECT FIELD('foo', 'Hej', 'ej', 'Heja', 'hej', 'foo');
SELECT FIND_IN_SET('b','a,b,c,d');
select length('asdadas');

use quang;

create table city (city varchar(20), country varchar(20));
select *
from city;

insert into city values ('Hanoi', 'Vietnam'),('Beijing','China'),('Bangkok','Thailand'),('Thanh Hoa', 'VietNam');
insert into city values ('Vatincan', '');
insert into city values ('Tawin','');
insert into city values ('Malay',null);
insert into city values ('Nacho', null);

select * from city order by (case
                                when country is null then city else country end);

alter table city add column gdp int default 1;
select * from city;
alter table city add column hello int default 2;
alter table city add column sth int;
update city set sth = gdp * hello;

use th04;
select MANV, TENNV from nhanvien where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) > 0;

select pb.TENPHG, count(*) as soluong  from nhanvien nv join phongban pb on nv.PHG = pb.MAPHG group by nv.PHG, pb.TENPHG having count(*) >= all(select count(*) from nhanvien group by PHG);



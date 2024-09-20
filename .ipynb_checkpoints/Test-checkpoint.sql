CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

select * from employee;
select * from branch;

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

select * from employee limit 5;
select * from branch;
select * from client;
select * from employee;
select employee.first_name as forename, employee.last_name as surname from employee;
select distinct employee.sex from employee;

select count(employee.emp_id) from employee;
select count(employee.super_id) from employee;
select count(emp_id) from employee where sex = 'F' and year(birth_day) > 1970;
select * from employee where sex = 'F' and year(birth_day) > 1970;
select avg(employee.salary) from employee where sex = 'M';
select sum(employee.salary) from employee where sex = 'M';

#find out how many males and females
select count(employee.sex), employee.sex from employee group by sex ;
select count(emp_id) from employee group by sex;
select emp_id, sum(works_with.total_sales) from works_with group by emp_id;
select * from client where client_name like '%LLC';

#Union
use th04;
select nhanvien.MANV, nhanvien.TENNV, phongban.TENPHG from nhanvien, phongban where nhanvien.PHG = phongban.MAPHG;

create table SINHVIEN(malop VARCHAR(3), tenlop VARCHAR(3));
insert into lop values ('L1','10A'),('L2','10B'),('L3','10C');
create table LOP(masv VARCHAR(3), hoten VARCHAR(10),malop varchar(2));
insert into sinhvien values ('01','A','L1'),('02', 'B', 'L2'), ('03', 'C', 'L2'), ('04', 'D', 'L1'), ('05', 'E', 'L1');
select * from sinhvien;
select * from lop;
select * from sinhvien join lop on LOP.malop = sinhvien.malop;
select * from sinhvien join LOP L on sinhvien.malop = L.malop;

use th04;

select TENPHG, DCHI from phongban, nhanvien where MAPHG = nhanvien.PHG;
select concat(HONV,' ', TENLOT, ' ', TENNV)  from nhanvien, phongban where TRPHG = nhanvien.MANV;
select TENNV, DCHI from nhanvien, phongban where PHG = phongban.MAPHG and TENPHG = 'Nghiên cứu';

select  nhanvien.TENNV, thannhan.TENTN from nhanvien, thannhan where MANV = MA_NVIEN and nhanvien.PHAI = 'Nữ';



select TENDA from dean, nhanvien where PHG = PHONG and concat(HONV,' ', TENLOT, ' ',TENNV) = 'Đinh Bá Tiến';

#gom nhóm
#10
select COUNT(dean.TENDA) from dean;
# select COUNT(dean.TENDA), dean.TENDA from dean group by dean.TENDA; #số lượng từng loại
#11
select COUNT(dean.TENDA) SoDANgCuu from dean, phongban where dean.PHONG = phongban.MAPHG and TENPHG = 'Nghiên cứu';
#12
select AVG(nhanvien.LUONG) LuongTBNu from nhanvien where PHAI = 'Nữ';
#13
select COUNT(thannhan.MA_NVIEN) SoLuongTN, TENNV Ten from thannhan, nhanvien where thannhan.MA_NVIEN = nhanvien.MANV and nhanvien.TENNV = 'Tiến';
#14
# select nhanvien.TENNV, COUNT() from dean, nhanvien where dean.PHONG = nhanvien.PHG group by dean.TENDA;
#15
select TENDA, COUNT(nhanvien.PHG) from nhanvien, dean where dean.PHONG = nhanvien.PHG group by dean.TENDA;
#16
select TENNV Ten, count(thannhan.TENTN) from nhanvien, thannhan where thannhan.MA_NVIEN = nhanvien.MANV group by MANV;
#17
select nhanvien.TENNV, COUNT(dean.TENDA) from nhanvien, dean where dean.PHONG = nhanvien.PHG group by TENNV;
#18

#19
select phongban.TENPHG, avg(nhanvien.LUONG) LuongTB from phongban, nhanvien where nhanvien.PHG = phongban.MAPHG group by phongban.TENPHG;
#20
select from phongban, nhanvien where phongban.MAPHG = nhanvien.PHG;
#21
select phongban.TENPHG, count(TENDA) SoDA from phongban, dean where phongban.MAPHG = dean.PHONG group by phongban.TENPHG;
#22
select phongban.TENPHG, nhanvien.TENNV, count(TENDA) SoDA from phongban, dean, nhanvien where phongban.MAPHG = dean.PHONG and phongban.TRPHG = nhanvien.MANV group by phongban.TENPHG;
#23

#24
select count(TENDA) SoDA, dean.DDIEM_DA from dean, phongban where phongban.MAPHG = dean.PHONG group by DDIEM_DA;
#25
select dean.TENDA, count(congviec.TEN_CONG_VIEC) from dean, congviec where dean.MADA = congviec.MADA group by dean.MADA;
#26
select dean.TENDA, count(nhanvien.TENNV) SoNV from dean, nhanvien where dean.PHONG = nhanvien.PHG group by dean.TENDA;
#27
select from phancong, congviec where congviec.MADA = phancong.MADA and phancong.;

select * from sinhvien join lop on SINHVIEN.malop = LOP.malop;
select * from sinhvien, lop where LOP.malop = SINHVIEN.malop;
select LOP.malop, tenlop, count(masv) SiSo from sinhvien, lop where LOP.malop = SINHVIEN.malop group by LOP.malop, tenlop;
select L.malop, tenlop, count(masv) SiSo from sinhvien join LOP L on sinhvien.malop = L.malop group by L.malop, l.tenlop;
select * from sinhvien right join LOP L on sinhvien.malop = L.malop;
select L.tenlop, count(SINHVIEN.malop) SiSo from sinhvien right join LOP L on sinhvien.malop = L.malop group by L.malop, tenlop;

use crashcourse;
create table homies(name varchar(32), job varchar(32), ingame varchar(32), nickname varchar(32), secondname varchar(32));
select * from homies;
show columns from homies;
insert into homies values
                       ('Đỗ Minh Quang', 'Data Analyst', 'Ai cho mày chạy', 'SteveDemo','Fred'),
                       ('Đinh Thái Tuấn', 'Quantitative Researcher', 'Sisyphean', 'Jgnod','James'),
                       ('Nguyễn Đức Anh Quân', 'Data Engineering', 'KumDen', 'KumDen','KumDen'),
                       ('Dương Đạt Khang', 'Software Developer', 'HELLOGAGAGAANG', 'súc vật',''),
                       ('Cao Nguyễn Minh Hoàng', 'Fullstack Developer', 'Gấu Bắc Cực Tím', 'Anh Bơ',''),
                       ('Nguyễn Đức Sĩ', 'Senior AI Engineering', 'Hanabeewidu', 'thầy Sĩ','Syx Kuto');
select * from homies;

create table JOB(job varchar(32));
insert into JOB values ('Data Analyst'),('Data Engineer'),('Senior AI Engineer'),('Quantitative Researcher'),('Fullstack Developer'),('Data Engineer');

alter table homies add constraint JOB foreign key (job) references job(job);
alter table job add primary key (job);
delete
from job
where job = 'Data Engineer';
update job set job = 'Software Developer' where job = 'Software Engineer';
select homies.nickname from homies;
select distinct homies.nickname, homies.secondname from homies;

use th04;
select * from lop cross join SINHVIEN S on lop.malop = S.malop;
select * from lop left join SINHVIEN S on lop.malop = S.malop;
use crashcourse;
select homies.nickname from homies union all select homies.job from homies;

use th04;
select nhanvien.MANV, nhanvien.TENNV from nhanvien where exists(select thannhan.TENTN from thannhan where thannhan.MA_NVIEN = nhanvien.MANV);

#2
select concat(nhanvien.HONV,' ', nhanvien.TENLOT,' ', nhanvien.TENNV) as HOTEN from nhanvien where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) >= all (select count(*) from thannhan, nhanvien where thannhan.MA_NVIEN =  nhanvien.MANV group by nhanvien.MANV);

#3
select concat(nhanvien.HONV,' ', nhanvien.TENLOT,' ', nhanvien.TENNV) as HOTEN from nhanvien where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) = 0;

#4
select concat(nhanvien.HONV,' ', nhanvien.TENLOT,' ', nhanvien.TENNV) as HOTEN from nhanvien where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) >= 1;

#5
select nhanvien.HONV as HOTEN from nhanvien where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) = 0;

#6
select TENNV as HOTEN from nhanvien where (select count(*) from nhanvien, nhanvien qly where nhanvien.MA_NQL = qly.MANV) >= all (select count(*) from nhanvien qly, nhanvien nv where nv.MA_NQL =  qly.MANV group by qly.MANV);

select qly.TENNV from nhanvien nv, nhanvien qly where nv.MA_NQL = qly.MANV group by qly.MANV having count(*) >= all(select count(*) from nhanvien qly group by qly.MA_NQL);


select qly.TENNV, count(nv.MANV) from nhanvien nv join nhanvien qly on nv.MA_NQL = qly.MANV group by qly.MANV;


select nhanvien.MANV, nhanvien.TENNV from nhanvien where exists(select thannhan.TENTN from thannhan where thannhan.MA_NVIEN = nhanvien.MANV);
select nhanvien.MANV, nhanvien.TENNV from nhanvien where exists(select thannhan.TENTN from thannhan join thannhan on nhanvien.MANV = thannhan.MA_NVIEN);
select nhanvien.MANV, nhanvien.TENNV from nhanvien where exists(select thannhan.TENTN from thannhan, nhanvien where thannhan.MA_NVIEN = nhanvien.MANV);

use crashcourse;


use th04;

DELIMITER $$
CREATE PROCEDURE getById(IN id int(11))
BEGIN
	DECLARE a int(11) DEFAULT 0;
    DECLARE b int(11) DEFAULT 0;
	SET a = id;
    SET b = id + 1000;
    SELECT b;

END; $$
DELIMITER ;

CALL getById(1);


DROP PROCEDURE IF EXISTS `docSo`;

CREATE PROCEDURE `docSo`(out a INT(11))
BEGIN

DECLARE message VARCHAR(255);

CASE a

WHEN 0 THEN

SET message = 'KHONG';
WHEN 1 THEN

SET message = 'MOT';
WHEN 2 THEN

SET message = 'HAI';

WHEN 3 THEN

SET message = 'BA';
WHEN 4 THEN

SET message = 'BON';
WHEN 5 THEN

SET message = 'NAM';

WHEN 6 THEN

SET message = 'SAU';
WHEN 7 THEN

SET message = 'BAY';
WHEN 8 THEN

SET message = 'TAM';

WHEN 9 THEN

SET message = 'CHIN';
ELSE

SET message = 'KHONG TIM THAY';

END CASE;

SELECT message;

END;

DELIMITER ;

call docSo(1);

CREATE TABLE IF NOT EXISTS `members` (
`us_id` INT(11) NOT NULL AUTO_INCREMENT,

`us_gender` TINYINT(1) DEFAULT '0',
`us_username` VARCHAR(30) COLLATE utf8_unicode_ci DEFAULT NULL,
`us_password` VARCHAR(32) COLLATE utf8_unicode_ci DEFAULT NULL,
`us_level` TINYINT(1) DEFAULT '0',

PRIMARY KEY (`us_id`)

) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
AUTO_INCREMENT=4 ;

INSERT INTO `members` (`us_id`, `us_gender`, `us_username`, `us_password`, `us_level`)
VALUES

(1, 0, 'admin', '57e34a1be668ebd6e40d430806beb099', 1),
(2, 1, 'member', '57e34a1be668ebd6e40d430806beb099', 2),
(3, 0, 'banded', '57e34a1be668ebd6e40d430806beb099', 0);

select * from members;

delimiter $$
create procedure changeLevel(out a tinyint(1))
begin
    set a = 100;
end; $$
delimiter ;

call docSo(@1);
select @1;

delimiter $$;
drop procedure if exists checkVar $$;
create procedure checkVar(out a int(11))
begin
    declare b int(1);
    set b = 1;
    set a = b;
end $$;
delimiter ;

call checkVar(@2);
select@2;

create table champ(name varchar(10) primary key , ultimate varchar(20));
create table midlane(name varchar(10), ultimate varchar(20), constraint fk_key foreign key (name) references champ(name));
insert into champ(name, ultimate) values ('Zed', 'DeathMark'), ('Lucian', 'The Culling');
select * from champ;
select date(now());
select curdate();

alter table midlane drop foreign key fk_key;



create table kwang(value float(3,2));
alter table kwang modify value float(5,3);
insert into kwang value (10.513);
select * from kwang;
alter table kwang add column intvalue2 smallint(1) auto_increment;
show columns from kwang;

create table haha(id int not null auto_increment,value int default 100, name varchar(40), primary key (id));
insert into haha(value, name) values (1,'Quang'),(211,'KumDen');
select * from haha;
insert into haha(name) value ('Si');

alter table haha change value new_value bigint not null default 10;
describe haha;
show columns from haha;

alter table haha drop primary key;

create table a(a int unique not null);
create table c(b int not null unique auto_increment primary key );
create table b(e int not null default 10 auto_increment);
create table d(c int not null default 100 primary key );
drop table a,b,c,d;

create table a(id int not null auto_increment primary key, );
drop table midlane;
SELECT DATE('2003-12-31 01:02:03') as date;
select datediff(now(), '2024/06/07');

use th04;




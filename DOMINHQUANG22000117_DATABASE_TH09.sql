use th04;

CREATE TABLE IF NOT EXISTS `members` (
`us_id` INT(11) NOT NULL AUTO_INCREMENT,
`us_username` VARCHAR(30) COLLATE utf8_unicode_ci DEFAULT NULL,
`us_password` VARCHAR(32) COLLATE utf8_unicode_ci DEFAULT NULL,
`us_level` TINYINT(1) DEFAULT '0',
PRIMARY KEY (`us_id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;
--
-- Contenu de la table `members`
--
INSERT INTO `members` (`us_id`, `us_username`, `us_password`, `us_level`) VALUES
(1, 'admin', '57e34a1be668ebd6e40d430806beb099', 1),
(2, 'member', '57e34a1be668ebd6e40d430806beb099', 2),
(3, 'banded', '57e34a1be668ebd6e40d430806beb099', 0);


DELIMITER $$

DROP PROCEDURE IF EXISTS `checkLogin`$$

CREATE PROCEDURE `checkLogin`(
IN input_username VARCHAR(255),
IN input_password VARCHAR(255),
OUT result VARCHAR(255)
)
BEGIN
/*Bien flag luu tru level. Mac dinh la -1*/
DECLARE flag INT(11) DEFAULT -1;

/*Thuc hien truy van gan level vao bien flag*/
SELECT us_level INTO flag FROM members
WHERE us_username = input_username AND us_password = MD5(input_password);

/*Sau khi thuc hien lenh select nay ma ko co du lieu thi
luc nay flag se khong thay doi. Chinh vi the neu flag = -1 tuc la sai thong tin
*/
IF (flag <= 0) THEN
SET result = 'Thong tin dang nhap sai';
ELSEIF (flag = 0) THEN
SET result = 'Tai khoan bi khoa';
ELSEIF (flag = 1) THEN
SET result = 'Tai khoan admin';
ELSE
SET result = 'Tai khoan member';
END IF;
END$$

DELIMITER ;

CALL checkLogin('admin', 'vancuong', @result);
SELECT @result;






#1
delimiter $$
drop procedure if exists loopwhile;
create procedure loopwhile(in a int(11))
begin
    select * from nhanvien where PHG = a;
end $$;
    delimiter ;

call loopwhile(4);

#2
delimiter $$
drop procedure if exists have_more_than;
create procedure have_more_than(in a int(20))
begin
    select * from nhanvien where LUONG >= a;
end $$;
    delimiter ;

call have_more_than(30000);

#1
delimiter $$
drop procedure if exists `SelectByRoom`$$
create procedure SelectByRoom(IN id_val int(11))
begin
    select *
    from nhanvien
    where nhanvien.PHG = id_val;
end; $$
delimiter ;
call SelectByRoom(4);

#2
delimiter $$
drop procedure if exists `SelectBySalary`$$
create procedure SelectBySalary(IN luong double)
begin
    select *
    from nhanvien
    where nhanvien.LUONG > luong;
end; $$
delimiter ;
call SelectBySalary(30000);

#3
delimiter $$
drop procedure if exists SelectBySalaryAndRoom $$
create procedure SelectBySalaryAndRoom (IN phong int(11), IN luong double)
begin
    select *
        from nhanvien
            where (nhanvien.LUONG > luong and PHG = phong);
end; $$
delimiter ;
call SelectBySalaryAndRoom(4, 25000);
call SelectBySalaryAndRoom(5, 30000);

#4
delimiter $$
drop procedure if exists FilterNameHCM $$
create procedure `FilterNameHCM`(DIACHI varchar(30))
begin
    select *
        from nhanvien
            where nhanvien.DCHI like diachi;
end $$
delimiter ;
call FilterNameHCM('%Tp%HCM%');

#5
delimiter $$
drop procedure if exists FilterByName $$
create procedure FilterByName(NAME varchar(15))
begin
    select *
        from nhanvien
            where nhanvien.HONV like NAME;
end $$
delimiter ;
call FilterByName('N%');

#6
delimiter $$
drop procedure if exists FilterBirthdayAndPlace $$
create procedure FilterBirthdayAndPlace(HO varchar(15), tenlot varchar(15), ten varchar(15))
begin
    select NGSINH, DCHI
        from nhanvien
            where nhanvien.HONV like HO and nhanvien.TENLOT like tenlot and TENNV like ten;
end $$
delimiter ;
call FilterBirthdayAndPlace('%Đinh%', '%Bá%', '%Tiến%');

#7
delimiter $$
drop procedure if exists FilterByBirthday $$
create procedure FilterByBirthday(NAMSINH1 int, NAMSINH2 int)
begin
    select *
        from nhanvien
            where year(NGSINH) >= NAMSINH1 and year(NGSINH) <= NAMSINH2;
end $$
delimiter ;
call FilterByBirthday(1960, 1965);

#8
delimiter $$
drop procedure if exists BirthYear $$
create procedure BirthYear()
begin
    select nhanvien.TENNV, nhanvien.NGSINH
    from nhanvien;
end $$
delimiter ;
call BirthYear();

#9
delimiter $$
drop procedure if exists AgeStaff $$
create procedure AgeStaff()
begin
    select nhanvien.TENNV, (year(now()) - year(NGSINH)) as TUOI
        from nhanvien;
end $$
delimiter ;
call AgeStaff;




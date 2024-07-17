use th04;

#Cho biết các nhân viên được phân công tham gia tất cả các đề án của công ty.

#C1
select *
from nhanvien
where not exists(select *
                 from dean
                 where dean.MADA not in (select distinct phancong.MADA
                                         from phancong
                                         where phancong.MADA = dean.MADA
                                           and phancong.MA_NVIEN = nhanvien.MANV));

select phancong.MADA
from phancong
where phancong.MADA = 3
  and phancong.MA_NVIEN = '009';
#C2
use th04;
select MANV, TENNV
from nhanvien
where not exists(select *
                 from dean
                 where not exists(select * from phancong where phancong.MA_NVIEN = MANV and phancong.MADA = dean.MADA));


#C3
select nhanvien.MANV
from nhanvien
where nhanvien.MANV in (select phancong.MA_NVIEN
                        from phancong
                        group by MA_NVIEN
                        having count(distinct phancong.MADA) = (select count(dean.MADA) from dean));


select count(dean.MADA)
from dean
where PHONG = '4';
select phancong.MA_NVIEN
from phancong
group by MA_NVIEN
having count(distinct phancong.MADA) = (select count(dean.MADA) from dean where PHONG = '4');


select *
from dean;
select MAPHG
from phongban
where TENPHG = 'Nghiên cứu';
select count(*)
from dean
where PHONG = (select MAPHG from phongban where TENPHG = 'Nghiên cứu');

insert into phancong
values ('003', 3, 1, 20);


#1
select nhanvien.MANV, TENNV
from nhanvien
where MANV in (select phancong.MA_NVIEN
               from phancong
               where MADA in (select MADA
                              from dean
                              where PHONG = (select MAPHG
                                             from phongban
                                             where TENPHG = 'Nghiên cứu'))
               group by MA_NVIEN
               having count(distinct MADA) = (select count(*)
                                              from dean
                                                       join phongban
                                                            on dean.PHONG = phongban.MAPHG and phongban.TENPHG = 'Nghiên cứu'));

select nhanvien.MANV, nhanvien.TENNV
from nhanvien
where not exists(select)

#2
select count(MADA)
from dean
where PHONG = '4';

select MADA
from dean
where PHONG = '4';

select phancong.MA_NVIEN
from phancong
where MADA in (select MADA from dean where PHONG = '4')
group by MA_NVIEN
having count(MADA) = (select count(MADA) from dean where PHONG = '4');

#3
select nhanvien.MANV, nhanvien.TENNV
from nhanvien
where not exists(select MADA
                 from (select MADA from phancong where MA_NVIEN = '009') as DADinhBaTien
                 where not exists(select * from phancong where MA_NVIEN = nhanvien.MANV and MADA = DADinhBaTien.MADA));

#4


#5
select nhanvien.MANV, nhanvien.TENNV
from nhanvien
where not exists(select *
                 from dean
                 where DDIEM_DA like 'TP HCM'
                   and not exists(select * from phancong where MADA = dean.MADA and MA_NVIEN = nhanvien.MANV));


#6
select TENPHG
from phongban
where not exists(select *
                 from dean
                 where DDIEM_DA = 'TP HCM'
                   and not exists(select *
                                  from dean da
                                           join phongban pb on da.PHONG = pb.MAPHG and da.MADA = dean.MADA and
                                                               MAPHG = phongban.MAPHG))





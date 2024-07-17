#1
use th04;

select da.MADA, da.TENDA
from dean da
where da.PHONG in (select PHG
                   from nhanvien
                   where nhanvien.HONV = 'Đinh')
   or da.PHONG in (select nv1.PHG
                   from nhanvien nv1
                            join phongban pb on nv1.MANV = pb.TRPHG
                   where nv1.HONV = 'Đinh');

#2
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where nv.manv in (select thannhan.MA_NVIEN
                  from thannhan
                  group by thannhan.MA_NVIEN
                  having count(thannhan.MA_NVIEN) > 2);

#3
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where not exists(select *
                 from thannhan
                 where thannhan.MA_NVIEN = nv.MANV);

#4
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where exists(select *
             from phongban pb,
                  thannhan
             where pb.TRPHG = nv.MANV
               and thannhan.MA_NVIEN = nv.MANV
             group by thannhan.MA_NVIEN
             having COUNT(thannhan.MA_NVIEN) >= 1);

#5
select nv.HONV
from nhanvien nv
         join phongban pb on nv.MANV = pb.TRPHG
where nv.HONV not in (select nv1.HONV
                      from thannhan,
                           nhanvien nv1,
                           phongban
                      where thannhan.MA_NVIEN = nv1.MANV);

#6
select concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where nv.LUONG > (select avg(nhanvien.luong)
                  from nhanvien
                           join phongban on nhanvien.PHG = phongban.MAPHG
                  where phongban.TENPHG = 'Nghiên cứu');

#7
select concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
From nhanvien nv
         join phongban pb on nv.MANV = pb.TRPHG
         join nhanvien nv2 on nv2.PHG = pb.MAPHG
group by nv2.PHG
having count(nv2.manv) >= ALL (select count(nhanvien.MANV)
                               from nhanvien
                               group by nhanvien.PHG);

#8
select da.MADA, da.TENDA
from dean da
where da.MADA not in (select phancong.MADA
                      from phancong
                      where phancong.MA_NVIEN like '009');

#9
select congviec.TEN_CONG_VIEC
from congviec
         join dean on congviec.MADA = dean.MADA
where dean.TENDA like 'San pham X'
  and (congviec.MADA, congviec.STT) not in (select phancong.MADA, phancong.STT
                                            from phancong
                                            where phancong.MA_NVIEN like '009');

#10
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where nv.MANV in (select pc.MA_NVIEN
                  from phancong pc
                           join dean da on pc.MADA = da.MADA
                           join diadiem_phg dd on dd.MAPHG = da.PHONG
                  where da.DDIEM_DA like 'TP HCM'
                    and dd.DIADIEM not like '%TP HCM%');

#Test
select nhanvien.MANV, nhanvien.TENNV
from nhanvien
where PHG in (select PHG from nhanvien where TENNV = 'Tiến');

select nhanvien.MANV, nhanvien.TENNV
from nhanvien
where LUONG > (select max(LUONG) from nhanvien where PHG = 4);

select count(nhanvien.MANV)
from phongban
         join nhanvien on nhanvien.PHG = phongban.MAPHG
group by phongban.MAPHG;
select phongban.TENPHG, count(nhanvien.MANV)
from phongban
         join nhanvien on phongban.MAPHG = nhanvien.PHG
group by MAPHG
having count(MANV) >= all (select count(nhanvien.MANV)
                           from phongban
                                    join nhanvien on nhanvien.PHG = phongban.MAPHG
                           group by phongban.MAPHG);


select LUONG
from nhanvien
         join phongban
where nhanvien.PHG = phongban.MAPHG
  and phongban.TENPHG = 'Nghiên cứu';
select concat(HONV, ' ', TENNV), LUONG
from nhanvien
where LUONG > any (select LUONG
                   from nhanvien
                            join phongban
                   where nhanvien.PHG = phongban.MAPHG
                     and phongban.TENPHG = 'Nghiên cứu');

#2
select MANV, concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien
where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) > 2;

select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where nv.manv in (select thannhan.MA_NVIEN
                  from thannhan
                  group by thannhan.MA_NVIEN
                  having count(*) > 2);

#3
#a
select MANV, concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien
where (select count(*) from thannhan where thannhan.MA_NVIEN = nhanvien.MANV) = 0;

#nếu ta dùng lồng tương quan thì sub query ko có join do join đã khai báo hết các bảng
#b
select MANV, concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien
where not exists(select 1 from thannhan where thannhan.MA_NVIEN = nhanvien.MANV);

#c
select * from nhanvien left join thannhan on nhanvien.MANV = thannhan.MA_NVIEN where thannhan.MA_NVIEN is null;

#d
select * from nhanvien where MANV not in(select MANV from nhanvien join thannhan on nhanvien.MANV = thannhan.MA_NVIEN);

#4
select phongban.TRPHG
from phongban
where (select count(*)
       from thannhan,
            nhanvien
       where TRPHG = nhanvien.MANV
         and thannhan.MA_NVIEN = nhanvien.MANV) >= 1;

#a
select MANV, concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien where MANV in (select phongban.TRPHG
from phongban
where (select count(*)
       from thannhan,
            nhanvien
       where TRPHG = nhanvien.MANV
         and thannhan.MA_NVIEN = nhanvien.MANV) >= 1);

#b
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where exists(select *
             from phongban pb,
                  thannhan
             where pb.TRPHG = nv.MANV
               and thannhan.MA_NVIEN = nv.MANV
             group by thannhan.MA_NVIEN
             having COUNT(thannhan.MA_NVIEN) >= 1);

#5
#a
select phongban.TRPHG
from phongban
where (select count(*)
       from thannhan,
            nhanvien
       where TRPHG = nhanvien.MANV
         and thannhan.MA_NVIEN = nhanvien.MANV) = 0;

#b
select nv.HONV
from nhanvien nv
         join phongban pb on nv.MANV = pb.TRPHG
where nv.HONV not in (select nv1.HONV
                      from thannhan,
                           nhanvien nv1,
                           phongban
                      where thannhan.MA_NVIEN = nv1.MANV);

#6

select avg(nhanvien.LUONG)
from nhanvien
         join phongban on nhanvien.PHG = phongban.MAPHG and TENPHG = 'Nghiên cứu';
select concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien
where LUONG > (select avg(nhanvien.LUONG)
               from nhanvien
                        join phongban on nhanvien.PHG = phongban.MAPHG and TENPHG = 'Nghiên cứu');

#7
select phongban.TRPHG, count(*)
from phongban
         join nhanvien on phongban.MAPHG = nhanvien.PHG
group by MAPHG
having count(*) >= all (select count(*)
                        from nhanvien
                                 join phongban on nhanvien.PHG = phongban.MAPHG
                        group by MAPHG);

#8
select dean.MADA
from dean
where MADA not in (select MADA from phancong where MA_NVIEN = '009');

#9

select STT
from phancong
where MA_NVIEN = '009';

select TEN_CONG_VIEC
from congviec
where STT not in (select STT from phancong where MA_NVIEN = '009')
  and MADA = 1;


#10
select dean.PHONG
from diadiem_phg
        join dean on diadiem_phg.MAPHG = dean.PHONG
            where dean.DDIEM_DA like '%Tp HCM' and diadiem_phg.DIADIEM <> 'Tp HCM';

select concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien
where nhanvien.PHG in (select dean.PHONG
from diadiem_phg
        join dean on diadiem_phg.MAPHG = dean.PHONG
            where dean.DDIEM_DA like '%Tp HCM' and diadiem_phg.DIADIEM <> 'Tp HCM');


#Tim ten va so luong than nhan cua nhx nhan vien co dong than nhan nhat
select count(*)
from thannhan
         join nhanvien on thannhan.MA_NVIEN = nhanvien.MANV
group by MANV;

select nhanvien.TENNV, count(*)
from nhanvien
         join thannhan on nhanvien.MANV = thannhan.MA_NVIEN
group by nhanvien.MANV
having count(*) >= all (select count(*)
                        from thannhan
                                 join nhanvien on thannhan.MA_NVIEN = nhanvien.MANV
                        group by MANV);


select * from dean join diadiem_phg on dean.DDIEM_DA = dean.DDIEM_DA;

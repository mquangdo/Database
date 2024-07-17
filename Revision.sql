use th04;

#1
select *
from nhanvien
where PHG = '4';

#2
select *
from nhanvien
where LUONG > 3000;

#3
select *
from nhanvien
where (LUONG > 25000 and PHG = '4')
   or (LUONG > 30000 and PHG = '5');

#4
select concat(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) hovaten
from nhanvien
order by hovaten desc
limit 5;

#5
select concat(nhanvien.HONV, ' ', nhanvien.TENLOT, ' ', nhanvien.TENNV) hovaten
from nhanvien
where HONV like 'N%';

#6
select NGSINH, DCHI
from nhanvien
where TENNV = 'Tien';

#7
select *
from nhanvien
where year(NGSINH) between 1960 and 1965;

#8
select nhanvien.NGSINH, nhanvien.TENNV
from nhanvien;

#9
select TENNV, (year(now()) - year(NGSINH))
from nhanvien;

#10;


#1
select pb.TENPHG, dd.DIADIEM
from phongban pb
         join diadiem_phg dd on pb.MAPHG = dd.MAPHG;

#2
select pb.TENPHG, nv.TENNV
from nhanvien nv
         join phongban pb on nv.MANV = pb.TRPHG;

#3
select TENNV, DCHI
from nhanvien nv
         join phongban pb on nv.PHG = pb.MAPHG and pb.TENPHG = 'Nghiên cứu';

#4
select TENDA tendean, TENPHG tenphong, TENNV as truongphong, NG_NHANCHUC as ngaynhanchuc
from dean da
         join phongban pb on da.PHONG = pb.MAPHG
         join nhanvien nv on pb.TRPHG = nv.MANV;

#5
select TENNV, TENTN
from nhanvien nv
         join thannhan tn on nv.MANV = tn.MA_NVIEN
where nv.PHAI = 'Nữ';

#6
select nv1.TENNV as nhanvien, nv2.TENNV as nql
from nhanvien nv1
         join nhanvien nv2 on nv1.MA_NQL = nv2.MANV;

#7
select concat(nv1.HONV, ' ', nv1.TENLOT, ' ', nv1.TENNV) hovaten,
       pb.TENPHG                                         tenphg,
       nv2.TENNV as                                      trgphg,
       nv3.TENNV                                         nql
from nhanvien nv1
         join phongban pb on nv1.PHG = pb.MAPHG
         join nhanvien nv2 on pb.TRPHG = nv2.MANV
         join nhanvien nv3 on nv3.MANV = nv1.MA_NQL;

#8
select nv.TENNV, nv2.TENNV
from nhanvien nv
         join dean da on nv.PHG = da.PHONG and da.TENDA = 'San pham X'
         join nhanvien nv2 on nv.MA_NQL = nv2.MANV and nv2.TENNV = 'Tùng';
#Ta thấy ta không sử dụng mệnh đề WHERE mà sử dụng AND bởi vì ở đây sử dụng AND thì cũng có tác dụng như WHERE và hơn nữa sử dụng AND thì cho ta tiếp tục sử dụng JOIN

select *
from nhanvien nv
         join dean da on nv.PHG = da.PHONG
         join nhanvien nv2 on nv.MA_NQL = nv2.MANV
where nv2.TENNV = 'Tùng'
  and da.TENDA = 'San pham X';


#9
select da.TENDA
from nhanvien nv
         join dean da on nv.PHG = da.PHONG and nv.TENNV = 'Tiến';

#10
select count(*) as soluong
from dean;

#11
select count(*) as soluong
from dean da
         join phongban pb on da.PHONG = pb.MAPHG
where pb.TENPHG = 'Nghiên cứu';
#Sử dụng WHERE hay AND đều cho cùng một kết quả

#12
select avg(LUONG) luongTB
from nhanvien
where PHAI = 'Nữ';

#13
select count(*) soluong
from nhanvien nv
         join thannhan tn on nv.MANV = tn.MA_NVIEN and nv.TENNV = 'Tiến';

#14

#15
select da.TENDA, count(*) as soluongnv
from dean da
         join nhanvien nv on da.PHONG = nv.PHG
group by TENDA;

#16
select concat(HONV, ' ', TENLOT, ' ', TENNV) hovaten, count(tn.TENTN) soluongTN
from thannhan tn
         right join nhanvien nv on nv.MANV = tn.MA_NVIEN
group by nv.MANV;

#17
select TENNV, count(MADA) soDA
from nhanvien nv
         join dean da on nv.PHG = da.PHONG
group by MANV;

#18
select nv2.TENNV tenNQL, count(nv.MANV) soluong
from nhanvien nv
         right join nhanvien nv2 on nv.MA_NQL = nv2.MANV
group by nv2.MANV;

#19
select pb.TENPHG tenPB, avg(LUONG) luongTB
from nhanvien nv
         join phongban pb on nv.PHG = pb.MAPHG
group by pb.MAPHG;

#20
select pb.TENPHG, count(nv.MANV) soluongNV, avg(LUONG) luongTB
from nhanvien nv
         join phongban pb on nv.PHG = pb.MAPHG
group by pb.MAPHG
having avg(LUONG) > 3000;

#21
select TENPHG tenphong, count(da.MADA) soluongDA
from phongban pb
         join dean da on pb.MAPHG = da.PHONG
group by TENPHG;

#22
select pb.TENPHG tenphong, nv.TENNV tenTrgphg, count(da.MADA) soluongDA
from phongban pb
         join nhanvien nv on pb.TRPHG = nv.MANV
         join dean da on pb.MAPHG = da.PHONG
group by pb.MAPHG;

#23
select pb.TENPHG tenPB, count(nv.MANV) soluongNV, count(da.MADA) soluongDA, TENDA tenDA
from phongban pb
         join nhanvien nv on pb.MAPHG = nv.PHG
         join dean da on pb.MAPHG = da.PHONG
group by pb.MAPHG
having avg(LUONG) > 30000;

#24
select count(MADA), DDIEM_DA
from dean da
group by DDIEM_DA;

#25
select TENDA, count(TEN_CONG_VIEC)
from dean da
         join congviec cv on da.MADA = cv.MADA
group by cv.MADA;

#26
select STT, count(MA_NVIEN)
from phancong
where MADA = 30
group by STT;

#27
select STT, count(MA_NVIEN)
from phancong
where MADA = (select dean.MADA from dean where TENDA = 'Dao tao')
group by STT;


#1
select *
from dean da
where da.PHONG in (select PHG
                   from nhanvien
                   where HONV = 'Đinh')
   or da.PHONG in (select PHG
                   from nhanvien nv
                            join phongban pb on nv.MANV = pb.TRPHG
                   where TENNV = 'Đinh');

#2
select concat(HONV, ' ', TENLOT, ' ', TENNV) as hovaten
from nhanvien nv
where (select count(*) from thannhan tn where tn.MA_NVIEN = nv.MANV) > 2;

#or
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where nv.manv in (select thannhan.MA_NVIEN
                  from thannhan
                  group by thannhan.MA_NVIEN
                  having count(*) > 2);


#3
select concat(HONV, ' ', TENLOT, ' ', TENNV) as hovaten
from nhanvien nv
where (select count(*) from thannhan tn where tn.MA_NVIEN = nv.MANV) = 0;

#or
select concat(HONV, ' ', TENLOT, ' ', TENNV) as hovaten
from nhanvien nv
where not exists(select * from thannhan tn where tn.MA_NVIEN = nv.MANV);


#4
select *
from nhanvien nv
where MANV in (select TRPHG from phongban pb)
  and exists(select *
             from thannhan tn
             where tn.MA_NVIEN = nv.MANV);

#or
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where exists(select *
             from phongban pb,
                  thannhan
             where pb.TRPHG = nv.MANV
               and thannhan.MA_NVIEN = nv.MANV
             group by thannhan.MA_NVIEN);


#Tim truong phong co >= 4 than nhan
select nv.MANV, concat(nv.HONV, ' ', nv.TENLOT, ' ', nv.TENNV) as 'Ten Nhan Vien'
from nhanvien nv
where (select count(*)
       from phongban pb,
            thannhan
       where pb.TRPHG = nv.MANV
         and thannhan.MA_NVIEN = nv.MANV
       group by thannhan.MA_NVIEN) >= 4;


#5
select *
from nhanvien nv
where MANV in (select TRPHG from phongban pb)
  and not exists(select *
                 from thannhan tn
                 where tn.MA_NVIEN = nv.MANV);


#6
select *
from nhanvien
where LUONG > (select avg(nv.LUONG)
               from nhanvien nv,
                    phongban pb
               where nv.PHG = pb.MAPHG
                 and pb.TENPHG = 'Nghiên cứu');


#7
select count(*)
from nhanvien nv
         join phongban pb on nv.PHG = pb.MAPHG
group by pb.MAPHG;

select pb.TRPHG
from nhanvien nv
         join phongban pb on nv.PHG = pb.MAPHG
group by pb.MAPHG
having count(*) >= all (select count(*)
                        from nhanvien nv
                                 join phongban pb on nv.PHG = pb.MAPHG
                        group by pb.MAPHG);

select concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen, TENPHG
from phongban pb
         join nhanvien nv on pb.MAPHG = nv.PHG
where nv.MANV in (select pb.TRPHG
                  from nhanvien nv
                           join phongban pb on nv.PHG = pb.MAPHG
                  group by pb.MAPHG
                  having count(*) >= all (select count(*)
                                          from nhanvien nv
                                                   join phongban pb on nv.PHG = pb.MAPHG
                                          group by pb.MAPHG));


#8
select da.MADA, da.TENDA
from dean da
where da.MADA not in (select phancong.MADA
                      from phancong
                      where phancong.MA_NVIEN like '009');

#9
select STT
from congviec
where MADA = 1
  and not exists(select * from phancong where MA_NVIEN = 009 and phancong.MADA = 1 and congviec.STT = phancong.STT);


#10
select distinct TENNV, DCHI
from nhanvien nv
         join dean da on nv.PHG = da.PHONG
         join diadiem_phg dd on nv.PHG = dd.MAPHG
where da.DDIEM_DA like '%Tp HCM%'
  and dd.DIADIEM not like '%Tp HCM%';

#or
select distinct dean.PHONG
from diadiem_phg
         join dean on diadiem_phg.MAPHG = dean.PHONG
where dean.DDIEM_DA like '%Tp HCM'
  and diadiem_phg.DIADIEM <> 'Tp HCM';

select concat(HONV, ' ', TENLOT, ' ', TENNV) HoVaTen
from nhanvien
where nhanvien.PHG in (select dean.PHONG
                       from diadiem_phg
                                join dean on diadiem_phg.MAPHG = dean.PHONG
                       where dean.DDIEM_DA like '%Tp HCM'
                         and diadiem_phg.DIADIEM <> 'Tp HCM');


#PHEP CHIA

#1
select * from dean where PHONG = 5;
select TENNV, MANV
from nhanvien
where not exists(select * from dean where dean.PHONG = (select MAPHG from phongban where TENPHG = 'Nghiên cứu') and not exists(select * from phancong where dean.MADA = phancong.MADA and nhanvien.MANV = MA_NVIEN));

#2
select TENNV, MANV from nhanvien where not exists(select * from (select * from dean where PHONG = 4) da
                                                           where not exists(select * from phancong where da.MADA = phancong.MADA and nhanvien.MANV = MA_NVIEN));



#3

select TENNV, MANV from nhanvien where not exists(select * from (select * from phancong pc where pc.MA_NVIEN = 009) da
                                                           where not exists(select * from phancong where da.MADA = phancong.MADA and nhanvien.MANV = MA_NVIEN));


#6
select * from phongban pb where not exists(select * from(select * from dean da where da.DDIEM_DA like '%Tp HCM%') da1
                                                  where not exists(select * from dean da2 where da2.MADA = da1.MADA and da2.PHONG = pb.MAPHG))
                                                                    #ở đây ta cố định lại một phòng là pb.MAPHG, và cho da1.MADA chạy


#Ta xác định tập chia là tập lấy từ bảng DEAN với DDIEM_DA là ở TP HCM, còn tập bị chia là tập PHONGBAN
#Giống như 2 vòng for lồng nhau, ta cho từng hàng trong PHONGBAN chạy trước, với mỗi hàng trong đấy thì ta chô từng hàng trong DEAN chạy
#Nếu ở tại một hàng của PHONGBAN mà tất cả các hàng của tập chia đều cùng với nó tạo thành 1 bộ của DEAN thì ta giữ lại hàng đó.



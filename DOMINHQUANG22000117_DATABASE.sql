use th04;

#1
SELECT phongban.TENPHG, diadiem_phg.DIADIEM from diadiem_phg join phongban on diadiem_phg.MAPHG = phongban.MAPHG;

#2
SELECT nhanvien.TENNV from nhanvien join th04.phongban p on nhanvien.MANV = p.TRPHG;

#3
SELECT TENNV, DCHI from nhanvien join phongban on nhanvien.PHG = phongban.MAPHG and TENPHG = 'Nghiên cứu';

#5
select  nhanvien.TENNV, thannhan.TENTN from nhanvien, thannhan where MANV = MA_NVIEN and nhanvien.PHAI = 'Nữ';

#9
select TENDA from dean, nhanvien where PHG = PHONG and concat(HONV,' ', TENLOT, ' ',TENNV) = 'Đinh Bá Tiến';

#10
SELECT COUNT(dean.TENDA) SoDA
FROM dean;

#11
SELECT COUNT(dean.TENDA) SoDA
FROM dean
         JOIN phongban ON dean.PHONG = phongban.MAPHG and TENPHG = 'Nghiên cứu';

#12
SELECT AVG(nhanvien.LUONG) LuongTBN
FROM nhanvien
WHERE PHAI = 'Nữ';

#13
SELECT COUNT(thannhan.MA_NVIEN) SoLuongTN, TENNV Ten
FROM thannhan
         JOIN nhanvien ON thannhan.MA_NVIEN = nhanvien.MANV and nhanvien.TENNV = 'Tiến';

#15
SELECT dean.TENDA TenDA, count(MANV) SoNV
FROM dean
         JOIN nhanvien ON dean.PHONG = nhanvien.PHG
GROUP BY TENDA;

#16.
SELECT nhanvien.HONV, nhanvien.TENLOT, nhanvien.TENNV, COUNT(thannhan.MA_NVIEN) as SOLUONGTN
FROM nhanvien
         LEFT JOIN thannhan
                   ON nhanvien.MANV = thannhan.MA_NVIEN
GROUP BY nhanvien.MANV;

#17.
SELECT nhanvien.HONV, nhanvien.TENLOT, nhanvien.TENNV, COUNT(phancong.MADA) as SOLUONGDEANTGIA
FROM nhanvien
         INNER JOIN phancong
                    ON nhanvien.MANV = phancong.MA_NVIEN
GROUP BY phancong.MA_NVIEN;

#18.
SELECT qly.TENNV, COUNT(nv.MANV) as SOLUONGQUANLY
FROM nhanvien nv
         JOIN nhanvien qly
                    ON qly.MA_NQL = nv.MANV
GROUP BY qly.MA_NQL;

#19.
SELECT phongban.TENPHG, AVG(nhanvien.LUONG) as LUONGTB
FROM phongban
         INNER JOIN nhanvien
                    ON phongban.MAPHG = nhanvien.PHG
GROUP BY phongban.MAPHG;

#20.
SELECT phongban.TENPHG, COUNT(nhanvien.MANV) as SOLUONGNV
FROM phongban
         INNER JOIN nhanvien
                    ON phongban.MAPHG = nhanvien.PHG
GROUP BY phongban.MAPHG
HAVING AVG(nhanvien.LUONG) > 30000;

#21.
SELECT phongban.TENPHG, COUNT(dean.TENDA) as SOLUONGDA
FROM phongban
         INNER JOIN dean
                    ON phongban.MAPHG = dean.PHONG
GROUP BY phongban.TENPHG;

#22.
SELECT phongban.TENPHG, nhanvien.TENNV as TENTRGPHONG, COUNT(dean.TENDA) as SOLUONGDA
FROM phongban
         INNER JOIN dean
                    ON phongban.MAPHG = dean.PHONG
         INNER JOIN nhanvien
                    ON phongban.TRPHG = nhanvien.MANV
GROUP BY phongban.TENPHG;

SELECT *
FROM phongban
         INNER JOIN dean
                    ON phongban.MAPHG = dean.PHONG
         INNER JOIN nhanvien
                    ON phongban.TRPHG = nhanvien.MANV
GROUP BY phongban.TENPHG;

#23.
SELECT phongban.TENPHG, COUNT(dean.TENDA), AVG(nhanvien.LUONG) as SOLUONGDA
FROM phongban
         INNER JOIN nhanvien
                    ON phongban.MAPHG = nhanvien.PHG
         INNER JOIN dean
                    ON phongban.MAPHG = dean.PHONG
GROUP BY phongban.MAPHG;

SELECT *
FROM phongban
         INNER JOIN nhanvien
                    ON phongban.MAPHG = nhanvien.PHG
         INNER JOIN dean
                    ON phongban.MAPHG = dean.PHONG;

#24.
SELECT dean.DDIEM_DA, COUNT(dean.MADA) as SOLUONGDA
FROM dean
GROUP BY dean.DDIEM_DA;

#25.
SELECT dean.TENDA, COUNT(congviec.TEN_CONG_VIEC) as SOLUONGCV
FROM dean
         INNER JOIN congviec
                    ON dean.MADA = congviec.MADA
GROUP BY congviec.MADA;

#26.
SELECT congviec.TEN_CONG_VIEC, COUNT(phancong.MA_NVIEN) as SOLUONGDUOCPHANCONG
FROM phancong
         INNER JOIN congviec
                    ON phancong.MADA = congviec.MADA AND phancong.STT = congviec.STT
WHERE congviec.MADA = 30
GROUP BY phancong.STT;
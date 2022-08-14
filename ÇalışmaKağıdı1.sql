--1) t�m m�sterileri listele
select *from Musteriler

--2) t�m m��terilerin sadece MusteriAdi ve MusteriUnvanini listeleyin
select MusteriAdi, MusteriUnvani from Musteriler 

--3) Birim fiyat� 18 ve �zeri olan �r�nleri listeleyin
select * from Urunler where BirimFiyati>= 18 

--4) Sehir bilgisi 'London' olan t�m personelleri listeleyiniz 
select * from Personeller where Sehir='London'

--5) sehir bilgisi 'London' olmayan t�m personllerin ad� ve soyad�n� listeleyiniz
select Adi,SoyAdi from Personeller Where Sehir <> 'London'

--6) KategoriIdsi 3 olan ve birim fiyati 10 dan k���k olan t�m �r�nleri listeleyiniz
select * from Urunler where KategoriID=3 and BirimFiyati<10 

--7) Sehir bilgisi london veya seattle olan t�m personelleri listeleyiniz
select * from personeller where Sehir='London' or Sehir ='Seattle' 
-- or yerine in kullan
select * from personeller where Sehir in ('London','Seattle')

--8) 6 ve 9 nolu kategor�dek� �r�nler d���ndaki t�m �r�nleri listeleyin
select * from Urunler Where KategoriID not in (6,9)

--9) birim fiyat� 10 ve 20 aras�ndak� t�m �r�nleri listeleyiniz
select * from Urunler where BirimFiyati>=10 and BirimFiyati<20
select * from Urunler where BirimFiyati between 10 and 20

--10) b�lgesi tan�ml� olmayan t�m m��terileri listeleyiniz 
select * from Musteriler Where Bolge is null

--11) faks numaras� olan t�m m��terileri listeleyiniz
select *from Musteriler where Faks is not null

--12) manager �nvan�na sahip t�m m��teriler listeleyin
select * from Musteriler where MusteriUnvani like '%Manager'

--13) muster�IDsi FR ile ba�layan 5 karakter olan t�m m��terileri listeleyin
select * from Musteriler where MusteriID like 'FR___'

--14) (171) alan kodlu telefon numaras�na sahip m��terileri listeleyin
select * from Musteriler where  Telefon like '(171)%'

--15) birim miktar alan�nda boxes ge�en t�m �r�nleri listeleyiniz
select * from Urunler where BirimdekiMiktar like '%boxes%'

--14) Fransa ve almanyadaki m�d�rlerin(manager) ad�n� ve telefonunu listeleyiniz
select MusteriAdi,Telefon from Musteriler where MusteriUnvani like '%manager' and Ulke in ('Germany', 'France')

--15) birim fiyat� 10un alt�nda olan �r�nlerin kategor�ID lerin tekil bir �ekilde listeleyiniz
select distinct KategoriID from Urunler where BirimFiyati <10 

--16) en d���k birim fiyata sahip be� �r�n� listeleyin
select top 5 * from Urunler order by BirimFiyati asc

--17) En y�ksek birim fiyata sahip 10 �r�n� listeleyin
select top 10 * from Urunler order by BirimFiyati desc

--18) M��terileri �lke ve �ehir bilgisine g�re s�ralay�p listeleyin
select *from Musteriler order by Ulke, Sehir

--19) Personellerin ad, soyad ve ya� bilgilerini listeleyin(datediff,getdate())
select  Adi,SoyAdi,Datediff(yy,DogumTarihi,GetDate()) as ya� from Personeller

--20) Birim Fiyat� en yuksek olan �r�n�n kategori ad�n� listeleyiniz
select KategoriAdi from Kategoriler Where KategoriID =
(select top 1 KategoriID from Urunler order by BirimFiyati desc)

--21) Kategori ad�nda 'on' ge�en kategorilerin �r�nlerini listeleyiniz
select* from Urunler where KategoriID in
(select KategoriID from Kategoriler Where KategoriAdi like '%on%')

--22) Nancy adl� personelin Brezilyaya sevk etti�i sat��lar� listeleyiniz 
select* from Satislar Where SevkUlkesi='Brazil' and PersonelID= 
(select PersonelID from Personeller Where Adi='Nancy') 

--23) 1996 y�l�nda yap�lan sipari�lerin listesi
select * from Satislar where DATEPART(yy,SatisTarihi)=1996

--24) Japonyadan ka� farkl� �r�n tedarik edilmektedir
Select COUNT(*) Adet from Urunler where TedarikciID in (Select TedarikciID from Tedarikciler where Ulke = 'Japan')

--25) Konbu adl� �r�nden ka� adet sat�lm��t�r
Select SUM(miktar) adet from [Satis Detaylari] where UrunID in (select UrunID from Urunler where UrunAdi = 'Konbu')

--26) 1997 y�l�nda yap�lm�� sat��lar�n en y�ksek, en d���k ve ortalama nakliye �cretlisi ne kadard�r?
select MIN(NakliyeUcreti) Dusuk, MAX(NakliyeUcreti) Yuksek, AVG(NakliyeUcreti) Ortalama from Satislar where DATEPART(yy,SatisTarihi) = 1997

--27) T�m �r�nleri listeleyiniz. Tablolar� basit birle�tirme ba�lay�n�z. (urunAdi,kategoriAdi)
Select u.UrunAdi,k.KategoriAdi from Urunler u, Kategoriler k where u.KategoriID = k.KategoriID

--28) T�m �r�nleri listeleyiniz. Tablolar� join metodu ba�lay�n�z. (urunAdi,kategoriAdi,Tedarik�i �irket ad�)
Select u.UrunAdi,k.KategoriAdi,t.SirketAdi from Urunler u 
inner join Kategoriler k on u.KategoriID = k.KategoriID
inner join Tedarikciler t on t.TedarikciID = u.TedarikciID

--29) 10248 ID li sat���n �r�nlerini listeleyiniz. (UrunAdi,Toplam fiyat�)
select u.UrunAdi,(sd.Miktar * sd.BirimFiyati) Toplam  from [Satis Detaylari] sd 
inner join Urunler u on u.UrunID = sd.UrunID where sd.SatisID = 10248 

--30) En pahal� ve En ucuz �r�n� listeleyiniz.
select * from (Select top 1 * from Urunler order by  BirimFiyati desc) a
union
select * from (Select top 1 * from Urunler order by  BirimFiyati asc) b

--31) Personelleri ve ba�l� �al��t��� ki�ileri listeleyiniz. (Ad,Tur(Patron,Personel,M��teri))
select p.Adi + ' ' + p.SoyAdi as Ad, Adres,'Patron' as Tur from Personeller p where BagliCalistigiKisi is null
union
select p.Adi + ' ' + p.SoyAdi as Ad, Adres,'Personel' as Tur from Personeller p where BagliCalistigiKisi is not null
union
select MusteriAdi as Ad,Adres ,'M��teri' as Tur from Musteriler

--32) Her bir kategoride ka� adet �r�n var listeleyiniz.
Select KategoriID,COUNT(*) Adet from Urunler group by KategoriID

--33) Nancy adl� personelin �lkelere g�re ka� adet sat�� sevk etti�ini listeleyiniz. (Sevk �lkesi,Adet)
Select SevkUlkesi,COUNT(*) Adet from Satislar s inner join Personeller p
on s.PersonelID = p.PersonelID where p.Adi = 'Nancy' group by SevkUlkesi

--34) T�m �r�nlerin ka� adet sat�ld���n� listeleyiniz. (�r�n ad�, Adet)
select u.UrunAdi,yeni.adet from 
(Select sd.UrunID,SUM(sd.Miktar) Adet from Satislar s inner join [Satis Detaylari] sd on s.SatisID = sd.SatisID
group by sd.UrunID) yeni inner join Urunler u on yeni.UrunID = u.UrunID


--35) '01.01.1997','01.01.1998' tarihleri aras�nda yap�lan sat��lar� g�steren sorguyu yaz�n�z. (Sat�� ID, M��teri Ad�, Personel Ad�,Personel ID, �deme Tarihi,Nakliye �creti)
select s.satisID, m.musteriAdi,p.Adi personelAdi ,s.personelID,s.odemeTarihi,s.nakliyeUcreti from satislar s
inner join Personeller p on p.PersonelID=s.PersonelID and s.SevkTarihi between '01.01.1997' and '01.01.1998'
inner join musteriler m on s.MusteriID=m.MusteriID

--36) Kategori ad�n�n i�erisinde �onfe� ge�en �r�nleri listeyen sql ifadesini yaz�n�z. (�r�n ID, Kategori ad�,Birim Fiyat�,Kategori Tan�m�,Tedarik�i �ehir)
select  u.urunID,k.kategoriAdi,u.birimfiyati,k.tanimi as kategoriTanimi,t.sehir as tedarikciSehir from urunler u
inner join Kategoriler k on u.KategoriID=k.KategoriID and k.KategoriAdi like '%onfe%'
inner join tedarikciler t on u.TedarikciID=t.TedarikciID

--37) Sevk b�lgesi bulunmayan ve Sevk �lkesi �Brazil� olan sat��lar�n sevk b�lgesini �BR� olarak g�ncelleyen sql ifadesini yaz�n�z.
UPDATE Satislar set SevkBolgesi='BR' where SevkBolgesi is null and SevkUlkesi='Brazil'

--38) M��teri ID�si BERGS olan M��teri ka� adet sat�n alma i�lemi ger�ekle�tirdi�ini g�steren sql ifadesini yaz�n�z.
select count(*) from Satislar where MusteriID=
(select MusteriID from musteriler where MusteriID='BERGS')

--39) �r�n ad� �Chai� olan �r�n� satan personellerin ad�n� ve soyad�n� listeyen sql sorgusunu yaz�n�z.
select adi +' '+soyadi as [personel Ad Soyad] from personeller where personelID in
(select personelID from satislar where satisID in
(select SatisID from [Satis Detaylari] where urunID in
(select UrunID from URUNLER where UrunAdi='Chai')))

--40) Eposta adresi hotmail.com uzant�l� olan personelleri �bos@duzce.edu.tr� olacak �ekilde d�zenleyen SQL ifadesini yaz�n�z.
alter table personeller add eposta nvarchar (60) 
update personeller set eposta='cigdemkilic@hotmail.com' where PersonelID=1
update personeller set eposta='ASFASDF@gmail.com' where PersonelID=2
update personeller set eposta='sgrafgadfgd@hotmail.com' where PersonelID=3

update personeller set eposta='bos@duzce.edu.tr' where eposta like '%hotmail.com'

--41) �Chang� adl� �r�nden ka� adet sat�ld���n� g�steren sql ifadesini yaz�n�z.
select sum(miktar) from [Satis Detaylari] where urunID in
(select urunID from  urunler where UrunAdi='Chang')

--42) B�lgesi tan�ml� olmayan personellerin ad�n�, soyad�n� ve ya� bilgisini g�steren SQL ifadesini yaz�n�z.
select adi, soyadi, datediff(yy,DogumTarihi,getdate()) yas from personeller

--43) Posta kodu 98105,98033,EC2 7JR olan personellerin t�m bilgilerini g�steren SQL ifadesini yaz�n�z.
select * from personeller where postakodu in ('98105','98033','EC2 7JR')

--44) �nvan� Mr. veya Dr. olup �ehri London olan personellerin t�m bilgilerini g�steren SQL ifadesini yaz�n�z.
select * from personeller where UnvanEki in( 'Mr.','Dr.') and sehir='London'

--45) �lkesi UK olup 30 y�l�n alt�nda �al��m�� personellerin t�m bilgilerini g�steren SQL ifadesini yaz�n�z.
select * from personeller where ulke='UK' and  datediff(yy,IseBaslamaTarihi,getdate())<30

--46) Kimseye ba�l� �al��mayacak �ekilde kendi bilgileriniz ile bir personel ekleyiniz.(Ad s�tununa �ad�n�z�, Soyad s�tununa �Soyad�n�z� vb.)
select * from personeller
insert into personeller (soyadi,adi,BagliCalistigiKisi) values ('k�l��','�i�dem',null)

--STORE PROCEDURE �RNEKLER�
--46) T�m m��terileri listeleyen SP yaz�n�z.
--Olu�turulmas�
Create Proc spTumMusteriler
as
Select * from Musteriler
--Kullan�m�
exec spTumMusteriler

--47) D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden SP yi yaz�n�z.
--Olu�turulmas�
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values
(@sirketAdi,@telefon)
--Kullan�m�
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555)
123-1234'

--48) D��ar�dan g�nderilen bilgilere g�re Nakliyecinin t�m bilgilerini g�ncelleyen SP yi yaz�n�z.
--Olu�turulmas�
create proc spNakliyeciDuzenle
@nakliyeciID int,
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
Update Nakliyeciler set SirketAdi=@sirketAdi,Telefon=@telefon
where NakliyeciID = @nakliyeciID
--Kullan�m�
exec spNakliyeciDuzenle 4,'NakliyeciAdi', '(444) 123-1234'
--veya
exec spNakliyeciDuzenle @nakliyeciID=4, @sirketAdi =
'NakliyeciAdi', @telefon ='(333) 123-1234'

--49) D��ar�dan g�nderilen bilgiye g�re Nakliyeciyi silen SP yi yaz�n�z.
--Olu�turulmas�
create proc spNakliyeciSil
@nakliyeciID int
as
delete from Nakliyeciler where NakliyeciID = @nakliyeciID
--Kullan�m�
exec spNakliyeciSil 4
--veya
exec spNakliyeciSil @nakliyeciID=4

--50) D��ar�dan g�nderilen bilgilere g�re Nakliyeci kaydeden SP yi yaz�n�z. Ayn� telefon numaras� varsa kaydetmeyiniz.
--Olu�turulmas�
create proc spNakliyecilerEkle
@SirketAdi nvarchar(40),
@Telefon nvarchar(24)
as
declare @sayi int
set @sayi = (Select count(*) from Nakliyeciler where Telefon =
@Telefon)
if @sayi>0
begin
print 'B�yle bir telefon numaras� kay�tl�'
end
else
begin
insert into Nakliyeciler (SirketAdi,Telefon)
values (@SirketAdi,@Telefon)
print 'Nakliyeci eklendi.'
end
--Kullan�m�
exec spNakliyecilerEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyecilerEkle @sirketAdi = 'NakliyeciAdi', @telefon
='(555) 123-1234'

--51) G�nderilen KategoriID ye g�re �r�nleri listeleyen SP yi yaz�n�z.(UrunID,UrunAdi,KategoriAdi)
--Olu�turulmas�
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID =
k.KategoriID
where k.KategoriID = @kategoriID
--Kullan�m�
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2

--52) D��ar�dan g�nderilen musteriID ye g�re o m��terinin sat�n ald��� �r�nleri ve ka� adet sat�n ald���n� listeleyen SP yaz�n�z.
--Olu�turulmas�
create PROCEDURE spMusteriUrunAdet
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullan�m�
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'


--53) D��ar�dan g�nderilen iki tarih aras�nda sevk edilen sat��lar� listeleyen SP yi yaz�n�z.
--Olu�turulmas�
create proc spSatisIkiTarih
@basTarih smalldatetime,
@bitTarih smalldatetime
as
select * from Satislar where SevkTarihi between @basTarih and
@bitTarih
--Kullan�m�
exec spSatisIkiTarih '01.01.1997','02.01.1997'
--veya
exec spSatisIkiTarih @basTarih='01.01.1997',@bitTarih='02.01.1997'







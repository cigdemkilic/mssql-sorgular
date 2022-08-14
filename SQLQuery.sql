--1) tüm müsterileri listele
select *from Musteriler

--2) tüm müþterilerin sadece MusteriAdi ve MusteriUnvanini listeleyin
select MusteriAdi, MusteriUnvani from Musteriler 

--3) Birim fiyatý 18 ve üzeri olan ürünleri listeleyin
select * from Urunler where BirimFiyati>= 18 

--4) Sehir bilgisi 'London' olan tüm personelleri listeleyiniz 
select * from Personeller where Sehir='London'

--5) sehir bilgisi 'London' olmayan tüm personllerin adý ve soyadýný listeleyiniz
select Adi,SoyAdi from Personeller Where Sehir <> 'London'

--6) KategoriIdsi 3 olan ve birim fiyati 10 dan küçük olan tüm ürünleri listeleyiniz
select * from Urunler where KategoriID=3 and BirimFiyati<10 

--7) Sehir bilgisi london veya seattle olan tüm personelleri listeleyiniz
select * from personeller where Sehir='London' or Sehir ='Seattle' 
-- or yerine in kullan
select * from personeller where Sehir in ('London','Seattle')

--8) 6 ve 9 nolu kategorýdeký ürünler dýþýndaki tüm ürünleri listeleyin
select * from Urunler Where KategoriID not in (6,9)

--9) birim fiyatý 10 ve 20 arasýndaký tüm ürünleri listeleyiniz
select * from Urunler where BirimFiyati>=10 and BirimFiyati<20
select * from Urunler where BirimFiyati between 10 and 20

--10) bölgesi tanýmlý olmayan tüm müþterileri listeleyiniz 
select * from Musteriler Where Bolge is null

--11) faks numarasý olan tüm müþterileri listeleyiniz
select *from Musteriler where Faks is not null

--12) manager ünvanýna sahip tüm müþteriler listeleyin
select * from Musteriler where MusteriUnvani like '%Manager'

--13) musterýIDsi FR ile baþlayan 5 karakter olan tüm müþterileri listeleyin
select * from Musteriler where MusteriID like 'FR___'

--14) (171) alan kodlu telefon numarasýna sahip müþterileri listeleyin
select * from Musteriler where  Telefon like '(171)%'

--15) birim miktar alanýnda boxes geçen tüm ürünleri listeleyiniz
select * from Urunler where BirimdekiMiktar like '%boxes%'

--14) Fransa ve almanyadaki müdürlerin(manager) adýný ve telefonunu listeleyiniz
select MusteriAdi,Telefon from Musteriler where MusteriUnvani like '%manager' and Ulke in ('Germany', 'France')

--15) birim fiyatý 10un altýnda olan ürünlerin kategorýID lerin tekil bir þekilde listeleyiniz
select distinct KategoriID from Urunler where BirimFiyati <10 

--16) en düþük birim fiyata sahip beþ ürünü listeleyin
select top 5 * from Urunler order by BirimFiyati asc

--17) En yüksek birim fiyata sahip 10 ürünü listeleyin
select top 10 * from Urunler order by BirimFiyati desc

--18) Müþterileri ülke ve þehir bilgisine göre sýralayýp listeleyin
select *from Musteriler order by Ulke, Sehir

--19) Personellerin ad, soyad ve yaþ bilgilerini listeleyin(datediff,getdate())
select  Adi,SoyAdi,Datediff(yy,DogumTarihi,GetDate()) as yaþ from Personeller

--20) Birim Fiyatý en yuksek olan ürünün kategori adýný listeleyiniz
select KategoriAdi from Kategoriler Where KategoriID =
(select top 1 KategoriID from Urunler order by BirimFiyati desc)

--21) Kategori adýnda 'on' geçen kategorilerin ürünlerini listeleyiniz
select* from Urunler where KategoriID in
(select KategoriID from Kategoriler Where KategoriAdi like '%on%')

--22) Nancy adlý personelin Brezilyaya sevk ettiði satýþlarý listeleyiniz 
select* from Satislar Where SevkUlkesi='Brazil' and PersonelID= 
(select PersonelID from Personeller Where Adi='Nancy') 

--23) 1996 yýlýnda yapýlan sipariþlerin listesi
select * from Satislar where DATEPART(yy,SatisTarihi)=1996

--24) Japonyadan kaç farklý ürün tedarik edilmektedir
Select COUNT(*) Adet from Urunler where TedarikciID in (Select TedarikciID from Tedarikciler where Ulke = 'Japan')

--25) Konbu adlý üründen kaç adet satýlmýþtýr
Select SUM(miktar) adet from [Satis Detaylari] where UrunID in (select UrunID from Urunler where UrunAdi = 'Konbu')

--26) 1997 yýlýnda yapýlmýþ satýþlarýn en yüksek, en düþük ve ortalama nakliye ücretlisi ne kadardýr?
select MIN(NakliyeUcreti) Dusuk, MAX(NakliyeUcreti) Yuksek, AVG(NakliyeUcreti) Ortalama from Satislar where DATEPART(yy,SatisTarihi) = 1997

--27) Tüm ürünleri listeleyiniz. Tablolarý basit birleþtirme baðlayýnýz. (urunAdi,kategoriAdi)
Select u.UrunAdi,k.KategoriAdi from Urunler u, Kategoriler k where u.KategoriID = k.KategoriID

--28) Tüm ürünleri listeleyiniz. Tablolarý join metodu baðlayýnýz. (urunAdi,kategoriAdi,Tedarikçi þirket adý)
Select u.UrunAdi,k.KategoriAdi,t.SirketAdi from Urunler u 
inner join Kategoriler k on u.KategoriID = k.KategoriID
inner join Tedarikciler t on t.TedarikciID = u.TedarikciID

--29) 10248 ID li satýþýn ürünlerini listeleyiniz. (UrunAdi,Toplam fiyatý)
select u.UrunAdi,(sd.Miktar * sd.BirimFiyati) Toplam  from [Satis Detaylari] sd 
inner join Urunler u on u.UrunID = sd.UrunID where sd.SatisID = 10248 

--30) En pahalý ve En ucuz ürünü listeleyiniz.
select * from (Select top 1 * from Urunler order by  BirimFiyati desc) a
union
select * from (Select top 1 * from Urunler order by  BirimFiyati asc) b

--31) Personelleri ve baðlý çalýþtýðý kiþileri listeleyiniz. (Ad,Tur(Patron,Personel,Müþteri))
select p.Adi + ' ' + p.SoyAdi as Ad, Adres,'Patron' as Tur from Personeller p where BagliCalistigiKisi is null
union
select p.Adi + ' ' + p.SoyAdi as Ad, Adres,'Personel' as Tur from Personeller p where BagliCalistigiKisi is not null
union
select MusteriAdi as Ad,Adres ,'Müþteri' as Tur from Musteriler

--32) Her bir kategoride kaç adet ürün var listeleyiniz.
Select KategoriID,COUNT(*) Adet from Urunler group by KategoriID

--33) Nancy adlý personelin ülkelere göre kaç adet satýþ sevk ettiðini listeleyiniz. (Sevk Ülkesi,Adet)
Select SevkUlkesi,COUNT(*) Adet from Satislar s inner join Personeller p
on s.PersonelID = p.PersonelID where p.Adi = 'Nancy' group by SevkUlkesi

--34) Tüm ürünlerin kaç adet satýldýðýný listeleyiniz. (Ürün adý, Adet)
select u.UrunAdi,yeni.adet from 
(Select sd.UrunID,SUM(sd.Miktar) Adet from Satislar s inner join [Satis Detaylari] sd on s.SatisID = sd.SatisID
group by sd.UrunID) yeni inner join Urunler u on yeni.UrunID = u.UrunID


--35) '01.01.1997','01.01.1998' tarihleri arasýnda yapýlan satýþlarý gösteren sorguyu yazýnýz. (Satýþ ID, Müþteri Adý, Personel Adý,Personel ID, Ödeme Tarihi,Nakliye Ücreti)
select s.satisID, m.musteriAdi,p.Adi personelAdi ,s.personelID,s.odemeTarihi,s.nakliyeUcreti from satislar s
inner join Personeller p on p.PersonelID=s.PersonelID and s.SevkTarihi between '01.01.1997' and '01.01.1998'
inner join musteriler m on s.MusteriID=m.MusteriID

--36) Kategori adýnýn içerisinde ‘onfe’ geçen ürünleri listeyen sql ifadesini yazýnýz. (Ürün ID, Kategori adý,Birim Fiyatý,Kategori Tanýmý,Tedarikçi Þehir)
select  u.urunID,k.kategoriAdi,u.birimfiyati,k.tanimi as kategoriTanimi,t.sehir as tedarikciSehir from urunler u
inner join Kategoriler k on u.KategoriID=k.KategoriID and k.KategoriAdi like '%onfe%'
inner join tedarikciler t on u.TedarikciID=t.TedarikciID

--37) Sevk bölgesi bulunmayan ve Sevk ülkesi ‘Brazil’ olan satýþlarýn sevk bölgesini ‘BR’ olarak güncelleyen sql ifadesini yazýnýz.
UPDATE Satislar set SevkBolgesi='BR' where SevkBolgesi is null and SevkUlkesi='Brazil'

--38) Müþteri ID’si BERGS olan Müþteri kaç adet satýn alma iþlemi gerçekleþtirdiðini gösteren sql ifadesini yazýnýz.
select count(*) from Satislar where MusteriID=
(select MusteriID from musteriler where MusteriID='BERGS')

--39) Ürün adý ‘Chai’ olan ürünü satan personellerin adýný ve soyadýný listeyen sql sorgusunu yazýnýz.
select adi +' '+soyadi as [personel Ad Soyad] from personeller where personelID in
(select personelID from satislar where satisID in
(select SatisID from [Satis Detaylari] where urunID in
(select UrunID from URUNLER where UrunAdi='Chai')))

--40) Eposta adresi hotmail.com uzantýlý olan personelleri ‘bos@duzce.edu.tr’ olacak þekilde düzenleyen SQL ifadesini yazýnýz.
alter table personeller add eposta nvarchar (60) 
update personeller set eposta='cigdemkilic@hotmail.com' where PersonelID=1
update personeller set eposta='ASFASDF@gmail.com' where PersonelID=2
update personeller set eposta='sgrafgadfgd@hotmail.com' where PersonelID=3

update personeller set eposta='bos@duzce.edu.tr' where eposta like '%hotmail.com'

--41) ‘Chang’ adlý üründen kaç adet satýldýðýný gösteren sql ifadesini yazýnýz.
select sum(miktar) from [Satis Detaylari] where urunID in
(select urunID from  urunler where UrunAdi='Chang')

--42) Bölgesi tanýmlý olmayan personellerin adýný, soyadýný ve yaþ bilgisini gösteren SQL ifadesini yazýnýz.
select adi, soyadi, datediff(yy,DogumTarihi,getdate()) yas from personeller

--43) Posta kodu 98105,98033,EC2 7JR olan personellerin tüm bilgilerini gösteren SQL ifadesini yazýnýz.
select * from personeller where postakodu in ('98105','98033','EC2 7JR')

--44) Ünvaný Mr. veya Dr. olup þehri London olan personellerin tüm bilgilerini gösteren SQL ifadesini yazýnýz.
select * from personeller where UnvanEki in( 'Mr.','Dr.') and sehir='London'

--45) Ülkesi UK olup 30 yýlýn altýnda çalýþmýþ personellerin tüm bilgilerini gösteren SQL ifadesini yazýnýz.
select * from personeller where ulke='UK' and  datediff(yy,IseBaslamaTarihi,getdate())<30

--46) Kimseye baðlý çalýþmayacak þekilde kendi bilgileriniz ile bir personel ekleyiniz.(Ad sütununa ‘adýnýz’, Soyad sütununa ‘Soyadýnýz’ vb.)
select * from personeller
insert into personeller (soyadi,adi,BagliCalistigiKisi) values ('kýlýç','çiðdem',null)

--STORE PROCEDURE ÖRNEKLERÝ
--46) Tüm müþterileri listeleyen SP yazýnýz.
--Oluþturulmasý
Create Proc spTumMusteriler
as
Select * from Musteriler
--Kullanýmý
exec spTumMusteriler

--47) Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazýnýz.
--Oluþturulmasý
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values
(@sirketAdi,@telefon)
--Kullanýmý
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555)
123-1234'

--48) Dýþarýdan gönderilen bilgilere göre Nakliyecinin tüm bilgilerini güncelleyen SP yi yazýnýz.
--Oluþturulmasý
create proc spNakliyeciDuzenle
@nakliyeciID int,
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
Update Nakliyeciler set SirketAdi=@sirketAdi,Telefon=@telefon
where NakliyeciID = @nakliyeciID
--Kullanýmý
exec spNakliyeciDuzenle 4,'NakliyeciAdi', '(444) 123-1234'
--veya
exec spNakliyeciDuzenle @nakliyeciID=4, @sirketAdi =
'NakliyeciAdi', @telefon ='(333) 123-1234'

--49) Dýþarýdan gönderilen bilgiye göre Nakliyeciyi silen SP yi yazýnýz.
--Oluþturulmasý
create proc spNakliyeciSil
@nakliyeciID int
as
delete from Nakliyeciler where NakliyeciID = @nakliyeciID
--Kullanýmý
exec spNakliyeciSil 4
--veya
exec spNakliyeciSil @nakliyeciID=4

--50) Dýþarýdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazýnýz. Ayný telefon numarasý varsa kaydetmeyiniz.
--Oluþturulmasý
create proc spNakliyecilerEkle
@SirketAdi nvarchar(40),
@Telefon nvarchar(24)
as
declare @sayi int
set @sayi = (Select count(*) from Nakliyeciler where Telefon =
@Telefon)
if @sayi>0
begin
print 'Böyle bir telefon numarasý kayýtlý'
end
else
begin
insert into Nakliyeciler (SirketAdi,Telefon)
values (@SirketAdi,@Telefon)
print 'Nakliyeci eklendi.'
end
--Kullanýmý
exec spNakliyecilerEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyecilerEkle @sirketAdi = 'NakliyeciAdi', @telefon
='(555) 123-1234'

--51) Gönderilen KategoriID ye göre ürünleri listeleyen SP yi yazýnýz.(UrunID,UrunAdi,KategoriAdi)
--Oluþturulmasý
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID =
k.KategoriID
where k.KategoriID = @kategoriID
--Kullanýmý
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2

--52) Dýþarýdan gönderilen musteriID ye göre o müþterinin satýn aldýðý ürünleri ve kaç adet satýn aldýðýný listeleyen SP yazýnýz.
--Oluþturulmasý
create PROCEDURE spMusteriUrunAdet
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullanýmý
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'


--53) Dýþarýdan gönderilen iki tarih arasýnda sevk edilen satýþlarý listeleyen SP yi yazýnýz.
--Oluþturulmasý
create proc spSatisIkiTarih
@basTarih smalldatetime,
@bitTarih smalldatetime
as
select * from Satislar where SevkTarihi between @basTarih and
@bitTarih
--Kullanýmý
exec spSatisIkiTarih '01.01.1997','02.01.1997'
--veya
exec spSatisIkiTarih @basTarih='01.01.1997',@bitTarih='02.01.1997'







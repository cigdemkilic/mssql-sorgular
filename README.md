# mssql-sorgular
northwind veri tabanı sorgu örnekleri
--1) tüm müsterileri listele
select *from Musteriler

--2) tüm müşterilerin sadece MusteriAdi ve MusteriUnvanini listeleyin
select MusteriAdi, MusteriUnvani from Musteriler 

--3) Birim fiyatı 18 ve üzeri olan ürünleri listeleyin
select * from Urunler where BirimFiyati>= 18 

--4) Sehir bilgisi 'London' olan tüm personelleri listeleyiniz 
select * from Personeller where Sehir='London'

--5) sehir bilgisi 'London' olmayan tüm personllerin adı ve soyadını listeleyiniz
select Adi,SoyAdi from Personeller Where Sehir <> 'London'

--6) KategoriIdsi 3 olan ve birim fiyati 10 dan küçük olan tüm ürünleri listeleyiniz
select * from Urunler where KategoriID=3 and BirimFiyati<10 

--7) Sehir bilgisi london veya seattle olan tüm personelleri listeleyiniz
select * from personeller where Sehir='London' or Sehir ='Seattle' 
-- or yerine in kullan
select * from personeller where Sehir in ('London','Seattle')

--8) 6 ve 9 nolu kategorıdekı ürünler dışındaki tüm ürünleri listeleyin
select * from Urunler Where KategoriID not in (6,9)

--9) birim fiyatı 10 ve 20 arasındakı tüm ürünleri listeleyiniz
select * from Urunler where BirimFiyati>=10 and BirimFiyati<20
select * from Urunler where BirimFiyati between 10 and 20

--10) bölgesi tanımlı olmayan tüm müşterileri listeleyiniz 
select * from Musteriler Where Bolge is null

--11) faks numarası olan tüm müşterileri listeleyiniz
select *from Musteriler where Faks is not null

--12) manager ünvanına sahip tüm müşteriler listeleyin
select * from Musteriler where MusteriUnvani like '%Manager'

--13) musterıIDsi FR ile başlayan 5 karakter olan tüm müşterileri listeleyin
select * from Musteriler where MusteriID like 'FR___'

--14) (171) alan kodlu telefon numarasına sahip müşterileri listeleyin
select * from Musteriler where  Telefon like '(171)%'

--15) birim miktar alanında boxes geçen tüm ürünleri listeleyiniz
select * from Urunler where BirimdekiMiktar like '%boxes%'

--14) Fransa ve almanyadaki müdürlerin(manager) adını ve telefonunu listeleyiniz
select MusteriAdi,Telefon from Musteriler where MusteriUnvani like '%manager' and Ulke in ('Germany', 'France')

--15) birim fiyatı 10un altında olan ürünlerin kategorıID lerin tekil bir şekilde listeleyiniz
select distinct KategoriID from Urunler where BirimFiyati <10 

--16) en düşük birim fiyata sahip beş ürünü listeleyin
select top 5 * from Urunler order by BirimFiyati asc

--17) En yüksek birim fiyata sahip 10 ürünü listeleyin
select top 10 * from Urunler order by BirimFiyati desc

--18) Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyin
select *from Musteriler order by Ulke, Sehir

--19) Personellerin ad, soyad ve yaş bilgilerini listeleyin(datediff,getdate())
select  Adi,SoyAdi,Datediff(yy,DogumTarihi,GetDate()) as yaş from Personeller

--20) Birim Fiyatı en yuksek olan ürünün kategori adını listeleyiniz
select KategoriAdi from Kategoriler Where KategoriID =
(select top 1 KategoriID from Urunler order by BirimFiyati desc)

--21) Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz
select* from Urunler where KategoriID in
(select KategoriID from Kategoriler Where KategoriAdi like '%on%')

--22) Nancy adlı personelin Brezilyaya sevk ettiği satışları listeleyiniz 
select* from Satislar Where SevkUlkesi='Brazil' and PersonelID= 
(select PersonelID from Personeller Where Adi='Nancy') 

--23) 1996 yılında yapılan siparişlerin listesi
select * from Satislar where DATEPART(yy,SatisTarihi)=1996

--24) Japonyadan kaç farklı ürün tedarik edilmektedir
Select COUNT(*) Adet from Urunler where TedarikciID in (Select TedarikciID from Tedarikciler where Ulke = 'Japan')

--25) Konbu adlı üründen kaç adet satılmıştır
Select SUM(miktar) adet from [Satis Detaylari] where UrunID in (select UrunID from Urunler where UrunAdi = 'Konbu')

--26) 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?
select MIN(NakliyeUcreti) Dusuk, MAX(NakliyeUcreti) Yuksek, AVG(NakliyeUcreti) Ortalama from Satislar where DATEPART(yy,SatisTarihi) = 1997

--27) Tüm ürünleri listeleyiniz. Tabloları basit birleştirme bağlayınız. (urunAdi,kategoriAdi)
Select u.UrunAdi,k.KategoriAdi from Urunler u, Kategoriler k where u.KategoriID = k.KategoriID

--28) Tüm ürünleri listeleyiniz. Tabloları join metodu bağlayınız. (urunAdi,kategoriAdi,Tedarikçi şirket adı)
Select u.UrunAdi,k.KategoriAdi,t.SirketAdi from Urunler u 
inner join Kategoriler k on u.KategoriID = k.KategoriID
inner join Tedarikciler t on t.TedarikciID = u.TedarikciID

--29) 10248 ID li satışın ürünlerini listeleyiniz. (UrunAdi,Toplam fiyatı)
select u.UrunAdi,(sd.Miktar * sd.BirimFiyati) Toplam  from [Satis Detaylari] sd 
inner join Urunler u on u.UrunID = sd.UrunID where sd.SatisID = 10248 

--30) En pahalı ve En ucuz ürünü listeleyiniz.
select * from (Select top 1 * from Urunler order by  BirimFiyati desc) a
union
select * from (Select top 1 * from Urunler order by  BirimFiyati asc) b

--31) Personelleri ve bağlı çalıştığı kişileri listeleyiniz. (Ad,Tur(Patron,Personel,Müşteri))
select p.Adi + ' ' + p.SoyAdi as Ad, Adres,'Patron' as Tur from Personeller p where BagliCalistigiKisi is null
union
select p.Adi + ' ' + p.SoyAdi as Ad, Adres,'Personel' as Tur from Personeller p where BagliCalistigiKisi is not null
union
select MusteriAdi as Ad,Adres ,'Müşteri' as Tur from Musteriler

--32) Her bir kategoride kaç adet ürün var listeleyiniz.
Select KategoriID,COUNT(*) Adet from Urunler group by KategoriID

--33) Nancy adlı personelin ülkelere göre kaç adet satış sevk ettiğini listeleyiniz. (Sevk Ülkesi,Adet)
Select SevkUlkesi,COUNT(*) Adet from Satislar s inner join Personeller p
on s.PersonelID = p.PersonelID where p.Adi = 'Nancy' group by SevkUlkesi

--34) Tüm ürünlerin kaç adet satıldığını listeleyiniz. (Ürün adı, Adet)
select u.UrunAdi,yeni.adet from 
(Select sd.UrunID,SUM(sd.Miktar) Adet from Satislar s inner join [Satis Detaylari] sd on s.SatisID = sd.SatisID
group by sd.UrunID) yeni inner join Urunler u on yeni.UrunID = u.UrunID


--35) '01.01.1997','01.01.1998' tarihleri arasında yapılan satışları gösteren sorguyu yazınız. (Satış ID, Müşteri Adı, Personel Adı,Personel ID, Ödeme Tarihi,Nakliye Ücreti)
select s.satisID, m.musteriAdi,p.Adi personelAdi ,s.personelID,s.odemeTarihi,s.nakliyeUcreti from satislar s
inner join Personeller p on p.PersonelID=s.PersonelID and s.SevkTarihi between '01.01.1997' and '01.01.1998'
inner join musteriler m on s.MusteriID=m.MusteriID

--36) Kategori adının içerisinde ‘onfe’ geçen ürünleri listeyen sql ifadesini yazınız. (Ürün ID, Kategori adı,Birim Fiyatı,Kategori Tanımı,Tedarikçi Şehir)
select  u.urunID,k.kategoriAdi,u.birimfiyati,k.tanimi as kategoriTanimi,t.sehir as tedarikciSehir from urunler u
inner join Kategoriler k on u.KategoriID=k.KategoriID and k.KategoriAdi like '%onfe%'
inner join tedarikciler t on u.TedarikciID=t.TedarikciID

--37) Sevk bölgesi bulunmayan ve Sevk ülkesi ‘Brazil’ olan satışların sevk bölgesini ‘BR’ olarak güncelleyen sql ifadesini yazınız.
UPDATE Satislar set SevkBolgesi='BR' where SevkBolgesi is null and SevkUlkesi='Brazil'

--38) Müşteri ID’si BERGS olan Müşteri kaç adet satın alma işlemi gerçekleştirdiğini gösteren sql ifadesini yazınız.
select count(*) from Satislar where MusteriID=
(select MusteriID from musteriler where MusteriID='BERGS')

--39) Ürün adı ‘Chai’ olan ürünü satan personellerin adını ve soyadını listeyen sql sorgusunu yazınız.
select adi +' '+soyadi as [personel Ad Soyad] from personeller where personelID in
(select personelID from satislar where satisID in
(select SatisID from [Satis Detaylari] where urunID in
(select UrunID from URUNLER where UrunAdi='Chai')))

--40) Eposta adresi hotmail.com uzantılı olan personelleri ‘bos@duzce.edu.tr’ olacak şekilde düzenleyen SQL ifadesini yazınız.
alter table personeller add eposta nvarchar (60) 
update personeller set eposta='cigdemkilic@hotmail.com' where PersonelID=1
update personeller set eposta='ASFASDF@gmail.com' where PersonelID=2
update personeller set eposta='sgrafgadfgd@hotmail.com' where PersonelID=3

update personeller set eposta='bos@duzce.edu.tr' where eposta like '%hotmail.com'

--41) ‘Chang’ adlı üründen kaç adet satıldığını gösteren sql ifadesini yazınız.
select sum(miktar) from [Satis Detaylari] where urunID in
(select urunID from  urunler where UrunAdi='Chang')

--42) Bölgesi tanımlı olmayan personellerin adını, soyadını ve yaş bilgisini gösteren SQL ifadesini yazınız.
select adi, soyadi, datediff(yy,DogumTarihi,getdate()) yas from personeller

--43) Posta kodu 98105,98033,EC2 7JR olan personellerin tüm bilgilerini gösteren SQL ifadesini yazınız.
select * from personeller where postakodu in ('98105','98033','EC2 7JR')

--44) Ünvanı Mr. veya Dr. olup şehri London olan personellerin tüm bilgilerini gösteren SQL ifadesini yazınız.
select * from personeller where UnvanEki in( 'Mr.','Dr.') and sehir='London'

--45) Ülkesi UK olup 30 yılın altında çalışmış personellerin tüm bilgilerini gösteren SQL ifadesini yazınız.
select * from personeller where ulke='UK' and  datediff(yy,IseBaslamaTarihi,getdate())<30

--46) Kimseye bağlı çalışmayacak şekilde kendi bilgileriniz ile bir personel ekleyiniz.(Ad sütununa ‘adınız’, Soyad sütununa ‘Soyadınız’ vb.)
select * from personeller
insert into personeller (soyadi,adi,BagliCalistigiKisi) values ('kılıç','çiğdem',null)


--STORE PROCEDURE ÖRNEKLERİ
--46) Tüm müşterileri listeleyen SP yazınız.
--Oluşturulması
Create Proc spTumMusteriler
as
Select * from Musteriler
--Kullanımı
exec spTumMusteriler

--47) Dışarıdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazınız.
--Oluşturulması
create proc spNakliyeciEkle
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
insert into Nakliyeciler (SirketAdi,Telefon) values
(@sirketAdi,@telefon)
--Kullanımı
exec spNakliyeciEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyeciEkle @sirketAdi = 'NakliyeciAdi', @telefon ='(555)
123-1234'

--48) Dışarıdan gönderilen bilgilere göre Nakliyecinin tüm bilgilerini güncelleyen SP yi yazınız.
--Oluşturulması
create proc spNakliyeciDuzenle
@nakliyeciID int,
@sirketAdi nvarchar(40),
@telefon nvarchar(24)
as
Update Nakliyeciler set SirketAdi=@sirketAdi,Telefon=@telefon
where NakliyeciID = @nakliyeciID
--Kullanımı
exec spNakliyeciDuzenle 4,'NakliyeciAdi', '(444) 123-1234'
--veya
exec spNakliyeciDuzenle @nakliyeciID=4, @sirketAdi =
'NakliyeciAdi', @telefon ='(333) 123-1234'

--49) Dışarıdan gönderilen bilgiye göre Nakliyeciyi silen SP yi yazınız.
--Oluşturulması
create proc spNakliyeciSil
@nakliyeciID int
as
delete from Nakliyeciler where NakliyeciID = @nakliyeciID
--Kullanımı
exec spNakliyeciSil 4
--veya
exec spNakliyeciSil @nakliyeciID=4

--50) Dışarıdan gönderilen bilgilere göre Nakliyeci kaydeden SP yi yazınız. Aynı telefon numarası varsa kaydetmeyiniz.
--Oluşturulması
create proc spNakliyecilerEkle
@SirketAdi nvarchar(40),
@Telefon nvarchar(24)
as
declare @sayi int
set @sayi = (Select count(*) from Nakliyeciler where Telefon =
@Telefon)
if @sayi>0
begin
print 'Böyle bir telefon numarası kayıtlı'
end
else
begin
insert into Nakliyeciler (SirketAdi,Telefon)
values (@SirketAdi,@Telefon)
print 'Nakliyeci eklendi.'
end
--Kullanımı
exec spNakliyecilerEkle 'NakliyeciAdi', '(555) 123-1234'
--veya
exec spNakliyecilerEkle @sirketAdi = 'NakliyeciAdi', @telefon
='(555) 123-1234'

--51) Gönderilen KategoriID ye göre ürünleri listeleyen SP yi yazınız.(UrunID,UrunAdi,KategoriAdi)
--Oluşturulması
create proc spUrunlerKategoriID
@kategoriID int
as
select u.UrunID,u.UrunAdi,k.KategoriAdi
from Urunler u inner join Kategoriler k on u.KategoriID =
k.KategoriID
where k.KategoriID = @kategoriID
--Kullanımı
exec spUrunlerKategoriID 2
--veya
exec spUrunlerKategoriID @kategoriID=2

--52) Dışarıdan gönderilen musteriID ye göre o müşterinin satın aldığı ürünleri ve kaç adet satın aldığını listeleyen SP yazınız.
--Oluşturulması
create PROCEDURE spMusteriUrunAdet
@MusteriID nchar(5)
AS
SELECT u.UrunAdi, SUM(sd.Miktar) as ToplamAdet FROM Urunler u
inner join [Satis Detaylari] sd on u.UrunID=sd.UrunID
inner join Satislar s on sd.SatisID = s.SatisID
WHERE s.MusteriID = @MusteriID
GROUP BY u.UrunAdi
--Kullanımı
exec spMusteriUrunAdet 'ALFKI'
--veya
exec spMusteriUrunAdet @MusteriID='ALFKI'


--53) Dışarıdan gönderilen iki tarih arasında sevk edilen satışları listeleyen SP yi yazınız.
--Oluşturulması
create proc spSatisIkiTarih
@basTarih smalldatetime,
@bitTarih smalldatetime
as
select * from Satislar where SevkTarihi between @basTarih and
@bitTarih
--Kullanımı
exec spSatisIkiTarih '01.01.1997','02.01.1997'
--veya
exec spSatisIkiTarih @basTarih='01.01.1997',@bitTarih='02.01.1997'

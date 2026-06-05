--1. Bölümlere (Polikliniklere) Göre Doktor Sayılarının Listelenmesi

SELECT b.Bolum_Adi AS 'Poliklinik Adı', COUNT(d.Doktor_ID) AS 'Doktor Sayısı'
FROM Bolumler b, Doktorlar d
WHERE b.Bolum_ID = d.Bolum_ID
GROUP BY b.Bolum_Adi
-----------------------------------------------------------------------------------

--2. Hastaların Randevu Bilgileri ve İlgili Doktorların Listelenmesi

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta Adı Soyadı',
 d.Ad + ' ' + d.Soyad AS 'Doktor',
 r.Randevu_Tarihi AS 'Tarih',
 r.Durum AS 'Randevu Durumu'
FROM Randevular r, Hastalar h, Doktorlar d
WHERE r.Hasta_ID = h.Hasta_ID AND r.Doktor_ID = d.Doktor_ID
-----------------------------------------------------------------------------------

--3. Hastaların Fatura Tutarları ve Ödeme Durumlarının İncelenmesi

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta Adı Soyadı',
 f.Fatura_Tarihi AS 'Fatura Tarihi',
 f.Tutar AS 'Tutar (TL)',
 f.Odendi_Mi AS 'Ödendi mi?
-----------------------------------------------------------------------------------

--4. Hastaların Kan Gruplarına Göre Sayısal Dağılımı

SELECT Kan_Grubu AS 'Kan Grubu', COUNT(Hasta_ID) AS 'Hasta Sayısı'
FROM Hastalar
GROUP BY Kan_Grubu
-----------------------------------------------------------------------------------

--5. Hangi Bölümde Hangi Cihazlar Var ve Son Bakım Tarihleri

SELECT b.Bolum_Adi AS 'Poliklinik',
 t.Cihaz_Adi AS 'Cihaz Adı',
 t.Son_Bakim_Tarihi AS 'Bakım Tarihi'
FROM Bolumler b, Tibbi_Cihazlar t
WHERE b.Bolum_ID = t.Bolum_ID
-----------------------------------------------------------------------------------

--6. Hastaların Reçete Edilen İlaçları ve Kullanım Şekilleri

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta Adı',
 i.Ilac_Adi AS 'İlaç',
 r.Doz AS 'Doz',
 i.Kullanim_Sekli AS 'Kullanım Şekli'
FROM Hastalar h, Tedaviler t, Receteler r, Ilaclar i
WHERE h.Hasta_ID = t.Hasta_ID
AND t.Tedavi_ID = r.Tedavi_ID
AND r.Ilac_ID = i.Ilac_ID
-----------------------------------------------------------------------------------

--7. Yatan Hastaların Oda Numaraları ve Kalış Süreleri

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta Adı',
 o.Oda_Numarasi AS 'Oda Numarası',
 y.Yatis_Tarihi AS 'Yatış Tarihi',
 y.Cikis_Tarihi AS 'Çıkış Tarihi'
FROM Hastalar h, Odalar o, Yatan_Hastalar y
WHERE h.Hasta_ID = y.Hasta_ID AND o.Oda_ID = y.Oda_ID
-----------------------------------------------------------------------------------

--8. Hastanede Yapılan Ameliyatlar ve Sorumlu Doktorlar

SELECT a.Ameliyat_Adi AS 'Ameliyat Türü',
 h.Ad + ' ' + h.Soyad AS 'Hasta',
 d.Ad + ' ' + d.Soyad AS 'Cerrah (Doktor)',
 a.Tarih AS 'Ameliyat Tarihi'
FROM Ameliyatlar a, Hastalar h, Doktorlar d
WHERE a.Hasta_ID = h.Hasta_ID AND a.Doktor_ID = d.Doktor_ID
-----------------------------------------------------------------------------------

--9. Hastaların Yaptırdığı Tahliller ve Çıkan Sonuçlar

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta Adı',
 t.Tahlil_Turu AS 'Tahlil Türü',
 t.Sonuc AS 'Tahlil Sonucu',
 t.Tarih AS 'Tarih'
FROM Hastalar h, Tahliller t
WHERE h.Hasta_ID = t.Hasta_ID
-----------------------------------------------------------------------------------

--10. Hastalara Konulan Teşhisler ve İlgilenen Doktorlar

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta',
 t.Teshis AS 'Konulan Teşhis',
 d.Ad + ' ' + d.Soyad AS 'İlgilenen Doktor',
 t.Tarih AS 'Tedavi Tarihi'
FROM Tedaviler t, Hastalar h, Doktorlar d
WHERE t.Hasta_ID = h.Hasta_ID AND t.Doktor_ID = d.Doktor_ID
-----------------------------------------------------------------------------------

--11. Polikliniklere (Bölümlere) Göre Görevli Hemşire Listesi

SELECT b.Bolum_Adi AS 'Poliklinik',
 he.Ad + ' ' + he.Soyad AS 'Hemşire Adı Soyadı'
FROM Hemsireler he, Bolumler b
WHERE he.Bolum_ID = b.Bolum_ID
ORDER BY b.Bolum_Adi
-----------------------------------------------------------------------------------

--12. Hastane Personellerinin Görevlerine Göre Sayısal Dağılımı

SELECT Gorev AS 'Personel Görevi',
 COUNT(Personel_ID) AS 'Çalışan Sayısı'
FROM Personeller
GROUP BY Gorev
-----------------------------------------------------------------------------------

--13. Müsait (Boş) Olan Odaların Listelenmesi

SELECT Oda_Numarasi AS 'Oda Numarası',
 Yatak_Sayisi AS 'Yatak Sayısı'
FROM Odalar
WHERE Bos_Mu = 1
-----------------------------------------------------------------------------------

--14. Ödemesi Yapılmamış (Bekleyen) Faturalar ve Hastalar

SELECT h.Ad + ' ' + h.Soyad AS 'Hasta Adı Soyadı',
 f.Fatura_Tarihi AS 'Fatura Tarihi',
 f.Tutar AS 'Ödenecek Tutar (TL)'
FROM Hastalar h, Faturalar f
WHERE h.Hasta_ID = f.Hasta_ID AND f.Odendi_Mi = 0
-----------------------------------------------------------------------------------

--15. Randevu Durumlarına Göre Toplam Sayılar

SELECT Durum AS 'Randevu Durumu',
 COUNT(Randevu_ID) AS 'Toplam Randevu'
FROM Randevular
GROUP BY Durum

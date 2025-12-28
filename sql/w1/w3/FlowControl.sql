/*
Akış Kontrolü
*/

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Değişken: DECLARE, SET
-- - Koşullar: IF / ELSE IF / ELSE
-- - Koşullu çıktı: CASE
-- - Temp table: CREATE TABLE #..., INSERT, SELECT, DROP
-- - Operatör/fonksiyon: %, CONCAT

-- Bu dosya; T-SQL'de IF/ELSE ve CASE kullanımını hem değişkenlerle
-- hem de temp table (#) üzerinden örnekler.

/***********************
 * Değişken İle Kullanım
 ***********************/
-- Pozitif / Negatif kontrolü
-- DECLARE: Değişken tanımlar ve başlangıç değeri atar.
-- IF/ELSE: Koşula göre tek satır veya blok çalıştırır.
DECLARE @n INT = -5;
IF @n > 0 PRINT 'Pozitif'; ELSE IF @n < 0 PRINT 'Negatif'; ELSE PRINT 'Sıfır';

-- Çift / Tek kontrolü
-- %: Mod alma (kalan). Çift sayı -> @a % 2 = 0.
DECLARE @a INT = 17;
IF @a % 2 = 0 PRINT 'Çift'; ELSE PRINT 'Tek';

-- Not harfi hesaplama
-- CASE: Koşullu ifade; SELECT içinde kolon üretmek için kullanılır.
DECLARE @Not INT = 82;
SELECT CASE WHEN @Not >= 90 THEN 'AA'
            WHEN @Not >= 80 THEN 'BA'
            WHEN @Not >= 70 THEN 'BB'
            WHEN @Not >= 60 THEN 'CB'
            ELSE 'FF' END AS NotHarfi;

-- Vergi hesaplama
-- SET: Değişkene değer atar.
-- PRINT: Mesaj basar (SSMS Messages pane'inde görülür).
DECLARE @Gelir DECIMAL(10,2) = 35000, @Vergi DECIMAL(10,2);
IF @Gelir < 20000 SET @Vergi = @Gelir * 0.10;
ELSE IF @Gelir < 50000 SET @Vergi = @Gelir * 0.20;
ELSE SET @Vergi = @Gelir * 0.30;
PRINT CONCAT('Vergi: ', @Vergi);

-- Faktöriyel sınırı kontrolü
DECLARE @f INT = 12;
IF @f < 0 PRINT 'Negatif'; 
ELSE IF @f > 20 PRINT 'Taşabilir'; 
ELSE PRINT 'Hesaplanabilir';

/***********************
 *Temp Table İle Kullanım
 ***********************/
-- Temp table pozitif/negatif
-- # ile başlayan tablolar TEMP TABLE'dır: sadece bu oturumda geçerlidir.
CREATE TABLE #Numbers (n INT);
INSERT INTO #Numbers VALUES (-5),(10),(0),(22),(-9);
SELECT n,
       CASE WHEN n > 0 THEN 'Pozitif'
            WHEN n < 0 THEN 'Negatif'
            ELSE 'Sıfır' END AS Durum
FROM #Numbers;
DROP TABLE #Numbers;

-- Ürün fiyat vergisi
CREATE TABLE #Products (Product VARCHAR(50), Price DECIMAL(10,2));
INSERT INTO #Products VALUES ('Kalem',12),('Tablet',3500),('Masa',500),('Kitap',50);
SELECT Product, Price,
       CASE WHEN Price < 50 THEN 'Düşük'
            WHEN Price < 500 THEN 'Orta'
            ELSE 'Yüksek' END AS VergiKategori
FROM #Products;
DROP TABLE #Products;

-- Stok kontrolü
CREATE TABLE #Stock (Item VARCHAR(20), Quantity INT);
INSERT INTO #Stock VALUES ('Kalem',10),('Defter',0),('Silgi',5);
SELECT Item, Quantity,
       CASE WHEN Quantity = 0 THEN 'Stok Yok'
            WHEN Quantity < 5 THEN 'Az'
            ELSE 'Var' END AS Durum
FROM #Stock;
DROP TABLE #Stock;

-- Not geçme/kalma
CREATE TABLE #Grades (Student VARCHAR(20), Score INT);
INSERT INTO #Grades VALUES ('Ali',85),('Ayşe',40),('Mehmet',72);
SELECT Student, Score,
       CASE WHEN Score >= 50 THEN 'Geçti' ELSE 'Kaldı' END AS Durum
FROM #Grades;
DROP TABLE #Grades;

-- İndirim uygulama
CREATE TABLE #Orders (Customer VARCHAR(20), Total DECIMAL(10,2));
INSERT INTO #Orders VALUES ('Ali',120),('Ayşe',600),('Mehmet',50);
SELECT Customer, Total,
       CASE WHEN Total > 500 THEN Total * 0.90
            WHEN Total > 100 THEN Total * 0.95
            ELSE Total END AS IndirimliTutar
FROM #Orders;
DROP TABLE #Orders;
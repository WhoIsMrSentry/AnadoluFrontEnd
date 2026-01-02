/*
Akış Kontrolü
*/
/*
Akış Kontrolü - Açıklamalı örnekler

Bu dosya; IF, CASE ve geçici tablolar (#table) ile akış kontrolü örnekleri
içerir. Her blok kısa bir açıklama ve değişkenlerin anlamı ile birlikte
verilmiştir. Amacımız, kodu hiç bilmeyen birinin bile anlayabilmesini sağlamak.
*/

/***********************
 * Basit IF örnekleri
 ***********************/
-- 1) Pozitif / Negatif kontrolü
-- @number: kontrol edilecek tamsayı
DECLARE @number INT = -5;
IF @number > 0
    PRINT 'Pozitif';
ELSE IF @number < 0
    PRINT 'Negatif';
ELSE
    PRINT 'Sıfır';

-- 2) Çift / Tek kontrolü
-- @value: örnek sayı, % operatörü ile mod (kalan) kontrolü yapılır
DECLARE @value INT = 17;
IF @value % 2 = 0
    PRINT 'Çift';
ELSE
    PRINT 'Tek';

-- 3) Not harfi hesaplama (CASE ile çoklu koşul)
-- @score: öğrenci notu, CASE ile aralıklara bakılarak harf döndürülür
DECLARE @score INT = 82;
SELECT CASE WHEN @score >= 90 THEN 'AA'
            WHEN @score >= 80 THEN 'BA'
            WHEN @score >= 70 THEN 'BB'
            WHEN @score >= 60 THEN 'CB'
            ELSE 'FF' END AS NotHarfi;

-- 4) Vergi hesaplama (farklı gelir dilimleri için farklı oranlar)
-- @income: yıllık gelir, @tax: hesaplanacak vergi
DECLARE @income DECIMAL(10,2) = 35000;
DECLARE @tax DECIMAL(10,2);
IF @income < 20000
    SET @tax = @income * 0.10; -- düşük gelir dilimi
ELSE IF @income < 50000
    SET @tax = @income * 0.20; -- orta gelir dilimi
ELSE
    SET @tax = @income * 0.30; -- yüksek gelir dilimi
PRINT CONCAT('Vergi: ', @tax);

-- 5) Faktöriyel sınırı kontrolü
-- @factorialInput: faktöriyel hesaplanacak sayı; negatif ve çok büyük
-- değerler için ön kontrol yapılır.
DECLARE @factorialInput INT = 12;
IF @factorialInput < 0
    PRINT 'Negatif'; -- negatif sayının faktöriyeli tanımsız
ELSE IF @factorialInput > 20
    PRINT 'Taşabilir'; -- çok büyük değer taşma yapabilir
ELSE
    PRINT 'Hesaplanabilir';


/***********************
 * Geçici (temp) tablolar ile CASE örnekleri
 * Her blok: CREATE #Table -> INSERT örnek veriler -> SELECT ile CASE kullanımı -> DROP
 ***********************/
-- Temp table: pozitif/negatif örneği
CREATE TABLE #Numbers (n INT);
INSERT INTO #Numbers VALUES (-5),(10),(0),(22),(-9);
SELECT n,
       CASE WHEN n > 0 THEN 'Pozitif'
            WHEN n < 0 THEN 'Negatif'
            ELSE 'Sıfır' END AS Durum
FROM #Numbers;
DROP TABLE #Numbers;

-- Temp table: ürün fiyat vergisi kategorisi
CREATE TABLE #Products (Product VARCHAR(50), Price DECIMAL(10,2));
INSERT INTO #Products VALUES ('Kalem',12),('Tablet',3500),('Masa',500),('Kitap',50);
SELECT Product, Price,
       CASE WHEN Price < 50 THEN 'Düşük'
            WHEN Price < 500 THEN 'Orta'
            ELSE 'Yüksek' END AS VergiKategori
FROM #Products;
DROP TABLE #Products;

-- Temp table: stok durumu kontrolü
CREATE TABLE #Stock (Item VARCHAR(20), Quantity INT);
INSERT INTO #Stock VALUES ('Kalem',10),('Defter',0),('Silgi',5);
SELECT Item, Quantity,
       CASE WHEN Quantity = 0 THEN 'Stok Yok'
            WHEN Quantity < 5 THEN 'Az'
            ELSE 'Var' END AS Durum
FROM #Stock;
DROP TABLE #Stock;

-- Temp table: not geçme/kalma örneği
CREATE TABLE #Grades (Student VARCHAR(20), Score INT);
INSERT INTO #Grades VALUES ('Ali',85),('Ayşe',40),('Mehmet',72);
SELECT Student, Score,
       CASE WHEN Score >= 50 THEN 'Geçti' ELSE 'Kaldı' END AS Durum
FROM #Grades;
DROP TABLE #Grades;

-- Temp table: siparişlerde indirim uygulama örneği
CREATE TABLE #Orders (Customer VARCHAR(20), Total DECIMAL(10,2));
INSERT INTO #Orders VALUES ('Ali',120),('Ayşe',600),('Mehmet',50);
SELECT Customer, Total,
       CASE WHEN Total > 500 THEN Total * 0.90
            WHEN Total > 100 THEN Total * 0.95
            ELSE Total END AS IndirimliTutar
FROM #Orders;
DROP TABLE #Orders;
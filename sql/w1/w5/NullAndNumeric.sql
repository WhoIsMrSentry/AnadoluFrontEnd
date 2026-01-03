
/* ===============================================
   NULL ve Sayısal Fonksiyonlar   
=============================================== */

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - NULL mantığı: IS NULL, IS NOT NULL, ISNULL()
-- - Tip dönüşümü: CAST
-- - Agregat ve yuvarlama: AVG, ROUND
-- - Sayısal fonksiyonlar: ABS, FLOOR, CEILING
-- - Tarih: GETDATE(), YEAR()
-- - Aralık/koşul: BETWEEN, NOT BETWEEN, CASE

IF OBJECT_ID('dbo.Enrollments','U') IS NOT NULL DROP TABLE dbo.Enrollments;
IF OBJECT_ID('dbo.Students','U')    IS NOT NULL DROP TABLE dbo.Students;
IF OBJECT_ID('dbo.Courses','U')     IS NOT NULL DROP TABLE dbo.Courses;
GO

CREATE TABLE dbo.Students (
    StudentID  INT         NOT NULL PRIMARY KEY,
    FirstName  NVARCHAR(30) NOT NULL,
    LastName   NVARCHAR(30) NOT NULL,
    City       NVARCHAR(50) NULL,
    BirthYear  INT          NULL,
    Grade      INT          NULL  -- genel başarı notu (0-100)
);
GO

CREATE TABLE dbo.Courses (
    CourseID    INT           NOT NULL PRIMARY KEY,
    CourseName  NVARCHAR(100) NOT NULL,
    Category    NVARCHAR(50)  NOT NULL,
    Credit      INT           NOT NULL
);
GO

CREATE TABLE dbo.Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID    INT NOT NULL,
    CourseID     INT NOT NULL,
    Score        INT NOT NULL,
    Semester     NVARCHAR(10) NOT NULL,
    CONSTRAINT FK_Enrollments_Students FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID),
    CONSTRAINT FK_Enrollments_Courses  FOREIGN KEY (CourseID)  REFERENCES dbo.Courses(CourseID)
);
GO

/* ---------- Örnek Veri Ekleme ---------- */

INSERT INTO dbo.Students (StudentID, FirstName, LastName, City, BirthYear, Grade) VALUES
(1,'Ali','Yılmaz','İstanbul',2002,85),
(2,'Veli','Kaya','Ankara',2001,70),
(3,'Ayşe','Demir','İzmir',2003,92),
(4,'Zeynep','Şahin','Bursa',2002,60),
(5,'Mehmet','Koç','İstanbul',2000,78),
(6,'Elif','Çelik','Ankara',2001,88),
(7,'Can','Arslan','Antalya',2004,55),
(8,'Deniz','Kurt','İzmir',2003,66),
(9,'Hasan','Doğan','Adana',2002,73),
(10,'Ece','Yıldız','Bursa',2001,81);
GO

INSERT INTO dbo.Courses (CourseID, CourseName, Category, Credit) VALUES
(1,'Veritabanı','Sayısal',4),
(2,'Programlama 1','Sayısal',5),
(3,'İstatistik','Sayısal',3),
(4,'Web Tasarım','Teknik',3),
(5,'İşletme','Sözel',2),
(6,'Yapay Zeka Giriş','Sayısal',3);
GO

INSERT INTO dbo.Enrollments (StudentID, CourseID, Score, Semester) VALUES
(1,1,90,'2023G'),
(1,2,85,'2023G'),
(1,3,70,'2023B'),
(2,1,60,'2023G'),
(2,4,75,'2023B'),
(3,1,95,'2023G'),
(3,2,88,'2023G'),
(3,6,80,'2023B'),
(4,2,68,'2023G'),
(4,5,72,'2023B'),
(5,1,77,'2023G'),
(5,3,69,'2023B'),
(6,2,91,'2023G'),
(6,4,83,'2023B'),
(7,3,58,'2023G'),
(7,5,62,'2023B'),
(8,1,74,'2023G'),
(8,6,79,'2023B'),
(9,4,71,'2023G'),
(10,2,89,'2023G');
GO

-- ==================================================
-- (1) NULL örnek verisi hazırlığı
-- - City alanı NULL olabilen (nullable) bir alan.
-- - Bazı satırlarda City'i NULL yaparak "şehir bilinmiyor" senaryosu üretiriz.
-- - Önemli: NULL karşılaştırması = ile yapılmaz.
-- ==================================================

-- Bazı öğrenci şehirlerini NULL yap (örnek veri hazırlığı)
-- NULL: "bilinmiyor/boş" anlamında özel bir değerdir.
-- Not: NULL karşılaştırması = ile yapılmaz; IS NULL / IS NOT NULL kullanılır.
UPDATE dbo.Students 
SET City = NULL 
WHERE StudentID IN (3,7);
SELECT * FROM dbo.Students;
GO

-- ==================================================
-- (2) NULL filtreleme
-- - IS NULL: değeri NULL olanları bulur.
-- - "City = NULL" yazarsan hiç eşleşmez.
-- ==================================================
-- IS NULL ile şehir bilgisi olmayan öğrenciler
SELECT StudentID, FirstName, LastName
FROM dbo.Students
WHERE City IS NULL;
GO

-- ==================================================
-- (3) NULL olmayanları filtreleme
-- - IS NOT NULL: değeri dolu olanları bulur.
-- ==================================================
-- IS NOT NULL ile şehir bilgisi olan öğrenciler
SELECT StudentID, FirstName, LastName, City
FROM dbo.Students
WHERE City IS NOT NULL;
GO

-- ==================================================
-- (4) NULL'ı ekranda "yerine koyma" (display)
-- - ISNULL(City, 'Bilinmiyor') sadece gösterimde kullanılır.
-- - Veriyi değiştirmez; sadece SELECT sonucunu değiştirir.
-- ==================================================
-- ISNULL ile boş şehirleri 'Bilinmiyor' olarak göster
-- ISNULL(expr, replacement): expr NULL ise replacement döndürür.
SELECT FirstName, LastName, ISNULL(City,'Bilinmiyor') AS Sehir
FROM dbo.Students;
GO

-- ==================================================
-- (5) Sayısal ortalama + CAST + ROUND
-- - AVG: ortalama alır.
-- - CAST: sayıyı DECIMAL'e çevirip daha kontrollü yuvarlamayı sağlar.
-- - LEFT JOIN: enrollments olmayan öğrenci de listelensin.
-- ==================================================
-- Not ortalamasını ROUND ile yuvarla
-- AVG(): Ortalama.
-- CAST: Tip dönüşümü; burada skorları DECIMAL'e çevirip daha kontrollü yuvarlama yapılır.
-- ROUND(x,0): 0 basamağa yuvarlar.
SELECT s.StudentID, s.FirstName,
       ROUND(AVG(CAST(e.Score AS DECIMAL(5,2))),0) AS YuvarlanmisOrtalama
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName;
GO

-- ==================================================
-- (6) ABS: mutlak değer
-- - Negatif sayıyı pozitife çevirir.
-- ==================================================
-- ABS fonksiyonu: Örnek negatif/pozitif fark göstermelik
SELECT ABS(-10) AS MutlakDeger;
GO

-- ==================================================
-- (7) FLOOR / CEILING: aşağı / yukarı yuvarlama
-- ==================================================
-- FLOOR ve CEILING ile fiyat benzeri sayıları aşağı ve yukarı yuvarlama
-- FLOOR: aşağı yuvarlar, CEILING: yukarı yuvarlar.
SELECT 12.7 AS Sayi, FLOOR(12.7) AS Asagi, CEILING(12.7) AS Yukari;
GO

-- ==================================================
-- (8) Ondalık bölme + ROUND
-- - Grade/10.0: 10.0 yazınca sonuç ondalıklı olur (integer bölme olmaz).
-- ==================================================
-- Öğrencilerin notlarını 10'luk sisteme göre yuvarlama
SELECT FirstName, LastName, Grade,
       ROUND(Grade/10.0, 0) AS OnlukSistem
FROM dbo.Students;
GO

-- ==================================================
-- (9) NOT BETWEEN
-- - 60 ile 80 arasında OLMAYAN notlar.
-- - BETWEEN iki uç değeri de dahil eder.
-- ==================================================
-- NOT BETWEEN ile 60-80 arası olmayan öğrenciler
SELECT FirstName, LastName, Grade
FROM dbo.Students
WHERE Grade NOT BETWEEN 60 AND 80;
GO


-- Öğrencilerin yaşlarını hesapla (basit varsayım: yıl bazlı)
-- GETDATE(): SQL Server'ın yerel (server) tarih-saatini döndürür.
SELECT FirstName, LastName, (YEAR(GETDATE()) - BirthYear) AS Yas
FROM dbo.Students;
GO

-- ==================================================
-- (10) GROUP BY + AVG + ROUND
-- - Kategorilere göre (Courses.Category) ortalama sınav skorları.
-- ==================================================
-- Her kategorideki derslerin ortalama skorunu bul ve yuvarla
SELECT c.Category, ROUND(AVG(e.Score), 1) AS Ortalama
FROM dbo.Enrollments e
JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.Category;
GO

-- Şehirleri NULL olan öğrencilerin not ortalamasını göster
SELECT AVG(CAST(Grade AS DECIMAL(5,2))) AS OrtalamaNot
FROM dbo.Students
WHERE City IS NULL;
GO

-- Şehri olan öğrencilerin not ortalamasını göster
SELECT AVG(CAST(Grade AS DECIMAL(5,2))) AS OrtalamaNot
FROM dbo.Students
WHERE City IS NOT NULL;
GO

-- Öğrencilerin notunu 0-100 aralığına 'kısaltma' 
SELECT FirstName, LastName,
       CASE 
         WHEN Grade < 0 THEN 0
         WHEN Grade > 100 THEN 100
         ELSE Grade
       END AS DuzenlenmisNot
FROM dbo.Students;
GO


-- ==================================================
-- (11) ROUND örneği
-- ==================================================
-- ROUND ile 2 basamağa yuvarlama örneği
SELECT ROUND(123.4567, 2) AS Yuvarlanmis;
GO

-- ==================================================
-- (12) Ortalama + FLOOR/CEILING
-- - AVG(Grade) ondalıklı çıkabilir; aşağı/yukarı yuvarlama örneği.
-- ==================================================
-- FLOOR/CEILING ile ortalama hesaplama
SELECT AVG(Grade), FLOOR(AVG(Grade)) AS AsagiYuvarlanmis,
       CEILING(AVG(Grade)) AS YukariYuvarlanmis
FROM dbo.Students;
GO


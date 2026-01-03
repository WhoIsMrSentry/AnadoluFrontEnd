
/* ===============================================
  String Fonksiyonları
=============================================== */

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Büyük/küçük harf: UPPER(), LOWER()
-- - Birleştirme: + ile concat
-- - Parça alma: LEFT(), RIGHT(), SUBSTRING()
-- - Uzunluk: LEN()
-- - Değiştirme: REPLACE()
-- - Arama: LIKE / NOT LIKE
-- - Sıralama: ORDER BY

/*--------Eğer Tablolar Daha Önce Oluşturulduysa DROP Et--------*/
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
-- (1) Sıralama (ORDER BY)
-- - ORDER BY ... DESC: Z'den A'ya / büyükten küçüğe sıralar.
-- - İki alanla sıralama yapılabilir: önce LastName, eşitse FirstName.
-- ==================================================
-- Öğrencilerin isimlerini ters sırada yaz
SELECT FirstName, LastName
FROM dbo.Students
ORDER BY LastName DESC, FirstName DESC;
GO

-- ==================================================
-- (2) Büyük/küçük harf dönüşümü: UPPER / LOWER
-- - UPPER(text): metni büyük harfe çevirir.
-- - LOWER(text): metni küçük harfe çevirir.
-- ==================================================
-- Öğrencilerin adlarını büyük harfe çevir
-- UPPER/LOWER: Metni büyük/küçük harfe çevirir.
SELECT UPPER(FirstName) AS BuyukAd, LastName
FROM dbo.Students;
GO

-- Ders adlarını küçük harfe çevir
SELECT LOWER(CourseName) AS KucukDers
FROM dbo.Courses;
GO

-- ==================================================
-- (3) Metin birleştirme (concat)
-- - SQL Server'da NVARCHAR alanlar + ile birleştirilebilir.
-- - Araya boşluk koymak için ' ' ekleriz.
-- ==================================================
-- Ad ve soyadı birleştir 
-- Metin birleştirme: NVARCHAR + NVARCHAR.
SELECT FirstName + ' ' + LastName AS AdSoyad
FROM dbo.Students;
GO

-- ==================================================
-- (4) Soldan / sağdan parça alma: LEFT / RIGHT
-- ==================================================
-- Ders adlarının ilk 3 harfini al
-- LEFT(text, n): soldan n karakter alır.
SELECT CourseName, LEFT(CourseName,3) AS IlkUcHarf
FROM dbo.Courses;
GO

-- Öğrenci adlarının son 2 harfini al
SELECT FirstName, RIGHT(FirstName,2) AS SonIkiHarf
FROM dbo.Students;
GO

-- ==================================================
-- (5) Uzunluk: LEN
-- ==================================================
-- Öğrenci adlarının uzunluğunu göster
-- LEN(text): karakter sayısı.
SELECT FirstName, LEN(FirstName) AS Uzunluk
FROM dbo.Students;
GO

-- ==================================================
-- (6) Değiştirme: REPLACE
-- - REPLACE(text, eski, yeni)
-- ==================================================
-- Ders adındaki boşlukları '-' ile değiştir
SELECT CourseName, REPLACE(CourseName,' ','-') AS Degismis
FROM dbo.Courses;
GO

-- ==================================================
-- (7) Arama: LIKE / NOT LIKE
-- - % : 0 veya daha fazla karakter
-- - A% : A ile başlar
-- - %li : li ile biter
-- ==================================================
-- 'Programlama' kelimesi geçen dersleri bul
-- LIKE '%...%': içinde geçenleri bulur. % -> joker (0+ karakter).
SELECT CourseName
FROM dbo.Courses
WHERE CourseName LIKE '%Programlama%';
GO

-- NOT LIKE ile 'a' harfi içermeyen dersleri bul
SELECT CourseName
FROM dbo.Courses
WHERE CourseName NOT LIKE '%a%';
GO

-- Öğrenci soyadlarında 'y' harfi geçenleri bul 
SELECT FirstName, LastName
FROM dbo.Students
WHERE LastName LIKE '%y%';
GO

-- Adı 'A' ile başlayan öğrencileri getir
SELECT FirstName, LastName
FROM dbo.Students
WHERE FirstName LIKE 'A%';
GO

-- Adı 'li' ile biten öğrenciler
SELECT FirstName, LastName
FROM dbo.Students
WHERE FirstName LIKE '%li';
GO

-- Ders adında 'a' veya 'e' harfi geçenleri listele
SELECT CourseName
FROM dbo.Courses
WHERE CourseName LIKE '%a%' OR CourseName LIKE '%e%';
GO

-- ==================================================
-- (8) SUBSTRING: ortadan parça alma
-- - SUBSTRING(text, start, length)
-- - start 1'den başlar.
-- ==================================================
-- Öğrencilerin isimlerinden 2. ve 3. karakterleri al
-- SUBSTRING(text, start, length): 1'den başlayan index ile parça alır.
SELECT FirstName, SUBSTRING(FirstName,2,2) AS IkinciUcuncu
FROM dbo.Students;
GO

-- ==================================================
-- (9) Bir metni biçimlendirme (karma kullanım)
-- - City NULL olursa sonuç NULL olur (NULL + '...' = NULL).
-- - İstenirse WHERE City IS NOT NULL eklenebilir veya ISNULL(City,'') kullanılabilir.
-- ==================================================
-- Şehir adlarını ilk iki harfi büyük geri kalanı küçük yap 
SELECT City,
       UPPER(LEFT(City,2)) + LOWER(SUBSTRING(City,3,LEN(City)-2)) AS DuzenlenmisSehir
FROM dbo.Students;
GO

-- ==================================================
-- (10) Alt sorgu örneği (string + aggregate)
-- - LEN(LastName) en büyük olanı bulup ona eşit olanları listeler.
-- ==================================================
-- Soyadı en uzun olan öğrencileri bul 
SELECT FirstName, LastName
FROM dbo.Students
WHERE LEN(LastName) = (
    SELECT MAX(LEN(LastName)) FROM dbo.Students
);
GO



-- 'Veritabanı' ders adını 'Veritabanı 1' yap
SELECT REPLACE(CourseName,'Veritabanı','Veritabanı 1') AS YeniAd
FROM dbo.Courses
WHERE CourseName LIKE 'Veritabanı%';
GO

-- ==================================================
-- (11) Birleştir + uzunluğa göre sırala
-- - LEN(FirstName + LastName): aradaki boşluğu saymak istemediğimiz için boşluksuz ölçüm.
-- - ORDER BY Uzunluk DESC: uzun isimler üstte.
-- ==================================================
-- Ad-soyadı birleştirip uzunluğuna göre sırala
SELECT FirstName + ' ' + LastName AS AdSoyad, LEN(FirstName + LastName) AS Uzunluk
FROM dbo.Students
ORDER BY Uzunluk DESC;
GO



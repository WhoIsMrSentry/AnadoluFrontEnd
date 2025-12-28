
/* ===============================================
   GROUP BY ve HAVING
=============================================== */

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Gruplama: GROUP BY
-- - Agregat fonksiyonlar: COUNT, AVG, MAX
-- - Grupları filtreleme: HAVING
-- - Join çeşitleri: INNER JOIN, LEFT JOIN
-- - Tekrarsız sayma: COUNT(DISTINCT ...)

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


-- Her ders için kaç kayıt olduğunu bul 
SELECT c.CourseName, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments e
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;
GO


-- Her şehirde kaç öğrenci olduğunu bul
SELECT City, COUNT(*) AS OgrenciSayisi
FROM dbo.Students
GROUP BY City;
GO

-- Her derste ortalama notu bul
-- GROUP BY kuralı: SELECT'te agregat olmayan kolonlar GROUP BY'da olmalı.
SELECT c.CourseName, AVG(e.Score) AS OrtalamaNot
FROM dbo.Enrollments e
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;
GO

-- HAVING ile ortalama notu 80 üzeri olan dersleri listele
-- HAVING: Gruplama sonrası filtrelemedir (WHERE ise gruplama öncesi satır filtreler).
SELECT c.CourseName, AVG(e.Score) AS OrtalamaNot
FROM dbo.Enrollments e
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName
HAVING AVG(e.Score) > 80;
GO

-- Öğrenci bazında aldığı ders sayısı
-- LEFT JOIN: Kayıt (Enrollments) olmasa bile öğrenciyi listeler; COUNT NULL'ları saymaz.
SELECT s.StudentID, s.FirstName, COUNT(e.EnrollmentID) AS DersSayisi
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName;
GO

-- HAVING ile 2'den fazla ders alan öğrencileri bul
SELECT s.StudentID, s.FirstName, COUNT(e.EnrollmentID) AS DersSayisi
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName
HAVING COUNT(e.EnrollmentID) >= 2;
GO

-- Şehirlere göre ortalama not
SELECT City, AVG(Grade) AS Ortalama
FROM dbo.Students
GROUP BY City;
GO

-- HAVING ile ortalama notu 75 üzeri olan şehirleri getir
SELECT City, AVG(Grade) AS Ortalama
FROM dbo.Students
GROUP BY City
HAVING AVG(Grade) > 75;
GO

-- Dönemlere göre sınav sayısı
SELECT Semester, COUNT(*) AS SinavSayisi
FROM dbo.Enrollments
GROUP BY Semester;
GO

-- HAVING ile 10 veya daha fazla kayıt olan dönemler
SELECT Semester, COUNT(*) AS SinavSayisi
FROM dbo.Enrollments
GROUP BY Semester
HAVING COUNT(*) >= 10;
GO


-- Ders kategorisine göre ortalama puan
SELECT c.Category, AVG(e.Score) AS Ortalama
FROM dbo.Enrollments e
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.Category;
GO

-- HAVING ile ortalama puanı 75 üzeri olan kategoriler
SELECT c.Category, AVG(e.Score) AS Ortalama
FROM dbo.Enrollments e
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.Category
HAVING AVG(e.Score) > 75;
GO


-- Öğrencilerin en yüksek notu
SELECT s.StudentID, s.FirstName, MAX(e.Score) AS EnYuksekNot
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName;
GO

-- HAVING ile en yüksek notu 90 ve üzeri olan öğrenciler
SELECT s.StudentID, s.FirstName, MAX(e.Score) AS EnYuksekNot
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName
HAVING MAX(e.Score) >= 90;
GO

-- Ders başına öğrenci sayısı
-- COUNT(DISTINCT ...): Tekrarsız öğrenci sayısını verir.
SELECT c.CourseName, COUNT(DISTINCT e.StudentID) AS OgrenciSayisi
FROM dbo.Courses c
LEFT JOIN dbo.Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName;
GO

-- HAVING ile en az 3 farklı öğrenciye sahip dersler
SELECT c.CourseName, COUNT(DISTINCT e.StudentID) AS OgrenciSayisi
FROM dbo.Courses c
LEFT JOIN dbo.Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING COUNT(DISTINCT e.StudentID) >= 3;
GO

-- Şehir ve dönem bazında kayıt sayıları
SELECT s.City, e.Semester, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON e.StudentID = s.StudentID
GROUP BY s.City, e.Semester;
GO

-- HAVING ile 2'den fazla kayıt olan şehir-dönem kombinasyonları
SELECT s.City, e.Semester, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON e.StudentID = s.StudentID
GROUP BY s.City, e.Semester
HAVING COUNT(*) > 2;
GO

-- Öğrencilerin tüm notlarının ortalaması
SELECT s.StudentID, s.FirstName, AVG(e.Score) AS OrtalamaNot
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName;
GO

-- HAVING ile ortalama notu 70-85 arasında olan öğrenciler
SELECT s.StudentID, s.FirstName, AVG(e.Score) AS OrtalamaNot
FROM dbo.Students s
LEFT JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
GROUP BY s.StudentID, s.FirstName
HAVING AVG(e.Score) BETWEEN 70 AND 85;
GO


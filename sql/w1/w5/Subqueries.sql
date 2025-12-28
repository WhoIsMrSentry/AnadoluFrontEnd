
/* ===============================================
   Temel Alt Sorgular
=============================================== */

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Alt sorgu ile filtre: IN (subquery)
-- - Varlık kontrolü: EXISTS / NOT EXISTS
-- - Tek değer döndüren alt sorgu: scalar subquery (SUM/MAX/AVG)
-- - Dış sorguya bağlı alt sorgu: correlated subquery
-- - JOIN + alt sorgu kombinasyonları, TOP + GROUP BY + ORDER BY


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


-- Veritabanı dersini alan öğrencileri alt sorgu ile bul
-- IN (subquery): Alt sorgudan dönen listedeki değerlere göre filtreler.
SELECT *
FROM dbo.Students
WHERE StudentID IN (
    SELECT StudentID FROM dbo.Enrollments WHERE CourseID = 1
);
GO

-- Herhangi bir derse kayıtlı öğrencileri EXISTS ile çek
-- EXISTS: Alt sorgu en az bir satır döndürüyorsa TRUE olur.
SELECT s.*
FROM dbo.Students s
WHERE EXISTS (
    SELECT 1 FROM dbo.Enrollments e WHERE e.StudentID = s.StudentID
);
GO

-- Hiç derse kayıtlı olmayan öğrencileri NOT EXISTS ile çek
SELECT s.*
FROM dbo.Students s
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Enrollments e WHERE e.StudentID = s.StudentID
);
GO

-- Ortalama notu tüm öğrencilerin ortalamasından yüksek olan öğrenciler
SELECT s.*
FROM dbo.Students s
WHERE s.Grade > (
    SELECT AVG(Grade) FROM dbo.Students
);
GO

-- En az bir derste 90 ve üzeri alan öğrenciler
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
WHERE s.StudentID IN (
    SELECT e.StudentID FROM dbo.Enrollments e WHERE e.Score >= 90
);
GO

-- En çok kaydı olan derste okuyan öğrencileri bul (basit subquery)
SELECT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
INNER JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID = (
    SELECT TOP 1 CourseID 
    FROM dbo.Enrollments
    GROUP BY CourseID
    ORDER BY COUNT(*) DESC
);
GO

-- Notu, kendi şehir ortalamasının üstünde olan öğrenciler
-- Correlated subquery: İç sorgu dış sorgudaki s.City değerine göre çalışır.
SELECT s.StudentID, s.FirstName, s.City, s.Grade
FROM dbo.Students s
WHERE s.Grade > (
    SELECT AVG(Grade) FROM dbo.Students s2 WHERE s2.City = s.City
);
GO

-- 'Sayısal' kategorisindeki dersleri alan öğrenciler
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
WHERE EXISTS (
    SELECT 1
    FROM dbo.Enrollments e
    JOIN dbo.Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = s.StudentID
      AND c.Category = 'Sayısal'
);
GO

-- Veritabanı dersinde en yüksek notu öğrenciler
SELECT s.FirstName, s.LastName, e.Score
FROM dbo.Students s
JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID = 1
  AND e.Score = (
      SELECT MAX(Score) FROM dbo.Enrollments WHERE CourseID = 1
  );
GO

-- Ders adı 'Programlama 1' olan derse kayıtlı öğrenciler (subquery + string)
SELECT s.FirstName, s.LastName
FROM dbo.Students s
WHERE s.StudentID IN (
    SELECT e.StudentID
    FROM dbo.Enrollments e
    WHERE e.CourseID = (
        SELECT CourseID FROM dbo.Courses WHERE CourseName = 'Programlama 1'
    )
);
GO

-- Her öğrencinin toplam notunu hesapla (subquery ile)
-- Scalar subquery: Tek bir değer döndürüp kolon olarak kullanılabilir.
SELECT s.StudentID, s.FirstName,
       (SELECT SUM(Score) FROM dbo.Enrollments e WHERE e.StudentID = s.StudentID) AS ToplamPuan
FROM dbo.Students s;
GO

-- Alt sorgu ile hiçbir kaydı olmayan dersleri bul
SELECT *
FROM dbo.Courses c
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Enrollments e WHERE e.CourseID = c.CourseID
);
GO

-- Alt sorgu ile en fazla kredili dersi alan öğrenciler
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
JOIN dbo.Enrollments e ON s.StudentID = e.StudentID
WHERE e.CourseID IN (
    SELECT CourseID FROM dbo.Courses WHERE Credit = (SELECT MAX(Credit) FROM dbo.Courses)
);
GO

-- Her dersteki ortalama notu, genel ortalamadan yüksek olan dersler
SELECT CourseName
FROM dbo.Courses c
WHERE (
    SELECT AVG(Score) FROM dbo.Enrollments e WHERE e.CourseID = c.CourseID
) > (
    SELECT AVG(Score) FROM dbo.Enrollments
);
GO

-- Bir öğrencinin aldığı ders sayısını göster (alt sorgu scalar)
SELECT s.StudentID, s.FirstName,
       (SELECT COUNT(*) FROM dbo.Enrollments e WHERE e.StudentID = s.StudentID) AS AldigiDersSayisi
FROM dbo.Students s;
GO

-- '2023G' döneminde ders alan öğrenciler
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
WHERE s.StudentID IN (
    SELECT e.StudentID FROM dbo.Enrollments e WHERE e.Semester = '2023G'
);
GO

-- En az bir derste dönemi '2023B' olan öğrenciler
SELECT DISTINCT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
WHERE EXISTS (
    SELECT 1 FROM dbo.Enrollments e WHERE e.StudentID = s.StudentID AND e.Semester = '2023B'
);
GO

-- Alt sorgu ile aldığı toplam kredi 10'dan fazla olan öğrenciler
SELECT s.StudentID, s.FirstName, s.LastName
FROM dbo.Students s
WHERE (
    SELECT SUM(c.Credit)
    FROM dbo.Enrollments e
    JOIN dbo.Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = s.StudentID
) > 10;
GO

-- Ders kaydı hiç olmayan şehirleri bul
SELECT DISTINCT City
FROM dbo.Students s
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.Enrollments e
    WHERE e.StudentID = s.StudentID
);
GO


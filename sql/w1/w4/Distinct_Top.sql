
/* ===============================================
    DISTINCT ve TOP 
=============================================== */

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Tekrar çalıştırılabilir script: OBJECT_ID ile kontrol + DROP TABLE
-- - Örnek şema kurma: CREATE TABLE, FOREIGN KEY, IDENTITY
-- - Örnek veri: INSERT
-- - Tekilleştirme: DISTINCT
-- - İlk N kayıt: TOP + ORDER BY
-- - JOIN: INNER JOIN
-- - Gruplama/sayma: GROUP BY, COUNT, COUNT(DISTINCT)


/*--------Eğer Tablolar Daha Önce Oluşturulduysa DROP Et--------*/
-- OBJECT_ID('<schema>.<name>','U'):
-- - 'U' user table demektir.
-- - Tablo varsa DROP TABLE ile sileriz ki script tekrar çalışabilsin.
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




-- Tüm öğrencileri listele 
SELECT * FROM dbo.Students;
GO

-- DISTINCT ile farklı şehirleri listele
-- DISTINCT: Aynı değerden tek kez döndürür (tekrarlı City değerlerini tekilleştirir).
SELECT DISTINCT City FROM dbo.Students;
GO

-- DISTINCT ile farklı ders kategorilerini listele
SELECT DISTINCT Category FROM dbo.Courses;
GO

-- DISTINCT ile 'Sayısal' kategorisindeki derslerin isimleri
SELECT DISTINCT CourseName
FROM dbo.Courses
WHERE Category = 'Sayısal';
GO

-- DISTINCT ile öğrencilerin okudukları dönemleri listele
SELECT DISTINCT Semester
FROM dbo.Enrollments;
GO

-- TOP ile ilk öğrenciyi bul ve adını göster
-- TOP n: Sonuç setinden ilk n satırı döndürür.
-- ORDER BY olmadan TOP "ilk" kavramı deterministik değildir; burada ORDER BY ile netleşir.
SELECT TOP 1 FirstName, LastName
FROM dbo.Students
ORDER BY StudentID ASC;
GO

-- TOP ile son öğrenciyi bul 
SELECT TOP 1 *
FROM dbo.Students
ORDER BY StudentID DESC;
GO

-- En yüksek notlu ilk 5 öğrenciyi getir (TOP + ORDER BY)
SELECT TOP 5 * 
FROM dbo.Students
ORDER BY Grade DESC;
GO

-- Veritabanı dersinde en yüksek puanı alan ilk 3 öğrenciyi getir
SELECT TOP 3 s.FirstName, s.LastName, e.Score
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON s.StudentID = e.StudentID
WHERE e.CourseID = 1
ORDER BY e.Score DESC;
GO

-- TOP ile son eklenen 5 kayıt (EnrollmentID'ye göre)
SELECT TOP 5 *
FROM dbo.Enrollments
ORDER BY EnrollmentID DESC;
GO


-- İstanbul'da okuyan öğrencileri notlarına göre azalan sırala, ilk 3'ünü göster
SELECT TOP 3 *
FROM dbo.Students
WHERE City = 'İstanbul'
ORDER BY Grade DESC;
GO

-- Notu 80 üzeri olan öğrencilerin farklı şehirlerini listele
SELECT DISTINCT City
FROM dbo.Students
WHERE Grade >= 80;
GO

-- En çok seçilen (Enrollments sayısı fazla olan) derslerden ilk 2 tanesini getir
-- COUNT(*): satır sayısı. GROUP BY ile ders bazında sayılır.
SELECT TOP 2 c.CourseName, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments e
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName
ORDER BY COUNT(*) DESC;
GO

-- En düşük 3 notu göster (Enrollments bazında)
SELECT TOP 3 s.FirstName, s.LastName, e.Score
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON e.StudentID = s.StudentID
ORDER BY e.Score ASC;
GO


-- Sınav notu 70'den küçük olan öğrencilerin farklı isimlerini getir
SELECT DISTINCT s.FirstName, s.LastName
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON e.StudentID = s.StudentID
WHERE e.Score < 70;
GO

-- TOP ile '2023G' dönemindeki en yüksek notu alan kayıt
SELECT TOP 1 s.FirstName, s.LastName, c.CourseName, e.Score
FROM dbo.Enrollments e
INNER JOIN dbo.Students s ON e.StudentID = s.StudentID
INNER JOIN dbo.Courses c ON e.CourseID = c.CourseID
WHERE e.Semester = '2023G'
ORDER BY e.Score DESC;
GO




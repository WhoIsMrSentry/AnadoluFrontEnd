
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



-- ==================================================
-- Açıklama (1): Her ders için kaç kayıt (enrollment) var?
-- - GROUP BY: Ders adına göre gruplar.
-- - COUNT(*): Her grup içindeki satır sayısı.
-- - INNER JOIN: Kayıtların ders adını (Courses) çekmek için.
-- ==================================================
SELECT crs.CourseName, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Courses AS crs ON enr.CourseID = crs.CourseID
GROUP BY crs.CourseName;
GO

-- ==================================================
-- Açıklama (2): Her şehirde kaç öğrenci var?
-- - Students tablosunu City alanına göre gruplarız.
-- - COUNT(*): Her şehirdeki öğrenci sayısını verir.
-- ==================================================
SELECT City, COUNT(*) AS OgrenciSayisi
FROM dbo.Students
GROUP BY City;
GO

-- ==================================================
-- Açıklama (3): Her derste ortalama sınav puanı
-- - AVG(enr.Score): Her ders grubunun ortalaması.
-- - GROUP BY kuralı: SELECT'te agregat olmayan sütun (CourseName) GROUP BY'da olmalı.
-- ==================================================
SELECT crs.CourseName, AVG(enr.Score) AS OrtalamaNot
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Courses AS crs ON enr.CourseID = crs.CourseID
GROUP BY crs.CourseName;
GO

-- ==================================================
-- Açıklama (4): HAVING ile grup filtreleme (ortalaması 80 üstü dersler)
-- - WHERE: satırları gruplamadan önce filtreler.
-- - HAVING: gruplama yapıldıktan sonra “grupları” filtreler.
-- ==================================================
SELECT crs.CourseName, AVG(enr.Score) AS OrtalamaNot
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Courses AS crs ON enr.CourseID = crs.CourseID
GROUP BY crs.CourseName
HAVING AVG(enr.Score) > 80;
GO

-- ==================================================
-- Açıklama (5): Öğrenci bazında aldığı ders sayısı (LEFT JOIN)
-- - LEFT JOIN: Enrollments kaydı olmasa bile öğrenciyi listeler.
-- - COUNT(enr.EnrollmentID): NULL değerler sayılmadığı için, kaydı olmayan öğrencide 0 döner.
-- ==================================================
SELECT stu.StudentID, stu.FirstName, COUNT(enr.EnrollmentID) AS DersSayisi
FROM dbo.Students AS stu
LEFT JOIN dbo.Enrollments AS enr ON stu.StudentID = enr.StudentID
GROUP BY stu.StudentID, stu.FirstName;
GO

-- ==================================================
-- Açıklama (6): HAVING ile en az 2 ders alan öğrencileri bulma
-- - COUNT(enr.EnrollmentID) grup içinde ders/kayıt sayısıdır.
-- ==================================================
SELECT stu.StudentID, stu.FirstName, COUNT(enr.EnrollmentID) AS DersSayisi
FROM dbo.Students AS stu
LEFT JOIN dbo.Enrollments AS enr ON stu.StudentID = enr.StudentID
GROUP BY stu.StudentID, stu.FirstName
HAVING COUNT(enr.EnrollmentID) >= 2;
GO

-- ==================================================
-- Açıklama (7): Şehirlere göre öğrencilerin ortalama genel notu (Grade)
-- ==================================================
SELECT City, AVG(Grade) AS Ortalama
FROM dbo.Students
GROUP BY City;
GO

-- ==================================================
-- Açıklama (8): HAVING ile ortalama notu 75 üstü şehirler
-- ==================================================
SELECT City, AVG(Grade) AS Ortalama
FROM dbo.Students
GROUP BY City
HAVING AVG(Grade) > 75;
GO

-- ==================================================
-- Açıklama (9): Dönemlere göre kaç sınav kaydı var?
-- - Enrollments içinde her satır bir “ders kaydı / sınav puanı” gibi düşünülebilir.
-- ==================================================
SELECT Semester, COUNT(*) AS SinavSayisi
FROM dbo.Enrollments
GROUP BY Semester;
GO

-- ==================================================
-- Açıklama (10): HAVING ile 10 veya daha fazla kayıt olan dönemler
-- ==================================================
SELECT Semester, COUNT(*) AS SinavSayisi
FROM dbo.Enrollments
GROUP BY Semester
HAVING COUNT(*) >= 10;
GO

-- ==================================================
-- Açıklama (11): Ders kategorisine göre ortalama puan
-- - Courses.Category ile gruplarız.
-- ==================================================
SELECT crs.Category, AVG(enr.Score) AS Ortalama
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Courses AS crs ON enr.CourseID = crs.CourseID
GROUP BY crs.Category;
GO

-- ==================================================
-- Açıklama (12): HAVING ile ortalama puanı 75 üstü kategoriler
-- ==================================================
SELECT crs.Category, AVG(enr.Score) AS Ortalama
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Courses AS crs ON enr.CourseID = crs.CourseID
GROUP BY crs.Category
HAVING AVG(enr.Score) > 75;
GO

-- ==================================================
-- Açıklama (13): Öğrencilerin en yüksek sınav notu (MAX)
-- - LEFT JOIN: Öğrenciyi her durumda listeler.
-- - MAX(enr.Score): Öğrencinin aldığı en yüksek Score.
-- ==================================================
SELECT stu.StudentID, stu.FirstName, MAX(enr.Score) AS EnYuksekNot
FROM dbo.Students AS stu
LEFT JOIN dbo.Enrollments AS enr ON stu.StudentID = enr.StudentID
GROUP BY stu.StudentID, stu.FirstName;
GO

-- ==================================================
-- Açıklama (14): HAVING ile en yüksek notu 90 ve üzeri olan öğrenciler
-- - HAVING MAX(enr.Score) >= 90: Grup (öğrenci) bazında koşul.
-- ==================================================
SELECT stu.StudentID, stu.FirstName, MAX(enr.Score) AS EnYuksekNot
FROM dbo.Students AS stu
LEFT JOIN dbo.Enrollments AS enr ON stu.StudentID = enr.StudentID
GROUP BY stu.StudentID, stu.FirstName
HAVING MAX(enr.Score) >= 90;
GO

-- ==================================================
-- Açıklama (15): Ders başına farklı öğrenci sayısı (COUNT DISTINCT)
-- - COUNT(DISTINCT enr.StudentID): Aynı öğrenci bir derse birden fazla kayıt oluşturamaz gibi düşünsek de,
--   veri tekrarına karşı tekilleştirerek sayar.
-- - LEFT JOIN: Hiç seçilmeyen dersler de listede görünür (OgrenciSayisi 0 olur).
-- ==================================================
SELECT crs.CourseName, COUNT(DISTINCT enr.StudentID) AS OgrenciSayisi
FROM dbo.Courses AS crs
LEFT JOIN dbo.Enrollments AS enr ON crs.CourseID = enr.CourseID
GROUP BY crs.CourseName;
GO

-- ==================================================
-- Açıklama (16): HAVING ile en az 3 farklı öğrenciye sahip dersler
-- ==================================================
SELECT crs.CourseName, COUNT(DISTINCT enr.StudentID) AS OgrenciSayisi
FROM dbo.Courses AS crs
LEFT JOIN dbo.Enrollments AS enr ON crs.CourseID = enr.CourseID
GROUP BY crs.CourseName
HAVING COUNT(DISTINCT enr.StudentID) >= 3;
GO

-- ==================================================
-- Açıklama (17): Şehir + dönem bazında kayıt sayısı
-- - İki alanla GROUP BY yapılabilir: City ve Semester birlikte grup anahtarı olur.
-- ==================================================
SELECT stu.City, enr.Semester, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Students AS stu ON enr.StudentID = stu.StudentID
GROUP BY stu.City, enr.Semester;
GO

-- ==================================================
-- Açıklama (18): HAVING ile 2'den fazla kayıt olan şehir-dönem kombinasyonları
-- ==================================================
SELECT stu.City, enr.Semester, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Students AS stu ON enr.StudentID = stu.StudentID
GROUP BY stu.City, enr.Semester
HAVING COUNT(*) > 2;
GO

-- ==================================================
-- Açıklama (19): Öğrencilerin tüm sınav notlarının ortalaması
-- - AVG(enr.Score): Öğrencinin tüm kayıtlarındaki Score ortalaması.
-- ==================================================
SELECT stu.StudentID, stu.FirstName, AVG(enr.Score) AS OrtalamaNot
FROM dbo.Students AS stu
LEFT JOIN dbo.Enrollments AS enr ON stu.StudentID = enr.StudentID
GROUP BY stu.StudentID, stu.FirstName;
GO

-- ==================================================
-- Açıklama (20): HAVING ile ortalama notu 70–85 arasında olan öğrenciler
-- - BETWEEN: iki değer arasında (dahil).
-- ==================================================
SELECT stu.StudentID, stu.FirstName, AVG(enr.Score) AS OrtalamaNot
FROM dbo.Students AS stu
LEFT JOIN dbo.Enrollments AS enr ON stu.StudentID = enr.StudentID
GROUP BY stu.StudentID, stu.FirstName
HAVING AVG(enr.Score) BETWEEN 70 AND 85;
GO


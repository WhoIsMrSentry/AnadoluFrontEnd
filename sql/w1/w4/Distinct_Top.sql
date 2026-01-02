
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





-- ==================================================
-- Açıklama (1): Tüm öğrencileri listeleme
-- - Amaç: Students tablosundaki tüm satır ve sütunları görmek.
-- - Not: Eğitim amacıyla * kullanıyoruz; gerçek projelerde genelde gerekli sütunlar seçilir.
-- ==================================================
SELECT *
FROM dbo.Students;
GO

-- ==================================================
-- Açıklama (2): DISTINCT ile farklı şehirleri listeleme
-- - DISTINCT: Aynı değerden sadece 1 tane döndürür (tekrarları tekilleştirir).
-- - City NULL ise, NULL da tek bir değer olarak 1 kez dönebilir.
-- ==================================================
SELECT DISTINCT City
FROM dbo.Students;
GO

-- ==================================================
-- Açıklama (3): DISTINCT ile farklı ders kategorilerini listeleme
-- - Courses tablosundaki Category alanında hangi kategori değerleri var?
-- ==================================================
SELECT DISTINCT Category
FROM dbo.Courses;
GO

-- ==================================================
-- Açıklama (4): Belirli bir koşul sonrası DISTINCT
-- - WHERE önce satırları filtreler (Category = 'Sayısal').
-- - Sonra DISTINCT, kalan satırlarda CourseName tekrarlarını tekilleştirir.
-- ==================================================
SELECT DISTINCT CourseName
FROM dbo.Courses
WHERE Category = 'Sayısal';
GO

-- ==================================================
-- Açıklama (5): DISTINCT ile öğrencilerin okudukları dönemleri (Semester) listeleme
-- - Enrollments tablosu “hangi öğrenci hangi dersi hangi dönemde aldı?” bilgisini tutar.
-- ==================================================
SELECT DISTINCT Semester
FROM dbo.Enrollments;
GO

-- ==================================================
-- Açıklama (6): TOP + ORDER BY ile “ilk” kaydı deterministik almak
-- - TOP 1: Sonuçtan 1 satır getir.
-- - ORDER BY StudentID ASC: En küçük StudentID “ilk” kabul edilir.
-- - ORDER BY olmazsa “ilk” kavramı garanti değildir.
-- ==================================================
SELECT TOP 1 FirstName, LastName
FROM dbo.Students
ORDER BY StudentID ASC;
GO

-- ==================================================
-- Açıklama (7): TOP + ORDER BY ile “son” kaydı almak
-- - ORDER BY StudentID DESC: En büyük StudentID “son” kabul edilir.
-- ==================================================
SELECT TOP 1 *
FROM dbo.Students
ORDER BY StudentID DESC;
GO

-- ==================================================
-- Açıklama (8): En yüksek notlu ilk 5 öğrenci
-- - TOP 5: En üstteki 5 satır.
-- - ORDER BY Grade DESC: Notu yüksek olanlar önce gelir.
-- ==================================================
SELECT TOP 5 *
FROM dbo.Students
ORDER BY Grade DESC;
GO

-- ==================================================
-- Açıklama (9): INNER JOIN ile iki tabloyu birleştirme + TOP
-- - Amaç: CourseID=1 (Veritabanı) dersinde en yüksek puanı alan ilk 3 öğrenciyi bulmak.
-- - FROM Enrollments: Puan (Score) bilgisi burada olduğu için “başlangıç” tablo olarak mantıklı.
-- - INNER JOIN Students: StudentID üzerinden isim-soyisim almak için.
-- - WHERE: Sadece ilgili ders.
-- - ORDER BY Score DESC: En yüksek puanlar üstte.
-- ==================================================
SELECT TOP 3 stu.FirstName, stu.LastName, enr.Score
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Students  AS stu ON stu.StudentID = enr.StudentID
WHERE enr.CourseID = 1
ORDER BY enr.Score DESC;
GO

-- ==================================================
-- Açıklama (10): Enrollments tablosunda “son eklenen” 5 kayıt
-- - EnrollmentID IDENTITY olduğu için genelde son eklenen kayıtlar en büyük ID’ye sahiptir.
-- ==================================================
SELECT TOP 5 *
FROM dbo.Enrollments
ORDER BY EnrollmentID DESC;
GO

-- ==================================================
-- Açıklama (11): Şehir + sıralama + TOP
-- - WHERE City='İstanbul': Önce İstanbul satırlarını filtreler.
-- - ORDER BY Grade DESC: Notu yüksek olanlar üstte.
-- - TOP 3: İlk 3 satır.
-- ==================================================
SELECT TOP 3 *
FROM dbo.Students
WHERE City = 'İstanbul'
ORDER BY Grade DESC;
GO

-- ==================================================
-- Açıklama (12): Filtrelenmiş veride DISTINCT
-- - Notu 80 ve üzeri olan öğrencilerin şehirlerini tekilleştir.
-- ==================================================
SELECT DISTINCT City
FROM dbo.Students
WHERE Grade >= 80;
GO

-- ==================================================
-- Açıklama (13): GROUP BY + COUNT + TOP
-- - Amaç: En çok seçilen dersleri bulmak (kayıt sayısı en yüksek dersler).
-- - COUNT(*): Her grup içindeki satır sayısı.
-- - GROUP BY CourseName: Ders adına göre gruplar.
-- - ORDER BY COUNT(*) DESC: En büyük sayılar üstte.
-- ==================================================
SELECT TOP 2 crs.CourseName, COUNT(*) AS KayitSayisi
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Courses AS crs ON enr.CourseID = crs.CourseID
GROUP BY crs.CourseName
ORDER BY COUNT(*) DESC;
GO

-- ==================================================
-- Açıklama (14): En düşük 3 not (JOIN ile öğrenci bilgisi dahil)
-- - En düşük puanlar için ORDER BY Score ASC.
-- ==================================================
SELECT TOP 3 stu.FirstName, stu.LastName, enr.Score
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Students AS stu ON enr.StudentID = stu.StudentID
ORDER BY enr.Score ASC;
GO

-- ==================================================
-- Açıklama (15): DISTINCT ile tekrar etmeyen isim-soyisim (JOIN + filtre)
-- - Amaç: Score < 70 olan kayıtların öğrencilerini tekilleştirerek listelemek.
-- - Aynı öğrenci birden fazla sınavda <70 almış olabilir; DISTINCT tekrarları önler.
-- ==================================================
SELECT DISTINCT stu.FirstName, stu.LastName
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Students AS stu ON enr.StudentID = stu.StudentID
WHERE enr.Score < 70;
GO

-- ==================================================
-- Açıklama (16): Belirli dönemde en yüksek notu alan kayıt
-- - WHERE Semester='2023G': Sadece o dönem.
-- - ORDER BY Score DESC + TOP 1: En yüksek skoru seç.
-- - JOIN Courses: Ders adını göstermek için.
-- ==================================================
SELECT TOP 1 stu.FirstName, stu.LastName, crs.CourseName, enr.Score
FROM dbo.Enrollments AS enr
INNER JOIN dbo.Students AS stu ON enr.StudentID = stu.StudentID
INNER JOIN dbo.Courses  AS crs ON enr.CourseID = crs.CourseID
WHERE enr.Semester = '2023G'
ORDER BY enr.Score DESC;
GO




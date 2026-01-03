-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Tekrar çalıştırılabilir kurulum: OBJECT_ID kontrolü + DROP TABLE
-- - Tabloları hazırlama: CREATE TABLE, PRIMARY KEY, FOREIGN KEY, IDENTITY
-- - Örnek veri yükleme: INSERT

-- =============================================================
-- SP HAZIRLIK (ÖRNEK TABLOLAR)
-- Bu dosya; SP_Examples.sql ve SP_Executions.sql içinde kullanılan
-- Students / Courses / Enrollments tablolarını ve örnek verileri hazırlar.
--
-- Önerilen çalışma sırası:
-- 1) Bu dosya (SP_Preps.sql)       -> tablolar + örnek veri
-- 2) SP_Examples.sql               -> stored procedure'ları oluştur/güncelle
-- 3) SP_Executions.sql             -> EXEC ile çağır ve test et
-- =============================================================

-- =============================================================
-- (1) Temizlik (DROP)
-- - Scripti tekrar tekrar çalıştırabilmek için varsa tabloları siler.
-- - FK (yabancı anahtar) nedeniyle silme sırası önemlidir:
--   önce Enrollments (child), sonra Students/Courses (parent).
-- =============================================================
IF OBJECT_ID('dbo.Enrollments','U') IS NOT NULL DROP TABLE dbo.Enrollments;
IF OBJECT_ID('dbo.Students','U')    IS NOT NULL DROP TABLE dbo.Students;
IF OBJECT_ID('dbo.Courses','U')     IS NOT NULL DROP TABLE dbo.Courses;
GO

-- =============================================================
-- (2) Students tablosu
-- - PRIMARY KEY: StudentID benzersiz olmalı.
-- - City/BirthYear/Grade NULL olabilir: "bilinmiyor" senaryosu.
-- =============================================================
CREATE TABLE dbo.Students (
    StudentID  INT         NOT NULL PRIMARY KEY,
    FirstName  NVARCHAR(30) NOT NULL,
    LastName   NVARCHAR(30) NOT NULL,
    City       NVARCHAR(50) NULL,
    BirthYear  INT          NULL,
    Grade      INT          NULL  -- genel başarı notu (0-100)
);
GO

-- =============================================================
-- (3) Courses tablosu
-- - PRIMARY KEY: CourseID benzersiz olmalı.
-- - Category: ör. Sayısal/Teknik/Sözel.
-- =============================================================
CREATE TABLE dbo.Courses (
    CourseID    INT           NOT NULL PRIMARY KEY,
    CourseName  NVARCHAR(100) NOT NULL,
    Category    NVARCHAR(50)  NOT NULL,
    Credit      INT           NOT NULL
);
GO

-- =============================================================
-- (4) Enrollments tablosu
-- - "Hangi öğrenci hangi dersi hangi dönemde aldı, kaç puan aldı?" bilgisi.
-- - EnrollmentID IDENTITY: otomatik artan kayıt numarası.
-- - StudentID/CourseID: FK ile Students/Courses'a bağlanır.
-- =============================================================
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

-- =============================================================
-- (5) Örnek veri ekleme (INSERT)
-- - FK yüzünden ekleme sırası önemlidir:
--   1) Students
--   2) Courses
--   3) Enrollments (çünkü ikisine de bağlı)
-- =============================================================

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
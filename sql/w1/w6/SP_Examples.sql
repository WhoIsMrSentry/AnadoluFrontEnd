-- =============================================================
-- STORED PROCEDURE ÖRNEKLERİ
-- CREATE OR ALTER: Procedure varsa günceller, yoksa oluşturur.
-- Not: Bu dosya Students/Courses/Enrollments tablolarının var olduğunu varsayar.
--      (Önce SP_Preps.sql çalışmalı.)
--
-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - SP yazımı: CREATE OR ALTER PROCEDURE, parametre kullanımı
-- - CRUD SP'leri: SELECT / INSERT / UPDATE / DELETE
-- - Join'li SP'ler: JOIN ile raporlama
-- - Agregat: AVG, MAX, SUM, COUNT, GROUP BY
-- - İlk kayıt: TOP + ORDER BY
-- - Akış kontrol: IF, WHILE, PRINT
-- - Temp table: #Temp ile raporlama
-- =============================================================

-- =============================================================
-- Notlar (kısa özet)
-- - Procedure (SP): Tek komutla tekrar tekrar çalıştırılabilen kayıtlı sorgu/işlem bloğu.
-- - Parametre: Dışarıdan değer alıp sorguyu dinamik yapar (örn: @StudentID).
-- - CREATE OR ALTER: Scripti tekrar çalıştırınca hata vermez; günceller.
-- - GO: batch ayırır; SQL Server'a "bu blok bitti" demek gibi.
-- =============================================================

/* 1. Tüm öğrencileri listele */
-- Parametresiz SP: sadece SELECT çalıştırır.
-- Kategori: Listeleme (READ)
CREATE OR ALTER PROCEDURE sp_ListStudents
AS
BEGIN
    SELECT * FROM Students;
END
GO

/* 2. ID ile öğrenci getir */
-- Parametreli SP: @StudentID dışarıdan alınır.
-- Kategori: Listeleme (READ) + filtre
CREATE OR ALTER PROCEDURE sp_GetStudentById
    @StudentID INT
AS
BEGIN
    SELECT * FROM Students WHERE StudentID = @StudentID;
END
GO


/* 3. Belirli bir dersi alan öğrencileri getir  */
-- Kategori: Raporlama (JOIN)
-- Neden JOIN?
-- - Enrollments: öğrenci-ders ilişkisinin tutulduğu yer
-- - Courses: ders adını buradan alırız
-- - Students: öğrenci bilgisi buradan gelir
CREATE OR ALTER PROCEDURE sp_GetStudentsByCourseName
    @CourseName NVARCHAR(100)
AS
BEGIN
    SELECT s.StudentID, s.FirstName, s.LastName, c.CourseName
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = @CourseName;
END
GO

/* 4. Şehre göre öğrenci listele */
-- Kategori: Listeleme (READ) + filtre
CREATE OR ALTER PROCEDURE sp_GetStudentsByCity
    @City NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Students WHERE City = @City;
END
GO

/* 5. Öğrencinin aldığı dersleri getir */
-- Kategori: Raporlama (JOIN)
-- Neden FROM Enrollments?
-- - Score ve Semester burada tutulur.
CREATE OR ALTER PROCEDURE sp_GetStudentCourses
    @StudentID INT
AS
BEGIN
    SELECT c.CourseName, e.Score, e.Semester
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = @StudentID;
END
GO

/* 6. Bir dersin ortalama notunu hesapla */
-- AVG(): Numeric ortalama alır.
-- Kategori: Agregat (AVG)
CREATE OR ALTER PROCEDURE sp_GetCourseAverageScore
    @CourseID INT
AS
BEGIN
    SELECT AVG(Score) AS OrtalamaNot
    FROM Enrollments
    WHERE CourseID = @CourseID;
END
GO

/* 7. Yeni öğrenci ekle */
-- Kategori: CRUD (CREATE)
-- Not: StudentID bu tabloda IDENTITY olmadığı için dışarıdan veriyoruz.
CREATE OR ALTER PROCEDURE sp_AddStudent
    @StudentID INT,
    @FirstName NVARCHAR(30),
    @LastName NVARCHAR(30),
    @City NVARCHAR(50),
    @BirthYear INT
AS
BEGIN
    INSERT INTO Students(StudentID,FirstName,LastName,City,BirthYear)
    VALUES(@StudentID,@FirstName,@LastName,@City,@BirthYear);
END
GO

/* 8. Öğrencinin genel notunu güncelle */
-- Kategori: CRUD (UPDATE)
CREATE OR ALTER PROCEDURE sp_UpdateStudentGrade
    @StudentID INT,
    @Grade INT
AS
BEGIN
    UPDATE Students
    SET Grade = @Grade
    WHERE StudentID = @StudentID;
END
GO

/* 9. Öğrenciyi sistemden sil */
-- Kategori: CRUD (DELETE)
-- FK (yabancı anahtar) nedeniyle silme sırası:
-- 1) Enrollments (child)
-- 2) Students (parent)
CREATE OR ALTER PROCEDURE sp_DeleteStudent
    @StudentID INT
AS
BEGIN
    DELETE FROM Enrollments WHERE StudentID = @StudentID;
    DELETE FROM Students WHERE StudentID = @StudentID;
END
GO

/* 10. Yeni ders ekle */
-- Kategori: CRUD (CREATE)
CREATE OR ALTER PROCEDURE sp_AddCourse
    @CourseID INT,
    @CourseName NVARCHAR(100),
    @Category NVARCHAR(50),
    @Credit INT
AS
BEGIN
    INSERT INTO Courses VALUES(@CourseID,@CourseName,@Category,@Credit);
END
GO

/* 11. Öğrenciyi derse kaydet */
-- Kategori: CRUD (CREATE)
-- Not: StudentID ve CourseID FK olduğu için ikisi de ilgili tablolarda var olmalı.
CREATE OR ALTER PROCEDURE sp_EnrollStudentToCourse
    @StudentID INT,
    @CourseID INT,
    @Score INT,
    @Semester NVARCHAR(10)
AS
BEGIN    
    INSERT INTO Enrollments(StudentID,CourseID,Score,Semester)
    VALUES(@StudentID,@CourseID,@Score,@Semester);    
END
GO

/* 12. Öğrencinin dersteki notunu güncelle */
-- Kategori: CRUD (UPDATE)
CREATE OR ALTER PROCEDURE sp_UpdateEnrollmentScore
    @StudentID INT,
    @CourseID INT,
    @NewScore INT
AS
BEGIN
    UPDATE Enrollments
    SET Score = @NewScore
    WHERE StudentID = @StudentID AND CourseID = @CourseID;
END
GO

/* 13. Öğrencinin ortalama ders notunu hesapla */
-- Kategori: Agregat (AVG)
CREATE OR ALTER PROCEDURE sp_GetStudentAverageScore
    @StudentID INT
AS
BEGIN
    SELECT AVG(Score) AS Ortalama
    FROM Enrollments
    WHERE StudentID = @StudentID;
END
GO

/* 14. Öğrencinin başarı durumunu yazdır */
-- PRINT: Sonucu mesaj olarak basar (result set döndürmez).
-- Kategori: Akış kontrol (IF/ELSE)
CREATE OR ALTER PROCEDURE sp_CheckStudentStatus
    @StudentID INT
AS
BEGIN
    DECLARE @avg FLOAT;
    SELECT @avg = AVG(Score) FROM Enrollments WHERE StudentID = @StudentID;

    IF @avg >= 60
        PRINT 'Başarılı';
    ELSE
        PRINT 'Başarısız';
END
GO

/* 15. En başarılı öğrenciyi getir */
-- TOP 1 + ORDER BY: En yüksek ortalamayı alanı seçer.
-- Kategori: Raporlama (JOIN + GROUP BY + TOP)
CREATE OR ALTER PROCEDURE sp_GetTopStudent
AS
BEGIN
    SELECT TOP 1 s.StudentID, s.FirstName, s.LastName, AVG(e.Score) AS Ortalama
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    GROUP BY s.StudentID, s.FirstName, s.LastName
    ORDER BY Ortalama DESC;
END
GO

/* 16. Ders bazında öğrenci sayıları */
-- Kategori: Agregat (COUNT + GROUP BY)
CREATE OR ALTER PROCEDURE sp_CourseStudentCounts
AS
BEGIN
    SELECT c.CourseName, COUNT(e.StudentID) AS OgrenciSayisi
    FROM Courses c
    INNER JOIN Enrollments e ON c.CourseID = e.CourseID
    GROUP BY c.CourseName;
END
GO


/* 17. Girilen iki sayının ortalamasını hesapla  */
-- Kategori: Hesaplama (tablosuz)
-- Not: / 2.0 -> ondalıklı sonuç için (integer bölme olmasın)
CREATE OR ALTER PROCEDURE sp_CalculateAverage
    @A INT,
    @B INT
AS
BEGIN
    SELECT (@A + @B) / 2.0 AS Ortalama;
END
GO

/* 18. Asal sayı kontrolü  */
-- Kategori: Akış kontrol (WHILE)
-- Mantık: 2'den başlayıp SQRT(@N)'e kadar bölen var mı bakar.
CREATE OR ALTER PROCEDURE sp_IsPrime
    @N INT
AS
BEGIN
    DECLARE @i INT = 2, @isPrime BIT = 1;

    IF @N < 2 SET @isPrime = 0;

    WHILE @i <= SQRT(@N) AND @isPrime = 1
    BEGIN
        IF @N % @i = 0 SET @isPrime = 0;
        SET @i += 1;
    END

    PRINT CASE WHEN @isPrime = 1 THEN 'Asal' ELSE 'Asal Değil' END;
END
GO

/* 19. Temp table kullanarak öğrencilerin not durumunu raporla */
-- #Temp: Geçici tablo; procedure bitince otomatik temizlenir (scope'a bağlı).
-- Kategori: Raporlama (#Temp)
CREATE OR ALTER PROCEDURE sp_ReportStudentScores
AS
BEGIN
    CREATE TABLE #Temp (
        StudentID INT,
        AvgScore FLOAT
    );

    INSERT INTO #Temp
    SELECT StudentID, AVG(Score)
    FROM Enrollments
    GROUP BY StudentID;

    SELECT s.FirstName, s.LastName, t.AvgScore
    FROM #Temp t
    JOIN Students s ON t.StudentID = s.StudentID;

    DROP TABLE #Temp;
END
GO

/* 20) Genel notu verilen değerin üzerinde olan öğrencileri listeler.*/
-- Kategori: Listeleme (READ) + filtre
CREATE OR ALTER PROCEDURE sp_GetStudentsAboveGrade
    @MinGrade INT
AS
BEGIN
    SELECT StudentID, FirstName, LastName, Grade
    FROM Students
    WHERE Grade >= @MinGrade;
END
GO

/* 21) Parametre olarak verilen dersin, o derste alınan en yüksek notunu getirir.*/
-- Kategori: Agregat (MAX)
CREATE OR ALTER PROCEDURE sp_GetMaxScoreByCourse
    @CourseID INT
AS
BEGIN
    SELECT MAX(Score) AS EnYuksekNot
    FROM Enrollments
    WHERE CourseID = @CourseID;
END
GO

/* 22) Bir öğrencinin kayıtlı olduğu derslerin kredi toplamını hesaplar.*/
-- Kategori: Agregat (SUM) + JOIN
-- Neden JOIN?
-- - Credit bilgisi Courses tablosunda.
CREATE OR ALTER PROCEDURE sp_GetStudentTotalCredit
    @StudentID INT
AS
BEGIN
    SELECT SUM(c.Credit) AS ToplamKredi
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE e.StudentID = @StudentID;
END
GO

/* 23) Parametre olarak verilen dönemde açılan (kayıt yapılan) dersleri listeler.*/
-- Kategori: Raporlama (JOIN) + DISTINCT
-- DISTINCT: Aynı ders birden fazla öğrenciyle tekrar etmesin.
CREATE OR ALTER PROCEDURE sp_GetCoursesBySemester
    @Semester NVARCHAR(10)
AS
BEGIN
    SELECT DISTINCT c.CourseName
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE e.Semester = @Semester;
END
GO


/* 24) Parametre olarak verilen doğum yılına göre yaş hesaplar.*/
-- Kategori: Hesaplama (tablosuz)
CREATE OR ALTER PROCEDURE sp_GetStudentAge
    @BirthYear INT
AS
BEGIN
    SELECT YEAR(GETDATE()) - @BirthYear AS Yas;
END
GO

/* 25) Belirlenen notun altında kalan öğrencileri listeler.*/
-- Kategori: Raporlama (JOIN) + filtre
-- DISTINCT: Aynı öğrenci farklı derslerde düşük aldıysa tekrar etmesin.
CREATE OR ALTER PROCEDURE sp_GetLowScoreStudents
    @LimitScore INT
AS
BEGIN
    SELECT DISTINCT s.StudentID, s.FirstName, s.LastName, e.Score
    FROM Students s
    JOIN Enrollments e ON s.StudentID = e.StudentID
    WHERE e.Score < @LimitScore;
END
GO

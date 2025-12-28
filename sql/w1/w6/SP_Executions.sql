
-- =============================================================
-- STORED PROCEDURE ÇALIŞTIRMA (EXEC)
-- EXEC <procedure> @Param=...: Procedure çağırır.
-- GO: Batch ayırır.
--
-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - EXEC ile SP çağırma (isimli parametre geçme)
-- - Aynı SP'yi farklı parametrelerle deneme
-- - Scripti parçalara ayırma: GO
-- =============================================================

------------------------------------------------------------
-- 1) sp_ListStudents
-- Amaç: Sistemdeki tüm öğrencileri listeler
------------------------------------------------------------
EXEC sp_ListStudents;
GO


------------------------------------------------------------
-- 2) sp_GetStudentById
-- Amaç: ID’ye göre tek bir öğrenciyi getirir
------------------------------------------------------------
EXEC sp_GetStudentById @StudentID = 1;
EXEC sp_GetStudentById @StudentID = 5;
GO


------------------------------------------------------------
-- 3) sp_GetStudentsByCourseName
-- Amaç: Parametre olarak verilen dersi alan öğrencileri listeler
------------------------------------------------------------
EXEC sp_GetStudentsByCourseName @CourseName = 'Veritabanı';
EXEC sp_GetStudentsByCourseName @CourseName = 'Programlama 1';
EXEC sp_GetStudentsByCourseName @CourseName = 'Yapay Zeka Giriş';
GO


------------------------------------------------------------
-- 4) sp_GetStudentsByCity
-- Amaç: Şehre göre öğrenci filtreleme
------------------------------------------------------------
EXEC sp_GetStudentsByCity @City = 'İstanbul';
EXEC sp_GetStudentsByCity @City = 'Ankara';
EXEC sp_GetStudentsByCity @City = 'İzmir';
GO


------------------------------------------------------------
-- 5) sp_GetStudentCourses
-- Amaç: Bir öğrencinin aldığı dersleri ve notlarını getirir
------------------------------------------------------------
EXEC sp_GetStudentCourses @StudentID = 1;
EXEC sp_GetStudentCourses @StudentID = 3;
GO


------------------------------------------------------------
-- 6) sp_GetCourseAverageScore
-- Amaç: Bir dersin ortalama notunu hesaplar
------------------------------------------------------------
EXEC sp_GetCourseAverageScore @CourseID = 1;
EXEC sp_GetCourseAverageScore @CourseID = 2;
GO


------------------------------------------------------------
-- 7) sp_AddStudent
-- Amaç: Yeni öğrenci ekler
------------------------------------------------------------
EXEC sp_AddStudent
    @StudentID = 20,
    @FirstName = 'Ahmet',
    @LastName  = 'Aksoy',
    @City      = 'Eskişehir',
    @BirthYear = 2003;
GO


------------------------------------------------------------
-- 8) sp_UpdateStudentGrade
-- Amaç: Öğrencinin genel notunu günceller
------------------------------------------------------------
EXEC sp_UpdateStudentGrade @StudentID = 1, @Grade = 90;
EXEC sp_UpdateStudentGrade @StudentID = 7, @Grade = 65;
GO


------------------------------------------------------------
-- 9) sp_DeleteStudent
-- Amaç: Öğrenciyi ve kayıtlarını sistemden siler
------------------------------------------------------------
EXEC sp_DeleteStudent @StudentID = 20;
GO


------------------------------------------------------------
-- 10) sp_AddCourse
-- Amaç: Yeni ders ekler
------------------------------------------------------------
EXEC sp_AddCourse
    @CourseID   = 10,
    @CourseName = 'Veri Madenciliği',
    @Category   = 'Sayısal',
    @Credit     = 4;
GO


------------------------------------------------------------
-- 11) sp_EnrollStudentToCourse
-- Amaç: Öğrenciyi derse kaydeder
------------------------------------------------------------
EXEC sp_EnrollStudentToCourse
    @StudentID = 1,
    @CourseID = 10,
    @Score    = 85,
    @Semester = '2024G';
GO


------------------------------------------------------------
-- 12) sp_UpdateEnrollmentScore
-- Amaç: Öğrencinin dersteki notunu günceller
------------------------------------------------------------
EXEC sp_UpdateEnrollmentScore
    @StudentID = 1,
    @CourseID  = 1,
    @NewScore  = 95;
GO


------------------------------------------------------------
-- 13) sp_GetStudentAverageScore
-- Amaç: Öğrencinin ders notu ortalamasını hesaplar
------------------------------------------------------------
EXEC sp_GetStudentAverageScore @StudentID = 1;
EXEC sp_GetStudentAverageScore @StudentID = 4;
GO


------------------------------------------------------------
-- 14) sp_CheckStudentStatus
-- Amaç: Öğrencinin başarılı / başarısız durumunu yazdırır
------------------------------------------------------------
EXEC sp_CheckStudentStatus @StudentID = 1;
EXEC sp_CheckStudentStatus @StudentID = 7;
GO


------------------------------------------------------------
-- 15) sp_GetTopStudent
-- Amaç: Sistemdeki en başarılı öğrenciyi getirir
------------------------------------------------------------
EXEC sp_GetTopStudent;
GO


------------------------------------------------------------
-- 16) sp_CourseStudentCounts
-- Amaç: Ders bazında öğrenci sayılarını listeler
------------------------------------------------------------
EXEC sp_CourseStudentCounts;
GO


------------------------------------------------------------
-- 17) sp_CalculateAverage
-- Amaç: Tablosuz iki sayının ortalamasını hesaplar
------------------------------------------------------------
EXEC sp_CalculateAverage @A = 10, @B = 20;
EXEC sp_CalculateAverage @A = 75, @B = 85;
GO


------------------------------------------------------------
-- 18) sp_IsPrime
-- Amaç: Girilen sayının asal olup olmadığını kontrol eder
------------------------------------------------------------
EXEC sp_IsPrime @N = 7;
EXEC sp_IsPrime @N = 20;
EXEC sp_IsPrime @N = 29;
GO


------------------------------------------------------------
-- 19) sp_ReportStudentScores
-- Amaç: Temp table kullanarak öğrenci ortalama not raporu üretir
------------------------------------------------------------
EXEC sp_ReportStudentScores;
GO


------------------------------------------------------------
-- 20) sp_GetStudentsAboveGrade
-- Amaç: Genel notu verilen değerin üzerinde olan öğrencileri listeler
------------------------------------------------------------
EXEC sp_GetStudentsAboveGrade @MinGrade = 80;
EXEC sp_GetStudentsAboveGrade @MinGrade = 60;
GO


------------------------------------------------------------
-- 21) sp_GetMaxScoreByCourse
-- Amaç: Bir dersteki en yüksek notu getirir
------------------------------------------------------------
EXEC sp_GetMaxScoreByCourse @CourseID = 1;
EXEC sp_GetMaxScoreByCourse @CourseID = 2;
GO


------------------------------------------------------------
-- 22) sp_GetStudentTotalCredit
-- Amaç: Öğrencinin aldığı derslerin toplam kredisini hesaplar
------------------------------------------------------------
EXEC sp_GetStudentTotalCredit @StudentID = 1;
EXEC sp_GetStudentTotalCredit @StudentID = 3;
GO


------------------------------------------------------------
-- 23) sp_GetCoursesBySemester
-- Amaç: Belirli bir dönemde açılan dersleri listeler
------------------------------------------------------------
EXEC sp_GetCoursesBySemester @Semester = '2023G';
EXEC sp_GetCoursesBySemester @Semester = '2023B';
GO


------------------------------------------------------------
-- 24) sp_GetStudentAge
-- Amaç: Doğum yılına göre yaş hesaplar (tablosuz)
------------------------------------------------------------
EXEC sp_GetStudentAge @BirthYear = 2001;
EXEC sp_GetStudentAge @BirthYear = 2004;
GO


------------------------------------------------------------
-- 25) sp_GetLowScoreStudents
-- Amaç: Notu belirli bir değerin altında olan öğrencileri listeler
------------------------------------------------------------
EXEC sp_GetLowScoreStudents @LimitScore = 60;
EXEC sp_GetLowScoreStudents @LimitScore = 70;
GO

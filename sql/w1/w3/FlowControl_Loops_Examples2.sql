
-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Koşul: IF/ELSE, nested IF
-- - Metin uzunluğu: LEN()
-- - Temp table (#) ile kontrol: CREATE/INSERT/SELECT/DROP
-- - Varlık kontrolü: EXISTS / NOT EXISTS
-- - Döngü: WHILE (sayma, toplam, faktöriyel vb.)
-- - Güncelleme: UPDATE

-- 1. IF basic check
-- Açıklama: Sayının pozitif olup olmadığını kontrol eder.
-- PRINT: Bilgilendirme mesajı üretir.
DECLARE @n INT = 5;
IF @n > 0
    PRINT 'Pozitif sayı';
ELSE
    PRINT 'Negatif veya sıfır';

-- 2. Multiple IF-ELSE conditions
-- Açıklama: Not değerine göre sonuç verir.
DECLARE @grade INT = 78;
IF @grade >= 85 PRINT 'Pekiyi';
ELSE IF @grade >= 70 PRINT 'İyi';
ELSE PRINT 'Geliştirilebilir';

-- 3. CASE usage
-- Açıklama: Güne göre mesaj oluşturur.
DECLARE @day INT = 3;
SELECT CASE @day
    WHEN 1 THEN 'Pazartesi'
    WHEN 2 THEN 'Salı'
    WHEN 3 THEN 'Çarşamba'
    ELSE 'Bilinmeyen gün'
END AS Gun;

-- 4. Nested IF
-- Açıklama: İki koşulun birlikte çalışmasını gösterir.
DECLARE @age INT = 25, @isMember BIT = 1;
IF @age >= 18
BEGIN
    IF @isMember = 1 PRINT 'Üyelik indirimi uygulanır';
    ELSE PRINT 'Normal fiyat uygulanır';
END

-- 5. Simple validation
-- Açıklama: Şifre uzunluğunu kontrol eder.
-- LEN(): Metin uzunluğu (karakter sayısı).
DECLARE @pwd NVARCHAR(50) = 'abc12345';
IF LEN(@pwd) < 6
    PRINT 'Şifre çok kısa';
ELSE
    PRINT 'Şifre geçerli';



-- 6. IF with temp table check
-- Açıklama: Tablo boş mu kontrol eder.
-- EXISTS/NOT EXISTS: Alt sorgu en az 1 kayıt döndürüyor mu kontrol eder.
CREATE TABLE #Products (Id INT, Name NVARCHAR(50));
IF NOT EXISTS (SELECT 1 FROM #Products)
    PRINT 'Tablo boş';
DROP TABLE #Products;

-- 7. Conditional insert
CREATE TABLE #Score (Student NVARCHAR(20), Score INT);
DECLARE @s INT = 90;
IF @s >= 50
    INSERT INTO #Score VALUES ('Ali', @s);
SELECT * FROM #Score;
DROP TABLE #Score;

-- 8. Price category assignment
CREATE TABLE #Items (Price INT, Category NVARCHAR(20));
DECLARE @p INT = 120;
INSERT INTO #Items
SELECT @p, CASE WHEN @p > 100 THEN 'Pahalı' ELSE 'Ucuz' END;
SELECT * FROM #Items;
DROP TABLE #Items;

-- 9. Check stock levels
CREATE TABLE #Stock (Product NVARCHAR(30), Qty INT);
INSERT INTO #Stock VALUES ('Laptop', 5);
IF (SELECT Qty FROM #Stock WHERE Product='Laptop') < 10
    PRINT 'Stok az';
DROP TABLE #Stock;

-- 10. Salary bonus example
CREATE TABLE #Employee (Name NVARCHAR(20), Salary INT, Bonus INT);
DECLARE @sal INT = 8000;
INSERT INTO #Employee
SELECT 'Mehmet', @sal, CASE WHEN @sal > 7000 THEN 1000 ELSE 500 END;
SELECT * FROM #Employee;
DROP TABLE #Employee;


-- 11. WHILE loop counting
DECLARE @i INT = 1;
WHILE @i <= 5
BEGIN
    PRINT CONCAT('Sayaç: ', @i);
    SET @i += 1;
END

-- 12. Sum 1..10
DECLARE @x INT = 1, @sum INT = 0;
WHILE @x <= 10
BEGIN
    SET @sum += @x;
    SET @x += 1;
END
PRINT CONCAT('Toplam: ', @sum);

-- 13. Factorial
DECLARE @f INT = 5, @res INT = 1;
WHILE @f > 1
BEGIN
    SET @res *= @f;
    SET @f -= 1;
END
PRINT CONCAT('Faktöriyel: ', @res);

-- 14. Count even numbers
DECLARE @n2 INT = 1, @evenCount INT = 0;
WHILE @n2 <= 20
BEGIN
    IF @n2 % 2 = 0 SET @evenCount += 1;
    SET @n2 += 1;
END
PRINT CONCAT('Çift sayı adedi: ', @evenCount);

-- 15. Reverse countdown
DECLARE @c INT = 5;
WHILE @c > 0
BEGIN
    PRINT CONCAT('Geri sayım: ', @c);
    SET @c -= 1;
END


-- 16. Insert 5 rows with loop
CREATE TABLE #Counter (Val INT);
DECLARE @k INT = 1;
WHILE @k <= 5
BEGIN
    INSERT INTO #Counter VALUES (@k);
    SET @k += 1;
END
SELECT * FROM #Counter;
DROP TABLE #Counter;

-- 17. Multiply values
CREATE TABLE #Nums (Val INT, DoubleVal INT);
DECLARE @n INT = 1;
WHILE @n <= 5
BEGIN
    INSERT INTO #Nums VALUES (@n, @n*2);
    SET @n += 1;
END
SELECT * FROM #Nums;
DROP TABLE #Nums;

-- 18. Fill temp table with squares
CREATE TABLE #Squares (Num INT, Square INT);
DECLARE @sq INT = 1;
WHILE @sq <= 10
BEGIN
    INSERT INTO #Squares VALUES (@sq, @sq*@sq);
    SET @sq += 1;
END
SELECT * FROM #Squares;
DROP TABLE #Squares;

-- 19. Loop to simulate stock reduction
CREATE TABLE #Reduce (Product NVARCHAR(20), Qty INT);
INSERT INTO #Reduce VALUES ('Telefon', 5);
DECLARE @r INT = 5;
WHILE @r > 0
BEGIN
    -- UPDATE: Temp table içindeki Qty alanını günceller.
    UPDATE #Reduce SET Qty = @r - 1;
    SET @r -= 1;
END
SELECT * FROM #Reduce;
DROP TABLE #Reduce;

-- 20. Generate dates
CREATE TABLE #Dates (DayNum INT);
DECLARE @d INT = 1;
WHILE @d <= 7
BEGIN
    INSERT INTO #Dates VALUES (@d);
    SET @d += 1;
END
SELECT * FROM #Dates;
DROP TABLE #Dates;



-- 1. IF basic check
-- Açıklama: Sayının pozitif olup olmadığını kontrol eder.
-- @number: kontrol edilecek sayı
DECLARE @number INT = 5;
IF @number > 0
    PRINT 'Pozitif sayı';
ELSE
    PRINT 'Negatif veya sıfır';

-- 2. Multiple IF-ELSE conditions
-- Açıklama: Not değerine göre sonuç verir.
-- @gradeScore: değerlendirme yapılacak not
DECLARE @gradeScore INT = 78;
IF @gradeScore >= 85 PRINT 'Pekiyi';
ELSE IF @gradeScore >= 70 PRINT 'İyi';
ELSE PRINT 'Geliştirilebilir';

-- 3. CASE usage
-- Açıklama: Güne göre mesaj oluşturur.
-- @dayNumber: 1= Pazartesi, 2= Salı, ...
DECLARE @dayNumber INT = 3;
SELECT CASE @dayNumber
    WHEN 1 THEN 'Pazartesi'
    WHEN 2 THEN 'Salı'
    WHEN 3 THEN 'Çarşamba'
    ELSE 'Bilinmeyen gün'
END AS Gun;

-- 4. Nested IF
-- Açıklama: İki koşulun birlikte çalışmasını gösterir.
-- @ageValue: kişinin yaşı, @isMemberFlag: üyelik durumu (1 = üye)
DECLARE @ageValue INT = 25, @isMemberFlag BIT = 1;
IF @ageValue >= 18
BEGIN
    IF @isMemberFlag = 1 PRINT 'Üyelik indirimi uygulanır';
    ELSE PRINT 'Normal fiyat uygulanır';
END

-- 5. Simple validation
-- Açıklama: Şifre uzunluğunu kontrol eder.
-- @password: kontrol edilecek şifre
DECLARE @password NVARCHAR(50) = 'abc12345';
IF LEN(@password) < 6
    PRINT 'Şifre çok kısa';
ELSE
    PRINT 'Şifre geçerli';



-- 6. IF with temp table check
-- Açıklama: Tablo boş mu kontrol eder.
CREATE TABLE #Products (Id INT, Name NVARCHAR(50));
-- Eğer tablo boşsa EXISTS sorgusu false döner
IF NOT EXISTS (SELECT 1 FROM #Products)
    PRINT 'Tablo boş';
DROP TABLE #Products;

-- 7. Conditional insert
CREATE TABLE #Score (Student NVARCHAR(20), Score INT);
DECLARE @scoreValue INT = 90;
IF @scoreValue >= 50
    INSERT INTO #Score VALUES ('Ali', @scoreValue);
SELECT * FROM #Score;
DROP TABLE #Score;

-- 8. Price category assignment
CREATE TABLE #Items (Price INT, Category NVARCHAR(20));
DECLARE @priceValue INT = 120;
INSERT INTO #Items
SELECT @priceValue, CASE WHEN @priceValue > 100 THEN 'Pahalı' ELSE 'Ucuz' END;
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
DECLARE @salaryValue INT = 8000;
INSERT INTO #Employee
SELECT 'Mehmet', @salaryValue, CASE WHEN @salaryValue > 7000 THEN 1000 ELSE 500 END;
SELECT * FROM #Employee;
DROP TABLE #Employee;


-- 11. WHILE loop counting
DECLARE @counter INT = 1;
WHILE @counter <= 5
BEGIN
    PRINT CONCAT('Sayaç: ', @counter);
    SET @counter += 1;
END

-- 12. Sum 1..10
DECLARE @current INT = 1, @sum INT = 0;
WHILE @current <= 10
BEGIN
    SET @sum += @current;
    SET @current += 1;
END
PRINT CONCAT('Toplam: ', @sum);

-- 13. Factorial
DECLARE @factorialInput INT = 5, @factorialResult INT = 1;
WHILE @factorialInput > 1
BEGIN
    SET @factorialResult *= @factorialInput;
    SET @factorialInput -= 1;
END
PRINT CONCAT('Faktöriyel: ', @factorialResult);

-- 14. Count even numbers
DECLARE @numIter INT = 1, @evenCount INT = 0;
WHILE @numIter <= 20
BEGIN
    IF @numIter % 2 = 0 SET @evenCount += 1;
    SET @numIter += 1;
END
PRINT CONCAT('Çift sayı adedi: ', @evenCount);

-- 15. Reverse countdown
DECLARE @countdown INT = 5;
WHILE @countdown > 0
BEGIN
    PRINT CONCAT('Geri sayım: ', @countdown);
    SET @countdown -= 1;
END


-- 16. Insert 5 rows with loop
CREATE TABLE #Counter (Val INT);
DECLARE @insertIndex INT = 1;
WHILE @insertIndex <= 5
BEGIN
    INSERT INTO #Counter VALUES (@insertIndex);
    SET @insertIndex += 1;
END
SELECT * FROM #Counter;
DROP TABLE #Counter;

-- 17. Multiply values
CREATE TABLE #Nums (Val INT, DoubleVal INT);
DECLARE @numValue INT = 1;
WHILE @numValue <= 5
BEGIN
    INSERT INTO #Nums VALUES (@numValue, @numValue*2);
    SET @numValue += 1;
END
SELECT * FROM #Nums;
DROP TABLE #Nums;

-- 18. Fill temp table with squares
CREATE TABLE #Squares (Num INT, Square INT);
DECLARE @squareIndex INT = 1;
WHILE @squareIndex <= 10
BEGIN
    INSERT INTO #Squares VALUES (@squareIndex, @squareIndex*@squareIndex);
    SET @squareIndex += 1;
END
SELECT * FROM #Squares;
DROP TABLE #Squares;

-- 19. Loop to simulate stock reduction
CREATE TABLE #Reduce (Product NVARCHAR(20), Qty INT);
INSERT INTO #Reduce VALUES ('Telefon', 5);
DECLARE @reduceQty INT = 5;
WHILE @reduceQty > 0
BEGIN
    UPDATE #Reduce SET Qty = @reduceQty - 1;
    SET @reduceQty -= 1;
END
SELECT * FROM #Reduce;
DROP TABLE #Reduce;

-- 20. Generate dates
CREATE TABLE #Dates (DayNum INT);
DECLARE @dayIndex INT = 1;
WHILE @dayIndex <= 7
BEGIN
    INSERT INTO #Dates VALUES (@dayIndex);
    SET @dayIndex += 1;
END
SELECT * FROM #Dates;
DROP TABLE #Dates;


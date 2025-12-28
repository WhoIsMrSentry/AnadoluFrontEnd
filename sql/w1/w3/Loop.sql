/*
Döngü
*/

-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Döngü: WHILE
-- - Sayaç mantığı: SET ile artırma/azaltma
-- - Çıktı: PRINT
-- - Matematik: SQRT(), % (mod), çarpma
-- - Koşullu yazdırma: CASE
-- Bu dosya; WHILE döngüsü ile sayaç/faktöriyel/fibonacci/asal kontrol örnekleri içerir.

-- 1–10 yazdırma
-- WHILE: Koşul TRUE oldukça döngü çalışır.
DECLARE @i INT = 1;
WHILE @i <= 10 BEGIN PRINT @i; SET @i += 1; END;

-- Faktöriyel hesaplama
-- BIGINT: INT'ten daha büyük değer aralığı (taşma ihtimalini azaltır).
DECLARE @num INT = 7, @ix INT = 1, @fact BIGINT = 1;
WHILE @ix <= @num BEGIN SET @fact *= @ix; SET @ix += 1; END;
PRINT @fact;

-- Fibonacci
-- Geçici değişken (@t) ile bir sonraki terim hesaplanır.
DECLARE @a1 INT = 0, @a2 INT = 1, @t INT, @c INT = 1;
WHILE @c <= 10 BEGIN PRINT @a1; SET @t = @a1 + @a2; SET @a1 = @a2; SET @a2 = @t; SET @c += 1; END;

-- Asal kontrol
-- SQRT(@x): Karekök. Asal testinde bölenleri 2..sqrt(n) aralığında kontrol etmek yeterlidir.
DECLARE @x INT = 29, @k INT = 2, @isPrime BIT = 1;
WHILE @k <= SQRT(@x) BEGIN IF @x % @k = 0 SET @isPrime = 0; SET @k += 1; END;
PRINT CASE WHEN @isPrime = 1 THEN 'Asal' ELSE 'Değil' END;

-- Geri sayım
DECLARE @g INT = 10;
WHILE @g > 0 BEGIN PRINT @g; SET @g -= 1; END;
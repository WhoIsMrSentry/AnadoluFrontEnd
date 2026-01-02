/*
Döngü (WHILE) örnekleri - Açıklamalı ve değişken isimleri anlaşılır
Bu dosya, hiç SQL bilmeyenlerin de takip edebilmesi için
her örneği adım adım açıklar. Her blokta kısa amaç, değişkenlerin
anlamı ve ne yapıldığı yazılıdır.
*/

-- 1) 1–10 yazdırma
-- Amaç: WHILE döngüsünün temel kullanımı. Sayaç değişkeniyle ilerler.
-- @counter: döngü sayaç değişkeni
DECLARE @counter INT = 1;
WHILE @counter <= 10
BEGIN
	-- Mevcut değeri yazdır
	PRINT @counter;
	-- Sayacı 1 artır
	SET @counter += 1;
END;


-- 2) Faktöriyel hesaplama (örn. 7!)
-- Amaç: döngü ile çarpma işlemini tekrar ederek faktöriyeli hesaplamak.
-- @targetNumber: faktöriyeli alınacak sayı
-- @index: döngü sayacı (1'den başlar)
-- @factorial: sonuç değerini tutar (BIGINT taşma riskini azaltır)
DECLARE @targetNumber INT = 7;
DECLARE @index INT = 1;
DECLARE @factorial BIGINT = 1;
WHILE @index <= @targetNumber
BEGIN
	-- factorial = factorial * index
	SET @factorial *= @index;
	SET @index += 1;
END;
-- Faktöriyel sonucu yazdır
PRINT @factorial;


-- 3) Fibonacci dizisi (ilk 10 terim)
-- Amaç: her adımda bir sonraki terimi hesaplayıp yazdırmak
-- @prev: önceki terim, @curr: mevcut terim, @next: geçici hesaplama
-- @count: kaç terim yazdırıldığını sayar
DECLARE @prev INT = 0;
DECLARE @curr INT = 1;
DECLARE @next INT;
DECLARE @count INT = 1;
WHILE @count <= 10
BEGIN
	-- Mevcut terimi yazdır
	PRINT @prev;
	-- Sonraki terimi hesapla ve yer değiştir
	SET @next = @prev + @curr;
	SET @prev = @curr;
	SET @curr = @next;
	SET @count += 1;
END;


-- 4) Asal kontrol
-- Amaç: @n sayısının asal olup olmadığını kontrol etmek
-- Yöntem: 2'den sqrt(n)'e kadar bölen aramak yeterlidir
-- @n: kontrol edilecek sayı, @divisor: şu anki bölen denemesi
-- @isPrimeFlag: sonuç bayrağı (1 = asal, 0 = asal değil)
DECLARE @n INT = 29; -- kontrol edilecek sayı
DECLARE @divisor INT = 2; -- bölen adayı
DECLARE @isPrimeFlag BIT = 1; -- başlangıçta asal kabul et
WHILE @divisor <= SQRT(@n)
BEGIN
	-- WHILE döngüsü burada çalışırken her seferinde @divisor değerini
	-- @n sayısına böleriz. Eğer kalan 0 ise tam bölünme vardır.
	IF @n % @divisor = 0
	BEGIN
		-- Tam bölünme bulundu: @n, @divisor ile bölünebiliyor.
		-- Bu durumda @n asaldır varsayımı bozulur, flag 0 yapılır.
		SET @isPrimeFlag = 0;
		-- Artık daha küçük bölen aramaya gerek yok; döngüyü kırıyoruz.
		BREAK; -- döngüyü hemen sonlandırır, sonraki satırlara gitmez
	END;

	-- Eğer burada reached ise o bölen işe yaramadı; sonraki böleni dene.
	-- @divisor 1 arttırılır ve WHILE koşulu tekrar kontrol edilir.
	SET @divisor += 1;
END;
PRINT CASE WHEN @isPrimeFlag = 1 THEN 'Asal' ELSE 'Değil' END;


-- 5) Geri sayım örneği
-- Amaç: basit bir azalan sayaç örneği
DECLARE @countdown INT = 10;
WHILE @countdown > 0
BEGIN
	PRINT @countdown;
	SET @countdown -= 1;
END;
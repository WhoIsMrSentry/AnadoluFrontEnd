-- =============================================================
-- ONLINE SHOP - TCL / PROGRAMLAMA ÖRNEKLERİ (TRANSACTION, TRY/CATCH, CURSOR, VIEW)
-- Bu dosya; bir stored procedure içinde transaction kullanımını ve bazı T-SQL örneklerini gösterir.
--
-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Stored procedure: CREATE PROCEDURE, parametreler
-- - Transaction yönetimi: BEGIN/COMMIT/ROLLBACK TRANSACTION
-- - Hata yönetimi: TRY/CATCH, ERROR_MESSAGE(), XACT_STATE(), RAISERROR
-- - Kimlik değeri alma: SCOPE_IDENTITY()
-- - Set-based veri taşıma: INSERT ... SELECT, UPDATE ... FROM JOIN
-- - Akış kontrol: IF/ELSE, CASE
-- - Cursor ve temp table (#): CURSOR, @@FETCH_STATUS, #Temp
-- - Fonksiyon/View: CREATE FUNCTION, CREATE VIEW
-- - Metadata: INFORMATION_SCHEMA, sys.foreign_keys
-- =============================================================

-- PlaceOrder stored procedure (transactional)
-- CREATE PROCEDURE: Veritabanında saklı yordam (stored procedure) oluşturur.
-- Parametreler: dışarıdan gelen değerlerdir (@UserID, @CartID).
CREATE PROCEDURE dbo.PlaceOrder
    @UserID INT,
    @CartID INT
AS
BEGIN
    -- SET NOCOUNT ON:
    -- - "(n rows affected)" mesajlarını kapatır.
    -- - Özellikle SP içinde gereksiz network/çıktıyı azaltır.
    SET NOCOUNT ON;

    -- TRY/CATCH: Hata yakalama bloğu.
    BEGIN TRY
        -- BEGIN TRANSACTION: Bu bloktaki değişiklikler tek bir atomik işlem olur.
        BEGIN TRANSACTION;

        -- 1) Create Order header (sipariş başlığı)
        INSERT INTO dbo.Orders (UserID, Status)
        VALUES (@UserID,'Processing');
        -- SCOPE_IDENTITY(): Aynı scope'ta en son üretilen IDENTITY değerini döndürür.
        DECLARE @OrderID INT = SCOPE_IDENTITY();

        -- 2) Move items from cart to order
        -- INSERT ... SELECT: CartItems'daki satırları OrderItems'a taşır.
        -- JOIN Products: UnitPrice olarak mevcut ürün fiyatını alır.
        INSERT INTO dbo.OrderItems (OrderID, ProductID, Quantity, UnitPrice)
        SELECT @OrderID, ci.ProductID, ci.Quantity, p.Price
        FROM dbo.CartItems ci
        JOIN dbo.Products p ON ci.ProductID = p.ProductID
        WHERE ci.CartID = @CartID;

        -- 3) Update totals
        -- Subquery: OrderItems içinden SUM(LineTotal) hesaplar.
        UPDATE dbo.Orders
        SET TotalAmount = (SELECT SUM(LineTotal) FROM dbo.OrderItems WHERE OrderID = @OrderID)
        WHERE OrderID = @OrderID;

        -- 4) Decrement inventory
        -- UPDATE ... FROM JOIN: Inventory tablosunu OrderItems ile eşleştirip stok düşer.
        UPDATE inv
        SET inv.Quantity = inv.Quantity - oi.Quantity, inv.LastUpdated = SYSUTCDATETIME()
        FROM dbo.Inventory inv
        JOIN dbo.OrderItems oi ON inv.ProductID = oi.ProductID
        WHERE oi.OrderID = @OrderID;

        -- 5) Add a placeholder payment record
        INSERT INTO dbo.Payments (OrderID, Amount, PaymentMethod, IsSuccessful)
        VALUES (@OrderID, (SELECT TotalAmount FROM dbo.Orders WHERE OrderID = @OrderID), 'Card', 1);

        -- 6) Clear cart
        -- Sepetteki kalemleri temizler (cart header silinmiyor).
        DELETE FROM dbo.CartItems WHERE CartID = @CartID;

        -- COMMIT: Transaction içindeki tüm değişiklikleri kalıcı yapar.
        COMMIT TRANSACTION;

        SELECT @OrderID AS CreatedOrderID;
    END TRY
    BEGIN CATCH
        -- XACT_STATE(): Transaction durumunu döndürür.
        -- 0: yok, 1: committable, -1: uncommittable
        IF XACT_STATE() <> 0
        BEGIN
            -- ROLLBACK: Transaction içindeki değişiklikleri geri alır.
            ROLLBACK TRANSACTION;
        END
        -- ERROR_MESSAGE(): Yakalanan hatanın mesajını döndürür.
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        -- RAISERROR: Hata fırlatır (severity 16 -> uygulama hatası gibi).
        RAISERROR('PlaceOrder failed: %s',16,1,@ErrMsg);
    END CATCH
END;
GO

-- Flow control examples
-- IF/ELSE and CASE
-- DECLARE: Değişken tanımlama. @ ile başlar.
DECLARE @Price DECIMAL(18,2) = 100.0;
IF @Price > 50
    PRINT 'Expensive';
ELSE
    PRINT 'Cheap';
GO

-- CASE in SELECT (example)
-- CASE: Koşullu ifade; SELECT içinde yeni bir kolon üretmek için sık kullanılır.
SELECT ProductName,
       CASE WHEN Price < 10 THEN 'Cheap' WHEN Price < 50 THEN 'Moderate' ELSE 'Expensive' END AS PriceRange
FROM dbo.Products;
GO

-- Cursor example 
-- # ile başlayan tablolar TEMP TABLE'dır: sadece mevcut oturumda yaşar.
-- Cursor: Satır satır dolaşma örneği (set-based yaklaşım genelde daha tercih edilir).
CREATE TABLE #StockReport (
    ProductID INT,
    ProductName NVARCHAR(255),
    Quantity INT
);
GO

DECLARE @pID INT, @pName NVARCHAR(255), @qty INT;
DECLARE product_cursor CURSOR FOR
    SELECT p.ProductID, p.ProductName, i.Quantity
    FROM dbo.Products p
    JOIN dbo.Inventory i ON p.ProductID = i.ProductID;

OPEN product_cursor;
FETCH NEXT FROM product_cursor INTO @pID, @pName, @qty;
-- @@FETCH_STATUS: Son FETCH sonucunu döndürür (0=başarılı).
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO #StockReport (ProductID, ProductName, Quantity)
    VALUES (@pID, @pName, @qty);

    FETCH NEXT FROM product_cursor INTO @pID, @pName, @qty;
END
CLOSE product_cursor;
DEALLOCATE product_cursor;

SELECT * FROM #StockReport;
DROP TABLE #StockReport;
GO

-- Scalar function example
-- Scalar function: Tek bir değer döndüren kullanıcı fonksiyonu.
CREATE FUNCTION dbo.ufn_FormatPrice(@Price DECIMAL(18,2))
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN CONCAT('$', FORMAT(@Price, 'N2'));
END;
GO

-- View example
-- VIEW: Sorguyu "sanal tablo" gibi isimlendirir; raporlama/okuma amaçlı sık kullanılır.
CREATE VIEW dbo.vOrderSummary
AS
SELECT o.OrderID,o.OrderDate,u.Username,o.TotalAmount,o.Status
FROM dbo.Orders o
JOIN dbo.Users u ON o.UserID = u.UserID;
GO

-- Helper metadata queries
-- INFORMATION_SCHEMA ve sys.*: Şema/metadata incelemek için sistem görünümleri.
SELECT TABLE_SCHEMA, TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE';
SELECT * FROM sys.foreign_keys;
GO


-- =============================================================
-- ONLINE SHOP - DML (ÖRNEK VERİ + CRUD SORGULARI)
-- Bu dosya örnek kayıtlar ekler ve SELECT/UPDATE/DELETE örnekleri gösterir.
-- Not: Bu scripti çalıştırmadan önce DDL (tablolar) oluşturulmuş olmalı.
--
-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Örnek veri ekleme: INSERT INTO ... VALUES (çoklu satır)
-- - Okuma: SELECT + JOIN ile tablo birleştirme
-- - Güncelleme: UPDATE ... SET ... WHERE
-- - Silme: DELETE ... WHERE (FK nedeniyle doğru silme sırası)
-- - Özetleme: GROUP BY + SUM, ORDER BY
-- - Batch ayırma: GO
-- =============================================================

-- Sample Data (INSERT örnekleri)
-- INSERT INTO ... (Kolonlar) VALUES (...), (...): tek statement ile çoklu satır ekler.
INSERT INTO dbo.Users (Username, Email, PasswordHash, FullName)
VALUES
('alice','alice@example.com','HASH1','Alice Smith'),
('bob','bob@example.com','HASH2','Bob Johnson'),
('carol','carol@example.com','HASH3','Carol Taylor');

INSERT INTO dbo.Suppliers (SupplierName, ContactEmail)
VALUES ('Acme Supplies','sales@acme.com'),('Global Goods','info@globalgoods.com');

INSERT INTO dbo.Categories (CategoryName) VALUES ('Electronics'),('Books'),('Home');

INSERT INTO dbo.Products (SKU, ProductName, CategoryID, Price, Description) VALUES
('SKU-1000','USB-C Cable',1,9.99,'1m braided cable'),
('SKU-1001','Wireless Mouse',1,24.50,'Ergonomic mouse'),
('SKU-2000','Database Design Book',2,49.90,'Comprehensive guide'),
('SKU-3000','Coffee Mug',3,7.99,'Ceramic mug 350ml');

INSERT INTO dbo.Inventory (ProductID, Quantity, ReorderLevel) VALUES
(1, 150, 20),(2, 80, 15),(3, 40, 5),(4, 200, 30);

INSERT INTO dbo.SupplierProducts (SupplierID, ProductID, SupplierSKU, UnitCost) VALUES
(1,1,'ACME-CBL-01',2.5),(1,2,'ACME-MSE-02',10.0),(2,3,'GG-BOOK-01',20.0),(2,4,'GG-MUG-01',2.0);

INSERT INTO dbo.Addresses (UserID, AddressLine1, City, Country) VALUES
(1,'123 Main St','Istanbul','Turkey'),(2,'456 Oak Ave','Ankara','Turkey');

INSERT INTO dbo.Carts (UserID) VALUES (1),(2);

INSERT INTO dbo.CartItems (CartID, ProductID, Quantity) VALUES (1,2,1),(1,3,1),(2,4,2);
GO

-- GO: Bir önceki batch'i sonlandırır (istemci tarafı ayırıcı).

-- CRUD Examples
-- SELECT + JOIN: Sepet -> kullanıcı -> sepet kalemleri -> ürün bilgilerini birleştirir.

SELECT u.Username, c.CartID, p.ProductName, ci.Quantity
FROM dbo.Carts c
JOIN dbo.Users u ON c.UserID = u.UserID
JOIN dbo.CartItems ci ON c.CartID = ci.CartID
JOIN dbo.Products p ON ci.ProductID = p.ProductID;
GO

-- UPDATE: CategoryID = 1 olan ürünlerin fiyatını %10 artırır.
-- WHERE yoksa tüm tabloyu güncellerdi; bu yüzden filtre kritik.
UPDATE dbo.Products SET Price = Price * 1.10 WHERE CategoryID = 1;
GO

-- DELETE: Önce child tablo (CartItems) silinir; sonra parent (Carts).
-- Bunun sebebi: CartItems -> Carts FK ilişkisi (FK varken parent'ı önce silemezsin).
DELETE FROM dbo.CartItems WHERE CartID = 2;
DELETE FROM dbo.Carts WHERE CartID = 2;
GO

-- Aggregate (GROUP BY): Ürün bazında toplam satılan adet.
-- SUM(oi.Quantity): ürünün tüm sipariş kalemlerindeki toplam miktarı.
 SELECT p.ProductID,p.ProductName,SUM(oi.Quantity) AS TotalSold
 FROM dbo.OrderItems oi
 JOIN dbo.Products p ON oi.ProductID = p.ProductID
 GROUP BY p.ProductID,p.ProductName
 ORDER BY TotalSold DESC;
 GO



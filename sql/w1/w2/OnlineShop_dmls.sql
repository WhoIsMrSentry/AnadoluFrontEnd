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

-- =============================================================
-- (1) Örnek Veri Ekleme (INSERT)
-- - Amaç: Sistemde test/örnek senaryo çalıştırmak için başlangıç verilerini oluşturmak.
-- - INSERT INTO ... (Kolonlar) VALUES (...), (...)
--   tek bir komutla birden fazla satır eklemeyi sağlar.
-- - Buradaki ID alanlarının çoğu DDL tarafında IDENTITY ise otomatik üretilir;
--   o yüzden INSERT'te genelde ID kolonlarını yazmayız.
-- =============================================================

-- Users: Sistemde alışveriş yapacak kullanıcılar
INSERT INTO dbo.Users (Username, Email, PasswordHash, FullName)
VALUES
('alice','alice@example.com','HASH1','Alice Smith'),
('bob','bob@example.com','HASH2','Bob Johnson'),
('carol','carol@example.com','HASH3','Carol Taylor');

-- Suppliers: Ürün tedarikçileri
INSERT INTO dbo.Suppliers (SupplierName, ContactEmail)
VALUES ('Acme Supplies','sales@acme.com'),('Global Goods','info@globalgoods.com');

-- Categories: Ürün kategorileri
INSERT INTO dbo.Categories (CategoryName) VALUES ('Electronics'),('Books'),('Home');

-- Products: Ürün kartları (hangi kategoriye ait, fiyatı vb.)
-- Not: CategoryID bir FK ise, önce Categories eklenmiş olmalı.
INSERT INTO dbo.Products (SKU, ProductName, CategoryID, Price, Description) VALUES
('SKU-1000','USB-C Cable',1,9.99,'1m braided cable'),
('SKU-1001','Wireless Mouse',1,24.50,'Ergonomic mouse'),
('SKU-2000','Database Design Book',2,49.90,'Comprehensive guide'),
('SKU-3000','Coffee Mug',3,7.99,'Ceramic mug 350ml');

-- Inventory: Ürün stok bilgisi
-- Quantity: mevcut stok; ReorderLevel: yeniden sipariş eşiği
INSERT INTO dbo.Inventory (ProductID, Quantity, ReorderLevel) VALUES
(1, 150, 20),(2, 80, 15),(3, 40, 5),(4, 200, 30);

-- SupplierProducts: Hangi tedarikçi hangi ürünü hangi maliyetle sağlar?
-- SupplierID ve ProductID genelde FK'dir.
INSERT INTO dbo.SupplierProducts (SupplierID, ProductID, SupplierSKU, UnitCost) VALUES
(1,1,'ACME-CBL-01',2.5),(1,2,'ACME-MSE-02',10.0),(2,3,'GG-BOOK-01',20.0),(2,4,'GG-MUG-01',2.0);

-- Addresses: Kullanıcı teslimat adresleri
INSERT INTO dbo.Addresses (UserID, AddressLine1, City, Country) VALUES
(1,'123 Main St','Istanbul','Turkey'),(2,'456 Oak Ave','Ankara','Turkey');

-- Carts: Kullanıcı sepetleri (her kullanıcıya bir sepet gibi düşün)
INSERT INTO dbo.Carts (UserID) VALUES (1),(2);

-- CartItems: Sepet kalemleri (hangi sepette hangi ürün kaç adet?)
INSERT INTO dbo.CartItems (CartID, ProductID, Quantity) VALUES (1,2,1),(1,3,1),(2,4,2);
GO

-- GO: Bir önceki batch'i sonlandırır (istemci tarafı ayırıcı).

-- =============================================================
-- (2) Okuma (SELECT) + JOIN
-- - Amaç: Sepetteki ürünleri kullanıcı adıyla birlikte listelemek.
-- - JOIN zinciri:
--   Carts (sepet) -> Users (sepetin sahibi)
--   Carts -> CartItems (sepet kalemleri)
--   CartItems -> Products (ürün adı)
-- - JOIN (INNER JOIN) kullanınca: eşleşmeyen kayıtlar gelmez.
-- =============================================================

SELECT u.Username, c.CartID, p.ProductName, ci.Quantity
FROM dbo.Carts c
JOIN dbo.Users u ON c.UserID = u.UserID
JOIN dbo.CartItems ci ON c.CartID = ci.CartID
JOIN dbo.Products p ON ci.ProductID = p.ProductID;
GO

-- =============================================================
-- (3) Güncelleme (UPDATE)
-- - Amaç: CategoryID = 1 olan ürünlerin fiyatını %10 artırmak.
-- - Price = Price * 1.10: mevcut fiyat üzerinden hesaplar.
-- - WHERE çok kritik: yoksa tüm ürünlerin fiyatı artar.
-- =============================================================
UPDATE dbo.Products SET Price = Price * 1.10 WHERE CategoryID = 1;
GO

-- =============================================================
-- (4) Silme (DELETE)
-- - Amaç: CartID=2 olan sepeti tamamen silmek.
-- - FK (yabancı anahtar) nedeniyle silme sırası önemlidir:
--   önce child tablo (CartItems), sonra parent tablo (Carts).
-- - Aksi halde: "FK constraint" hatası alırsın.
-- =============================================================
DELETE FROM dbo.CartItems WHERE CartID = 2;
DELETE FROM dbo.Carts WHERE CartID = 2;
GO

-- =============================================================
-- (5) Özetleme (AGGREGATE) + GROUP BY
-- - Amaç: Ürün bazında toplam satılan adetleri görmek.
-- - OrderItems: her satır bir sipariş kalemi (ürün + adet).
-- - SUM(oi.Quantity): aynı ürünün tüm siparişlerdeki toplam adedi.
-- - GROUP BY: ürün bazında toplamak için şart.
-- - ORDER BY TotalSold DESC: en çok satılan en üstte.
-- =============================================================
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM dbo.OrderItems oi
JOIN dbo.Products p ON oi.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC;
GO



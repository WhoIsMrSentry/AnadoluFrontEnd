-- =============================================================
-- ONLINE SHOP - DDL (TABLO/İLİŞKİ OLUŞTURMA) SCRIPT'I
-- Bu dosya; OnlineShop veritabanını oluşturur ve e-ticaret şemasını
-- (kullanıcı, ürün, sipariş, stok, sepet, ödeme, kargo vb.) kurar.
--
-- Bu derste öğreneceklerimiz (bu dosyadaki konular):
-- - Veritabanı oluşturma: USE, CREATE DATABASE, ALTER DATABASE
-- - Batch yönetimi: GO
-- - Tablo oluşturma: CREATE TABLE, veri tipleri (INT, NVARCHAR, DECIMAL, DATETIME2, BIT)
-- - Anahtarlar/kısıtlar: PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK, DEFAULT
-- - Kimlik kolonları: IDENTITY(seed, increment)
-- - Hesaplanan kolon: AS (...) PERSISTED
-- - Sonradan ilişki ekleme: ALTER TABLE ... ADD CONSTRAINT
--
-- Eğitim notu:
-- - Bu dosya T-SQL (SQL Server) içindir.
-- - "dbo" varsayılan şemadır (schema). Nesneler genelde dbo.<TabloAdı> olarak oluşturulur.
-- - "GO" bir T-SQL komutu değil; SSMS/sqlcmd gibi istemcilerin "batch" ayırıcı anahtar kelimesidir.
--   Yani GO geldiğinde, önceki blok ayrı bir "batch" olarak sunucuya gönderilir.
-- =============================================================

-- 1) Veritabanını Oluştur / Sıfırla
-- Not: Aşağıdaki DROP bloğu yorumda (kapalı). Açarsan, mevcut DB'yi
-- tek kullanıcı moduna alıp silerek sıfırlamayı amaçlar.
-- USE <db>:
-- - Mevcut oturumun "aktif" veritabanını değiştirir.
-- - CREATE DATABASE gibi işlemler için genelde master'da olmak tercih edilir.
USE master;
--IF DB_ID(N'OnlineShop') IS NOT NULL
--BEGIN
--    DB_ID(N'OnlineShop'):
--    - İsimden veritabanı id'sini döndürür; yoksa NULL.
--
--    ALTER DATABASE ... SET SINGLE_USER:
--    - DB'yi tek kullanıcı moduna alır; başka bağlantıların kapanmasını kolaylaştırır.
--
--    WITH ROLLBACK IMMEDIATE:
--    - Açık transaction/oturumları zorla sonlandırır; beklemeden rollback yapar.
--
--    DROP DATABASE:
--    - Veritabanını tamamen siler (tüm tablolar/veriler gider).
--      Eğitim/test için işe yarar; prod ortamda tehlikelidir.
--    ALTER DATABASE OnlineShop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--    DROP DATABASE OnlineShop;
--END

-- OnlineShop veritabanını oluşturur
-- CREATE DATABASE:
-- - Sunucuda yeni bir veritabanı oluşturur.
-- - Varsayılan ayarlarda data/log dosyaları SQL Server'ın default path'lerine açılır.
CREATE DATABASE OnlineShop;
GO

-- Aktif veritabanını OnlineShop olarak ayarlar
USE OnlineShop;
GO

-- Recovery modelini SIMPLE yapar (log büyümesini azaltır; eğitim/testte sık)
-- RECOVERY SIMPLE:
-- - Transaction log otomatik truncate olur.
-- - Point-in-time restore (zamana noktasal dönüş) desteklenmez.
ALTER DATABASE OnlineShop SET RECOVERY SIMPLE;
GO

-- 2) Tabloları Oluştur
-- Aşağıda her tablo; bir iş alanını temsil eder ve FK'lerle birbirine bağlanır.

-- Users: Kullanıcı hesapları (username/email unique, CreatedAt UTC, IsActive)
-- NVARCHAR: Unicode (Türkçe karakterler dahil) metin tipi.
-- NOT NULL: Kolon boş bırakılamaz.
-- NULL: Kolon boş bırakılabilir.
-- IDENTITY(seed, increment): Otomatik artan sayısal değer üretir.
-- PRIMARY KEY: Tekillik + index sağlar, satırı benzersiz tanımlar.
-- UNIQUE: Kolonda tekrar eden değerleri engeller (SQL Server bir unique index oluşturur).
-- DEFAULT: INSERT sırasında değer verilmezse varsayılanı kullanır.
-- SYSUTCDATETIME(): UTC tarih-saat döndürür (DATETIME2 hassasiyetinde).
CREATE TABLE dbo.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,               -- Kullanıcı PK; 1'den başlayıp 1'er artar
    Username NVARCHAR(50) NOT NULL UNIQUE,              -- Giriş adı; benzersiz olmalı
    Email NVARCHAR(255) NOT NULL UNIQUE,                -- E-posta; benzersiz olmalı
    PasswordHash NVARCHAR(255) NOT NULL,                -- Şifre değil, hash (örn. bcrypt/argon2 çıktısı)
    FullName NVARCHAR(200) NULL,                        -- Ad soyad (opsiyonel)
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Kayıt zamanı (UTC)
    IsActive BIT NOT NULL DEFAULT 1                     -- 1=aktif, 0=pasif
);
GO

-- Addresses: Adres bilgileri
-- Hem kullanıcıya (UserID) hem tedarikçiye (SupplierID) bağlanabilir.
-- User/Supplier silinirse ilgili FK alanı NULL olur (ON DELETE SET NULL).
CREATE TABLE dbo.Addresses (
    AddressID INT IDENTITY(1,1) PRIMARY KEY,            -- Adres PK
    UserID INT NULL,                                    -- Adres bir kullanıcıya aitse dolu
    SupplierID INT NULL,                                -- Adres bir tedarikçiye aitse dolu
    AddressLine1 NVARCHAR(255) NOT NULL,                -- Adres satırı 1
    AddressLine2 NVARCHAR(255) NULL,                    -- Adres satırı 2 (opsiyonel)
    City NVARCHAR(100) NOT NULL,                        -- İl/şehir
    State NVARCHAR(100) NULL,                           -- İlçe/eyalet vb. (ülkeye göre değişir)
    PostalCode NVARCHAR(20) NULL,                       -- Posta kodu
    Country NVARCHAR(100) NOT NULL,                     -- Ülke
    CONSTRAINT FK_Addresses_Users
        FOREIGN KEY (UserID)
        REFERENCES dbo.Users(UserID)
        ON DELETE SET NULL                              -- User silinirse adres silinmez; UserID NULL olur
);
GO

-- Categories: Ürün kategorileri
-- ParentCategoryID ile hiyerarşik yapı (üst/alt kategori) kurulur.
-- Self-referencing FK:
-- - ParentCategoryID aynı tablonun PK'sine bağlanır.
-- - Böylece kategori ağacı (tree) oluşturulur.
CREATE TABLE dbo.Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,           -- Kategori PK
    CategoryName NVARCHAR(100) NOT NULL UNIQUE,         -- Kategori adı benzersiz
    ParentCategoryID INT NULL,                          -- Üst kategori (root ise NULL)
    CONSTRAINT FK_Categories_Parent
        FOREIGN KEY (ParentCategoryID)
        REFERENCES dbo.Categories(CategoryID)           -- Üst kategori kendi tablosundaki bir kaydı işaret eder
);
GO

-- Suppliers: Ürün tedarikçileri
CREATE TABLE dbo.Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,           -- Tedarikçi PK
    SupplierName NVARCHAR(200) NOT NULL,                -- Firma adı
    ContactEmail NVARCHAR(255) NULL                     -- İletişim e-postası (opsiyonel)
);
GO

-- Addresses tablosuna Suppliers FK ekler (SupplierID üzerinden)
-- ALTER TABLE ... ADD CONSTRAINT:
-- - Var olan bir tabloya sonradan constraint eklemek için kullanılır.
-- - Burada Addresses oluşturulurken Suppliers tablosu henüz yoktu diye değil;
--   sadece "okunabilirlik"/"aşamalı kurulum" için ayrı yazılmış olabilir.
ALTER TABLE dbo.Addresses
    ADD CONSTRAINT FK_Addresses_Suppliers FOREIGN KEY (SupplierID) REFERENCES dbo.Suppliers(SupplierID) ON DELETE SET NULL;
GO

-- Products: Ürün kartları
-- SKU unique; CategoryID opsiyonel; kategori silinirse CategoryID NULL olur.
-- DECIMAL(18,2): 18 basamak toplam, 2 basamak ondalık (para değerleri için yaygın).
CREATE TABLE dbo.Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,            -- Ürün PK
    SKU NVARCHAR(50) NOT NULL UNIQUE,                   -- Stok kodu; benzersiz
    ProductName NVARCHAR(255) NOT NULL,                 -- Ürün adı
    CategoryID INT NULL,                                -- Kategori (opsiyonel)
    Price DECIMAL(18,2) NOT NULL DEFAULT 0,             -- Liste fiyatı (varsayılan 0)
    Description NVARCHAR(MAX) NULL,                     -- Uzun açıklama (MAX -> büyük metin)
    IsActive BIT NOT NULL DEFAULT 1,                    -- Ürün satışta mı?
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Ürün eklenme zamanı (UTC)
    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.Categories(CategoryID)
        ON DELETE SET NULL                              -- Kategori silinirse ürün silinmez; CategoryID NULL olur
);
GO

-- Inventory: Stok takibi (ürün başına miktar, yeniden sipariş seviyesi)
CREATE TABLE dbo.Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,          -- Stok PK
    ProductID INT NOT NULL,                             -- Hangi ürünün stoku
    Quantity INT NOT NULL DEFAULT 0,                    -- Mevcut stok
    ReorderLevel INT NOT NULL DEFAULT 10,               -- Uyarı/yeniden sipariş eşiği
    LastUpdated DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Son güncelleme zamanı (UTC)
    CONSTRAINT FK_Inventory_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)              -- Ürün silinirse stok kaydı yetim kalmamalı
);
GO

-- SupplierProducts: Tedarikçi-Ürün eşleştirme (many-to-many)
-- (SupplierID, ProductID) UNIQUE -> aynı eşleşme iki kez eklenemez.
-- Many-to-many örneği:
-- - Bir tedarikçi birçok ürün sağlayabilir.
-- - Bir ürün birçok tedarikçiden temin edilebilir.
CREATE TABLE dbo.SupplierProducts (
    SupplierProductID INT IDENTITY(1,1) PRIMARY KEY,    -- Yapay PK (surrogate key)
    SupplierID INT NOT NULL,                            -- Tedarikçi
    ProductID INT NOT NULL,                             -- Ürün
    SupplierSKU NVARCHAR(100) NULL,                     -- Tedarikçinin kendi SKU/kodu
    UnitCost DECIMAL(18,2) NULL,                        -- Tedarikçiden alış maliyeti (opsiyonel)
    CONSTRAINT UQ_Supplier_Product
        UNIQUE (SupplierID, ProductID),                 -- Aynı tedarikçi-ürün eşleşmesi tekrar edemez
    CONSTRAINT FK_SupplierProducts_Suppliers
        FOREIGN KEY (SupplierID)
        REFERENCES dbo.Suppliers(SupplierID),
    CONSTRAINT FK_SupplierProducts_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);
GO

-- Orders: Sipariş başlığı
-- OrderID 1000'den başlar; Shipping/BillingAddressID opsiyoneldir.
-- Status: Sipariş durumu metin alanı (varsayılan: 'Pending').
-- TotalAmount: Sipariş toplam tutarı alanı (varsayılan: 0).
CREATE TABLE dbo.Orders (
    OrderID INT IDENTITY(1000,1) PRIMARY KEY,           -- Sipariş no (1000'den başlar)
    UserID INT NOT NULL,                                -- Siparişi veren kullanıcı
    OrderDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Sipariş zamanı (UTC)
    Status NVARCHAR(50) NOT NULL DEFAULT 'Pending',     -- Varsayılan durum: Pending
    TotalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,       -- Sipariş toplamı
    ShippingAddressID INT NULL,                         -- Kargo adresi (opsiyonel)
    BillingAddressID INT NULL,                          -- Fatura adresi (opsiyonel)
    CONSTRAINT FK_Orders_Users
        FOREIGN KEY (UserID)
        REFERENCES dbo.Users(UserID),
    CONSTRAINT FK_Orders_ShippingAddress
        FOREIGN KEY (ShippingAddressID)
        REFERENCES dbo.Addresses(AddressID),
    CONSTRAINT FK_Orders_BillingAddress
        FOREIGN KEY (BillingAddressID)
        REFERENCES dbo.Addresses(AddressID)
);
GO

-- OrderItems: Sipariş kalemleri (siparişteki ürünler)
-- LineTotal hesaplanan kolon: Quantity * UnitPrice (PERSISTED -> fiziksel saklanır).
-- PERSISTED:
-- - Hesaplanan kolon değerini disk üzerinde saklar.
-- - Böylece SELECT sırasında her seferinde hesaplanmak zorunda kalmaz;
--   ayrıca indexlenebilmesi kolaylaşır (kurallara bağlı).
CREATE TABLE dbo.OrderItems (
    OrderItemID INT IDENTITY(1,1) PRIMARY KEY,          -- Sipariş kalemi PK
    OrderID INT NOT NULL,                               -- Hangi siparişe ait
    ProductID INT NOT NULL,                             -- Hangi ürün
    Quantity INT NOT NULL DEFAULT 1,                    -- Adet (varsayılan 1)
    UnitPrice DECIMAL(18,2) NOT NULL,                   -- Sipariş anındaki birim fiyat (ürün fiyatı değişse bile korunur)
    LineTotal AS (Quantity * UnitPrice) PERSISTED,      -- Kalem toplamı
    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);
GO

-- Payments: Sipariş ödemeleri (başarılı/başarısız takibi)
-- PaymentMethod: Ödeme yöntemi bilgisi (metin alanı).
CREATE TABLE dbo.Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,            -- Ödeme PK
    OrderID INT NOT NULL,                               -- Hangi siparişin ödemesi
    PaymentDate DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Ödeme zamanı (UTC)
    Amount DECIMAL(18,2) NOT NULL,                      -- Ödenen tutar
    PaymentMethod NVARCHAR(50) NOT NULL,                -- Ödeme yöntemi
    IsSuccessful BIT NOT NULL DEFAULT 0,                -- 1=başarılı, 0=başarısız
    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID)
);
GO

-- Shipments: Kargo/sevkiyat kayıtları (takip no, durum, çıkış tarihi)
-- ShippedDate NULL olabilir: hazırlık aşamasında henüz çıkış tarihi yoktur.
CREATE TABLE dbo.Shipments (
    ShipmentID INT IDENTITY(1,1) PRIMARY KEY,           -- Sevkiyat PK
    OrderID INT NOT NULL,                               -- Hangi sipariş için
    ShippedDate DATETIME2 NULL,                         -- Kargoya verildiği tarih (nullable)
    Carrier NVARCHAR(100) NULL,                         -- Kargo firması
    TrackingNumber NVARCHAR(100) NULL,                  -- Takip numarası
    Status NVARCHAR(50) NOT NULL DEFAULT 'Preparing',   -- Varsayılan durum: Preparing
    CONSTRAINT FK_Shipments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID)
);
GO

-- ShipmentItems: Bir sevkiyatın hangi sipariş kalemlerinden kaç adet içerdiği
CREATE TABLE dbo.ShipmentItems (
    ShipmentItemID INT IDENTITY(1,1) PRIMARY KEY,       -- Sevkiyat kalemi PK
    ShipmentID INT NOT NULL,                            -- Hangi sevkiyat
    OrderItemID INT NOT NULL,                           -- Hangi sipariş kalemi
    Quantity INT NOT NULL,                              -- Bu sevkiyatta gönderilen adet
    CONSTRAINT FK_ShipmentItems_Shipments
        FOREIGN KEY (ShipmentID)
        REFERENCES dbo.Shipments(ShipmentID),
    CONSTRAINT FK_ShipmentItems_OrderItems
        FOREIGN KEY (OrderItemID)
        REFERENCES dbo.OrderItems(OrderItemID)
);
GO

-- Reviews: Ürün yorumları/puanları (Rating 1-5 arası CHECK ile zorlanır)
-- CHECK constraint:
-- - Veri kalitesini DB seviyesinde garanti eder.
-- - Rating 1..5 dışındaysa INSERT/UPDATE hata verir.
CREATE TABLE dbo.Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,             -- Yorum PK
    ProductID INT NOT NULL,                             -- Hangi ürün
    UserID INT NOT NULL,                                -- Hangi kullanıcı
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5), -- 1-5 arası zorunlu
    Comment NVARCHAR(MAX) NULL,                         -- Yorum metni (opsiyonel)
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Yorum zamanı (UTC)
    CONSTRAINT FK_Reviews_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID),
    CONSTRAINT FK_Reviews_Users
        FOREIGN KEY (UserID)
        REFERENCES dbo.Users(UserID)
);
GO

-- Carts: Sepet başlığı (UserID UNIQUE -> her kullanıcıya tek sepet)
-- UNIQUE(UserID):
-- - Bir kullanıcı için yalnızca bir Cart kaydı olmasını sağlar.
-- - Uygulama tarafında "sepet oluştur/varsa getir" senaryosunu kolaylaştırır.
CREATE TABLE dbo.Carts (
    CartID INT IDENTITY(1,1) PRIMARY KEY,               -- Sepet PK
    UserID INT NOT NULL UNIQUE,                         -- Sepetin sahibi; kullanıcı başına tek sepet
    CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(), -- Sepetin oluşturulma zamanı (UTC)
    CONSTRAINT FK_Carts_Users
        FOREIGN KEY (UserID)
        REFERENCES dbo.Users(UserID)
);
GO

-- CartItems: Sepetteki ürünler (ürün + adet)
CREATE TABLE dbo.CartItems (
    CartItemID INT IDENTITY(1,1) PRIMARY KEY,           -- Sepet kalemi PK
    CartID INT NOT NULL,                                -- Hangi sepet
    ProductID INT NOT NULL,                             -- Hangi ürün
    Quantity INT NOT NULL DEFAULT 1,                    -- Adet
    CONSTRAINT FK_CartItems_Carts
        FOREIGN KEY (CartID)
        REFERENCES dbo.Carts(CartID),
    CONSTRAINT FK_CartItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);
GO
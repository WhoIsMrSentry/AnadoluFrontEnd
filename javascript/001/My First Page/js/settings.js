 // ==================== HARICI JAVASCRIPT DOSYASI ====================
// Bu dosya HTML sayfasından çağrılarak çalıştırılır
// HTML dosyasında <script src="js/settings.js"></script> şeklinde bağlanır

// ==================== DOCUMENT.WRITE() FONKSİYONU ====================
// document.write(): HTML sayfasına doğrudan içerik yazdırır
// ⚠️ UYARI: Modern web geliştirmede kullanımı önerilmez
// Sayfa yüklendikten sonra kullanılırsa tüm sayfa içeriğini siler
document.write("This is my first JavaScript code!");

// ==================== KONSOL FONKSİYONLARI ====================
// Geliştirici araçlarında (F12) Console sekmesinde görünür
// Hata ayıklama (debugging) ve test için kullanılır

// console.log(): Normal mesaj - beyaz/siyah renkte
console.log("Hello, World!");

// console.error(): Hata mesajı - kırmızı renkte ve hata ikonu ile
console.error("This is an error message");

// console.warn(): Uyarı mesajı - sarı/turuncu renkte ve uyarı ikonu ile  
console.warn("This is a warning message");

// console.info(): Bilgi mesajı - mavi renkte ve bilgi ikonu ile
console.info("This is an info message");

// ==================== KULLANICI ETKİLEŞİMİ ====================
// alert(): Kullanıcıya popup mesaj gösterir - OK butonu ile kapatılır
// Sayfa etkileşimini durdurur (blocking)
alert("This is an alert message");

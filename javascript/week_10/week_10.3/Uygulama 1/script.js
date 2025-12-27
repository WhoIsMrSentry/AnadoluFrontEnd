// Amaç: 1-100 arası rastgele sayı tutma ve kullanıcı tahmin ettikçe yönlendirme.

// Math.random(): 0<=x<1 üretir. 100 ile çarparak 0<=x<100 yaparız.
// parseInt ile ondalık kısmı atıp 0..99 elde edilir.
// +1 ekleyerek aralığı 1..100 yaparız.
// Not: parseInt yerine Math.floor daha yaygın kullanılır; burada mantığı göstermek için parseInt kullanıldı.
var rastgeleSayi = parseInt(Math.random() * 100) + 1;

// Kullanıcıya (debug amaçlı) tutulan sayıyı gösteriyoruz.
alert("Rastgele sayı: " + rastgeleSayi);

// tahmin: kullanıcının girdiği sayı
// fark: tutulan sayı ile tahmin arasındaki mutlak fark
var tahmin, fark;

// do...while: En az 1 kere çalıştırıp sonra koşulu kontrol eder.
// Neden: Kullanıcıdan en az bir tahmin almak istiyoruz.
do {
    // prompt her zaman string döndürür; parseInt ile tam sayıya çeviriyoruz.
    tahmin = parseInt(prompt("1 ile 100 arasında bir sayı tahmin edin:"));

    // Hatalı giriş kontrolü:
    // - sayı değilse isNaN(...) true olur
    // - aralık dışıysa kabul etmeyiz
    if (tahmin < 1 || tahmin > 100 || isNaN(tahmin)) {
        alert("Lütfen 1 ile 100 arasında geçerli bir sayı girin.");
        // continue: döngünün bu turunu bitirir, başa döner (yeni tahmin ister)
        continue;
    }

    // Math.abs: mutlak değer. Aradaki uzaklığı pozitif olarak hesaplamak için.
    fark = Math.abs(rastgeleSayi - tahmin);

    // ===: hem değer hem tip eşitliği (burada tam sayı karşılaştırması yapıyoruz)
    if (fark === 0) {
        alert("Tebrikler! Doğru tahmin ettiniz: " + rastgeleSayi);
    } else if (fark <= 5) {
        alert("Çok yakınsınız!");
    } else if (fark <= 15) {
        alert("Yaklaştınız!");
    } else {
        alert("Uzak kaldınız! ");
    }
    
// Koşul: fark 0 olmadıkça devam et (doğru tahmin edilene kadar)
} while (fark !== 0);
var rastgeleSayi = parseInt(Math.random() * 100) + 1;
alert("Rastgele sayı: " + rastgeleSayi);

var tahmin, fark;

do {
    tahmin = parseInt(prompt("1 ile 100 arasında bir sayı tahmin edin:"));

    if (tahmin < 1 || tahmin > 100 || isNaN(tahmin)) {
        alert("Lütfen 1 ile 100 arasında geçerli bir sayı girin.");
        continue;
    }

    fark = Math.abs(rastgeleSayi - tahmin);

    if (fark === 0) {
        alert("Tebrikler! Doğru tahmin ettiniz: " + rastgeleSayi);
    } else if (fark <= 5) {
        alert("Çok yakınsınız!");
    } else if (fark <= 15) {
        alert("Yaklaştınız!");
    } else {
        alert("Uzak kaldınız! ");
    }
    
} while (fark !== 0);
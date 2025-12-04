var i = 0;
// while(true) sonsuz döngüdür; break ile uygun zamanda çıkış yapılır.
while (true) {
    // i değeri 3'ten küçükse "Merhaba" yazdır ve i'yi artır.
    if (i < 3) {
        console.log("Merhaba");
        i++;
    } else {
        // i artık 3 veya daha büyük olduğunda döngüyü sonlandır.
        break;
    }
}



do {
    // do-while: Önce bir kez çalışır, sonra koşula bakar. Bu yüzden en az bir kez log basar.
    console.log(i);
}
while (i < 3);





// for yapısı: (başlangıç; koşul; artış)
for (var i = 0; i <= 3; i++) {
    console.log(i);
}




var i = 0;
// var değişkenleri fonksiyon kapsamlıdır (function-scoped); blok kapsamı yoktur.
// Modern JS'te let/const tercih edilir (block-scoped), eğitim amacıyla var kullanıldı.
for (i = 1; i <= 3; i++) {
    console.log("i: " + i);
}




console.log("i döngüsü bitti yeni j döngüsü başlıyor");



for (var i = 0; i <= 2; i++) {
    console.log("i: " + i);
    // İç içe döngü: her i değeri için j 0'dan 3'e kadar döner.
    for (var j = 0; j <= 3; j++) {
        console.log("j: " + j);
    }
    console.log("Döngü bitti");
}




// 24 saatlik döngü: 0-23 arası her saat için çalışır
for (var saat = 0; saat <= 23; saat++) {
    // Her saat içinde 60 dakika döngüsü: 0-59 arası
    for (var dakika = 0; dakika < 60; dakika++) {
        // Önce özel durumları kontrol et
        // 12:00'da ara verme durumu
        if (saat == 12 && dakika == 0) {
            console.log("Saat 12:00 - Derse ara verildi");
            // continue: Bu adımı atla, bir sonraki dakikaya geç
            continue;
        } 
        // 13:00'da ders bitiş durumu
        else if (saat == 13 && dakika == 0) {
            console.log("Saat 13:00 - Ders bitti");
            // break: İç döngüyü (dakika döngüsünü) sonlandır
            break;
        }
        // Saat ve dakika formatını oluştur (sıfır doldurma ile)
        // padStart(2, '0'): Sayıyı 2 haneli yapar, eksikse başına '0' ekler
        const hh = String(saat).padStart(2, '0');
        const mm = String(dakika).padStart(2, '0');
        // Template literal kullanarak formatlı çıktı
        console.log(`saat ${hh}:${mm}`);
    }
    // 13:00'da tamamen dur
    // Dış döngüyü (saat döngüsünü) sonlandır
    if (saat == 13) {
        break;
    }
}


// Ek Notlar:
// - break: İçinde bulunduğu döngüyü anında bitirir.
// - continue: Döngünün o adımını atlayıp bir sonraki adıma geçer (bu dosyada örneği yok).
// - Modern yaklaşım: String(i).padStart(2, '0') kullanarak sıfır doldurma yapılabilir.

// Saat formatını yazdırmak için modern bir yaklaşım

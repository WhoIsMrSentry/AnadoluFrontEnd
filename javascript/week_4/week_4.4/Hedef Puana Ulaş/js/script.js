/*
    Hedef: 100 puana ulaşana kadar soruları cevapla. 3 yanlış yaparsan oyun biter.
    Puanlama:
    - Doğru cevap: +20 puan
    - Yanlış cevap: -5 puan (puan 0'ın altına düşmez)
    Döngü:
    - Sorular sırayla döner, sona gelince başa sarar.
*/


/////////////////////////////////////////////////////////////////////////////////////////////////////////


// Puanı, yanlış sayısını ve sıra numarasını tutan değişkenler
var puan = 0;
var yanlis = 0;
var i = 0;

// Sorular ve doğru cevaplarını küçük harfle saklayalım (karşılaştırma kolaylığı için)
var sorular = [
    { soru: "Türkiye'nin başkenti neresidir?", cevap: "ankara" },
    { soru: "Atatürk kaç yılında doğmuştur?", cevap: "1881" },
    { soru: "Ankara'nın plaka kodu kaçtır?", cevap: "06" },
    { soru: "Türkiye'nin en büyük gölü hangisidir?", cevap: "tuz gölü" },
    { soru: "Türkiye'nin en uzun nehri hangisidir?", cevap: "kızılırmak" }
];


/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Hedefe ulaşmadıkça ve 3 yanlıştan az yaptıkça oyuna devam et
while (puan < 100 && yanlis < 3) {
    var aktif = sorular[i];
    // Kullanıcıdan cevabı al (boşluk ve büyük/küçük harf farklarını temizleyeceğiz)
    var girdi = prompt("Puan: " + puan + " | Yanlış: " + yanlis + "\n" + aktif.soru);

    if (girdi && girdi.toLowerCase().trim() === aktif.cevap) {
        // Doğru cevap: puanı artır
        puan += 20;
        alert("Doğru! Puan: " + puan);
    } else {
        // Yanlış cevap: yanlış sayısını artır, puandan 5 düş; puan negatif olmasın
        yanlis++;
        puan -= 5;
        if (puan < 0) puan = 0;
        alert("Yanlış! Doğru cevap: " + aktif.cevap + "\nPuan: " + puan);
    }

    // Sonraki soruya geç; sona gelirse başa sar
    i = (i + 1) % sorular.length;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// Oyun sonucu
if (puan >= 100) {
    alert("Tebrikler! 100 puana ulaştınız. Yanlış: " + yanlis);
} else {
    alert("3 yanlış yaptınız. Oyun bitti. Puan: " + puan);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

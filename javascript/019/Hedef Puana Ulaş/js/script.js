var puan = 0;
var yanlis = 0;
var i = 0;

var sorular = [
    { soru: "Türkiye'nin başkenti neresidir?", cevap: "ankara" },
    { soru: "Atatürk kaç yılında doğmuştur?", cevap: "1881" },
    { soru: "Ankara'nın plaka kodu kaçtır?", cevap: "06" },
    { soru: "Türkiye'nin en büyük gölü hangisidir?", cevap: "tuz gölü" },
    { soru: "Türkiye'nin en uzun nehri hangisidir?", cevap: "kızılırmak" }
];

while (puan < 100 && yanlis < 3) {
    var aktif = sorular[i];
    var girdi = prompt("Puan: " + puan + " | Yanlış: " + yanlis + "\n" + aktif.soru);

    if (girdi && girdi.toLowerCase().trim() === aktif.cevap) {
        puan += 20;
        alert("Doğru! Puan: " + puan);
    } else {
        yanlis++;
        puan -= 5;
        if (puan < 0) puan = 0;
        alert("Yanlış! Doğru cevap: " + aktif.cevap + "\nPuan: " + puan);
    }

    i = (i + 1) % sorular.length;
}

if (puan >= 100) {
    alert("Tebrikler! 100 puana ulaştınız. Yanlış: " + yanlis);
} else {
    alert("3 yanlış yaptınız. Oyun bitti. Puan: " + puan);
}

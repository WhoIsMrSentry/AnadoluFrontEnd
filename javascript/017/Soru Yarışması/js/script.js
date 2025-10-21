var puan = 0;
var soruSayısı = 3;

alert("Oyuna Hoşgeldiniz!");
alert(soruSayısı + " soruluk bir bilgi yarışması oynayacağız. Her doğru cevap için 10 puan kazanacaksınız.");

for (var i = 1; i <= soruSayısı; i++) {
    console.log(i + ". soru:");

    var soru = "";
    var dogruCevap = 0;

    if (i === 1) {
        soru = "5+3 = ? kaçtır?";
        dogruCevap = 8;
    }
    else if (i === 2) {
        soru = "20+10 = ? kaçtır?";
        dogruCevap = 30;
    }
    else if (i === 3) {
        soru = "15+5 = ? kaçtır?";
        dogruCevap = 20;
    }

    var cevap = prompt("Puanınız: " + puan + " - Soru " + i + "/ " + soruSayısı + ":  " + soru);
    cevap = Number(cevap);

    if (cevap === dogruCevap) {
        puan += 10;
        alert("Doğru! Puanınız: " + puan);
    } else {
        alert("Yanlış! Doğru cevap: " + dogruCevap + ". Puanınız: " + puan);
    }
}

alert("Oyun bitti! Toplam puanınız: " + puan);

if (puan === soruSayısı * 10) {
    alert("Mükemmel! Tüm soruları doğru cevapladınız.");
}
else if (puan >= (soruSayısı * 10) / 2) {
    alert("Tebrikler! İyi bir performans sergilediniz.");
}
else {
    alert("Daha iyi şanslar! Bir dahaki sefere daha dikkatli olun.");
}
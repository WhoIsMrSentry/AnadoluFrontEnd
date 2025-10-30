/*
    Bu oyun, 3 sorudan oluşan basit bir bilgi yarışmasıdır.
    Kurallar:
    - Her doğru cevap 10 puan kazandırır.
    - Yanlış cevapta puan değişmez (bu örnekte ceza yoktur).
    - En sonunda toplam puanınız gösterilir ve durum değerlendirilebilir.
*/

// Oyuncunun puanını ve toplam soru sayısını tutarız
var puan = 0;
var soruSayısı = 3;


/////////////////////////////////////////////////////////////////////////////////////////////////////////


// Oyuna giriş mesajları
alert("Oyuna Hoşgeldiniz!");
alert(soruSayısı + " soruluk bir bilgi yarışması oynayacağız. Her doğru cevap için 10 puan kazanacaksınız.");

// Tüm soruları sırayla soralım
for (var i = 1; i <= soruSayısı; i++) {
    console.log(i + ". soru:");

    var soru = "";
    var dogruCevap = 0;

    // Hangi soru ise, metni ve doğru cevabı belirle
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

    /////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Kullanıcıdan cevabı iste (prompt metin döndürür, sayıya çeviriyoruz)
    var cevap = prompt("Puanınız: " + puan + " - Soru " + i + "/ " + soruSayısı + ":  " + soru);
    cevap = Number(cevap);

    if (cevap === dogruCevap) {
        // Doğruysa 10 puan ekle ve kullanıcıyı bilgilendir
        puan += 10;
        alert("Doğru! Puanınız: " + puan);
    } else {
        // Yanlışsa doğrunun ne olduğunu göster (puan değişmez)
        alert("Yanlış! Doğru cevap: " + dogruCevap + ". Puanınız: " + puan);
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Yarışma bitti: son puanı göster
alert("Oyun bitti! Toplam puanınız: " + puan);

// Basit değerlendirme
if (puan === soruSayısı * 10) {
    alert("Mükemmel! Tüm soruları doğru cevapladınız.");
}
else if (puan >= (soruSayısı * 10) / 2) {
    alert("Tebrikler! İyi bir performans sergilediniz.");
}
else {
    alert("Daha iyi şanslar! Bir dahaki sefere daha dikkatli olun.");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
    Bu küçük oyun, 5 adet basit matematik sorusundan oluşan mini bir bilgi yarışmasıdır.
    Amaç: Her doğru cevapta 10 puan kazanmak. Yanlış cevapta puandan 10 düşülür.
    Nasıl çalışır?
    1) Puan sıfırdan başlar.
    2) Her soru için sizden cevap istenir (prompt ile).
    3) Cevap doğruysa puan +10, yanlışsa puan -10 olur ve bilgi verilir (alert ile).
    4) En sonunda toplam puanınız gösterilir ve kısa bir değerlendirme yapılır.
*/


/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Başlangıç puanını tutan değişken
var puan = 0;

// Oyuncuya oyunu anlatalım
alert("Oyuna Hoşgeldiniz!");
alert("5 soruluk bir bilgi yarışması oynayacağız. Her doğru cevap için 10 puan kazanacaksınız.");

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// 1. Soru: Kullanıcıdan cevap alıyoruz (prompt her zaman metin döndürür, bu yüzden Number ile sayıya çeviriyoruz)
var cevap1 = prompt("Soru 1 : 3+5 kaç eder?");
cevap1 = Number(cevap1);
if (cevap1 === 8) {
    // Doğru cevap: puanı 10 artır
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    // Yanlış cevap: puanı 10 azalt
    puan = puan - 10;
    alert("Maalesef yanlış cevap. Doğru cevap 8'dir. Puanınız: " + puan);
    
}
console.log("1. soru tamamlandı. Puanınız: " + puan);

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// 2. Soru
var cevap2 = prompt("Soru 2 : 12+7 kaç eder?");
cevap2 = Number(cevap2);
if (cevap2 === 19) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    puan = puan - 10;
    alert("Maalesef yanlış cevap. Doğru cevap 19'dur. Puanınız: " + puan);
}
console.log("2. soru tamamlandı. Puanınız: " + puan);

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// 3. Soru
var cevap3 = prompt("Soru 3 : 20+15 kaç eder?");
cevap3 = Number(cevap3);
if (cevap3 === 35) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    puan = puan - 10;
    alert("Maalesef yanlış cevap. Doğru cevap 35'tir. Puanınız: " + puan);
}
console.log("3. soru tamamlandı. Puanınız: " + puan);

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// 4. Soru
var cevap4 = prompt("Soru 4 : 50+25 kaç eder?");
cevap4 = Number(cevap4);
if (cevap4 === 75) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    puan = puan - 10;
    alert("Maalesef yanlış cevap. Doğru cevap 75'tir. Puanınız: " + puan);
}
console.log("4. soru tamamlandı. Puanınız: " + puan);

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// 5. Soru
var cevap5 = prompt("Soru 5 : 100+150 kaç eder?");
cevap5 = Number(cevap5);
if (cevap5 === 250) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    puan = puan - 10;
    alert("Maalesef yanlış cevap. Doğru cevap 250'dir. Puanınız: " + puan);
}
console.log("5. soru tamamlandı. Puanınız: " + puan);

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// Yarışma bittiğinde son puanı hem ekranda hem de konsolda gösterelim
alert("Yarışma bitti! Toplam puanınız: " + puan);
console.log("Yarışma tamamlandı. Toplam puanınız: " + puan);

// Toplam puana göre kısa bir değerlendirme mesajı göster
if (puan >= 50) {
    alert("Mükemmel! Tüm soruları doğru cevapladınız.");
} else if (puan >= 40) {
    alert("1 soruyu yanlış cevapladınız. Çok iyi!");
}
else if (puan >= 30) {
    alert("2 soruyu yanlış cevapladınız. İyi!");
}
else if (puan >= 20) {
    alert("3 soruyu yanlış cevapladınız. Fena değil.");
}
else if (puan >= 10) {
    alert("4 soruyu yanlış cevapladınız. Daha iyi olabilirdi.");
}
else {
    alert("Maalesef tüm soruları yanlış cevapladınız. Tekrar deneyin.");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

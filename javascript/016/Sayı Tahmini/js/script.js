var puan = 0;
alert("Oyuna Hoşgeldiniz!");
alert("5 soruluk bir bilgi yarışması oynayacağız. Her doğru cevap için 10 puan kazanacaksınız.");
var cevap1 = prompt("Soru 1 : 3+5 kaç eder?");
cevap1 = Number(cevap1);
if (cevap1 === 8) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    alert("Maalesef yanlış cevap. Doğru cevap 8'dir. Puanınız: " + puan);
    puan = puan - 10;
}
console.log("1. soru tamamlandı. Puanınız: " + puan);


var cevap2 = prompt("Soru 2 : 12+7 kaç eder?");
cevap2 = Number(cevap2);
if (cevap2 === 19) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    alert("Maalesef yanlış cevap. Doğru cevap 19'dur. Puanınız: " + puan);
    puan = puan - 10;
}
console.log("2. soru tamamlandı. Puanınız: " + puan);


var cevap3 = prompt("Soru 3 : 20+15 kaç eder?");
cevap3 = Number(cevap3);
if (cevap3 === 35) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    alert("Maalesef yanlış cevap. Doğru cevap 35'tir. Puanınız: " + puan);
    puan = puan - 10;
}
console.log("3. soru tamamlandı. Puanınız: " + puan);

var cevap4 = prompt("Soru 4 : 50+25 kaç eder?");
cevap4 = Number(cevap4);
if (cevap4 === 75) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    alert("Maalesef yanlış cevap. Doğru cevap 75'tir. Puanınız: " + puan);
    puan = puan - 10;
}
console.log("4. soru tamamlandı. Puanınız: " + puan);


var cevap5 = prompt("Soru 5 : 100+150 kaç eder?");
cevap5 = Number(cevap5);
if (cevap5 === 250) {
    puan = puan + 10;
    alert("Tebrikler! Doğru cevap. Puanınız: " + puan);
} else {
    alert("Maalesef yanlış cevap. Doğru cevap 250'dir. Puanınız: " + puan);
    puan = puan - 10;
}
console.log("5. soru tamamlandı. Puanınız: " + puan);

alert("Yarışma bitti! Toplam puanınız: " + puan);
console.log("Yarışma tamamlandı. Toplam puanınız: " + puan);

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
var vize = prompt("Vize Notunuzu Girin:");
var final = prompt("Final Notunuzu Girin:");
var quiz = prompt("Quiz Notunuzu Girin:");
var devamsızlık = prompt("Devamsızlık Yüzdesini Girin:");

var vizeNotu = Number(vize);
var finalNotu = Number(final);
var quizNotu = Number(quiz);    

var ortalama = (vizeNotu * 0.4) + (finalNotu * 0.6) + (quizNotu * 0.2) - (devamsızlık * 0.1);
console.log("Vize Notunuz:", vizeNotu);
console.log("Final Notunuz:", finalNotu);
console.log("Quiz Notunuz:", quizNotu);
console.log("Devamsızlık Yüzdesi:", devamsızlık);   
console.log("Ortalama Notunuz:", ortalama);

if (ortalama < 40 ) {
    console.log("FF ile Kaldınız");}
else if (ortalama >= 41 && ortalama <= 49) {
    console.log("DD Koşullu Geçtiniz");
}else if (ortalama >= 50 && ortalama <= 64) {
    console.log("CC ile Geçtiniz");
}else if (ortalama >= 65 && ortalama <= 84) {
    console.log("BB ile Geçtiniz");
}else if (ortalama >= 85 && ortalama <= 100) {
    console.log("AA ile Geçtiniz");
}else {
    console.log("Geçersiz Not Girdiniz");
}
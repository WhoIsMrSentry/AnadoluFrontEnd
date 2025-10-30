// Kullanıcıdan sayısal değerler ve bir metin alınır
var deger = prompt("deger1 girin", "örnek 5");
var deger2 = prompt("deger2 girin", "örnek 3");
var metin = prompt("metin girin");

// String -> Number dönüşümü
var sayi1 = Number(deger);
var sayi2 = Number(deger2);

console.log("Toplam:", sayi1 + sayi2);
console.log("Fark:", sayi1 - sayi2);
console.log("Çarpım:", sayi1 * sayi2);
console.log("Bölüm:", sayi1 / sayi2);
console.log("Mod:", sayi1 % sayi2);

// Number -> String dönüşümü ve string işlemler
var s1 = String(deger);
var s2 = String(deger2);

console.log("Toplam (string birleştirme):", s1 + s2);
console.log("Fark:", s1 - s2);       // sayı gibi davranır -> Number(s1) - Number(s2)
console.log("Çarpım:", s1 * s2);
console.log("Bölüm:", s1 / s2);
console.log("Mod:", s1 % s2);

// Üs alma ve bileşik atamalar
var n1 = Number(deger);
var n2 = Number(deger2);
console.log("n1^2:", n1 ** 2);
console.log("n2^2:", n2 ** 2);

n2 += 5; // n2 = n2 + 5
console.log("n2 += 5:", n2);

n2 *= 2; // n2 = n2 * 2
console.log("n2 *= 2:", n2);

n2 %= 4; // n2 = n2 % 4
console.log("n2 %= 4:", n2);

// Farklı türlere dönüştürme örnekleri
metin = Number(metin);
console.log("Number(metin):", metin);

var bool = Boolean(metin);
console.log("Boolean(metin):", bool);

console.log(typeof metin); // number veya NaN (NaN de number türündedir)
console.log(typeof bool);  // boolean
console.log(typeof n1);    // number
console.log(typeof n2);    // number

// Operatör önceliği: bölme önce yapılır
console.log(n1 + n2 / 2);

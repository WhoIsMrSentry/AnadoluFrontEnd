// Kullanıcıdan iki değer alırız; prompt her zaman string döndürür
let deger = prompt("deger1 girin", "örnek 5");
let deger2 = prompt("deger2 girin", "örnek 3");

// String değerleri sayıya dönüştürüp aritmetik işlemler yapıyoruz
let sayi1 = Number(deger);
let sayi2 = Number(deger2);

console.log("Toplam:", sayi1 + sayi2);
console.log("Fark:", sayi1 - sayi2);
console.log("Çarpım:", sayi1 * sayi2);
console.log("Bölüm:", sayi1 / sayi2);
console.log("Mod:", sayi1 % sayi2);

// Bu kısım string karşılaştırması yapar; sayısal değil, sözlük sırasına göre
console.log(deger > deger2);
console.log(deger < deger2);
console.log(deger == deger2);
console.log(deger != deger2);
console.log(deger === deger2);

// Artırma/azaltma örnekleri (dikkat: deger/deger2 string iken otomatik dönüşüm etkileyebilir)
deger++;
console.log("deger++:", deger);
deger2++;
console.log("deger2++:", deger2);

deger--;
console.log("deger--:", deger);
deger2--;
console.log("deger2--:", deger2);

let deger3 = prompt("deger3 girin", "örnek 7");

// Tekrar stringe çevirme ve toplama örneği
let sayı1 = String(deger);
let sayı2 = String(deger2);
let sayı3 = Number(deger3);

console.log("Toplam:", sayı1 + sayı2 + sayı3);

// Burada + operatörü string birleştirme yapar, bu yüzden ortalama beklediğiniz gibi olmayabilir
let ortalama = (sayı1 + sayı2 + sayı3) / 3;
console.log("Ortalama:", ortalama);

if (confirm("Ortalama yazılsın mı?")) {
    alert("Ortalama: " + ortalama);
}

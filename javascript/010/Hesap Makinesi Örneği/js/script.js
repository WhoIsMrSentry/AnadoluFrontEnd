// Kullanıcıdan iki sayı ve bir işlem türü al
var deger = prompt("Sayı 1 girin", "örnek 5");
var deger2 = prompt("Sayı 2 girin", "örnek 3");

var islem = prompt("işlem girin", "örnek + - * / %");

console.log("Sayı 1:", deger);
console.log("Sayı 2:", deger2);
console.log("İşlem:", islem);

// String'ten sayıya dönüştürme
var sayi1 = Number(deger);
var sayi2 = Number(deger2);

// İşlem türüne göre sonucu hesapla
if (islem === "+") {
    sonuc = sayi1 + sayi2;
}

else if (islem === "-") {
    sonuc = sayi1 - sayi2;
}

else if (islem === "*") {
    sonuc = sayi1 * sayi2;
}

else if (islem === "/") {
    sonuc = sayi1 / sayi2;
}
else if (islem === "%") {
    sonuc = sayi1 % sayi2;
}

console.log(islem + " " + "işlemi" + " " + "Sonucu:", sonuc);

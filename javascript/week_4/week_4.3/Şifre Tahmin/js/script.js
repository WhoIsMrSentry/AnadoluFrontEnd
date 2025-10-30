/*
    Bu küçük uygulama, kullanıcıdan bir şifre tahmini ister.
    Kurallar:
    - Doğru şifre: 12345
    - Toplam 3 deneme hakkı vardır.
    - Her yanlış denemede kalan hak bir azalır.
    - Doğru tahmin edilirse tebrik mesajı, hakkı biterse uyarı mesajı gösterilir.
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Doğru şifreyi ve kalan deneme hakkını tanımlayalım
var sifre = "12345";
var hak = 3;

// İlk tahmini kullanıcıdan al
var tahmin = prompt("Şifreyi tahmin ediniz:");

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Tahmin yanlış olduğu sürece ve en az 1 hakkımız daha varken denemeye devam et
while (tahmin !== sifre && hak > 1) {
    hak--; // Yanlış denemede hak bir azalır
    tahmin = prompt("Yanlış şifre. Kalan hakkınız: " + hak + "\nTekrar deneyiniz:");
}
// Döngü bittiğinde doğru bildiysek tebrik edelim; yoksa üzücü haberi verelim
if (tahmin === sifre) {
    alert("Tebrikler, şifre doğru!");
}
else {
    alert("Üzgünüm, şifre yanlış.");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

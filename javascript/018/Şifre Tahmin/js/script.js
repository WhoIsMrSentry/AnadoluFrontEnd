var sifre = "12345";
var hak = 3;
var tahmin = prompt("Şifreyi tahmin ediniz:");

while (tahmin !== sifre && hak > 1) {
    hak--;
    tahmin = prompt("Yanlış şifre. Kalan hakkınız: " + hak + "\nTekrar deneyiniz:");
}
if (tahmin === sifre) {
    alert("Tebrikler, şifre doğru!");
}
else {
    alert("Üzgünüm, şifre yanlış.");
}

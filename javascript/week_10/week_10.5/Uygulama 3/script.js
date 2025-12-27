// Amaç: Kullanıcıdan alınan bir değeri sayı olarak yorumlama ve temel kontroller.

// prompt ile gelen her değer stringdir.
// Neden: kullanıcı klavyeden metin girer; JS bunu string olarak döndürür.
var userInput = prompt("Lütfen bir sayı giriniz:");

// typeof: değişkenin tipini verir.
// Burada userInput'in string olduğunu göstermek için.
var inputType = typeof userInput;
alert("Girdiğiniz değerin tipi: " + inputType);

// String'i sayıya çevirme:
// parseInt: tam sayı okur (ondalık varsa atar)
// parseFloat: ondalıklı sayıyı da okur
// Neden: kullanıcı "12.5" girerse parseInt 12 döndürür, parseFloat 12.5 döndürür.
var intNumber = parseInt(userInput);
var floatNumber = parseFloat(userInput);
alert("Tam sayı olarak: " + intNumber);
alert("Ondalıklı sayı olarak: " + floatNumber);

// isNaN(x): x NaN mi?
// Eğer hem intNumber hem floatNumber NaN ise kullanıcı sayı girmemiş demektir.
if (isNaN(intNumber) && isNaN(floatNumber)) {
    alert("Girdiğiniz değer geçerli bir sayı değil.");
}
else {
    alert("Girdiğiniz değer geçerli bir sayıdır.");
}

// Sayı geçerliyse Math fonksiyonlarını göstermek:
// Math.round: en yakına yuvarlar
// Math.ceil: yukarı yuvarlar
// Math.floor: aşağı yuvarlar
// Math.random: 0<=x<1 rastgele sayı
if (!isNaN(floatNumber)) {
    alert("Yuvarlanmış sayı (Math.round): " + Math.round(floatNumber));
    alert("Yukarı yuvarlanmış sayı (Math.ceil): " + Math.ceil(floatNumber));
    alert("Aşağı yuvarlanmış sayı (Math.floor): " + Math.floor(floatNumber));
    alert("0 ile 1 arasında rastgele sayı (Math.random): " + Math.random());
}

// Pozitif / negatif / sıfır kontrolü
// Neden: koşul ifadeleri ve sayının işaretini belirleme pratiği.
if (!isNaN(floatNumber)) {
    if (floatNumber > 0) {
        alert("Girdiğiniz sayı pozitiftir.");
    } else if (floatNumber < 0) {
        alert("Girdiğiniz sayı negatiftir.");
    } else {
        alert("Girdiğiniz sayı sıfırdır.");
    }
}


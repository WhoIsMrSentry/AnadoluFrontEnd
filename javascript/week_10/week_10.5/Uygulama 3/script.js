//kullanıcıdan bir sayı alacağız (prompt ile gelen her değer stringdir)
var userInput = prompt("Lütfen bir sayı giriniz:");

//veri tipini kontrol edeceğiz (typeof ile)
var inputType = typeof userInput;
alert("Girdiğiniz değerin tipi: " + inputType);

//stringi sayıya çevireceğiz (parseInt ve parseFloat ile)
var intNumber = parseInt(userInput);
var floatNumber = parseFloat(userInput);
alert("Tam sayı olarak: " + intNumber);
alert("Ondalıklı sayı olarak: " + floatNumber);

//sayının geçerli olup olmadığını kontrol edeceğiz (isNaN ile)
if (isNaN(intNumber) && isNaN(floatNumber)) {
    alert("Girdiğiniz değer geçerli bir sayı değil.");
}
else {
    alert("Girdiğiniz değer geçerli bir sayıdır.");
}

//sayı geçerliyse math fonksiyonlarını kullanacağız (Math.round, Math.ceil, Math.floor, Math.random)
if (!isNaN(floatNumber)) {
    alert("Yuvarlanmış sayı (Math.round): " + Math.round(floatNumber));
    alert("Yukarı yuvarlanmış sayı (Math.ceil): " + Math.ceil(floatNumber));
    alert("Aşağı yuvarlanmış sayı (Math.floor): " + Math.floor(floatNumber));
    alert("0 ile 1 arasında rastgele sayı (Math.random): " + Math.random());
}

//pozitif ve negatif sayı kontrolü yapacağız

if (!isNaN(floatNumber)) {
    if (floatNumber > 0) {
        alert("Girdiğiniz sayı pozitiftir.");
    } else if (floatNumber < 0) {
        alert("Girdiğiniz sayı negatiftir.");
    } else {
        alert("Girdiğiniz sayı sıfırdır.");
    }
}


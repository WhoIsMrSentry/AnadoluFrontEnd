// 10. Hafta - Ders 6: Uygulama 4
// Konu: Sayısal Dönüşümler ve Özel Değerler (Infinity, -Infinity, NaN)
// Not: Bu ders uygulama odaklıdır.
// sıfıra bölme işlemlerini test edeceğiz
console.log(1 / 0); // infinity
console.log(-1 / 0);
// infinity ve - infinity değerlerini göreceğiz

//Nan değerini inceleyeceğiz
console.log(0 / 0); // NaN

//NaN ile ilgili bazı özellikleri test edeceğiz
console.log(NaN === NaN); // false
console.log(isNaN(NaN)); // true

//farklı dönüştürme metodlarını karşılaştıracağız (parseInt, parseFloat, Number vs +)

console.log(Number("123abc")); // NaN
console.log(parseInt("123abc")); // 123
console.log(parseFloat("123.45abc")); // 123.45
console.log(+"123abc"); // NaN
console.log(+"123.45abc"); // NaN
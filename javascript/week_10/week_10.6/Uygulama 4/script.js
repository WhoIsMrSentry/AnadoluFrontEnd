// 10. Hafta - Ders 6: Uygulama 4
// Konu: Sayısal Dönüşümler ve Özel Değerler (Infinity, -Infinity, NaN)
// Not: Bu ders uygulama odaklıdır.

// console.log(...): sonucu tarayıcı konsolunda gösterir.
// Neden: alert gibi kullanıcıyı durdurmadan çıktıları incelemek.

// Sıfıra bölme işlemleri
// JS'te 1/0 hata vermez; Infinity (sonsuz) üretir.
console.log(1 / 0); // Infinity

// Negatif sayı sıfıra bölünürse -Infinity oluşur.
console.log(-1 / 0); // -Infinity

// 0/0 belirsiz bir işlemdir; sonuç NaN olur.
console.log(0 / 0); // NaN

// NaN'ın bazı özellikleri:
// NaN, kendisine bile eşit değildir.
console.log(NaN === NaN); // false
// isNaN(x): NaN kontrolü yapar.
console.log(isNaN(NaN)); // true

// Farklı dönüştürme metodlarını karşılaştırma
// Number(...): string'in tamamı sayı olmalı; değilse NaN
console.log(Number("123abc")); // NaN

// parseInt(...): baştan itibaren tam sayı okur; sayı bittiğinde durur.
console.log(parseInt("123abc")); // 123

// parseFloat(...): ondalıklı okuyabilir; sayı bittiğinde durur.
console.log(parseFloat("123.45abc")); // 123.45

// Unary plus (+): hızlı Number(...) dönüşümü; tüm string sayı değilse NaN.
console.log(+"123abc"); // NaN
console.log(+"123.45abc"); // NaN
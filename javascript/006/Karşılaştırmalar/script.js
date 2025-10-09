// Sayısal ve string karşılaştırmaları
var sayi = 3;
var sayi2 = 5;
var sayi3 = "3";

console.log(sayi > sayi2);  // false (3, 5'ten büyük değil)
console.log(sayi < sayi2);  // true
console.log(sayi >= sayi2); // false
console.log(sayi <= sayi2); // true
console.log(sayi == sayi2); // false (eşit değil)
console.log(sayi != sayi2); // true (eşit değil)
console.log(sayi == sayi3); // true (== tip dönüştürerek karşılaştırır)

// String karşılaştırmaları (Unicode/alfabetik sıraya göre)
var yazı = "A";
var yazı2 = "B";
console.log(yazı > yazı2); // false ("A" < "B")
console.log(yazı < yazı2); // true

console.log("Ahmet" > "Ali");  // false ("Ahm" < "Ali")
console.log("Ahmet" == "Ali"); // false
console.log("Ahmet" != "Ali"); // true

// Küçük/büyük harf karşılaştırması: küçük harfler genelde büyüklerden sonra gelir
console.log("ahmet" > "Ahmet"); // true olabilir ("a" > "A")
console.log("ahmet" < "Ahmet"); // false olabilir

// Eşitlik: == (gevşek) ve === (sıkı) farkı
console.log(0 == false);  // true (0, false'a dönüştürülebilir)
console.log(0 === false); // false (tipler farklı)

console.log(1 == true);   // true (1, true'a dönüştürülebilir)
console.log(1 === true);  // false (tipler farklı)

// null ve undefined özel durumu
console.log(null == undefined);  // true (özel kural)
console.log(null === undefined); // false (tipler farklı)
console.log(null > 1);           // false
console.log(null < 1);           // true (karşılaştırmada null -> 0 kabul edilir)
console.log(null == 0);          // false (eşitlikte özel kural devreye girer)

// Boş string ve false
console.log("" == false);  // true (boş string -> 0 -> false)
console.log("" === false); // false (tipler farklı)

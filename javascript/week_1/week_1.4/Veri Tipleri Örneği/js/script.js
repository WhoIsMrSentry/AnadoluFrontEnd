// Temel değişken tanımlamaları (string, number, boolean, null, undefined)
var isim = "Emir";          // string (metin)
var soyisim = "Hamurcu";    // string
var yas = 20;                // number (tam sayı)
var sehir = "Eskişehir";    // string
var durum = true;            // boolean (doğru)
var durum2 = false;          // boolean (yanlış)
var nullDeger = null;        // null (bilinçli olarak boş)
var tanimsizDeger;           // undefined (değer atanmamış)

// Template literal (backtick `) ile değişkenleri metin içine kolayca gömebiliriz
console.log(`Benim adım ${isim} ${soyisim} ve ben ${yas} yaşındayım. ${sehir} şehrinde yaşıyorum. 
Bu şehri seviyorum: ${durum} | Bu şehri sevmiyorum: ${durum2} | null değer: ${nullDeger} | tanımsız değer: ${tanimsizDeger}`);

// typeof operatörü: değişkenin veri tipini öğrenmek için kullanılır
console.log(typeof isim);      // "string"
console.log(typeof soyisim);   // "string"
console.log(typeof yas);       // "number"
console.log(typeof sehir);     // "string"
console.log(typeof durum);     // "boolean"
console.log(typeof durum2);    // "boolean"
console.log(typeof nullDeger); // DİKKAT: "object" döner (JS'in tarihi bir davranışı)
console.log(typeof tanimsizDeger); // "undefined"

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// 12. Hafta - Uygulama: Öğrenci / Not İşlemleri
// Amaç: Diziler üzerinde push/filter/indexOf/slice/sort/map ve döngü pratiği.
// Not: “isimler” ve “notlar” paralel dizidir; aynı index aynı öğrenciyi temsil eder.

var isimler = ["Ahmet", "Ayşe", "Mehmet", "Zeynep", "Can"];
var notlar = [85, 92, 78, 95, 67];

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Yeni öğrenci ekle (push)
// push: dizinin sonuna eleman ekler.
isimler.push("Elif");
notlar.push(88);
console.log("Güncel isimler:", isimler);
console.log("Güncel notlar:", notlar);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Geçen öğrenciler (70 ve üzeri)
// filter: şartı sağlayan elemanları seçip yeni dizi döndürür.
// Burada index kullanarak aynı index'teki notu kontrol ediyoruz.
var gecenOgrenciler = isimler.filter(function (_, index) {
	return notlar[index] >= 70;
});
console.log("Geçen öğrenciler:", gecenOgrenciler);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Not ortalaması (length)
// length: dizide kaç eleman olduğunu verir; ortalama hesabında bölen olarak kullanılır.
var toplam = 0;
for (var i = 0; i < notlar.length; i++) {
	toplam = toplam + notlar[i];
}
var ortalama = toplam / notlar.length;
console.log("Not ortalaması:", ortalama);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Belirli bir notun kaçıncı sırada olduğunu bul (indexOf)
// indexOf(x): x'in ilk bulunduğu index'i verir; yoksa -1 döner.
var arananNot = 78;
var arananIndex = notlar.indexOf(arananNot);
console.log("Aranan not", arananNot, "index:", arananIndex);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Notları büyükten küçüğe sırala (kopya dizi)
// slice(): dizinin kopyasını oluşturur (sort orijinali bozmasın diye).
// sort((a,b)=>b-a): sayısal büyükten küçüğe sıralama.
var siraliNotlar = notlar.slice().sort(function (a, b) { return b - a; });
console.log("Büyükten küçüğe sıralı notlar:", siraliNotlar);

// En yüksek ve en düşük not
var enYuksekNot = siraliNotlar[0];
var enDusukNot = siraliNotlar[siraliNotlar.length - 1];
console.log("En yüksek not:", enYuksekNot);
console.log("En düşük not:", enDusukNot);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Tüm notlara +5 bonus ekle (map)
// map: her elemanı dönüştürür ve yeni dizi döndürür.
var bonusluNotlar = notlar.map(function (deger) { return deger + 5; });
console.log("Bonuslu notlar:", bonusluNotlar);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Öğrenci not listesi (for...of)
// for...of: isimleri değer olarak gezer.
// idx: paralel dizide aynı index'teki notu okumak için artırılır.
var idx = 0;
for (var isim of isimler) {
	console.log(isim + " - " + notlar[idx]);
	idx++;
}

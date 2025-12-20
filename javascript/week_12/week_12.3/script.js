/////////////////////////////////////////////////////////////////////////////////////////////////////////

var isimler = ["Ahmet", "Ayşe", "Mehmet", "Zeynep", "Can"];
var notlar = [85, 92, 78, 95, 67];

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Yeni öğrenci ekle (push)
isimler.push("Elif");
notlar.push(88);
console.log("Güncel isimler:", isimler);
console.log("Güncel notlar:", notlar);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Geçen öğrenciler (70 ve üzeri)
var gecenOgrenciler = isimler.filter(function (_, index) {
	return notlar[index] >= 70;
});
console.log("Geçen öğrenciler:", gecenOgrenciler);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Not ortalaması (length)
var toplam = 0;
for (var i = 0; i < notlar.length; i++) {
	toplam = toplam + notlar[i];
}
var ortalama = toplam / notlar.length;
console.log("Not ortalaması:", ortalama);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Belirli bir notun kaçıncı sırada olduğunu bul (indexOf)
var arananNot = 78;
var arananIndex = notlar.indexOf(arananNot);
console.log("Aranan not", arananNot, "index:", arananIndex);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Notları büyükten küçüğe sırala (kopya dizi)
var siraliNotlar = notlar.slice().sort(function (a, b) { return b - a; });
console.log("Büyükten küçüğe sıralı notlar:", siraliNotlar);

// En yüksek ve en düşük not
var enYuksekNot = siraliNotlar[0];
var enDusukNot = siraliNotlar[siraliNotlar.length - 1];
console.log("En yüksek not:", enYuksekNot);
console.log("En düşük not:", enDusukNot);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Tüm notlara +5 bonus ekle (map)
var bonusluNotlar = notlar.map(function (deger) { return deger + 5; });
console.log("Bonuslu notlar:", bonusluNotlar);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Öğrenci not listesi (for...of)
var idx = 0;
for (var isim of isimler) {
	console.log(isim + " - " + notlar[idx]);
	idx++;
}

// Başlangıç verileri
var urunler = [
	{ isim: "Mouse", fiyat: 1200, stok: 10, kategori: "Aksesuar" },
	{ isim: "Klavye", fiyat: 1800, stok: 15, kategori: "Aksesuar" },
	{ isim: "Telefon", fiyat: 8000, stok: 8, kategori: "Elektronik" },
	{ isim: "Laptop", fiyat: 15000, stok: 5, kategori: "Elektronik" },
	{ isim: "Kulaklık", fiyat: 900, stok: 20, kategori: "Elektronik" }
];

var sepet = [];

console.log("--- E-TİCARET SEPET SİSTEMİ ---");

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sepete ürün ekle (push, find)
var eklenecekLaptop = urunler.find(function (u) { return u.isim === "Laptop"; });
var eklenecekKlavye = urunler.find(function (u) { return u.isim === "Klavye"; });
sepet.push(eklenecekLaptop);
sepet.push(eklenecekKlavye);
console.log("Sepete eklenenler:", sepet.map(function (u) { return u.isim; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sepetten ürün çıkar (splice, indexOf)
var silinecek = sepet.indexOf(eklenecekKlavye);
if (silinecek !== -1) {
	sepet.splice(silinecek, 1);
}
console.log("Sepet durumu:", sepet.map(function (u) { return u.isim; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sepet toplamı (length)
var toplamFiyat = 0;
for (var i = 0; i < sepet.length; i++) {
	toplamFiyat = toplamFiyat + sepet[i].fiyat;
}
console.log("Sepet toplamı:", toplamFiyat);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Kategoriye göre filtrele (filter)
var elektronik = urunler.filter(function (u) { return u.kategori === "Elektronik"; });
console.log("Elektronik kategorisi:", elektronik.map(function (u) { return u.isim; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fiyata göre sıralama (sort)
var fiyataGore = urunler.map(function (u) { return u; });
fiyataGore.sort(function (a, b) { return a.fiyat - b.fiyat; });
console.log("Fiyata göre artan sıralı ürünler:", fiyataGore.map(function (u) { return u.isim + " (" + u.fiyat + ")"; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// İndirim uygula (map)
var indirimli = urunler.map(function (u) {
	return { isim: u.isim, fiyat: Math.round(u.fiyat * 0.9), stok: u.stok, kategori: u.kategori };
});
console.log("%10 indirimli fiyatlar:", indirimli.map(function (u) { return u.isim + " (" + u.fiyat + ")"; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Stok kontrolü (filter)
var stoktaOlanlar = urunler.filter(function (u) { return u.stok > 0; });
console.log("Stokta olan ürünler:", stoktaOlanlar.map(function (u) { return u.isim; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Ürün ara (includes, filter)
var arananMetin = "lap";
var bulunanUrunler = urunler.filter(function (u) { return u.isim.toLowerCase().includes(arananMetin); });
console.log('"' + arananMetin + '" içeren ürünler:', bulunanUrunler.map(function (u) { return u.isim; }));

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Ürün listesini numara ile yaz (for..of, length)
var sira = 1;
for (var urun of urunler) {
	console.log(sira + ". " + urun.isim + " - " + urun.fiyat + " TL, Stok: " + urun.stok);
	sira++;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// İsimleri birleştir (map, join)
var urunIsimleri = urunler.map(function (u) { return u.isim; }).join(", ");
console.log("Tüm ürün isimleri:", urunIsimleri);

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Belirli fiyat aralığı (filter)
var minFiyat = 1000;
var maxFiyat = 10000;
var fiyatAraligi = urunler.filter(function (u) { return u.fiyat >= minFiyat && u.fiyat <= maxFiyat; });
console.log("Fiyat aralığı " + minFiyat + " - " + maxFiyat + ":", fiyatAraligi.map(function (u) { return u.isim + " (" + u.fiyat + ")"; }));

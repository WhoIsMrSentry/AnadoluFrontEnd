// 12. Hafta - Uygulama: Görev Listesi
// Amaç: prompt ile kullanıcıdan görev alıp dizi (array) içine eklemek ve temel array metotlarını kullanmak.
// Kullanılanlar:
// - push: sona ekler
// - shift: baştan siler
// - pop: sondan siler
// - length: eleman sayısı
// - for...of: listeleme
// - includes: içeriyor mu kontrolü
// Not: sort ile sıralama istenmiş; bu dosyada sıralama adımı yok (istersen ekleriz).

var gorevler = [];
while (true) {
    // prompt(...): kullanıcıdan giriş alır; dönüş her zaman string'dir.
    var ekle = prompt("Yeni görev eklemek istiyor musunuz? (evet/hayır)");
    // toLowerCase(): büyük/küçük harf farkını kaldırarak karşılaştırmayı kolaylaştırır.
    if (ekle.toLowerCase() !== "evet") {
        // break: döngüyü tamamen bitirir.
        break;
    }
    // Yeni görev metni alıyoruz.
    var yeniGorev = prompt("Bir görev girin:");
    // push(...): görevi dizinin sonuna ekler.
    gorevler.push(yeniGorev);
}

console.log(gorevler);

// shift(): ilk görevi kaldırır (dizi sola kayar).
gorevler.shift();
console.log(gorevler);

// pop(): son görevi kaldırır.
gorevler.pop();
console.log(gorevler);

// length: toplam görev sayısını verir.
console.log("Toplam görev sayısı: " + gorevler.length);

// for...of: dizinin elemanlarını değer olarak tek tek gezer.
for (var gorev of gorevler) {
    console.log(gorev);
}

// includes(x): dizide x var mı? true/false döndürür.
var kontrolGorev = prompt("Hangi görevi kontrol etmek istersiniz?");
if (gorevler.includes(kontrolGorev)) {
    console.log(kontrolGorev + " listede mevcut.");
}
else {
    console.log(kontrolGorev + " listede mevcut değil.");
}

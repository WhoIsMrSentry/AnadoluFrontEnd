// prompt ile görev al 3 defa dizinin sonuna ekle push ile 
// ilk görevi silin shift ile
//son görevi silin pop ile
//toplanm görev sayısını göster length ile
// tüm görevleri listele for.. of ile
//belirli bir görevin listede olup olmadığını kontrol et includes ile
// görevleri alfabetik sıraya göre sırala sort ile

var gorevler = [];
while (true) {
    var ekle = prompt("Yeni görev eklemek istiyor musunuz? (evet/hayır)");
    if (ekle.toLowerCase() !== "evet") {
        break;
    }
    var yeniGorev = prompt("Bir görev girin:");
    gorevler.push(yeniGorev);
}

console.log(gorevler);

gorevler.shift();
console.log(gorevler);

gorevler.pop();
console.log(gorevler);

console.log("Toplam görev sayısı: " + gorevler.length);

for (var gorev of gorevler) {
    console.log(gorev);
}

var kontrolGorev = prompt("Hangi görevi kontrol etmek istersiniz?");
if (gorevler.includes(kontrolGorev)) {
    console.log(kontrolGorev + " listede mevcut.");
}
else {
    console.log(kontrolGorev + " listede mevcut değil.");
}

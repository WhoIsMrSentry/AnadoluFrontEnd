// sayfa prompt ile 3 değişken ak kitab adı yazar adı sayfa sayısı alıyor ve bir obje oluşturup konsola yazdırıyor
// console log ile çıktıyı görünür yap
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



var kitapAdi = prompt("Kitap Adı Girin:");
var yazarAdi = prompt("Yazar Adı Girin:");
var sayfaSayisi = prompt("Sayfa Sayısını Girin:");

var kitap = {
    kitapAdi: kitapAdi,
    yazarAdi: yazarAdi,
    sayfaSayisi: sayfaSayisi
};

for (var özellik in kitap) {
    console.log(özellik + ": " + kitap[özellik]); // Özellik adı ve değeri konsola yazdırılır
}

alert("Kitap bilgileri konsola yazdırıldı.");

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

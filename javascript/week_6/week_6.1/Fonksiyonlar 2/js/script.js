/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fonksiyon bildirimi (function declaration) ile 'selam' isimli fonksiyon tanımlanıyor.
// Çağrıldığında bir uyarı penceresinde "Selam, Dünya!" mesajını gösterir.
function selam() {
    alert("Selam, Dünya!"); // Tarayıcıda uyarı (alert) kutusu açar
}

// Fonksiyon çağrısı: 'selam' fonksiyonunu çalıştırır.
selam();

/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Fonksiyon ifadesi (function expression) oluşturuluyor ve 'merhaba' değişkenine atanıyor.
// Çağrıldığında "Merhaba, Dünya!" mesajını gösterir.
var merhaba = function () {
    alert("Merhaba, Dünya!"); // Uyarı kutusunda mesaj göster
};

// Fonksiyon çağrısı: 'merhaba' fonksiyonunu çalıştırır.
merhaba();

/////////////////////////////////////////////////////////////////////////////////////////////////////////

function soruCevap(soru, cevapEvet, cevapHayir) {
    if (confirm(soru)) { // Kullanıcıya soru sorar
        return cevapEvet(); // Evet cevabı döner
    } else {
        return cevapHayir(); // Hayır cevabı döner
    }
}


function gosterKabul() {
    alert("Kabul Ettiniz!"); // Sonucu gösterir
}


function gosterRed() {
    alert("Reddettiniz!"); // Sonucu gösterir
}

soruCevap("Devam etmek istiyor musunuz?", gosterKabul, gosterRed); // Fonksiyonu çağırır
soruCevap("JavaScript öğrenmek ister misiniz?", function () {
    alert("Harika!"); // Evet cevabı için anonim fonksiyon
}, function () {
    alert("Üzgünüm!"); // Hayır cevabı için anonim fonksiyon
}); // Fonksiyonu çağırır

/////////////////////////////////////////////////////////////////////////////////////////////////////////

function toplam(a, b) {
    return a + b; // İki sayının toplamını döner
}

// Çıktıyı görünür kılmak için konsola yazalım
console.log("toplam(3,5) =", toplam(3, 5)); // 8



var toplama = function (a, b) {
    return a + b; // İki sayının toplamını döner
}

// Çıktıyı görünür kılmak için konsola yazalım
console.log("toplama(10,20) =", toplama(10, 20)); // 30


//////////////////////////////////////////////////////////////////////////////////////////////////////////

function selamVer(isim) {
    return "Selam, " + isim + "!"; // İsimle birlikte selam mesajı döner
}
// Dönen değeri göstermek için konsola yazalım
console.log(selamVer("Emir")); // "Selam, Emir!"

var selamlayici = function (isim) {
    return "Selam, " + isim + "!"; // İsimle birlikte selam mesajı döner
}

// Kullanıcının beklediği isimlerle yardımcı selamlama fonksiyonları
function selamlama(isim) {
    return "Selam, " + isim + "!";
}

// Olası yazım: "selmalama" için alias
function selmalama(isim) {
    return selamlama(isim);
}

// Örnek kullanım (konsola):
console.log(selmalama("Emir"));

///////////////////////////////////////////////////////////////////////////////////////////////////////////

var yas = prompt("Yaşınızı girin:", 18); // Kullanıcıdan yaşını alır

if (yas < 18) {
    function reşitDeğil() {
        alert("Reşit değilsiniz.");
    }
    reşitDeğil();
} else {
    function reşit() {
        alert("Reşitsiniz.");
    }
    reşit();
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////





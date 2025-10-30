var mesaj = " Nasılsın, Dünya!";

function mesajGosterDurum() {
    alert("Merhaba," + mesaj);
}

mesajGosterDurum();


////////////////////////////////////////////////////////////////////////////////////


var kullanıcıAdı = "Ahmet";
console.log("Global Kullanıcı Adı: " + kullanıcıAdı);

function showUserID() {
    var kullanıcıAdı = "Emir";
    console.log("Local Kullanıcı Adı: " + kullanıcıAdı);
}
showUserID();


/////////////////////////////////////////////////////////////////////////////////////



function mesajGonder(gonderen , mesaj, metin="Boş Mesaj") {
    alert(gonderen + " : " + mesaj + " Metin: " + metin);
} 

mesajGonder("Ahmet", "Merhaba Nasılsın?");
mesajGonder("Emir", "İyiyim sen nasılsın?" , "Javascript");



/////////////////////////////////////////////////////////////////////////////////////


function topla(a, b) {
    return a + b;
}

var toplamaSonucu = topla(5, 10);
var textToplamaSonucu = topla("Merhaba ", "Dünya!");
console.log(textToplamaSonucu);
console.log("Toplama Sonucu: " + toplamaSonucu);


//////////////////////////////////////////////////////////////////////////////////////

function yasKontrol(yas) {
    if (yas > 18) {
        return true;
    } else {
        return confirm ("Ebeveyn izniniz var mı?");
    }
}

var yas = prompt("Yaşınızı giriniz:",18);

if (yasKontrol(yas)) {
    alert("Giriş izni verildi.");
} else {
    alert("Giriş izni reddedildi.");
}

//////////////////////////////////////////////////////////////////////////////////////


function filmGoster(age) {
    if (!yasKontrol(yas)) {
        return;
    }
    alert("Filmi izleyebilirsiniz.");
}
filmGoster(yas);


//////////////////////////////////////////////////////////////////////////////////////

function ornekReturn() {
    // return
    // bazi + degiskenler + bu + sekilde + uzun + olabilir;           //yanlış kullanım örneği

    return (bazi + degiskenler + bu + sekilde + uzun + olabilir);    //doğru kullanım örneği
}

//////////////////////////////////////////////////////////////////////////////////////

function yasKontrolu(yas){
    if (yas > 18) {
        return true;
    } else {
        return confirm("Ailenden izin aldın mı?");
    }
}

function yasKontrolu2(yas){
 if (yas > 18) {
    return true;
 }
    return confirm("Ailenden izin aldın mı?");

}

/////////////////////////////////////////////////////////////////////////////////


// Temel veri tipleri için değişken tanımlamaları
var yazı = " Ahmet ";           //string türünde değişken
var sayı = 1;                  //number türünde değişken
var booleanDeğer = true;      //boolean türünde değişken
var merhaba;                 //undefined türünde değişken
var bos = null;             //null türünde değişken

var kullancı =  new Object();  //object türünde değişken
var kullancı = {};            //object türünde değişken (kısa yazım)


// Özellikli bir nesne tanımlanıyor
var kullancı = {               //object türünde değişken (özellikli)
    isim: "Ahmet",            //isim özelliği
    yas: 25,                 //yas özelliği
    şehir: "Eskişehir",      //şehir özelliği
    //adminMi: true        //adminMi özelliği (boolean türünde)
    silmeFonksiyonu: "Bu string ifade gözüküyorsa silinmedi/ Undefined ise silindi" //silmeFonksiyonu özelliği (fonksiyon türünde)
};

// Nesnenin özellikleri ekrana yazdırılıyor
alert(
    "İsim: " + kullancı.isim +
    "\nyas: " + kullancı.yas +
    "\nŞehir: " + kullancı.şehir +
    "\nTest: " + kullancı.test
);


kullancı.adminMi = true; // Yeni özellik ekleniyor
alert("Admin mi? " + "\n"+ kullancı.adminMi); // Yeni özellik ekrana yazdırılıyor

delete kullancı.adminMi; // Özellik siliniyor
alert("Admin mi? " + "\n"+ kullancı.adminMi); // Silinen özellik ekrana yazdırılıyor (undefined)


alert("Silme fonksiyonu: " + "\n"+ kullancı.silmeFonksiyonu); // Silme fonksiyonu ekrana yazdırılıyor

delete kullancı.silmeFonksiyonu
alert("Silme fonksiyonu: " + "\n"+ kullancı.silmeFonksiyonu); // Silme fonksiyonu ekrana yazdırılıyor-

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


var kullancı2 = {
    isim: "Emir",
    yas: 19,
    şehir: "Hatay",
    web_tasarımcı: true
};


alert(kullancı2["isim"]); // "Emir" ekrana yazdırılır
alert(kullancı2["yas"]); // 19 ekrana yazdırılır
alert(kullancı2["şehir"]); // "Hatay" ekrana yazdırılır
alert(kullancı2["web_tasarımcı"]); // true ekrana yazdırılır

var ozellikAdi = "web_tasarımcı"; // Özellik adı değişkene atanır
alert(kullancı2[ozellikAdi]); // true ekrana yazdırılır


delete kullancı2["web_tasarımcı"]; // Özellik silinir
alert(kullancı2["web_tasarımcı"]); // undefined ekrana yazdırılır

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



var kullancı3 = {
    isim: "Emir",
    yas: 19,
    şehir: "Hatay",
};

var anahtar = prompt("Hangi özelliği öğrenmek istiyorsunuz?", "isim"); // Kullanıcıdan özellik adı alınır
alert(kullancı3[anahtar]); // Kullanıcının istediği özellik ekrana yazdırılır



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var meyve = prompt("Hangi meyveyi istersiniz? (elma, muz, portakal)", "elma");

var poset = {
    [meyve]: 5 // Kullanıcının istediği meyve özelliği eklenir
};

alert("Poşet içinde " + poset[meyve] + " adet " + meyve + " var."); // Sepetteki meyve sayısı ekrana yazdırılır

// alert("Poşetteki meyveler: " + Object.keys(poset).join(", ")); //bu işlenmedi Sepetteki tüm meyveler ekrana yazdırılır object.keys ile join kullanımı

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


var meyve = "Elma";
var sepet = { [meyve + "yedim"]: 5 }; // Özellik adı dinamik olarak oluşturulur
var sepet = { "Elmayedim": 5 }; // Özellik adı statik olarak oluşturulur

// kaç elme yedim
alert("Sepetten " + sepet.Elmayedim + " adet elma yedim."); // Sepetteki elma sayısı ekrana yazdırılır

//değişken değiştirme

meyve = "Muz";
sepet = { [meyve + "yedim"]: 3 }; // Özellik adı dinamik olarak oluşturulur
sepet = { "Muzyedim": 3 }; // Özellik adı statik olarak oluşturulur

// kaç muz yedim
alert("Sepetten " + sepet.Muzyedim + " adet muz yedim."); // Sepetteki muz sayısı ekrana yazdırılır

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


var object = {
    for: 1,
    let: 2,
    return: 3
};

alert(object.for + object.let + object.return); // 6 ekrana yazdırılır
alert(String(object["for"]) + String(object["let"]) + String(object["return"])); // "123" ekrana yazdırılır
alert(object["let"] * object["return"] + String(object["for"])); // 61 ekrana yazdırılır

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


function kullancıOlustur(isim, yas, şehir) {
    return {
        isim: isim,
        yas: yas,
        şehir: şehir
    };
}

var kullancı = kullancıOlustur("Mehmet", 19, "İstanbul"); // Yeni nesne oluşturulur

alert(kullancı.isim); // "Mehmet" ekrana yazdırılır
alert(kullancı.yas); // 19 ekrana yazdırılır
alert(kullancı.şehir); // "İstanbul" ekrana yazdırılır
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var kullancı = {
    isim: "Emir",
    soyisim: "Hamurcu" 
};

alert("isim" in kullancı); // true ekrana yazdırılır
alert("soyisim" in kullancı); // true ekrana yazdırılır
alert("yas" in kullancı); // false ekrana yazdırılır

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var kullancı = {
    isim: "Ege",
    yas: 19,
    adminMi: false
};

for (var anahtar in kullancı) {
    alert(anahtar + ": " + kullancı[anahtar]); // Özellik adı ve değeri ekrana yazdırılır
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var kodlar = {
    "90": "Türkiye",
    "44": "İngiltere",
    "33": "Fransa"
};

for (var kod in kodlar) {
    alert("+" + kod + " : " + kodlar[kod]); // Ülke kodu ve adı ekrana yazdırılır
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


var kullancı = {
    isim: "Ahmet",
    soyisim: "Avcıoğlu",
};

kullancı["yas"] ;
kullancı["yas"] = 30; // Yeni özellik eklenir

for (var anahtar in kullancı) {
    alert(anahtar + ": " + kullancı[anahtar]); // Özellik adı ve değeri ekrana yazdırılır
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var kullancı = {
    isim: "Ekrem",
    soyisim: "Sarıdağ",
    yas: 22
};

var yonetici = kullancı; // yönetici, kullancı ile aynı nesneyi gösterir
alert("Yönetici ismi: " + yonetici.isim); // "Ekrem" ekrana yazdırılır

yonetici.isim = "Ahmet"; // yönetici üzerinden ismi değiştirilir
alert("Yönetici ismi: " + yonetici.isim); // "Ahmet" ekrana yazdırılır

var degisken = "mehmet";
alert(degisken); // "mehmet" ekrana yazdırılır


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var a = {};
var b = a; // b, a ile aynı nesneyi gösterir

alert(a == b); // true ekrana yazdırılır
alert(a === b); // true ekrana yazdırılır

var c = {}; // Yeni boş nesne oluşturulur
var d = {}; // Yeni boş nesne oluşturulur

alert(c == d); // false ekrana yazdırılır
alert(c === d); // false ekrana yazdırılır

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var kullancı = {
    isim: "Akif",
    yas: 30
};

var kopya = {}; // Yeni boş nesne oluşturulur

// Özellikler kopyalanır
for (var anahtar in kullancı) {
    kopya[anahtar] = kullancı[anahtar];
}

alert("Orijinal isim: " + kullancı.isim); // "Akif" ekrana yazdırılır
alert("Orijinal yas: " + kullancı.yas); // 30 ekrana yazdırılır

alert("Kopya isim: " + kopya.isim); // "Akif" ekrana yazdırılır
alert("Kopya yas: " + kopya.yas); // 30 ekrana yazdırılır

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var kullancı = {
    isim: "Berkay",
};

var izin1 = {okuma: true};
var izin2 = {duzenleme: true};

Object.assign(kullancı, izin1, izin2); // Özellikler kullancı nesnesine kopyalanır


for(var anahtar in kullancı) {
    alert(anahtar + ": " + kullancı[anahtar]); // Özellik adı ve değeri ekrana yazdırılır
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

var yonetici = {isim: "Mehmet"};

Object.assign(yonetici,{isim: "Ahmet", adminMi: false , soyad: "Avcıoğlu" }); // Özellikler kullancı nesnesine kopyalanır

var özellikler = "";
for(var anahtar in yonetici) {
    özellikler += anahtar + ": " + yonetici[anahtar] + "\n"; // Özellik adı ve değeri ekrana yazdırılır
}

alert(özellikler);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

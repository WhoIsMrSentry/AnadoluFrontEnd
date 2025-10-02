// prompt: kullanıcıdan metin girişi alır (string döner)
var deger = prompt("adınızı girin", "örnek ad");
console.log(deger);

// confirm: kullanıcıya evet/hayır sorar (boolean döner)
var status1 = confirm("emin misiniz?");
console.log(status1);

var status2 = confirm("kaydetmek istiyor musunuz?");
console.log(status2);

var status3 = confirm("silmek istiyor musunuz?");
console.log(status3);

// Basit birleştirme örneği
var isim = "Emir";
var soyisim = prompt("soyadınızı girin", "örnek soyad");
console.log(isim + " " + soyisim);
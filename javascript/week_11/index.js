/////////////////////////////////////////////////////////////////////////////////////////////////////////
console.log("11. Hafta - Diziler Notları");
/////////////////////////////////////////////////////////////////////////////////////////////////////////

// new Array(): yeni bir dizi oluşturur.
// Neden: Array constructor ile dizi oluşturmayı göstermek.
var dizi1 = new Array();
console.log("new Array() ile boş dizi:", dizi1, "| uzunluk:", dizi1.length);

// []: dizi oluşturmanın en yaygın ve okunabilir yolu.
var dizi2 = [];
console.log("[] ile boş dizi:", dizi2, "| uzunluk:", dizi2.length);

// Dizi literal ile başlangıç elemanları verilebilir.
var meyveler = ["Elma", "Portakal", "Erik"];
console.log("Başlangıç meyveleri:", meyveler);
// meyveler[3] = ... : belirtilen index'e doğrudan değer atar (gerekirse dizi uzar).
// Neden: push dışında, indeksle de ekleme yapılabildiğini göstermek.
meyveler[3] = "Çilek";
console.log("İndekse yazarak eleman ekleme:", meyveler);

// Diziler farklı tipleri aynı anda tutabilir (JS dinamik tipli).
var karisik = ["Elma", { isim: "Ahmet" }, true, function () { return "Merhaba"; }];
console.log("Karışık dizi:", karisik);
// karisik[3](): 3. index'te fonksiyon var; çağırınca dönüş değerini alırız.
console.log("Fonksiyon elemanı:", karisik[3]());

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var sepet = ["Elma", "Portakal", "Erik"];
// push(x): dizinin SONUNA eleman ekler ve yeni length döner.
// Neden: en çok kullanılan ekleme yöntemi.
sepet.push("Mandalina");
console.log("push ile ekleme:", sepet);

// pop(): dizinin SON elemanını siler ve silinen elemanı döndürür.
var sonEleman = sepet.pop();
console.log("pop ile silinen:", sonEleman, "| kalan:", sepet);

// shift(): dizinin İLK elemanını siler ve silinen elemanı döndürür.
// Not: shift, tüm elemanları kaydırdığı için push/pop'a göre daha maliyetlidir.
var ilkEleman = sepet.shift();
console.log("shift ile silinen:", ilkEleman, "| kalan:", sepet);

// unshift(x): dizinin BAŞINA eleman ekler ve yeni length döner.
var yeniUzunluk = sepet.unshift("Ananas");
console.log("unshift ile başa ekleme:", sepet, "| yeni uzunluk:", yeniUzunluk);

// unshift birden fazla eleman da alabilir (başa sırayla ekler).
sepet.unshift("Karpuz", "Kavun");
console.log("unshift ile çoklu ekleme:", sepet);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var dizi = ["Elma", "Armut", "Erik"];
// Klasik for: index ile gezeriz; dizi[i] ile elemana erişiriz.
for (var i = 0; i < dizi.length; i++) {
     console.log("for:", i, dizi[i]);
 }

// for...in: dizideki index'leri (key) gezer. (Genelde objeler için daha uygundur.)
for (var key in dizi) {
     console.log("for...in:", key, dizi[key]);
 }

// for...of: dizideki değerleri doğrudan gezer (en okunabilir yöntemlerden).
for (var value of dizi) {
     console.log("for...of:", value);
 }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var liste = [];
// Çok yüksek bir index'e değer atarsan, length buna göre büyür.
// Neden: Array length'in “en büyük index + 1” mantığıyla çalıştığını göstermek.
liste[123] = "Domates";
console.log("Yüksek indeks length:", liste.length);

var sayilar = [1, 2, 3, 4, 5];
// length küçültmek: diziyi KESER (sondan elemanlar düşer).
sayilar.length = 2;
console.log("length küçültmek diziyi keser:", sayilar);
// length büyütmek: araya “empty slot” ekler (değer atanmamış boşluk).
sayilar.length = 5;
console.log("length büyütmek boş slot ekler:", sayilar);

// new Array(2): “içinde 2 eleman var” değil, “length=2 boş slot” üretir.
var bosDizi = new Array(2);
console.log("new Array(2):", bosDizi, "| uzunluk:", bosDizi.length, "| 0. index:", bosDizi[0]);

var arr = [1, 2, 3];
// String(arr): dizi string'e çevrilirken elemanlar virgülle birleştirilir.
console.log("String(arr):", String(arr));
// [1,2] + 1: dizi önce string'e çevrilir ("1,2"), sonra "1,2" + "1" olur.
console.log("[1,2] + 1 sonucu:", [1, 2] + 1);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var sayilar2 = [5, 10, 15];
var cikarilan = sayilar2.pop();
console.log("pop sonrası silinen:", cikarilan, "| kalan uzunluk:", sayilar2.length);

var bos = [];
// Var olmayan index'e erişmek: undefined döner (hata değildir).
console.log("Boş dizinin 0. elemanı:", bos[0]);

var renkler = ["Kırmızı", "Mavi"];
// Atlayarak index verme: aradaki index'ler empty slot olur.
renkler[5] = "Yeşil";
console.log("Atlayarak ekleme length:", renkler.length, "| 3. index:", renkler[3]);

var dizininBasi = [1, 2, 3];
dizininBasi.unshift("Ahmet");
console.log("unshift sonrası dizi:", dizininBasi, "| 3. index:", dizininBasi[3]);

var arabalar = ["BMW", "Audi", "Mercedes"];
arabalar.shift();
arabalar.shift();
console.log("İki kez shift sonrası sıradaki araç:", arabalar[0]);

var dizi4 = [10, 20, 30];
// dizi4.length, son elemandan 1 fazladır; dizi4[dizi4.length] her zaman undefined olur.
console.log("dizi4[dizi4.length]:", dizi4[dizi4.length]);

var notlar = [70, 80, 90];
// pop() son elemanı çıkarır, push(...) tekrar sona ekler -> eleman sayısı değişmez.
notlar.push(notlar.pop());
console.log("push(pop()) uzunluğu değiştirmez:", notlar.length);

var x = [1, 2, 3];
x[10] = 99;
// Seyrek dizi: arada boş slotlar vardır; bu durum bazı yöntemlerde farklı davranışlara yol açabilir.
console.log("Seyrek dizi örneği x[5]:", x[5], "| uzunluk:", x.length);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var arrDelete = ["eve", "gitmek", "istiyorum"];
// delete arr[i]: elemanı siler ama index'i “boş slot” bırakır, length değişmez.
delete arrDelete[0];
console.log("delete boş yer bırakır:", arrDelete, "| length:", arrDelete.length);

var arrSplice = ["Ben", "JS", "çalışıyorum."];
// splice(başlangıç, adet): belirtilen yerden belirtilen sayıda elemanı SİLER (diziyi değiştirir).
arrSplice.splice(2, 3);
console.log("splice ile eleman silme:", arrSplice);

var arrReplace = ["Ben", "tam", "şimdi", "JS", "çalışıyorum."];
// splice(..., ... , yeniElemanlar...): hem silebilir hem yerine yenisini ekleyebilir.
arrReplace.splice(0, 4, "Ders");
console.log("splice ile değiştirme:", arrReplace);

var arrSil = ["Ben", "tam", "şimdi", "JS", "çalışıyorum."];
// splice ayrıca “silinen elemanları” dizi olarak döndürür.
var silinen = arrSil.splice(0, 2);
console.log("splice dönen elemanlar:", silinen, "| kalan dizi:", arrSil);

var karma = ["Ben", "Javascript", "çalışıyorum"];
// splice(1,0, ...): 0 sil -> araya ekleme yap.
karma.splice(1, 0, "karmaşık");
console.log("splice ile araya ekleme:", karma);

var sayiSplice = [1, 2, 5];
// Negatif index: sondan sayar (-1 son eleman).
var silinenler = sayiSplice.splice(-1, 15, 3, 4);
console.log("Negatif index ile splice:", sayiSplice, "| silinenler:", silinenler);

var isimler = ["ahmet", "mehmet", "barış", "elif", "idil"];
// Birden fazla eleman ekleme: splice içine birden çok yeni değer verilebilir.
isimler.splice(-3, 1, "behiç", "betül", "göktuğ");
console.log("Birden fazla ekleme:", isimler);





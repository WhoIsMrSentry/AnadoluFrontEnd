/////////////////////////////////////////////////////////////////////////////////////////////////////////
console.log("11. Hafta - Diziler Notları");
/////////////////////////////////////////////////////////////////////////////////////////////////////////

var dizi1 = new Array();
console.log("new Array() ile boş dizi:", dizi1, "| uzunluk:", dizi1.length);

var dizi2 = [];
console.log("[] ile boş dizi:", dizi2, "| uzunluk:", dizi2.length);

var meyveler = ["Elma", "Portakal", "Erik"];
console.log("Başlangıç meyveleri:", meyveler);
meyveler[3] = "Çilek";
console.log("İndekse yazarak eleman ekleme:", meyveler);

var karisik = ["Elma", { isim: "Ahmet" }, true, function () { return "Merhaba"; }];
console.log("Karışık dizi:", karisik);
console.log("Fonksiyon elemanı:", karisik[3]());

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var sepet = ["Elma", "Portakal", "Erik"];
sepet.push("Mandalina");
console.log("push ile ekleme:", sepet);

var sonEleman = sepet.pop();
console.log("pop ile silinen:", sonEleman, "| kalan:", sepet);

var ilkEleman = sepet.shift();
console.log("shift ile silinen:", ilkEleman, "| kalan:", sepet);

var yeniUzunluk = sepet.unshift("Ananas");
console.log("unshift ile başa ekleme:", sepet, "| yeni uzunluk:", yeniUzunluk);

sepet.unshift("Karpuz", "Kavun");
console.log("unshift ile çoklu ekleme:", sepet);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var dizi = ["Elma", "Armut", "Erik"];
for (var i = 0; i < dizi.length; i++) {
	console.log("for:", i, dizi[i]);
}

for (var key in dizi) {
	console.log("for...in:", key, dizi[key]);
}

for (var value of dizi) {
	console.log("for...of:", value);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var liste = [];
liste[123] = "Domates";
console.log("Yüksek indeks length:", liste.length);

var sayilar = [1, 2, 3, 4, 5];
sayilar.length = 2;
console.log("length küçültmek diziyi keser:", sayilar);
sayilar.length = 5;
console.log("length büyütmek boş slot ekler:", sayilar);

var bosDizi = new Array(2);
console.log("new Array(2):", bosDizi, "| uzunluk:", bosDizi.length, "| 0. index:", bosDizi[0]);

var arr = [1, 2, 3];
console.log("String(arr):", String(arr));
console.log("[1,2] + 1 sonucu:", [1, 2] + 1);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var sayilar2 = [5, 10, 15];
var cikarilan = sayilar2.pop();
console.log("pop sonrası silinen:", cikarilan, "| kalan uzunluk:", sayilar2.length);

var bos = [];
console.log("Boş dizinin 0. elemanı:", bos[0]);

var renkler = ["Kırmızı", "Mavi"];
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
console.log("dizi4[dizi4.length]:", dizi4[dizi4.length]);

var notlar = [70, 80, 90];
notlar.push(notlar.pop());
console.log("push(pop()) uzunluğu değiştirmez:", notlar.length);

var x = [1, 2, 3];
x[10] = 99;
console.log("Seyrek dizi örneği x[5]:", x[5], "| uzunluk:", x.length);

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var arrDelete = ["eve", "gitmek", "istiyorum"];
delete arrDelete[0];
console.log("delete boş yer bırakır:", arrDelete, "| length:", arrDelete.length);

var arrSplice = ["Ben", "JS", "çalışıyorum."];
arrSplice.splice(2, 3);
console.log("splice ile eleman silme:", arrSplice);

var arrReplace = ["Ben", "tam", "şimdi", "JS", "çalışıyorum."];
arrReplace.splice(0, 4, "Ders");
console.log("splice ile değiştirme:", arrReplace);

var arrSil = ["Ben", "tam", "şimdi", "JS", "çalışıyorum."];
var silinen = arrSil.splice(0, 2);
console.log("splice dönen elemanlar:", silinen, "| kalan dizi:", arrSil);

var karma = ["Ben", "Javascript", "çalışıyorum"];
karma.splice(1, 0, "karmaşık");
console.log("splice ile araya ekleme:", karma);

var sayiSplice = [1, 2, 5];
var silinenler = sayiSplice.splice(-1, 15, 3, 4);
console.log("Negatif index ile splice:", sayiSplice, "| silinenler:", silinenler);

var isimler = ["ahmet", "mehmet", "barış", "elif", "idil"];
isimler.splice(-3, 1, "behiç", "azra", "göktuğ");
console.log("Birden fazla ekleme:", isimler);





///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Büyük sayıları yazma yöntemleri
// Amaç: Uzun uzun sıfır yazmak yerine, okunabilir ve hatasız biçimde büyük sayılar tanımlamak.

// 1.000.000 (bir milyon) sayısını klasik şekilde yazarız.
var milyon = 1000000;
// alert(...) tarayıcıda ekrana mesaj kutusu çıkarır; burada değişkenin değerini görmek için kullanıyoruz.
alert(milyon);

// 1.000.000.000 (bir milyar) sayısını klasik şekilde yazarız.
var milyar = 1000000000;
alert(milyar);

// Bilimsel gösterim (scientific notation): 1e6 = 1 * 10^6
// Neden: Daha kısa, daha okunabilir; sıfır sayma hatasını azaltır.
var kisaMilyon = 1e6;
alert(kisaMilyon);

// 1e9 = 1 * 10^9 (bir milyar)
var kisaMilyar = 1e9;
alert(kisaMilyar);

// 7.3e9 = 7.3 * 10^9
alert(7.3e9); // 7.3 milyar

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sayıyı farklı tabanlarda string'e çevirme
// Amaç: Hex (16'lık) ve binary (2'lik) gösterimi öğrenmek (özellikle renk kodları, bit işlemleri vb.).

var sayı = 255;
// toString(16): sayıyı 16'lık tabanda metne çevirir. 255 (10'luk) = ff (16'lık)
alert(sayı.toString(16)); // "ff"
// toString(2): sayıyı 2'lik tabanda metne çevirir. 255 = 11111111
alert(sayı.toString(2));  // "11111111"

var sayı2 = 250;
alert(sayı2.toString(16)); // "fa"
alert(sayı2.toString(2));  // "11111010"

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Yuvarlama / tam sayıya indirme fonksiyonları
// Neden önemli: fiyat/puan gösterimi, sayısal hesaplar, aralık kontrolü gibi yerlerde çok kullanılır.

var sayı3 = 3.14;

// Math.floor(x): x'i aşağı yuvarlar (ondalık kısmı atar ama negatifte daha da küçültür)
alert("sayı3 = " + sayı3 + " için Math.floor: " + Math.floor(sayı3)); // 3
// Math.ceil(x): x'i yukarı yuvarlar
alert("sayı3 = " + sayı3 + " için Math.ceil: " + Math.ceil(sayı3)); // 4
// Math.round(x): en yakına yuvarlar (0.5 ve üzeri yukarı)
alert("sayı3 = " + sayı3 + " için Math.round: " + Math.round(sayı3)); // 3
// Math.trunc(x): sadece ondalık kısmı keser (negatifte floor gibi davranmaz)
alert("sayı3 = " + sayı3 + " için Math.trunc: " + Math.trunc(sayı3)); // 3

var sayı4 = 9.81;

alert("sayı4 = " + sayı4 + " için Math.floor: " + Math.floor(sayı4)); // 9
alert("sayı4 = " + sayı4 + " için Math.ceil: " + Math.ceil(sayı4)); // 10
alert("sayı4 = " + sayı4 + " için Math.round: " + Math.round(sayı4)); // 10
alert("sayı4 = " + sayı4 + " için Math.trunc: " + Math.trunc(sayı4)); // 9

var sayı5 = -3.14;

// Negatif sayılarda farkı görmek önemli:
// - floor: -3.14'ü -4'e indirir (daha küçük/eşit tam sayı)
// - ceil:  -3.14'ü -3'e çıkarır
// - trunc: -3.14'ün ondalığını keser -> -3
alert("sayı5 = " + sayı5 + " için Math.floor: " + Math.floor(sayı5)); // -4
alert("sayı5 = " + sayı5 + " için Math.ceil: " + Math.ceil(sayı5)); // -3
alert("sayı5 = " + sayı5 + " için Math.round: " + Math.round(sayı5)); // -3
alert("sayı5 = " + sayı5 + " için Math.trunc: " + Math.trunc(sayı5)); // -3


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Ondalıklı sayılarda basamak kontrolü ve "floating point" hataları
// Neden: JavaScript sayıları IEEE-754 float olarak tuttuğu için 0.1 + 0.2 gibi işlemler beklenmedik sonuç verebilir.

var sayı6 = 1.23456;
// 2 basamağa kırpma (truncate gibi):
// 1) 100 ile çarp -> 123.456
// 2) floor ile aşağı yuvarla -> 123
// 3) 100'e böl -> 1.23
// Neden: toFixed her zaman string döndürür; burada sayı olarak kırpılmış değeri görmek istiyoruz.
alert(Math.floor(sayı6 * 100) / 100); // 1.23

var sayı7 = 1.23756;
// toFixed(n): n basamağa yuvarlar ve SONUÇ STRING döner.
// Neden: ekrana/rapora para gibi sabit basamakla yazdırmak için.
alert(sayı7.toFixed(3)); // "1.238"

// 0.1 ve 0.2 ikilik sistemde tam temsil edilemez -> toplama sonucu çok küçük hata payı içerir.
alert(0.1 + 0.2); // 0.30000000000000004
// Bu yüzden doğrudan eşitlik kontrolü bazen false çıkar.
alert((0.1 + 0.2 == 0.3)); // false

// Ekran gösterimi için toFixed ile formatlayıp (string), gerekiyorsa tekrar Number'a çeviririz.
alert((0.1 + 0.2).toFixed(2)); // "0.30"
alert(Number((0.1 + 0.2).toFixed(2)) == 0.3); // true


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// NaN (Not-a-Number) nedir?
// NaN: sayı olması beklenen bir işlemin sonuç üretememesi durumunda oluşan özel bir değerdir.

// String'i sayıya bölmeye çalışmak anlamsızdır; sonuç NaN olur.
"Ahmet" / 5 // NaN
// isNaN(x): x NaN mi diye kontrol eder.
// Not: isNaN bazı otomatik dönüştürmeler yapabildiği için modern kullanımda Number.isNaN daha güvenlidir.
isNaN("Ahmet" / 5) // true

// NaN'ın ilginç özelliği: NaN, kendisine bile eşit değildir.
// Neden: IEEE-754 standardında NaN karşılaştırmaları her zaman false döner.
alert(NaN === NaN); // false

var ahmet = "Ahmet" / 5;
alert(isNaN(ahmet)); // true

var emir = "Ahmet" / 5;
alert(isNaN(emir)); // true

// İki NaN değeri birbirine eşit değildir (hem == hem ===)
ahmet == emir // false
ahmet === emir // false


///////////////////////////////////////////////////////////////////////////////////////////////////////////
// isFinite(x): x sonlu (finite) bir sayı mı?
// Neden: Kullanıcı girdisi veya hesap sonucu Infinity/NaN gibi özel değerler içeriyor mu diye kontrol etmek için.

isFinite("ahmet"); // false (sayıya çevrilemez)
isFinite(5); // true
isFinite(NaN); // false
isFinite(Infinity); // false
isFinite(-Infinity); // false


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tür kontrolü ve sayıya dönüştürme
// Neden: prompt gibi fonksiyonlar her zaman string döndürür; matematik için number'a çevirmek gerekir.

var sayıX = 123;
// typeof: değişkenin tipini string olarak döndürür.
typeof sayıX; // "number"

var sayıY = "123";
typeof sayıY; // "string"

// Number("123"): string'i number'a çevirmeye çalışır; tamamen sayı değilse NaN dönebilir.
var sayıZ = Number("123");
typeof sayıZ; // "number"

var sayıT = "123";
// Unary plus (+): hızlı sayı dönüştürme. Number(...) ile benzer.
typeof(+sayıT); // "number"

// Unary plus sayıysa aynı bırakır, string sayıysa number'a çevirir.
+2546489; // 2546489
+ "2546489"; // 2546489


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// parseInt ve parseFloat
// Neden: String'in başından itibaren sayı okuyup dönüştürmek (ör. "100px" gibi birim içeren değerler).

// parseInt(str): tam sayı okur (ondalık kısmı atar). Okumaya soldan başlar, ilk geçersiz karakterde durur.
parseInt("100px"); // 100
// Başta 0'lar varsa okur; hemen sonra harf gelirse 0 dönebilir.
parseInt("00EmirHamurcuasjdvgasytdasda"); // 0
// İlk karakter sayı değilse NaN döner.
parseInt("EmirHamurcuasjdvgasytdasda"); // NaN
parseInt("a100"); // NaN
// Ondalıklı string'i tam sayıya çevirirken sadece tam kısmı alır.
parseInt("123.45"); // 123
// parseInt tabanı (radix) verilmezse genelde 10 kabul edilir.
parseInt("010"); // 10 (onluk tabanda)
// Radix verilirse o tabana göre okur.
parseInt("010", 8); // 8 (sekizlik tabanda)

// parseFloat(str): ondalıklı (float) okur. Bilimsel gösterimi de anlayabilir.
parseFloat("123.45"); // 123.45
parseFloat("100px"); // 100
parseFloat("Emir123.45"); // NaN
parseFloat("123.45abc"); // 123.45
parseFloat("0.1e2"); // 10 (0.1 * 10^2 = 10)
parseFloat("   5.67   "); // 5.67

// parseFloat okurken ikinci noktada durur.
alert(parseFloat("1.2.34")); // 1.2


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Math.random(): 0 (dahil) ile 1 (hariç) arasında rastgele ondalıklı sayı üretir
// Neden: oyunlar, örnek veri üretme, rastgele seçim gibi yerlerde.

alert(Math.random()); // 0 <= x < 1
// Çarpma ile aralığı büyütürüz: 0 <= x < 10
alert(Math.random() * 10);
alert(Math.random() * 100);

// parseInt(...) ile ondalık kısmı atarak "tam sayı" elde etmeye çalışıyoruz.
// Not: parseInt yerine Math.floor kullanmak daha net ve güvenilir bir tercihtir.
alert(parseInt(Math.random())); // her zaman 0 çıkar (çünkü 0 <= x < 1)
alert(parseInt(Math.random() * 10)); // 0..9
alert(parseInt(Math.random() * 100)); // 0..99


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sık kullanılan matematik fonksiyonları
// Neden: bir listedeki en büyük/en küçük değeri bulma ve üs alma işlemleri.

// Math.max(...): verilen değerlerin en büyüğünü döndürür.
Math.max(3, 5, -10, 0, 1); // 5
// Math.min(...): verilen değerlerin en küçüğünü döndürür.
Math.min(3, 5, -10, 0, 1); // -10
// Math.pow(a, b): a'nın b'inci kuvvetini döndürür.
Math.pow(2, 3); // 8


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// İki sayı arasındaki farkı (mutlak değer olarak) hesaplama
// Neden: aradaki mesafeyi/farkı büyüklük olarak bulmak isteriz (negatif/pozitif fark önemsizse).

function difference(a, b) {
    // Math.abs(x): x'in mutlak değerini alır (negatifse pozitife çevirir).
    // a - b sonucu negatif de olabilir; abs ile her zaman pozitif fark döndürürüz.
    return Math.abs(a - b);
}

alert(difference(5, 3)); // 2
alert(difference(5, 10)); // 2

/////////////////////////////////////////////////////////////////////////////////////////////////////////
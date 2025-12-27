// Amaç: Kullanıcının yazdığı cümle üzerinde temel string işlemleri yapmak.

// prompt(...): kullanıcıdan giriş alır; dönüş tipi her zaman string'dir.
// Neden: Cümleyi kullanıcıdan dinamik almak istiyoruz.
var sentence = prompt("Lütfen bir cümle giriniz:");

// length: cümlenin karakter sayısı (boşluklar dahil)
var length = sentence.length;
alert("Cümlenin uzunluğu: " + length);

// toUpperCase / toLowerCase: metni büyük/küçük harfe çevirir.
// Neden: arama/karşılaştırma yaparken harf duyarlılığını azaltmak için de kullanılır.
var upperCaseSentence = sentence.toUpperCase();
var lowerCaseSentence = sentence.toLowerCase();
alert("Büyük harfli cümle: " + upperCaseSentence);
alert("Küçük harfli cümle: " + lowerCaseSentence);

// split(" "): string'i boşluklardan bölerek dizi (array) üretir.
// [0]: dizinin ilk elemanı -> ilk kelime.
// Not: Birden fazla boşluk varsa sonuç değişebilir; burada temel mantık hedefleniyor.
var firstWord = sentence.split(" ")[0];
alert("İlk kelime: " + firstWord);

// Belirli bir harfin kaç kez geçtiğini bulma
// Neden: döngü ve karakter karşılaştırma pratiği.
var charToCount = prompt("Hangi harfin kaç kez geçtiğini öğrenmek istersiniz? Lütfen bir harf giriniz:");

// Sayaç değişkeni: kaç kez bulunduğunu tutar.
var count = 0;

// for döngüsü ile cümleyi karakter karakter geziyoruz.
for (var i = 0; i < sentence.length; i++) {
    // toLowerCase ile her iki tarafı küçülterek büyük/küçük harf farkını kaldırıyoruz.
    // === ile tam eşitlik kontrolü yapıyoruz.
    if (sentence[i].toLowerCase() === charToCount.toLowerCase()) {
        count++;
    }
}

alert("'" + charToCount + "' harfi cümlede " + count + " kez geçiyor.");
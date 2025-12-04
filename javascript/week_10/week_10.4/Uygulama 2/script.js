//kullanıcıdan bir cümle alacağız
var sentence = prompt("Lütfen bir cümle giriniz:");

//cümlenin uzunluğu bulacağız 
var length = sentence.length;
alert("Cümlenin uzunluğu: " + length);

//cümleyi büyük ve küçük harfe çevireceğiz
var upperCaseSentence = sentence.toUpperCase();
var lowerCaseSentence = sentence.toLowerCase();
alert("Büyük harfli cümle: " + upperCaseSentence);
alert("Küçük harfli cümle: " + lowerCaseSentence);

//ilk kelimeyi ayırıcağız
var firstWord = sentence.split(" ")[0];
alert("İlk kelime: " + firstWord);

//belirli bir harfin kaç kez geçtiğini bulacağız ( for döngüsü ile)
var charToCount = prompt("Hangi harfin kaç kez geçtiğini öğrenmek istersiniz? Lütfen bir harf giriniz:");
var count = 0;
for (var i = 0; i < sentence.length; i++) {
    if (sentence[i].toLowerCase() === charToCount.toLowerCase()) {
        count++;
    }
}
alert("'" + charToCount + "' harfi cümlede " + count + " kez geçiyor.");
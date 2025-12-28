/////////////////////////////////////////////////////////////////////////////////////////////////////////
// String (metin) tanımlama yöntemleri
// Neden: JavaScript'te metinler string tipindedir; tek tırnak, çift tırnak ve backtick farklı amaçlarla kullanılır.

// Çift tırnak ile string tanımlama
var text = "Ahmet"
// Tek tırnak ile string tanımlama (çoğu zaman çift tırnakla aynı işi görür)
var text2 = 'Mehmet'
// Backtick (template literal) ile string tanımlama
// Neden: Değişken yerleştirme (${...}) ve çok satırlı metin için idealdir.
var text3 = `Ayşe`

// console.log(...): geliştirici konsoluna yazdırır (alert gibi kullanıcıyı durdurmaz)
console.log(text)
console.log(text2)
console.log(text3)

// Fonksiyon: tekrar eden işlemleri tek yerde toplamak için kullanılır.
// toplam(a, b): iki sayıyı toplar ve sonucu döndürür.
function toplam(a, b) {
    // return: fonksiyonun sonucunu dışarı verir.
    return a + b;
}

// String birleştirme (+) ile sonucu yazdırma
alert("Toplam: " + toplam(5, 10));

// Template literal ile ${...} içine ifade yazıp sonucu string'e gömeriz.
alert(`Toplam: ${toplam(7, 3)}`)

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Çok satırlı string (template literal)
// Neden: \n eklemekle uğraşmadan satır satır metin yazmak için.

var davetliListesi = `Davetliler:
- Ahmet
- Emir
- Ejder
- Ekrem`

// alert ile metni ekranda görmek için
alert(davetliListesi)


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Kaçış karakterleri (escape sequences)
// \n: yeni satır
// Neden: Normal tırnaklı string'lerde çok satırlı yazmak için \n kullanılır.

var isimList = "İsimler:\n- Ahmet\n- Emir\n- Ejder\n- Ekrem"
alert(isimList)


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Unicode karakterleri
// Neden: Klavyede olmayan sembolleri Unicode koduyla string içine yazabiliriz.

// \u263A: ☺ (smiley)
var smiley = "\u263A"
alert(smiley)

// \u00A9: © (copyright)
var copyright = "\u00A9 2024"
alert(copyright)


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// String uzunluğu (length)
// Neden: karakter sayısı, doğrulama (min/max), sayaç gibi yerlerde kullanılır.

var yazı = "Ahmet"
// length: string'in karakter sayısını verir.
alert(yazı.length) //5

var yazı2 = "Merhaba Dünya"
alert(yazı2.length) //13 (boşluk da karakterdir)

var boşYazı = ""
alert(boşYazı.length) //0

var boşlukYazı = " "
alert(boşlukYazı.length) //1


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// String karakterlerine erişim
// Neden: belirli harfi almak, kontrol etmek, döngüyle işlemek vb.

var isim = "Ahmet"

// Modern yöntem: Köşeli parantez ile index erişimi
// Not: Index 0'dan başlar.
alert(isim[0]) //A
alert(isim[1]) //h
alert(isim[2]) //m
alert(isim[3]) //e
alert(isim[4]) //t
// Sınır dışı index -> undefined
alert(isim[5]) //undefined

// Klasik yöntem: charAt(index)
// Fark: Sınır dışı index için "" (boş string) döndürür.
alert(isim.charAt(0)) //A
alert(isim.charAt(1)) //h
alert(isim.charAt(2)) //m
alert(isim.charAt(3)) //e
alert(isim.charAt(4)) //t
alert(isim.charAt(5)) //"" (boş string)


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// String üzerinde döngü ve string'lerin değişmezliği (immutability)
// Neden: karakter karakter gezip işlem yapmak için.

// for...of: string'i karakter karakter dolaşır.
for(var i of isim) {
    alert(i)
}

// String'ler değişmezdir: isim[0] değerini doğrudan değiştiremezsin.
isim[0] //A
isim[0] = "E" // hata vermez ama string değişmez olduğu için işe yaramaz
alert(isim) //Ahmet

// Değiştirmek için yeni bir string oluşturursun.
isim = isim[0] + "hmet" // yeni string
alert(isim) //Ahmet

isim = isim[3] + "hmet" // yeni string (3. index 'e')
alert(isim) //ehmet


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// String metotları: küçük/büyük harf ve arama
// Neden: kullanıcı girdisini normalize etmek (küçültmek), bir metnin içinde arama yapmak.

var isim = "Ahmet"

// toLowerCase(): tüm harfleri küçük yapar (yeni string döndürür)
isim.toLowerCase()
alert(isim.toLowerCase()) //ahmet

// toUpperCase(): tüm harfleri büyük yapar (yeni string döndürür)
isim.toUpperCase()
alert(isim.toUpperCase()) //AHMET

// indexOf(aranan, başlangıçIndexi?): metinde aranan kısmın başladığı index'i döndürür.
// Bulamazsa -1 döndürür.
isim.indexOf("emir") //-1
isim.indexOf("Ah") //0
isim.indexOf("met") //2
isim.indexOf("m") //2
// İkinci parametre ile aramaya belirli bir indexten başlanır.
isim.indexOf("e", 3) //3
isim.indexOf("A", 1) //-1


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Arama ve kontrol metotları (indexOf / lastIndexOf / includes / startsWith / endsWith)
// Neden: bir metnin içinde kelime var mı, nerede geçiyor, başta/sonda mı gibi kontroller.

var tekerleme = "Bir berber bir berbere gel beraber bir berber dükkanı açalım demiş."

// indexOf: metin içinde arama yapar, ilk geçen yerin index'ini döner.
tekerleme.indexOf("bir") //10

// indexOf(aranan, başlangıçIndexi): belirtilen indexten itibaren arar.
tekerleme.indexOf("bir",11) //22

// lastIndexOf: sondan geriye doğru arar (son geçen yeri bulmak için)
tekerleme.lastIndexOf("bir") //43

// includes: metin içeriyor mu? (true/false)
tekerleme.includes("berber") //true
tekerleme.includes("Berber") //false (büyük/küçük harf duyarlı)
tekerleme.includes("berbere") //true

// startsWith: belirtilen ifadeyle başlıyor mu?
tekerleme.startsWith("bir") //false
tekerleme.startsWith("Bir") //true
tekerleme.startsWith("berber") //false

// endsWith: belirtilen ifadeyle bitiyor mu?
tekerleme.endsWith("demiş") //false
tekerleme.endsWith("demiş.") //true (nokta da karakterdir)
tekerleme.endsWith("açalım") //false


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Parça alma (slice / substring / substr)
// Neden: metinden belirli bir kısmı almak (ör. kullanıcı adı, uzantı, ilk/son karakterler).

var isim = "Ahmet"

// slice(start, end?): end dahil değildir. Negatif index alabilir (sondan sayar).
isim.slice(1) //hmet
isim.slice(0,5) //Ahmet
isim.slice(0, 2) //Ah
isim.slice(2, 4) //me
isim.slice(-2) //et
isim.slice(1, -1) //hme

// substring(start, end?): end dahil değildir. Negatif değerleri 0 gibi kabul eder.
isim.substring(1) //hmet
isim.substring(0,5) //Ahmet
isim.substring(0, 2) //Ah
isim.substring(2, 4) //me
// substring negatif değer almaz

// substr(start, length): start'tan başlar, length kadar alır.
// Not: substr modern JS'te "legacy" sayılır; genelde slice tercih edilir.
isim.substr(1) //hmet
isim.substr(0,5) //Ahmet
isim.substr(0, 2) //Ah
isim.substr(2, 2) //me
isim.substr(-2) //et


/////////////////////////////////////////////////////////////////////////////////////////////////////////
// String karşılaştırma
// Neden: alfabetik sıralama, karşılaştırma kurallarını anlamak.
// Not: String karşılaştırma Unicode sıralamasına göre yapılır; Türkçe/yerel kurallar için localeCompare kullanılır.

alert("a">"z") //false
alert("a"<"z") //true

// Karakter karakter karşılaştırır: abc < abd çünkü c < d
alert("abc"<"abd") //true
alert("abc">"abd") //false

// Eşitlik / eşit değil
alert("abc"=="abc") //true
alert("abc"!="abc") //false

// Büyük/küçük harflerin Unicode değerleri farklıdır
// "a" karakterinin Unicode değeri 97, "A" karakterinin Unicode değeri 65'tir.
// Bu yüzden "a" > "A" ifadesi true, "A" > "a" ifadesi de false olur.
alert("a">"A") //true
alert("A">"a") //false

// Yerel harfler (Ö gibi) Unicode sıralamasında beklediğin gibi davranmayabilir
alert("Österreich"<"Zealand") //false
alert("Zealand"<"Österreich") //true

// localeCompare: yerel kurallara göre karşılaştırma yapar.
// Sonuç: 0 eşit, -1 küçük, 1 büyük anlamına gelir.
alert("Österreich".localeCompare("Zealand")) //1
alert("Zealand".localeCompare("Österreich")) //-1


/////////////////////////////////////////////////////////////////////////////////////////////////////////
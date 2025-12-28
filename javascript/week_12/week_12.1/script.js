/////////////////////////////////////////////////////////////////////////////////////////////////////////

// 12. Hafta - Dizi Metotları
// Amaç: Array metotlarının "ne yapar" ve "neden kullanılır" mantığını görmek.
// Not: Bazı metotlar (concat/map/filter) yeni dizi döndürür, bazıları (sort/reverse) diziyi yerinde değiştirir.


var arr = [1, 2];
// concat(...): dizi(leri) birleştirir ve YENİ bir dizi döndürür (orijinal dizi değişmez).
// Neden: var olan diziyi bozmadan birleştirme yapmak.
console.log(arr.concat([3, 4], [5, 6])); // [1, 2, 3, 4, 5, 6]


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi = [1, 2];
// concat sonucu bir değişkene atanmazsa, dizi değişmez.
// Neden: concat "mutate" etmez, "return" ile yeni dizi verir.
dizi.concat([3, 4]);
console.log(dizi); // [1, 2]

// Aşağıdaki concat çağrıları da aynı şekilde: sonuç kullanılmadığı için etkisi yoktur.
dizi.concat(5, 6);
dizi.concat([7, 8], 9, 10);


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var obj = {
    0: "HTML",
    1: "CSS",
    2: "JavaScript",
    [Symbol.isConcatSpreadable]: true,
    length: 3
};

// Symbol.isConcatSpreadable = true olursa:
// concat, bu objeyi "dizi gibi" açarak (0..length-1) elemanları tek tek ekler.
// Neden: concat'in bazı array-benzeri objeleri nasıl yayabildiğini göstermek.
dizi.concat(obj); // ["HTML", "CSS", "JavaScript"]


/////////////////////////////////////////////////////////////////////////////////////////////////////////


/**
 * An array containing a mix of numbers, boolean, and strings.
 * 
 * @type {(number|boolean|string)[]}
 * @example
 * // dizi2 = [1, 2, false, 'Ahmet', 'Emir']
 */
var dizi2 = [1, 2 , false, 'Ahmet', 'Emir']

// indexOf(x): dizide x'in ilk bulunduğu index'i döndürür; yoksa -1 döner.
// Neden: "var mı" ve "nerede" kontrolü.
dizi2.indexOf(false); // 2
dizi2.indexOf('Emir');  // 4
dizi2.indexOf(3); // -1
// indexOf(x, start): aramaya start index'inden başlar.
dizi2.indexOf('Ahmet', 3); // -1
// start negatifse (örn -4), length + start olarak hesaplanır.
dizi2.indexOf('Ahmet', -4); // 3

// concat ile yeni eleman eklersek, yeni bir dizi döner; burada geri atama yapıyoruz.
dizi2 = dizi2.concat(0);
dizi2.indexOf(0,2); // 5


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi2 = [1, 2 , false, 'Ahmet', 'Emir']
// lastIndexOf(x): sondan başa doğru arar, x'in son bulunduğu index'i döndürür.
dizi2.lastIndexOf(false); // 2
dizi2.lastIndexOf('Emir');  // 4
// includes(x): içeriyor mu? true/false döndürür (okunabilir "var mı" kontrolü).
dizi2.includes(3); // false
dizi2.includes('Ahmet', 3); // true
dizi2.includes('ahmet', 3); // false
dizi2.includes(false); // true


if (dizi2.includes('Emir')) {
    // Neden: Koşula bağlı işlem yapmak (dizide varsa mesaj yazdır).
    console.log('Dizi içerisinde Emir değeri bulunmaktadır.');
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var kullanıcılar = [
    {id: 1, isim: 'Ahmet'},
    {id: 2, isim: 'Emir'},
    {id: 3, isim: 'Mehmet'}
];


// find(predicate): şartı sağlayan İLK elemanı döndürür; bulamazsa undefined.
// Neden: id ile tek kayıt bulmak gibi durumlar.
var bul = kullanıcılar.find(i => i.id == 2);                              //find kurala uymaya başlayan ilk elemanı döner
console.log(bul); // {id: 2, isim: 'Emir'}


// filter(predicate): şartı sağlayan TÜM elemanları döndürür; sonuç her zaman dizidir.
// Neden: listeyi süzmek (ör. id < 3 olanlar).
var state = kullanıcılar.filter(i => i.id < 3);                           //filter kurala uyan tüm elemanları döner
console.log(state); // [{id: 1, isim: 'Ahmet'}, {id: 2, isim: 'Emir'}]

/////////////////////////////////////////////////////////////////////////////////////////////////////////


// map(transform): her elemanı dönüştürür, aynı uzunlukta YENİ dizi döndürür.
// Neden: "isim -> uzunluk" gibi dönüşümler.
var uzunluklar = ['Ahmet', 'Emir', 'Mehmet', 'Ejder', 'Duru'].map(i => i.length);         // map her eleman için verilen işlemi yapar ve yeni dizi döner
console.log(uzunluklar); // [5, 4, 6, 5, 4]                                               // Ahmet'in uzunluğu 5, Emir'in uzunluğu 4 ...


var uzunluklar2 = ['Ahmet', "2 + 3 = 5"].map(i => i.length);
console.log(uzunluklar2); // [5, 9]

// var uzunluklar3 = [undefined].map(i => i.length);
// console.log(uzunluklar3); // [error]

// NaN bir number değeridir; NaN.length olmadığı için undefined döner (hata vermez).
var uzunluklar4 = [NaN].map(i => i.length);
console.log(uzunluklar4); // [undefined]

// Bu objede length alanı yok; o yüzden undefined döner.
var uzunluklar5 = [{0:"Ahmet", 1:"Mehmet"}].map(i => i.length);
console.log(uzunluklar5); // [undefined]


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi = [1, 2, 3, 4, 5];
// sort(): varsayılan olarak elemanları string gibi sıralar (sayılarda yanıltıcı olabilir).
console.log(dizi.sort()); // [1, 2, 3, 4, 5]

var dizi2 = [1, 3, 15, 2, 22, 4, 43];
console.log(dizi2.sort()); // [1, 15, 2, 22, 3, 4, 43]

var dizi3 = ['ahmet', 'emir', 'mehmet', 'zeynep', 'ali'];
console.log(dizi3.sort()); // alfabetik sıralama

function siralama(a, b) {
    // compareFn: <0 ise a önce, >0 ise b önce, 0 ise sırası değişmez.
    if (a < b) {
        return 1;
    }
    if (a > b) {
        return -1;
    }
    if (a == b) {
        return 0;
    }
}

console.log(dizi2.sort(siralama)); // [43, 22, 15, 4, 3, 2, 1]
// a - b: küçükten büyüğe sayısal sıralama (negatif/pozitif fark ile karar verir)
console.log(dizi2.sort((a, b) => a - b)); // [1, 2, 3, 4, 15, 22, 43] küçükten büyüğe
// b - a: büyükten küçüğe
console.log(dizi2.sort((a, b) => b - a)); // [43, 22, 15, 4, 3, 2, 1] büyükten küçüğe


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi4 = [1, 3, 2, 5, 4, 15, 25, 12, 53];
// reverse(): diziyi yerinde ters çevirir (orijinal dizi değişir).
console.log(dizi4.reverse()); // [53, 12, 25, 15, 4, 5, 2, 3, 1]
var dizi5 = ['ahmet', 'emir', 'mehmet', 'zeynep', 'ali'];
console.log(dizi5.reverse()); // ['ali', 'zeynep', 'mehmet', 'emir', 'ahmet']


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var isimler = "Ahmet Avcıoğlu, Emir Hamurcu, İdil Yücel, Ertuğrul Şen, Burcu Davran";

// split(", "): string'i ayırıcıya göre böler ve dizi döndürür.
var isimlerDizi = isimler.split(", "); // [ 'Ahmet Avcıoğlu', 'Emir Hamurcu', 'İdil Yücel', 'Ertuğrul Şen', 'Burcu Davran' ]
console.log(isimlerDizi);
// map + split(" "): her "Ad Soyad" ifadesini parçalayarak ad/soyad alıyoruz.
var tekIsimler = isimlerDizi.map(i => i.split(" ")[0]); // [ 'Ahmet', 'Emir', 'İdil', 'Ertuğrul, 'Burcu' ]
var soyisimler = isimlerDizi.map(i => i.split(" ")[1]); // [ 'Avcıoğlu', 'Hamurcu', 'Yücel', 'Şen, 'Davran' ]

console.log(tekIsimler);
console.log(soyisimler);


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi6 = ['Ahmet', 'Emir', 'Mehmet', 'Derya', 'Zeynep'];
// join(" "): elemanları ayırıcı ile birleştirip tek string yapar.
var dizi7 = dizi6.join(" "); // "Ahmet Emir Mehmet Derya Zeynep"
console.log(dizi7);

// forEach(fn): her eleman için fn çalıştırır; yeni dizi döndürmez.
dizi6.forEach(alert); // her bir elemanı alert ile gösterir

// Array.isArray(x): x bir dizi mi? (typeof burada yeterli değildir)
console.log(Array.isArray(dizi6)); // true
console.log(Array.isArray('Ahmet')); // false
console.log(Array.isArray({})); // false


/////////////////////////////////////////////////////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////////////////////////////////////////////////////

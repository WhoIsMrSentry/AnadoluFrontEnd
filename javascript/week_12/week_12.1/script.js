/////////////////////////////////////////////////////////////////////////////////////////////////////////


var arr = [1, 2];
console.log(arr.concat([3, 4], [5, 6])); // [1, 2, 3, 4, 5, 6]


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi = [1, 2];
dizi.concat([3, 4]);
console.log(dizi); // [1, 2]

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

dizi.concat(obj); // ["HTML", "CSS", "JavaScript"]


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi2 = [1, 2 , false, 'Ahmet', 'Emir']

dizi2.indexOf(false); // 2
dizi2.indexOf('Emir');  // 4
dizi2.indexOf(3); // -1
dizi2.indexOf('Ahmet', 3); // -1
dizi2.indexOf('Ahmet', -4); // 3

dizi2 = dizi2.concat(0);
dizi2.indexOf(0,2); // 5


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi2 = [1, 2 , false, 'Ahmet', 'Emir']
dizi2.lastIndexOf(false); // 2
dizi2.lastIndexOf('Emir');  // 4
dizi2.includes(3); // false
dizi2.includes('Ahmet', 3); // true
dizi2.includes('ahmet', 3); // false
dizi2.includes(false); // true


if (dizi2.includes('Emir')) {
    console.log('Dizi içerisinde Emir değeri bulunmaktadır.');
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var kullanıcılar = [
    {id: 1, isim: 'Ahmet'},
    {id: 2, isim: 'Emir'},
    {id: 3, isim: 'Mehmet'}
];


var bul = kullanıcılar.find(i => i.id == 2);                              //find kurala uymaya başlayan ilk elemanı döner
console.log(bul); // {id: 2, isim: 'Emir'}


var state = kullanıcılar.filter(i => i.id < 3);                           //filter kurala uyan tüm elemanları döner
console.log(state); // [{id: 1, isim: 'Ahmet'}, {id: 2, isim: 'Emir'}]

/////////////////////////////////////////////////////////////////////////////////////////////////////////


var uzunluklar = ['Ahmet', 'Emir', 'Mehmet', 'Ejder', 'Duru'].map(i => i.length);         // map her eleman için verilen işlemi yapar ve yeni dizi döner
console.log(uzunluklar); // [5, 4, 6, 5, 4]                                               // Ahmet'in uzunluğu 5, Emir'in uzunluğu 4 ...


var uzunluklar2 = ['Ahmet', "2 + 3 = 5"].map(i => i.length);
console.log(uzunluklar2); // [5, 9]

// var uzunluklar3 = [undefined].map(i => i.length);
// console.log(uzunluklar3); // [error]

var uzunluklar4 = [NaN].map(i => i.length);
console.log(uzunluklar4); // [undefined]

var uzunluklar5 = [{0:"Ahmet", 1:"Mehmet"}].map(i => i.length);
console.log(uzunluklar5); // [undefined]


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi = [1, 2, 3, 4, 5];
console.log(dizi.sort()); // [1, 2, 3, 4, 5]

var dizi2 = [1, 3, 15, 2, 22, 4, 43];
console.log(dizi2.sort()); // [1, 15, 2, 22, 3, 4, 43]

var dizi3 = ['ahmet', 'emir', 'mehmet', 'zeynep', 'ali'];
console.log(dizi3.sort()); // alfabetik sıralama

function siralama(a, b) {
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
console.log(dizi2.sort((a, b) => a - b)); // [1, 2, 3, 4, 15, 22, 43] küçükten büyüğe
console.log(dizi2.sort((a, b) => b - a)); // [43, 22, 15, 4, 3, 2, 1] büyükten küçüğe


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi4 = [1, 3, 2, 5, 4, 15, 25, 12, 53];
console.log(dizi4.reverse()); // [53, 12, 25, 15, 4, 5, 2, 3, 1]
var dizi5 = ['ahmet', 'emir', 'mehmet', 'zeynep', 'ali'];
console.log(dizi5.reverse()); // ['ali', 'zeynep', 'mehmet', 'emir', 'ahmet']


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var isimler = "Ahmet Avcıoğlu, Emir Hamurcu, İdil Yücel, Ertuğrul Şen, Azra Akgün, Burcu Davran";

var isimlerDizi = isimler.split(", "); // [ 'Ahmet Avcıoğlu', 'Emir Hamurcu', 'İdil Yücel', 'Ertuğrul Şen', 'Azra Akgün', 'Burcu Davran' ]
console.log(isimlerDizi);
var tekIsimler = isimlerDizi.map(i => i.split(" ")[0]); // [ 'Ahmet', 'Emir', 'İdil', 'Ertuğrul', 'Azra', 'Burcu' ]
var soyisimler = isimlerDizi.map(i => i.split(" ")[1]); // [ 'Avcıoğlu', 'Hamurcu', 'Yücel', 'Şen', 'Akgün', 'Davran' ]

console.log(tekIsimler);
console.log(soyisimler);


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var dizi6 = ['Ahmet', 'Emir', 'Mehmet', 'Derya', 'Zeynep'];
var dizi7 = dizi6.join(" "); // "Ahmet Emir Mehmet Derya Zeynep"
console.log(dizi7);


dizi6.forEach(alert); // her bir elemanı alert ile gösterir

console.log(Array.isArray(dizi6)); // true
console.log(Array.isArray('Ahmet')); // false
console.log(Array.isArray({})); // false


/////////////////////////////////////////////////////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////////////////////////////////////////////////////

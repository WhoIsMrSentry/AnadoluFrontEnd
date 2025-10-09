var deger1 = true;
var deger2 = false; 
var yıl = prompt("Mevcut Yılı girin", "örnek 2024");

if (deger1) {
    console.log("deger1 true");
} else {
    console.log("deger1 false");
}

if (deger2) {
    console.log("deger2 true");
} else {
    console.log("deger2 false");
}

if (yıl == 2025) {
    console.log("Mevcut yıl 2025");
} else if (yıl < 2025) {
    console.log("Yıl 2025'ten küçük" + " " + "Geçerli yıl" + " " + yıl);
} else {
    console.log("Yıl 2025'ten büyük" + " " + "Geçerli yıl"+ " " + yıl);
}


if (0) {
    console.log("0 true");
}else {
    console.log("0 false");
}


if (1) {
    console.log("1 true");
}else {
    console.log("1 false");
}

var sayı = 5;
var sayı2 = 6;

if (sayı>sayı2) {
    console.log(" koşul sağalanıyor" + " " + sayı + " " + "büyüktür" + " " + sayı2);
}
else if (sayı==sayı2) {
    console.log("koşul sağlanıyor" + " " + sayı + " " + "eşittir" + " " + sayı2);
}
else {
    console.log("koşul sağlanmıyor" + " " + sayı + " " + "küçüktür" + " " + sayı2);
}   

if (typeof (sayı / sayı2) === "number" && !isNaN(sayı / sayı2)) {         
    console.log("sayı sayıdır");
} else {
    console.log("sayı sayı değildir");
}

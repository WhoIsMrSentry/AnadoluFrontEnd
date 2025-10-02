// Temel türler ve dönüşümler
var deger = 5; // number türünde bir değer
console.log(typeof deger); // "number"

var deger2 = Number("deger"); // sayıya çevirmeye çalışır: NaN döner
console.log(typeof deger2, deger2); // "number" ve NaN

var text = 5;
console.log(typeof text); // "number"

var text2 = String(text); // sayıyı stringe çevirir -> "5"
console.log(typeof text2, text2); // "string", "5"

// İşlemler ve beklenen sonuçlar
console.log(2 + 3); // 5 (aritmetik toplama)
console.log("3" + "2"); // "32" (string birleştirme)
console.log("6" / "3"); // 2 (bölmede sayısal dönüşüm yapılır)

var deger = "Ahmet";
console.log(Boolean(deger)); // true (boş olmayan string truthy)

// Tür zorlaması (coercion) örnekleri
console.log("" + 1 + 0); // "10"
console.log("" - 1 + 0); // -1 (boş string -> 0)
console.log(true + false); // 1 (1 + 0)
console.log(6 / "3"); // 2
console.log("2" * "3"); // 6
console.log(4 + 5 + "px"); // "9px"
console.log("4" - 3); // 1
console.log(7 / 0); // Infinity
console.log(null + 1); // 1 (null -> 0)
console.log(undefined + 1); // NaN

// Aritmetik ve operatör önceliği
console.log((5 + 12) / (2*2)); // 17/4 = 4.25
console.log(10 % 3); // 1 (mod)
console.log(2 * 3); // 6
console.log(2 ** 3); // 8 (üs alma)
console.log(2 + 3 * 4); // 14 (çarpma önce)

// Artırma/Azaltma ve bileşik atama
var a = 1;
a++; // a = a + 1
console.log(a); // 2

var b = 1;
b--; // b = b - 1
console.log(b); // 0

var c = 1;
console.log(c + 5); // 6
    
var num = 10;
num += 5; // num = num + 5
console.log(num); // 15

var num2 = 10;
num2 *= 5; // num2 = num2 * 5
console.log(num2); // 50

var num3 = 10;
num3 -= 5; // num3 = num3 - 5
console.log(num3); // 5

var num4 = 10;
num4 /= 5; // num4 = num4 / 5
console.log(num4); // 2




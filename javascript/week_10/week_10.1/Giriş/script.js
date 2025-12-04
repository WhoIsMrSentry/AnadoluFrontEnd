///////////////////////////////////////////////////////////////////////////////////////////////////////////
var milyon = 1000000;
alert(milyon);

var milyar = 1000000000;
alert(milyar);

var kisaMilyon = 1e6;
alert(kisaMilyon);

var kisaMilyar = 1e9;
alert(kisaMilyar);

alert(7.3e9); // 7.3 milyar

///////////////////////////////////////////////////////////////////////////////////////////////////////////

var sayı = 255;
alert(sayı.toString(16)); // "ff"
alert(sayı.toString(2));  // "11111111"

var sayı2 = 250;
alert(sayı2.toString(16)); // "fa"
alert(sayı2.toString(2));  // "11111010"

/////////////////////////////////////////////////////////////////////////////////////////////////////////

var sayı3 = 3.14;

alert("sayı3 = " + sayı3 + " için Math.floor: " + Math.floor(sayı3)); // 3
alert("sayı3 = " + sayı3 + " için Math.ceil: " + Math.ceil(sayı3)); // 4
alert("sayı3 = " + sayı3 + " için Math.round: " + Math.round(sayı3)); // 3
alert("sayı3 = " + sayı3 + " için Math.trunc: " + Math.trunc(sayı3)); // 3

var sayı4 = 9.81;

alert("sayı4 = " + sayı4 + " için Math.floor: " + Math.floor(sayı4)); // 9
alert("sayı4 = " + sayı4 + " için Math.ceil: " + Math.ceil(sayı4)); // 10
alert("sayı4 = " + sayı4 + " için Math.round: " + Math.round(sayı4)); // 10
alert("sayı4 = " + sayı4 + " için Math.trunc: " + Math.trunc(sayı4)); // 9

var sayı5 = -3.14;

alert("sayı5 = " + sayı5 + " için Math.floor: " + Math.floor(sayı5)); // -4
alert("sayı5 = " + sayı5 + " için Math.ceil: " + Math.ceil(sayı5)); // -3
alert("sayı5 = " + sayı5 + " için Math.round: " + Math.round(sayı5)); // -3
alert("sayı5 = " + sayı5 + " için Math.trunc: " + Math.trunc(sayı5)); // -3


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var sayı6 = 1.23456;
alert(Math.floor(sayı6 * 100) / 100); // 1.23

var sayı7 = 1.23756;
alert(sayı7.toFixed(3)); // "1.238"

alert(0.1 + 0.2); // 0.30000000000000004 (2+2 = 5 burdan çıkıyor) 
alert((0.1 + 0.2 == 0.3)); // false

alert((0.1 + 0.2).toFixed(2)); // "0.30"
alert(Number((0.1 + 0.2).toFixed(2)) == 0.3); // true


/////////////////////////////////////////////////////////////////////////////////////////////////////////


"Ahmet" / 5 // NaN
isNaN("Ahmet" / 5) // true

alert(NaN === NaN); // false


var ahmet = "Ahmet" / 5;
alert(isNaN(ahmet)); // true

var emir = "Ahmet" / 5;
alert(isNaN(emir)); // true

ahmet == emir // false
ahmet === emir // false


///////////////////////////////////////////////////////////////////////////////////////////////////////////


isFinite("ahmet"); // false
isFinite(5); // true
isFinite(NaN); // false
isFinite(Infinity); // false
isFinite(-Infinity); // false


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var sayıX = 123;
typeof sayıX; // "number"

var sayıY = "123";
typeof sayıY; // "string"

var sayıZ = Number("123");
typeof sayıZ; // "number"

var sayıT = "123";
typeof(+sayıT); // "number"

+2546489; // 2546489
+ "2546489"; // 2546489


/////////////////////////////////////////////////////////////////////////////////////////////////////////


// parseInt örnekleri
parseInt("100px"); // 100
parseInt("00EmirHamurcuasjdvgasytdasda"); // 0
parseInt("EmirHamurcuasjdvgasytdasda"); // NaN
parseInt("a100"); // NaN
parseInt("123.45"); // 123
parseInt("010"); // 10 (onluk tabanda)
parseInt("010", 8); // 8 (sekizlik tabanda)

// parseFloat örnekleri
parseFloat("123.45"); // 123.45
parseFloat("100px"); // 100
parseFloat("Emir123.45"); // NaN
parseFloat("123.45abc"); // 123.45
parseFloat("0.1e2"); // 10
parseFloat("   5.67   "); // 5.67

alert(parseFloat("1.2.34")); // 1.2


/////////////////////////////////////////////////////////////////////////////////////////////////////////


alert(Math.random()); // 0 ile 1 arasında rastgele sayı üretir
alert(Math.random() * 10); // 0 ile 10 arasında rastgele sayı üretir
alert(Math.random() * 100); // 0 ile 100 arasında rastgele sayı üretir

alert(parseInt(Math.random())); // 0 ile 1 arasında rastgele tam sayı üretir
alert(parseInt(Math.random() * 10)); // 0 ile 10 arasında rastgele tam sayı üretir
alert(parseInt(Math.random() * 100)); // 0 ile 100 arasında rastgele tam sayı üretir


/////////////////////////////////////////////////////////////////////////////////////////////////////////


Math.max(3, 5, -10, 0, 1); // 5
Math.min(3, 5, -10, 0, 1); // -10
Math.pow(2, 3); // 8


/////////////////////////////////////////////////////////////////////////////////////////////////////////

function difference(a, b) {
    return Math.abs(a - b);
}

alert(difference(5, 3)); // 2
alert(difference(5, 10)); // 2

/////////////////////////////////////////////////////////////////////////////////////////////////////////
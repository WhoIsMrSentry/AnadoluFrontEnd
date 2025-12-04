/////////////////////////////////////////////////////////////////////////////////////////////////////////

var text = "Ahmet"
var text2 = 'Mehmet'
var text3 = `Ayşe`

console.log(text)
console.log(text2)
console.log(text3)

function toplam(a, b) {
    return a + b;
}


alert("Toplam: " + toplam(5, 10));


alert(`Toplam: ${toplam(7, 3)}`)

/////////////////////////////////////////////////////////////////////////////////////////////////////////


var davetliListesi = `Davetliler:
- Ahmet
- Emir
- Ejder
- Ekrem`

alert(davetliListesi)


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var isimList = "İsimler:\n- Ahmet\n- Emir\n- Ejder\n- Ekrem"
alert(isimList)


/////////////////////////////////////////////////////////////////////////////////////////////////////////


//unicode karakterleri (internetten bakılabilir ezber yapmaya gerek yok)
var smiley = "\u263A"
alert(smiley)

var copyright = "\u00A9 2024"
alert(copyright)


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var yazı = "Ahmet"
alert(yazı.length) //5

var yazı2 = "Merhaba Dünya"
alert(yazı2.length) //13

var boşYazı = ""
alert(boşYazı.length) //0

var boşlukYazı = " "
alert(boşlukYazı.length) //1


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var isim = "Ahmet"

//string karakterlerine erişim modern yöntem
alert(isim[0]) //A
alert(isim[1]) //h
alert(isim[2]) //m
alert(isim[3]) //e
alert(isim[4]) //t
alert(isim[5]) //undefined

//string karakterlerine erişim klasik yöntem
alert(isim.charAt(0)) //A
alert(isim.charAt(1)) //h
alert(isim.charAt(2)) //m
alert(isim.charAt(3)) //e
alert(isim.charAt(4)) //t
alert(isim.charAt(5)) //"" (boş string)


/////////////////////////////////////////////////////////////////////////////////////////////////////////


for(var i of isim) {
    alert(i)
}

isim[0] //A
isim[0] = "E" //hata vermez ama değişiklik yapmaz 
alert(isim) //Ahmet

isim = isim[0] + "hmet" //değişiklik yapılabilir
alert(isim) //Ahmet
isim = isim[3] + "hmet" //değişiklik yapılabilir
alert(isim) //ehmet


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var isim = "Ahmet"

isim.toLowerCase() //tüm karakterleri küçük yapar
alert(isim.toLowerCase()) //ahmet

isim.toUpperCase() //tüm karakterleri büyük yapar
alert(isim.toUpperCase()) //AHMET

isim.indexOf("emir") //-1 (bulamazsa -1 döner)
isim.indexOf("Ah") //0 (başlangıçtan itibaren arar)
isim.indexOf("met") //2 (başlangıçtan itibaren arar)
isim.indexOf("m") //2 (başlangıçtan itibaren arar)
isim.indexOf("e", 3) //3 (3. indexten itibaren arar)
isim.indexOf("A", 1) //-1 (1. indexten itibaren arar)


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var tekerleme = "Bir berber bir berbere gel beraber bir berber dükkanı açalım demiş."

tekerleme.indexcOf("bir") //1
tekerleme.indexOf("bir",1) //5
tekerleme.lastIndexOf("bir") //43     //sondan aramaya başlar genelde kullanılmaz


tekerleme.includes("berber") //true
tekerleme.includes("Berber") //false
tekerleme.includes("berbere") //true

tekerleme.startsWith("bir") //false
tekerleme.startsWith("Bir") //true
tekerleme.startsWith("berber") //false

tekerleme.endsWith("demiş") //false
tekerleme.endsWith("demiş.") //true
tekerleme.endsWith("açalım") //false


/////////////////////////////////////////////////////////////////////////////////////////////////////////


var isim = "Ahmet"
isim.slice(1) //hmet
isim.slice(0,5) //Ahmet
isim.slice(0, 2) //Ah
isim.slice(2, 4) //me
isim.slice(-2) //et
isim.slice(1, -1) //hme

isim.substring(1) //hmet
isim.substring(0,5) //Ahmet
isim.substring(0, 2) //Ah
isim.substring(2, 4) //me
//substring negatif değer almaz 

isim.substr(1) //hmet
isim.substr(0,5) //Ahmet
isim.substr(0, 2) //Ah
isim.substr(2, 2) //me
isim.substr(-2) //et


/////////////////////////////////////////////////////////////////////////////////////////////////////////


alert("a">"z") //false
alert("a"<"z") //true

alert("abc"<"abd") //true
alert("abc">"abd") //false

alert("abc"=="abc") //true
alert("abc"!="abc") //false

alert("a">"A") //true
alert("A"<"a") //false

alert("Österreich"<"Zealand") //false
alert("Zealand"<"Österreich") //true

alert("Österreich".localeCompare("Zealand")) //1
alert("Zealand".localeCompare("Österreich")) //-1


/////////////////////////////////////////////////////////////////////////////////////////////////////////
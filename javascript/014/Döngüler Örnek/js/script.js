var sayı = (prompt("Bir sayı girin:"));
var sayı2 = (prompt("Sınır için bir sayı girin (örneğin 100):"));
sayı = Number(sayı);
sayı2 = Number(sayı2);
console.log("Girdiğiniz sayı: " + sayı);


for (var i = 1; i <= sayı; i++) {
    if (i === sayı2) {
        console.log("Sınıra ulaşıldı, döngüden çıkılıyor");
        break;
    }
    
    if (i % 2 !== 0) {
        console.log(i); // i tek sayı ise logla
    }
    else {
        console.log(i + " çift sayı atlandı");
        continue;
    }
}

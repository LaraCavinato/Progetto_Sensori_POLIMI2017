import processing.serial.*;

Serial port; 

int numCircles = 5;
Circle[] circles = new Circle[numCircles];  //crea l'array contenenete i 5 oggetti della clesse cerchi
String intensity = "0";
 
//Funzione per creare la finestra grafica e inizializzare porta serial e array di cerchi
void setup() {  
  size (500, 200);
  noStroke ();
  int a = 50;
  
  String nameport = Serial.list()[1];  //sceglie dalla lista di porte serialidisponibili quella standard del Mac
  port = new Serial (this, nameport, 9600); 
   
  for (int i=0; i<numCircles; i++) {
     circles[i] = new Circle (a, 0.5*height); //reimpie l'array con oggetti della classe cerchio e li mette a metà altezza e equispaziati nella finestra
     a = a + 100;
  }
  
  
}


//disegna i cerchi nella finestra grafice che è appena stata creata
void draw() {
  
  background(255);
  for (int i=0; i<numCircles; i++) {
    circles[i].display(0); // disegna i cinque cerchi e li colora del colore base riferito a 0
  }
  // direttive per la scritta all'interno dell'interfaccia 
  String s = " Sugar quantity ";
  fill (0);
  textSize (32);
  textAlign (CENTER);
  text (s, 250, 40);
  
 
  //controlla che la porta seriale sia effettivamente aperta
  if (port.available()>0)
  {
    intensity = port.readString(); //legge il valore di intensità del led dalla porta seriale.
    println(intensity);
  }
  int lux=Integer.parseInt(intensity);
  for(int i=0;i<(lux/10)%5;i++){
    circles[i].display(1);
  }
}  
  
   
 

// classe crechio
class Circle {
  float x, y; // posizione del cerchio
  int dim; // dimensione del diametro
  color c; // colore
 
  Circle(float x, float y) { //riceve le posizioni di dove mettere il cerchio (a,0.5]height)
    this.x = x;
    this.y = y;
    dim = 50;
    c = color(220, 220, 220);  // colore di base dei cerchi prima che vengano modificati in base al led
  }
  
  void display(int col) { //metodo della classe cerchio che in base al valore di ingresso (1 o 0) modifica il colore del cerchio
    if (col == 0) {
      fill (c); 
    } else {
        fill (255, 255, 0);
      }
    ellipse (x, y, dim, dim); //tipo di oggetto che deve essere colorato
  } 
} 
  
ArrayList<bacteria> colony = new ArrayList<bacteria>();
ArrayList<bacteria> colony2 = new ArrayList<bacteria>();
ArrayList<food> fooda = new ArrayList<food>();
ArrayList<predator> predatora = new ArrayList<predator>();
ArrayList<predator> predatorb = new ArrayList<predator>();
void setup(){
  background(127);
  frameRate(60);
size(1080,720);
for(int i = 0; i <= 250; i++){
  int x = (int)(Math.random()*1080);
  int y = (int)(Math.random()*720);
colony.add(new bacteria(x,y));
}
for(int a = 0; a <= 150; a++){
  fooda.add(new food((int)(Math.random()*1060)+10,(int)(Math.random()*740)+10));
}
for(int b = 0; b <= 0; b++){
  predatora.add(new predator((int)(Math.random()*1060)+10,(int)(Math.random()*740)+10));
}
}
void draw(){
  background(127);
  for(food food : fooda){
food.show();
food.bacteria();
}
for(bacteria bob : colony){
bob.walk();
bob.show();
for(food food2 : fooda){
food2.eaten(bob);
}
}
for(predator predator : predatora){
predator.show();
predator.trackmove();
predator.eat();
}
for(bacteria bob : colony2){
  int indexa = 0;
  boolean success = false;
  for(bacteria bob2 : colony){
  if(bob2.alive == false){
  colony.set(indexa, bob);
  success = true;
  break;
  }
  indexa++;
  }
  if(success == false){
  colony.add(bob);
  }
}
for(predator predator : predatorb){
predatora.add(predator);
}
colony2 = new ArrayList<bacteria>();
predatorb = new ArrayList<predator>();
}
class bacteria{
  int myX;
  int myY;
  boolean alive;
  bacteria(int x, int y){
  myX = x;
  myY = y;
  alive = true;
  }
  void show(){
    if(alive){
  fill(0);
  stroke(0);
  ellipse(myX,myY,10,10);
  }
  }
  void walk(){
    if(alive){
  myX = myX + (int)(Math.random()*9)-4;
  if(myX < 10){
  myX = myX + (int)(Math.random()*10);
  }
  if(myX > 1070){
  myX = myX - (int)(Math.random()*10);
  }
  myY = myY + (int)(Math.random()*9)-4;
    if(myY < 10){
  myY = myY + (int)(Math.random()*10);
  }
  if(myY > 710){
  myY = myY - (int)(Math.random()*10);
  }
    }
  }
  void multiply(){
    if(alive){
  colony2.add(new bacteria(myX + (int)(Math.random()*5)-2, myY + (int)(Math.random()*5)-2));
    }
  }
}
class food{
  int myX;
  int myY;
  int spawntimer = 0;
  boolean alive;
  boolean spawned = true;
  food(int x, int y){
  myX = x;
  myY = y;
  }
  void eaten(bacteria bacteria){
    if(alive){
      if(bacteria.alive){
  int x = myX - bacteria.myX;
  x = x*x;
  int y = myY - bacteria.myY;
  y = y*y;
  int distance = x + y;
  distance = (int)Math.sqrt(distance);
  if(distance <= 15){
    if(alive){
  bacteria.multiply();
  alive = false;
    }
  }
      }
    }
  }
  void bacteria(){
  if(Math.random() < 0.00005){
    if(alive){
   alive = false;
   colony.add(new bacteria(myX,myY));
    }
  }
  }
  void show(){
    if(spawned){
    spawntimer++;
    }
    if(spawntimer >= 10){
    alive = true;
    spawntimer = 0;
    spawned = false;
    }
    if(alive){
    stroke(127,0,127);
   fill(127,0,127);
  ellipse(myX,myY,5,5);
    }
  }
}
class predator{
  int myX;
  int myY;
  int index2 = 0;
  int timer = 200;
  int size = 25;
  boolean alive = true;
  predator(int ax, int ay){
  myX = ax;
  myY = ay;
    int[] numbers;
  numbers = new int[colony.size()];
  int index = 0;
  for(bacteria bacteria : colony){
  if(bacteria.alive){
    int x = myX - bacteria.myX;
    int y = myY - bacteria.myY;
    x = x*x;
    y = y*y;
    int distance = (int)Math.sqrt(x+y);
  numbers[index] = distance;
  }else{
  numbers[index] = 1000000;
  }
  index++;
  }
  int lowestnum = numbers[0];
  for(int i = 0; i < colony.size(); i++){
  if(numbers[i] < lowestnum){
  lowestnum = numbers[i];
  index2 = i;
  }
  }
  }
  void show(){
    if(alive){
  fill(timer*2-145,0,0);
  stroke(0);
  ellipse(myX,myY,size,size);
  timer--;
  if(timer < 0){
  alive = false;
  }
    }
  }
  void trackmove(){
    if(alive){
    bacteria bob = colony.get(index2);
    if(bob.alive == false){
  int[] numbers;
  numbers = new int[colony.size()];
  int index = 0;
  for(bacteria bacteria : colony){
  if(bacteria.alive){
    int x = myX - bacteria.myX;
    int y = myY - bacteria.myY;
    x = x*x;
    y = y*y;
    int distance = x+y;
  numbers[index] = distance;
  }else{
  numbers[index] = 10000000;
  }
  index++;
  }
  int lowestnum = numbers[0];
  for(int i = 0; i < colony.size(); i++){
  if(numbers[i] < lowestnum){
  lowestnum = numbers[i];
  index2 = i;
  }
  }
  }
  int xdistance = bob.myX - myX;
  int ydistance = bob.myY - myY;
  int adistance = xdistance * xdistance + ydistance * ydistance;
  adistance = (int)Math.sqrt(adistance);
  int speed = 100/size;
  double time = (adistance/speed);
  double xmove = xdistance/time;
  double ymove = ydistance/time;
  myX = myX + (int)xmove;
  myY = myY + (int)ymove;
}
  }
  void eat(){
    if(alive){
  for(bacteria bacteria : colony){
    if(bacteria.alive){
  int x = bacteria.myX - myX;
  int y = bacteria.myY - myY;
  int distance = x*x + y*y;
  distance = (int)Math.sqrt(distance);
  if(distance < size/2){
  bacteria.alive = false;
  fooda.add(new food(myX,myY));
  size = size + 1;
  timer = 200;
  if(size > 50){
   predatorb.add(new predator(myX + (int)(Math.random()*51) - 25,myY + (int)(Math.random()*51) - 25 ));
   size = 25;
  }
  }
  }
  }
  }
  }
}

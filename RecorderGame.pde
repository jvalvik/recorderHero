PImage img;
Bullet c;
Bullet c1;
int speed = 3;

void setup() {
  size(1280,720);
  background(255);
  img = loadImage("recorder1280_720.jpg");
  for (int i = 0; i < 6; i++){
    int h = height/2-204;
  c = new Bullet(980,h);
  c1 = new Bullet(980,h+63);
  }
}

void draw() {
  background(img); 
  c.display();
  c.move(speed);
  c1.display();
  c1.move(speed);
}

Generator gen;

void setup() {
  size(800, 600);
  
  gen = new Generator();
  
  noSmooth();
}

void draw() {
  background(0);
  
  gen.draw();
}

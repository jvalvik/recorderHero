class Button {
  PVector Pos = new PVector(0, 0);
  float Width = 0;
  float Height = 0;
  color Colour;
  String Text;
  Boolean Pressed = false;
  Boolean Clicked = false;
  Boolean Stroke = false;

  Button(int x, int y, int w, int h, String t, int r, int g, int b, boolean s) {
    Pos.x = x;
    Pos.y = y;
    Width = w;
    Height = h;
    Colour = color(r, g, b);
    Text = t;
    Stroke = s;
  }

  void update() {
    if (mousePressed == true && mouseButton == LEFT && Pressed == false) {
      Pressed = true;
      if (mouseX >= Pos.x && mouseX <= Pos.x + Width && mouseY >= Pos.y && mouseY <= Pos.y + Height) {
        Clicked = true;
      }
    } else {
      Clicked = false;
    } 
    if (mousePressed != true) {
      Pressed = false;
    }
  }

  void changeColor(int grey) {
    Colour = color(grey);
  }

  void render() {
    fill(Colour);
    rect(Pos.x, Pos.y, Width, Height);
    
    fill(0);
    stroke(0);
    textSize(28);
    textAlign(CENTER, CENTER);
    if (Text == "Stop")
      fill(255, 0, 0);
    else if (Text == "Start")
      fill(0, 255, 0);
    else
      fill(0);
    text(Text, Pos.x+(Width/2), Pos.y+(Height/2));
  }
  boolean isClicked() {
    return Clicked;
  }
}

// Button Template

class Button {
  float x, y; 

  String t;

  Button(float x, float y, String t) { // Constructor for button 
    this.x = x;
    this.y = y;
    this.t = t;
  }

  void display() {
    // Template for the button
    textSize(48);
    if (mouseX > x-170 && mouseX < x+170 && mouseY > y+-10 && mouseY < y+70 ) {
      fill(100);
      stroke(255);
    } else {
      fill(0);
      stroke(255);
    }

    rectMode(CENTER);
    rect(x+0, y+30, 330, 70);

    strokeWeight(5);
    fill(255);
    text(t, x, y);
  }
}
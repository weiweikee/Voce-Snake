// Instruction Page

class Instruct {
  Button back; // Declaring Back Button

  Instruct() {
    back = new Button(width/2, 730, "Back");
  }

  // Displaying the instruction and back button.
  void display() {
    background(0);
    textAlign(CENTER, TOP);
    textSize(150);
    text("Instructions", width/2, 50);
    textSize(36);
    fill(255);
    text("1. Use Arrow keys to change direction", 450, 290);
    text("2. Press P to pause", 450, 390);
    text("3 .Hold Spacebar to activate voice control", 450, 490);
    textSize(16);
    text("'Up', 'Down', 'Left', 'Right' are commands for voice control.", 450, 555);
    text("Please only use one command at a time.", 450, 595);
    text("You can also say the command then press spacebar.", 450, 630);

    back.display();
    if (mousePressed == true) { 
      // Checking if the mouse is pressed in the button box.
      if (mouseX > back.x-170 && mouseX < back.x+170 && 
        mouseY > back.y+-10 && mouseY < back.y+70 ) {
        fill(255, 0, 0);
        gameState = 4; // Going back to Menu
        buttonSound.play();
      }
    }
  }
}
// HighScore Page

class HighScore {
  Button back; // Declaring back button



  HighScore() {
    back = new Button(width/2, 730, "Back"); // Creating Button
  }

  // Displaying the Highscore and back button.
  void display() {
    // HighScore Screen
    background(0);
    textAlign(CENTER, TOP);
    textSize(150);
    text("High Score", width/2, 50);
    text(highscore, width/2, 370);
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
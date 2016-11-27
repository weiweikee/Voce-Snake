// Menu Page

class Menu {
  Button start; // Declaring Start Button
  Button stat; // Declaring HighScore Button
  Button instruction; // Declaring Instruction Button

  Menu() {
    // Creating Each button
    start = new Button(450, 400, "Start");
    stat = new Button(450, 630, "High Score");
    instruction = new Button(450, 515, "Instruction");
  }


  void display() {
    loop();
    background(0);
    textAlign(CENTER, TOP);
    start.display();
    stat.display();
    instruction.display();


    fill(255);

    textAlign(CENTER, TOP);
    textSize(265);
    text("SNAKE", width/2, 50);
    if (mousePressed == true) { 
      // Checking if the mouse is pressed in the button box.
      if (mouseX > start.x-170 && mouseX < start.x+170 && 
        mouseY > start.y+-10 && mouseY < start.y+70 ) {
        fill(255, 0, 0);
        gameState = 1;  // Go to Game
        buttonSound.play();
      }
      if (mouseX > stat.x-170 && mouseX < stat.x+170 && 
        mouseY > stat.y+-10 && mouseY < stat.y+70 ) {
        gameState = 5; // Go to HighScore
        buttonSound.play();
      }
      if (mouseX > instruction.x-170 && mouseX < instruction.x+170 && 
        mouseY > instruction.y+-10 && mouseY < instruction.y+70 ) {
        gameState = 6; // Go to Instructions
        buttonSound.play();
      }
    }
  }
}
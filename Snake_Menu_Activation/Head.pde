//Snake's Head and Tail

class Head {



  Head() {
  }

  void display() {
    fill(255);
    stroke(0);
    strokeWeight(1);
    rectMode(CORNER); // reset rectangle to corner mode to fit in with the grid
    for (int i = 0; i < x.size(); i++) {
      rect(x.get(i)*cellWidth, y.get(i)*cellHeight, cellWidth, cellHeight);
      fill(200);
    }
  }

  void update() {
    // Updating movement for snake 
    if (frameCount%3==0) {
      // Credit to KTByte, Movement according to the direction X & Y arrays.
      x.add(0, x.get(0) + (directionX[dir]));  
      y.add(0, y.get(0) + (directionY[dir]));  
      // Checking Whether the snake eat the food
      if (x.get(0) == food.x && y.get(0) == food.y) { 
        // New foods
        food.x = int(random(gridWidth-1)); 
        food.y = int(random(gridHeight-1)); 
        score = score + 10; // Add 10 score per food
        sound.play(); // play sound effect
      } else {
        // Clear the arraylist if the food is not eaten so the snake would not get longer.
        x.remove(x.size()-1);
        y.remove(y.size()-1);
      }
    }
    // When snake go out off the screen, it will come back on the opposite size. 
    // (Gridwidth-1)  and (gridHeight-1) because array count from 0 to 29 instead of 1 to 30. 
    for (int i = 0; i < x.size(); i++) {
      if (x.get(0) > gridWidth-1) {  
        x.set(i, 0);
      }
      if (x.get(0) < 0) {
        x.set(i, gridWidth-1);
      }

      if (y.get(0) > gridHeight-1) {
        y.set(i, 0);
      }

      if (y.get(0) < 0) {
        y.set(i, gridHeight-1);
      }
    }
  }
  void check() {
    // Checking whether the snake head hit the tail
    fill(255);
    for (int i = 1; i < x.size(); i++) {
      // Checking if the first block hit any other blocks
      if (x.get(0) == x.get(i) && y.get(0) == y.get(i)) { 
        // Checking whether if we are playing the game
        if (gameState == 1) {
          // Game over screen (Will Not Loop so the text only appear one time) 
          gameState = 3; 
          text("Game Over", width/2, 325);
          textSize(50);
          text("Press M for Menu", width/2, 510);
          overSound.play();
          //noLoop();
        }
      }
    }
  }
}
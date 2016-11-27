// Snake Food

class Food {
  // Random inside the screen
  int x = int(random(gridWidth-1)); // Inside possible number of grids (0 - 29) 
  int y = int(random(gridHeight-1)); // Inside possible number of grids (0 - 29) 

  Food() {
  }


  void display() {
    noStroke();
    rectMode(CORNER);
    fill(255, 0, 0);
    // the grids will be multiple with the cell height and width to create the food.
    rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);
  }
}
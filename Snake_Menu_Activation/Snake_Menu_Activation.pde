// Voce Snake  //<>//
// by Wei Wei Chi Nov 2016

import processing.sound.*; // Importing Sound Library
import voce.*; // Import External Voce Library

String s; // Output String for Voce 
//Match Voce String with String Below
String Left = "left"; 
String Right = "right";
String Up = "up";
String Down = "down";
boolean voice = false; // Boolean to check whether voice recognition is on

int score = 0;
int highscore; 
int gameState = 4; 
// 1. Playing
// 2. Paused
// 3. Game Over
// 4. Main Menu
// 5. High Score
// 6. Instruction


int gridWidth = 30; // no. of cells
int gridHeight = 30; // no. of cells 

int cellWidth; // cell width size 
int cellHeight; // cell height size

ArrayList<Integer> x = new ArrayList<Integer> (); //Arraylist for snake's xPos
ArrayList<Integer> y = new ArrayList<Integer> (); //Arraylist for snake's yPos

int dir; // direction 
int newdir; // new direction // Credit to KTByte 

int[] directionX = {0, 0, -1, 1}; //UP, DOWN, LEFT, RIGHT Array for xdir  //Credit to KTByte 
int[] directionY = {-1, 1, 0, 0}; //UP, DOWN, LEFT, RIGHT Array for ydir //Credit to KTByte 


Head head; // Declaring snake head & tail
Food food; // Declaring food
Menu menu; // Declaring Menu Page
HighScore hScore; // Declaring Highscore page
Instruct instruct; // Declaring Instruction Page
Table table; // Declaring Table for CSV file
SoundFile sound; // Food Eating Sound Effect 
SoundFile overSound; // Game Over Sound Effect
SoundFile buttonSound; // Button Sound Effect

void setup() {
  frameRate(20); // set slower framerate to create snake's slow framerate effect
  size(900, 900);
  background(0);

  textSize(24);
  fill(255);
  //the following initiates the voce library //The library must be manually uploaded
  voce.SpeechInterface.init("Documents/Processing/libraries/voce-0.9.1/lib", 
    true, true, "Documents/Processing/libraries/voce-0.9.1/lib/gram", "directions");
  System.out.println("This is a speech recognition test. "); 

  x.add(round(gridWidth/2));  // Beginning xPos for snake
  y.add(round(gridHeight/2));  // Beginning yPos for snake

  // Calculate the cell size based on the grid size and the window size
  cellWidth = width/gridWidth; // Credit to Dan Wilcox's CellClick
  cellHeight = height/gridHeight; // Credit to Dan Wilcox's CellClick

  head = new Head(); // Creating snake head & tail
  food = new Food(); // Creating food
  menu = new Menu(); // Creating Menu
  hScore= new HighScore(); // Creating Highscore
  instruct = new Instruct(); // Creating Instruction Page
  table = loadTable("HighScore.csv", "header"); // Accessing Highscore csv file
  for (TableRow row : table.rows()) { // Accesing Row of the Highscore Data
    highscore = row.getInt("HighScore"); // Accessing HighScore for use
  }
  // Credit to FreeSound.org
  sound = new SoundFile(this, "mario_coin.wav"); // Food sound
  overSound = new SoundFile(this, "gameover.wav"); // Gameover sound
  buttonSound = new SoundFile(this, "blip.wav"); // Menu button sound
}



void draw() {
  // Checking whether voce is activated
  if (voice == true) {
    // For loop to do speech recognition
    if (voce.SpeechInterface.getRecognizerQueueSize() > 0) {
      s = voce.SpeechInterface.popRecognizedString(); 
      println(s);
      // Checking whether Voce command with direction.
      if (s.equals(Right) == true) {
        newdir = 3;
      }
      if (s.equals(Left) == true) {
        newdir = 2;
      }
      if (s.equals(Up) == true) {
        newdir = 0;
      }
      if (s.equals(Down) == true) {
        newdir = 1;
      }
      //Credit to KTByte 
      // Checking if the head touch the first tail
      if (x.size() <= 1 ||           
        !(x.get(1) == x.get(0)+directionX[newdir] && 
        y.get(1) == y.get(0)+directionY[newdir])) {
        dir = newdir;
      }
    }
  }
  if (gameState == 1) { // GameState 1 = play game
    playGame(); // Playing the Game.
  }

  if (gameState == 4) { // GameState 2 = Menu
    menu.display(); // Display Menu page.
  }

  if (gameState == 5) { // GameState 3 = HighScore
    hScore.display(); // Display Highscore page.
  }

  if (score > highscore) {
    highscore = score; // Replacing highscore.
    savingHighScore(); // Saving HighScore in CSV.
  }

  if (gameState == 6) { // GameState 6 = Instruction
    instruct.display(); // Display Instruction page.
  }
}   

// This function is the game itself
void playGame() {
  background(0);
  food.display(); // displaying food
  head.display(); // displaying snake
  head.update(); // updating snake 
  head.check(); // checking if snake touch food
  fill(255);
  textSize(36);
  textAlign(LEFT, BOTTOM);
  text("Score:" +score, 5, 36); // Score on top left corner
  textAlign(CENTER, CENTER);
  textSize(100);
}

void keyPressed() {
  // If spacebar is pressed activate voce
  if (key == ' ') {
    voice = true;
  } 
  // Toggle between Paused and Unpaused
  // The Gamestate is checked to see if it is paused or unpaused.
  if (key == 'p' || key == 'P') {
    if (gameState == 1) { 
      gameState = 2;
      text("Pause", width/2, 325);
      textSize(50);
      text("Press P to Unpause", width/2, 450); 
      text("Press M for Menu", width/2, 510);
      //noLoop();
    } else {
      if (gameState == 2) {
        gameState = 1;
        //loop();
      }
    }
  }
  // This is used to return to menu 
  // Gamestate check whether the game is paused or gameover
  if (key == 'm' || key == 'M') {
    if (gameState == 2 || gameState == 3) {
      //loop();
      gameState = 4;
      // This code clear the arraylist x and y to reset x and y positions
      x.clear(); 
      y.clear(); 
      // This code add x, y to the middle of the screen to reset x and y positions
      x.add(round(gridWidth/2)); 
      y.add(round(gridHeight/2));  
      score = 0;
    }
  }
  // Keyboard control for the snake
  if (key == CODED) {
    if (keyCode == RIGHT) {
      newdir = 3;
    } 
    if (keyCode == LEFT) {
      newdir = 2;
    }
    if (keyCode == UP) {
      newdir = 0;
    }
    if (keyCode == DOWN) {
      newdir = 1;
    } 

    // Credit to KTByte 
    // Checking if the head touch the first tail
    if (x.size() <= 1 ||          
      !(x.get(1) == x.get(0)+directionX[newdir] && 
      y.get(1) == y.get(0)+directionY[newdir])) {
      dir = newdir;
    }
  }
}

// Releasing Key which stop voce
void keyReleased() { 
  if (key == ' ') {
    voice = false;
  }
}           

void savingHighScore() {  // Function to Save HighScore.
  // Creating New CSV File to Save the Highscore.
  table = new Table();
  table.addColumn("HighScore");
  TableRow newRow = table.addRow();
  newRow.setInt("HighScore", highscore);

  saveTable(table, "data/HighScore.csv");
}
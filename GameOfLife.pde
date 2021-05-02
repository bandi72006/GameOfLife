//Bandar Al Aish

int gridHeight = 8;
int gridWidth = 13;

int cells[][] = new int[gridWidth][gridHeight]; //Creates new array

int delayTime = 250; //Default value

String gameState = "";

void createCells(int[][] cells){
  for (int y = 0; y <= gridHeight-1; y++){
    for (int x = 0; x <= gridWidth-1; x++){
      if (random(0,1) > 0.5){
        cells[x][y] = 1;
      }
    }
  }
}

void clearCells(int[][] cells){
  for (int y = 0; y <= gridHeight-1; y++){
    for (int x = 0; x <= gridWidth-1; x++){
      cells[x][y] = 0;
    }
  }
}

void updateCells(int[][] cells){
  int nextGen[][] = new int[gridWidth][gridHeight];
  for (int x = 0; x <= gridWidth-1; x++){
    for (int y = 0; y <= gridHeight-1; y++){
      int neighbors = checkNeighbors(x, y);
      if (cells[x][y] == 1){ //Alive cell
        if (neighbors == 2 || neighbors == 3){ 
          nextGen[x][y] = 1;
        }else{
          nextGen[x][y] = 0;
        }
        
      }else{ //Dead cell
        if (neighbors == 3){
          nextGen[x][y] = 1;
        }else{
          nextGen[x][y] = 0;
        }
      }
    }
  }
  
  //replaces old cells with the new generation
  for (int x = 0; x <= gridWidth-1; x++){
    for (int y = 0; y <= gridHeight-1; y++){
      cells[x][y] = nextGen[x][y];
    }
  }
}

int checkNeighbors(int x, int y){
  //Lazy code! Make it more efficient!
  int neighbors = 0;
  
  //Bottom row
  if (y != gridHeight-1){
    if (x != 0){
      if (cells[x-1][y+1] == 1){
        neighbors += 1;
      }
    }
    
    if (cells[x][y+1] == 1){
        neighbors += 1;
    }
    
    if(x!=gridWidth-1){
      if (cells[x+1][y+1] == 1){
          neighbors += 1;
      }
    }
  }
  
  //Middle row
  if(x != 0){
    if (cells[x-1][y] == 1){
        neighbors += 1;
    }
  }
  
  if (x != gridWidth-1){
    if (cells[x+1][y] == 1){
      neighbors += 1;
    }
  }
  
  //Top row
  
  if (y != 0){
    if(x != 0){
      if (cells[x-1][y-1] == 1){
          neighbors += 1;
      }
    }
    
    if (cells[x][y-1] == 1){
        neighbors += 1;
    }
    
    if (x != gridWidth-1){
      if (cells[x+1][y-1] == 1){
          neighbors += 1;
      }
    }
  }
  return neighbors;
}

void drawCells(int[][] cells){
  fill(255,0,0);
  noStroke();
  for (int i = 0; i <= gridHeight-1; i++){
    for (int j = 0; j <= gridWidth-1; j++){
      if(cells[j][i] == 1){
          rect(j*100+5, i*100+5, 90, 90); 
      }
    }
  }
}

void drawGrid(){
  stroke(0);
  strokeWeight(1);
  for (int i = 0; i <= gridWidth-1; i++){
    line(i*100, 0, i*100, 720);
  }
  for (int i = 0; i <= gridHeight-1; i++){
    line(0, i*100, 1280, i*100);
  }
}

void setup(){
  size(1280,720);
  createCells(cells);
}

void draw(){
  if (gameState == "runCells"){
    //Logic stuff
    updateCells(cells);
    
    //Mouse movement
    if (mousePressed == true){
      if (mouseButton == LEFT){
        print(pmouseX + " " + mouseX + "\n ");
      }
    }
    
    //drawing stuff
    background(200);
    drawCells(cells);
    drawGrid();
    delay(delayTime);
    
  }else if (gameState == "drawMode"){
    background(200);
    //Mouse click converted to array index
    if (mousePressed == true){
      if (mouseButton == LEFT){
        if(cells[floor(mouseX/100)][floor(mouseY/100)] == 1){
          cells[floor(mouseX/100)][floor(mouseY/100)] = 0;
        }else{
          cells[floor(mouseX/100)][floor(mouseY/100)] = 1;
        }
      }
      else{
        gameState = "runCells";
      }
    }
    
    drawGrid();
    drawCells(cells);
    delay(100); //Gives a delay for user to let go of click button
    
  }
}

void keyPressed(){
  if (key == 111){ //ASCII for o
    if (delayTime > 0){
      delayTime -= 10;
    } 
  } else if (key == 108){ //ASCII for l
    delayTime += 10;
  } else if (key == 32){ //ASCII for space
    gameState = "drawMode";
    clearCells(cells);
  } else if (key == 114){ //ASCII for r
    gameState = "runCells";
    createCells(cells);
  }
}

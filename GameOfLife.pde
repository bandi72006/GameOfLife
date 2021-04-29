//Bandar Al Aish
//Create varoable for x and y value     vvvvvv

int cells[][] = new int[13][8]; //Creates new array

int delayTime = 500; //Default value

String gameState = "";

void createCells(int[][] cells){
  for (int y = 0; y <= 7; y++){
    for (int x = 0; x <= 12; x++){
      if (random(0,1) > 0.5){
        cells[x][y] = 1;
      }
    }
  }
}

void clearCells(int[][] cells){
  for (int y = 0; y <= 7; y++){
    for (int x = 0; x <= 12; x++){
      cells[x][y] = 0;
    }
  }
}

void updateCells(int[][] cells){
  int nextGen[][] = new int[13][8];
  for (int x = 0; x <= 12; x++){
    for (int y = 0; y <= 7; y++){
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
  for (int x = 0; x <= 12; x++){
    for (int y = 0; y <= 7; y++){
      cells[x][y] = nextGen[x][y];
    }
  }
}

int checkNeighbors(int x, int y){
  //Lazy code! Make it more efficient!
  int neighbors = 0;
  
  //Bottom row
  if (y != 7){
    if (x != 0){
      if (cells[x-1][y+1] == 1){
        neighbors += 1;
      }
    }
    
    if (cells[x][y+1] == 1){
        neighbors += 1;
    }
    
    if(x!=12){
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
  
  if (x != 12){
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
    
    if (x != 12){
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
  for (int i = 0; i <= 7; i++){
    for (int j = 0; j <= 12; j++){
      if(cells[j][i] == 1){
          rect(j*100+5, i*100+5, 90, 90); 
      }
    }
  }
}

void drawGrid(){
  stroke(0);
  strokeWeight(1);
  for (int i = 0; i <= 12; i++){
    line(i*100, 0, i*100, 720);
  }
  for (int i = 0; i <= 7; i++){
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

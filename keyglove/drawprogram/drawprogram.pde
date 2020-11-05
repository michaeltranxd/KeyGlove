// Need G4P library
import g4p_controls.*;

// vars for drawing
boolean drawOn=false;
boolean refill=false;
int radius = 10;
int t0_click;
int double_click_time=250; // double click if two clickws withing this time window

// brushColor
color brushColor = color(255, 255, 255);

// threshold (measured in pixels
int threshold = 5;

// Delete when done
boolean up, down, left, right, sideways;

public void setup(){
  fullScreen();
  //size(500, 500);
  //noStroke();
  background(0);
  fill(brushColor);
  
  portSetup();
  robotSetup();
 
  t0_click=millis();
  
  // make a line for the toolbar to separate it 
  stroke(255,255,255);
  strokeWeight(104);
  line(0,44,displayWidth,44);
  line(0,displayHeight-44,displayWidth,displayHeight-44);
  
  createGUI();
}
boolean array[] = new boolean[]{false, false, false, false, false};
public void draw(){
  
    array[0] = up;
    array[1] = right;
    array[2] = left;
    array[3] = down;
    array[4] = sideways;

    //robot.processFlexSensorData(array);
  // drawOn must be on
  // but we ALSO can't let the user draw in the toolboxes
  if(drawOn==true && mouseY >= 104+radius && pmouseY >= 104+radius && mouseY <= displayHeight-104-radius && pmouseY <= displayHeight-radius-104){
      stroke(brushColor); // Set brush color
      strokeWeight(radius * 2); // Set size of brush
      line(pmouseX, pmouseY, mouseX, mouseY);  // Draw line
  }
  
  if(refill){
    refill=false;
  }
}

void mousePressed(){
  drawOn=true;
}
 
void mouseReleased(){
  if(millis()-t0_click < double_click_time){
    background(0);
    // redraw toolbar as well //<>//
    stroke(255,255,255);
    strokeWeight(104);
    line(0,44,displayWidth,44);
    line(0,displayHeight-44,displayWidth,displayHeight-44);
  }
 
  drawOn=false;    
  t0_click=millis();
}

void keyPressed() {
  if(keyCode == 'A'){
    up = true;
  }
  if(keyCode == 'S'){
    right = true;
  }
  if(keyCode == 'D'){
    left = true;
  }
  if(keyCode == 'F'){
    down = true;
  }
  if(keyCode == 'G'){
    sideways = true;
  }
}
 
void keyReleased() {
  if(keyCode == 'A'){
    up = false;
  }
  if(keyCode == 'S'){
    right = false;
  }
  if(keyCode == 'D'){
    left = false;
  }
  if(keyCode == 'F'){
    down = false;
  }
  if(keyCode == 'G'){
    sideways = false;
  }
}

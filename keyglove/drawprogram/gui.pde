// color button objects
GButton redBtn; 
GButton blueBtn; 
GButton greenBtn;
GButton purpleBtn;
GButton yellowBtn;
GButton cyanBtn;
GButton orangeBtn;

// line weight buttons
GButton size1Btn; 
GButton size5Btn; 
GButton size10Btn;
GButton size15Btn;
GButton size20Btn;
GButton size25Btn;
GButton size30Btn;

// brush color button event click buttons
public void redBtn_click(GButton source, GEvent event) {
  brushColor = color(255, 10, 10);  
  refill=true;
}

public void blueBtn_click(GButton source, GEvent event) {
  brushColor = color(10, 10, 255) ; 
  refill=true;
}

public void greenBtn_click(GButton source, GEvent event) {
  brushColor = color(10, 255, 10) ; 
  refill=true;
}

public void purpleBtn_click(GButton source, GEvent event) { 
  brushColor = color(169, 49, 224) ; 
  refill=true;
}

public void yellowBtn_click(GButton source, GEvent event) { 
  brushColor = color(255, 255, 10);  
  refill=true;
}

public void cyanBtn_click(GButton source, GEvent event) {
  brushColor = color(10, 255, 255) ; 
  refill=true;
}

public void orangeBtn_click(GButton source, GEvent event) { 
  brushColor = color(255, 106, 0);  
  refill=true;
}

// line weight button click event functions
public void size1Btn_click(GButton source, GEvent event) {
  radius=1;
}

public void size5Btn_click(GButton source, GEvent event) {
  radius=5;
}

public void size10Btn_click(GButton source, GEvent event) {
  radius=10;
}

public void size15Btn_click(GButton source, GEvent event) {
  radius=15;
}

public void size20Btn_click(GButton source, GEvent event) {
  radius=20;
}

public void size25Btn_click(GButton source, GEvent event) {
  radius=25;
}

public void size30Btn_click(GButton source, GEvent event) {
  radius=30;
}

// Create all the GUI controls.
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Paint Program");
  
  // create color buttons
  createColorButtons();
  
  // create line weight buttons
  createSizeButtons();
}

// creates the buttons for controlling the colors
public void createColorButtons(){
  redBtn = new GButton(this, 10, 8, 80, 80);
  redBtn.addEventHandler(this, "redBtn_click");
  redBtn.setLocalColorScheme(GCScheme.RED_SCHEME);
  
  blueBtn = new GButton(this, (displayWidth-100)/6, 8, 80, 80);
  blueBtn.addEventHandler(this, "blueBtn_click");
  blueBtn.setLocalColorScheme(GCScheme.BLUE_SCHEME);

  greenBtn = new GButton(this, (displayWidth-100)/3, 8, 80, 80);
  greenBtn.addEventHandler(this, "greenBtn_click");
  greenBtn.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  
  purpleBtn = new GButton(this, (displayWidth-100)/2, 8, 80, 80);
  purpleBtn.addEventHandler(this, "purpleBtn_click");
  purpleBtn.setLocalColorScheme(GCScheme.PURPLE_SCHEME);
  
  yellowBtn = new GButton(this, 2*(displayWidth-100)/3, 8, 80, 80);
  yellowBtn.addEventHandler(this, "yellowBtn_click");
  yellowBtn.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
  
  cyanBtn = new GButton(this, 5*(displayWidth-100)/6, 8, 80, 80);
  cyanBtn.addEventHandler(this, "cyanBtn_click");
  cyanBtn.setLocalColorScheme(8);
  
  orangeBtn = new GButton(this, displayWidth - 90, 8, 80, 80);
  orangeBtn.addEventHandler(this, "orangeBtn_click");
  orangeBtn.setLocalColorScheme(GCScheme.ORANGE_SCHEME);
}

// create brush weight buttons
public void createSizeButtons(){
  size1Btn = new GButton(this, 10, displayHeight-88, 80, 80);
  size1Btn.addEventHandler(this, "size1Btn_click");
  size1Btn.setLocalColorScheme(9);
  size1Btn.setText("1");
  
  size5Btn = new GButton(this, (displayWidth-100)/6, displayHeight-88, 80, 80);
  size5Btn.addEventHandler(this, "size5Btn_click");
  size5Btn.setLocalColorScheme(9);
  size5Btn.setText("5");

  size10Btn = new GButton(this, (displayWidth-100)/3, displayHeight-88, 80, 80);
  size10Btn.addEventHandler(this, "size10Btn_click");
  size10Btn.setLocalColorScheme(9);
  size10Btn.setText("10");
  
  size15Btn = new GButton(this, (displayWidth-100)/2, displayHeight-88, 80, 80);
  size15Btn.addEventHandler(this, "size15Btn_click");
  size15Btn.setLocalColorScheme(9);
  size15Btn.setText("15");
  
  size20Btn = new GButton(this, 2*(displayWidth-100)/3, displayHeight-88, 80, 80);
  size20Btn.addEventHandler(this, "size20Btn_click");
  size20Btn.setLocalColorScheme(9);
  size20Btn.setText("20");
  
  size25Btn = new GButton(this, 5*(displayWidth-100)/6, displayHeight-88, 80, 80);
  size25Btn.addEventHandler(this, "size25Btn_click");
  size25Btn.setLocalColorScheme(9);
  size25Btn.setText("25");
  
  size30Btn = new GButton(this, displayWidth - 90, displayHeight-88, 80, 80);
  size30Btn.addEventHandler(this, "size30Btn_click");
  size30Btn.setLocalColorScheme(9);
  size30Btn.setText("30");
}

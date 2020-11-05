import java.awt.AWTException;
import java.awt.Robot;

EnhancedRobot robot;

class EnhancedRobot {
  Robot workerRobot;
  Hand hand;
  
  boolean isLeftClick, isRightClick;
  boolean anyAction = false;
  
  // May need to change distance
  float dist= 2000;
  float pointCurrX, pointCurrY;
  
    /* STANDARD BINDINGS
      -1 - No Operation Key 
       0 - Left Click
       1 - Right Click
       2 - IDK
       3 - IDK
       4 - IDK
    */
    
  EnhancedRobot(int f0, int f1, int f2, int f3, int f4){
    createRobot();
    this.hand = new Hand(f0, f1, f2, f3, f4);    
  }
  
  private void createRobot(){
    try {
        this.workerRobot = new Robot();
    } catch (AWTException e) {
        throw new RuntimeException(e);
    }    
  }
  
  /* Maybe toss into thread if too slow? */
  public void processGyroSensorData(float[] data){
    pointCurrX = float(width/2)+dist*tan(radians(data[0]));  // Yaw
    pointCurrY = float(height/2)-dist*tan(radians(data[1])); // Pitch
    workerRobot.mouseMove(int(pointCurrX), int(pointCurrY));
  }
  
  /* Parse the letter out first then toss in the data */
  public void processFlexSensorData(boolean[] data){
    // The values in states is now the previous state
    for(int i = 0; i < 5; i++){
      hand.lastStates[i] = hand.states[i];
    }
    //print("flex data should be ");
    //printArray(data);
    // Update the values in states
    for(int i = 0; i < 5; i++){          
        hand.states[i] = data[i]; // Change the state to the state that was collected
    }
    //printArray(hand.states);
    // Check if we see the same states twice in a row and hand is not timing at all
    if(!hand.statesRepeated() && !hand.isTiming){
      println("no repeated");
      hand.t0_chain_button = millis(); // Update the timer of the hand to measure 250ms to get new key combo
      hand.isTiming = true;
    }
    // After processing check the move and let the hand process the event
    hand.processKeyCombo();
  }
  
  void pressKey(int keyCode){ 
    workerRobot.keyPress(keyCode); 
    workerRobot.keyRelease(keyCode);
    println("The key that should show up is : " + (char)keyCode);
  }
  void pressMouse(int mouseCode){ workerRobot.mousePress(mouseCode); }
  void releaseMouse(int mouseCode){ workerRobot.mouseRelease(mouseCode); }  
} // End of EnhancedRobot class

void robotSetup(){
  // Configure bot here!
  // This should be thumb, index, middle, ring, pinky
  robot = new EnhancedRobot(0, 1, 2, 3, 4); // Change bindings of robot **if required

}

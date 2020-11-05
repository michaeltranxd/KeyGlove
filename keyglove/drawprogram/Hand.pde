enum HandEvent{
  LEFTCLICK,
  RIGHTCLICK,
  KEYBOARDMODE,
  MOUSEMODE,
  FINALIZEKEY,
  KEY1,
  KEY2,
  KEY3,
  KEY4,
  RECALIBRATE,
  CHANGECOLOR,
  NONE;
}

class Hand{
  /* Indecies of the Controls */
  int thumbIndex = 0;
  int indexFingerIndex = 1;
  int middleFingerIndex = 2;
  int ringFingerIndex = 3;
  int pinkyIndex = 4;
  
  // Debounce for using multiple states
  int time_to_chain_buttons = 50;
  int t0_chain_button = 0;

  // States of the fingers:
  // True  = bent
  // False = not bent
  boolean states[] = { false, false, false, false, false };
  boolean lastStates[] = { false, false, false, false, false };
  
  // State that the hand is timing 250ms for the action
  boolean isTiming = false;
  
  // State for mouseMode vs keyboard mode
  boolean mouseMode = true;
  
  // Keys for the keyboard
  char[] keys1 = {KeyEvent.VK_A, KeyEvent.VK_B, KeyEvent.VK_C, KeyEvent.VK_D, KeyEvent.VK_E, KeyEvent.VK_F};
  char[] keys2 = {KeyEvent.VK_G, KeyEvent.VK_H, KeyEvent.VK_I, KeyEvent.VK_J, KeyEvent.VK_K, KeyEvent.VK_L};
  char[] keys3 = {KeyEvent.VK_M, KeyEvent.VK_N, KeyEvent.VK_O, KeyEvent.VK_P, KeyEvent.VK_Q, KeyEvent.VK_R, KeyEvent.VK_S};
  char[] keys4 = {KeyEvent.VK_T, KeyEvent.VK_U, KeyEvent.VK_V, KeyEvent.VK_W, KeyEvent.VK_X, KeyEvent.VK_Y, KeyEvent.VK_Z};
  int keyIndex = 0;
  char[] currentListOfKeys = keys1;
 
  // Colors for brush
  color[] brushColors = { color(255, 10, 10), color(10, 10, 255), color(10, 255, 10), color(169, 49, 224), color(255, 255, 10), color(10, 255, 255), color(255, 106, 0)  };
  int brushIndex = 0;
  
  /* Variable that holds the previous event that was just processed */
  HandEvent previousEvent = HandEvent.NONE;
  
  /* Assign indecies of controls starting thumb thru pinky */
  Hand(int f0, int f1, int f2, int f3, int f4){
    thumbIndex = f0;
    indexFingerIndex = f1;
    middleFingerIndex = f2;
    ringFingerIndex = f3;
    pinkyIndex = f4;
  }
  
  /* Function to calcualte the states into a byte value through bit shifting */
  private int calculateStateByteValue(){
    /* Thumb(2^0) Index(2^1) Middle(2^2) Ring(2^3) Pinky(2^4) */
    /*     1           2          4          8          16    */
    int value = 0;
    if(states[thumbIndex])
      value = value | 1;
    if(states[indexFingerIndex])
      value = value | 2;
    if(states[middleFingerIndex])
      value = value | 4;
    if(states[ringFingerIndex])
      value = value | 8;
    if(states[pinkyIndex])
      value = value | 16;
    return value;
  }
  
  private void printState(int value){
    println("State: " + (value & 1) + " " + ((value >> 1) & 1) + " " + ((value >> 2) & 1) + " " + ((value >> 3) & 1) + " " + ((value >> 4) & 1));
  }
  
  /* Process the key combo based on the debounce interval (counts when state changes) */
  private void processKeyCombo(){
    // Convert states to a numerical value by bit shifting
    int stateByteValue = calculateStateByteValue();
    
    if(millis() - time_to_chain_buttons > t0_chain_button && isTiming){
      // Process the key combo when time_to_chain_buttons time elapsed
      // Mark the hand to be not timing anything so we can process the next move
      isTiming = false;
      printState(stateByteValue); // Comment out when done printing
      
      // Turn off the keys from previous event
      clearPreviousEvent();
      
      HandEvent event = getEvent(stateByteValue);

      // Execute event
      executeEvent(event);
      previousEvent = event;
    }
  }
  
  private HandEvent getEvent(int stateByteValue){
      HandEvent event = HandEvent.NONE;
      // Then check the combinations
      if(mouseMode){
        //println("state:" + stateByteValue);
        if(stateByteValue == 2) // 0 1 0 0 0
          event = HandEvent.LEFTCLICK;
        else if(stateByteValue == 4) // 0 0 1 0 0
          event = HandEvent.RIGHTCLICK;
        else if(stateByteValue == 8) // 0 0 0 1 0
          event = HandEvent.CHANGECOLOR;
        else if(stateByteValue == 17) // 1 0 0 0 1
          event = HandEvent.KEYBOARDMODE;
        else if(stateByteValue == 30) // 0 1 1 1 1
          event = HandEvent.RECALIBRATE;
      }
      else{
        /* Anything below, is the keyboard events */
        if(stateByteValue == 1) // 1 0 0 0 0
          event = HandEvent.FINALIZEKEY;
        else if(stateByteValue == 2) // 0 1 0 0 0
          event = HandEvent.KEY1;
        else if(stateByteValue == 4) // 0 0 1 0 0
          event = HandEvent.KEY2;
        else if(stateByteValue == 8) // 0 0 0 1 0
          event = HandEvent.KEY3;
        else if(stateByteValue == 16) // 0 0 0 0 1
          event = HandEvent.KEY4;
        else if(stateByteValue == 12) // 0 0 1 1 0
          event = HandEvent.MOUSEMODE;
      }

      return event;
  }
  
  private void clearPreviousEvent(){
    if(previousEvent == HandEvent.LEFTCLICK)
      robot.releaseMouse(InputCodes.MOUSE_LEFT);
    else if(previousEvent == HandEvent.RIGHTCLICK)
      robot.releaseMouse(InputCodes.MOUSE_RIGHT);
  }
  
  private void executeEvent(HandEvent event){
    if(event == HandEvent.LEFTCLICK)
      robot.pressMouse(InputCodes.MOUSE_LEFT);
    else if(event == HandEvent.RIGHTCLICK)
      robot.pressMouse(InputCodes.MOUSE_RIGHT);
    else if(event == HandEvent.KEYBOARDMODE)
      mouseMode = false;
    else if(event == HandEvent.MOUSEMODE)
      mouseMode = true;
    else if(event == HandEvent.FINALIZEKEY)
      robot.pressKey(currentListOfKeys[keyIndex]);
    else if(event == HandEvent.KEY1){
      if(currentListOfKeys != keys1){
        keyIndex = 0;
        currentListOfKeys = keys1;
      }
      keyIndex = (keyIndex + 1) % 6;
    }
    else if(event == HandEvent.KEY2){
      if(currentListOfKeys != keys2){
        keyIndex = 0;
        currentListOfKeys = keys2;
      }
      keyIndex = (keyIndex + 1) % 6;
    }
    else if(event == HandEvent.KEY3){
      if(currentListOfKeys != keys3){
        keyIndex = 0;
        currentListOfKeys = keys3;
      }
      keyIndex = (keyIndex + 1) % 6;
    }
    else if(event == HandEvent.KEY4){
      if(currentListOfKeys != keys4){
        keyIndex = 0;
        currentListOfKeys = keys4;
      }
      keyIndex = (keyIndex + 1) % 6;
    }
    else if(event == HandEvent.RECALIBRATE){
      if(myPort != null){
        myPort.clear();
        myPort.stop();
        delay(1000);
        println("port should have been closed");
      }
      portSetup();
    }
    else if(event == HandEvent.CHANGECOLOR){
      brushColor = brushColors[brushIndex];
      brushIndex = (brushIndex + 1) % 7;
    }
  }  
  
  private boolean statesRepeated(){
    for(int i = 0; i < 5; i++){
      if(lastStates[i] != states[i])
        return false;
    }
    return true;
  }
  
} // End of hand class

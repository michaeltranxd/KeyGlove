import processing.serial.*;

Serial myPort; // Port we are reading data from
boolean flexData[];  // Array of data to hold the flex sensor data being received
float gyroData[];   // Array of data to hold the gyroscope data being received

// Add this function to setup to begin
void portSetup(){
  try{
    myPort = new Serial(this, Serial.list()[0], 57600);  // make sure Arduino is talking serial at this baud rate
    delay(1000);
    myPort.clear();            // flush buffer
    myPort.bufferUntil('\n');  // set buffer full flag on receipt of carriage return
  }
  catch(Exception e){
    println("No port available");
  }
}

void serialEvent(Serial port){
  try{
     String inData = port.readStringUntil('\n');
     //println(inData);
     inData = trim(inData);                 // cut off white space (carriage return)
     
     if (inData != null) {
      // Peek at first character of inData, should be our header
      char firstCharacter = inData.charAt(0);
      // Remove first character to grab only data
      inData = inData.substring(2).trim();
      if(firstCharacter == 'f'){
        // This is where the data for flex sensors should go
        
        // Split data into booleans
        int data[] = int(split(inData, ','));
        flexData = boolean(data);
        //print("premethod flex");
        //printArray(flexData);
        //for(boolean dataA : flexData){ // print them
        //  print(dataA + ",");
        //}
        //println();
        if(flexData.length == 5){ // For five flex sensors
          robot.processFlexSensorData(flexData);
        }
      }
      else if(firstCharacter == 'g'){
        // This is where the data for gyroscope should go
        gyroData = float(split(inData, ','));
        //println(gyroData);
        if(gyroData.length == 3){ // For three gyroscope data (yaw, pitch, roll)
          robot.processGyroSensorData(gyroData);
          
        }
      }

    }
  } catch(Exception e) {
    // println(e.toString());
  }
}

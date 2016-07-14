/**
 * Button. 
 * 
 * Click on one of the colored squares in the 
 * center of the image to change the color of 
 * the background. 
 */
 import processing.serial.*;
Serial myPort;

int x [] = {0,0,0,40,0,80,0,120,0,0,0,0,0,0,0,0,0,0,0,0};
int l [] = {0,0,0,0,0};
int k [] = {0,0,0,0,0};
int rectSize = 90;     // Diameter of rect
int circleSize = 93;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
color currentColor;
boolean rectOver = false;
boolean circleOver = false;

void setup() {
  size(640, 360);
  rectColor = color(0);
  rectHighlight = color(51);
  circleColor = color(255);
  circleHighlight = color(204);
  baseColor = color(102);
  currentColor = baseColor;
  ellipseMode(CENTER);
  myPort = new Serial(this, "/dev/ttyUSB1", 9600);

}

void draw() {
  update(mouseX, mouseY);
  background(currentColor);
  
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(x[0], x[1], 20,20 );
  rect(x[2], x[3], 20,20);
  rect(x[4], x[5], 20,20);
  rect(x[6], x[7], 20,20);
  
  
}

void update(int z, int y) {
  if ( overRect(x[0], x[1], 20, 20) ) {
    l[0]=1;l[1]=0;l[2]=0;l[3]=0;
    print("Hover");
    println(" button  "+0);
  } 
  else if ( overRect(x[2], x[3], 20, 20) ) {
    l[1]=1;l[0]=0;l[2]=0;l[3]=0;
    print("Hover");
    println(" button  "+1);
  }
  else if ( overRect(x[4], x[5], 20, 20) ) {
    l[2]=1;l[1]=0;l[0]=0;l[3]=0;
    print("Hover");
    println(" button  "+2);
  }
  else if ( overRect(x[6], x[7], 20, 20) ) {
    l[3]=1;l[1]=0;l[2]=0;l[0]=0;
    print("Hover");
    println(" button  "+3);
  }
  else {
    l[1]=0;l[2]=0;l[3]=0;l[0]=0;
    println("free");
  }
}

void mousePressed() {
  if (l[0]==1) {
    k[0]=1;
    print("pressed");
    println(" button  "+0);
    myPort.write(str(0));
  }
  if (l[1]==1) {
    k[1]=1;
    print("pressed");
    println(" button  "+1);
    myPort.write(str(1));
  }
  if (l[2]==1) {
    k[2]=1;
    print("pressed");
    println(" button "+2);
    myPort.write(str(2));
  }
  if (l[3]==1) {
    k[3]=1;
    print("pressed");
    println(" button "+3);
    myPort.write(str(3));
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}
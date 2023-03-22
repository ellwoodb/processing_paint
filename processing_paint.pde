import java.awt.event.KeyEvent;  // For arrow key codes

// Colorswitcher
color[] colors = {
    #000000,  // black
    #9D9D9D,  // grey
    #FFFFFF,  // white
    #FF0000,  // red
    #A24110,  // brown
    #FF9800,  // orange
    #FFDE00,  // yellow
    #10A219,  // green
    #2CBB00,  // dark green
    #00D6FF,  // blue
    #0057FF,  // dark blue
  };
int currentColorIndex = 0;

// Stroke thickness
int strokeThickness = 1;

// Modes
String[] modesTexts = {
  "Stift",
  "Box",
  "Radierer",
  };
int currentMode = 0;

// Box values
int boxBeginX;
int boxBeginY;
int boxEndX;
int boxEndY;


void setup(){
  size(800,500);
  background(255);
  frameRate(60);

  // Sketch
  // Floor
  fill(#10A219);
  noStroke();
  rect(0, 400, 800, 50);
  // House
  fill(#A24110);
  noStroke();
  rect(115, 330, 70, 70);
  // Roof
  fill(0);
  noStroke();
  triangle(100, 330, 150, 270, 200, 330);
  // Tree
  fill(#A24110);
  noStroke();
  rect(550, 280, 30, 120);
  // Leaves
  fill(#10A219);
  noStroke();
  ellipse(550, 280, 50, 50);
  ellipse(600, 300, 70, 70);
  ellipse(600, 280, 70, 70);
  ellipse(520, 270, 50, 50);
  ellipse(560, 250, 60, 60);
  // Text
  fill(#000000);
  textSize(20);
  textAlign(CENTER);
  String welcomeText = "Sie wollten eine Skizze, hier ist eine, aber noch ein bisschen mehr.\nVersuchen Sie mal das Bild noch etwas zu verschönern...";
  text(welcomeText, 400, 170);
}

void draw(){
  // Ground Bar
  fill(#EEEEEE);
  noStroke();
  rect(0, 450, 800, 50);
  // Color display
  strokeWeight(2);
  stroke(#8E8E8E);
  fill(colors[currentColorIndex]);
  ellipse(50, 475, 30, 30);
  // Stroke thickness display
  fill(#000000);
  textAlign(LEFT);
  textSize(25);
  text(str(strokeThickness), 100, 483);
  // Mode display
  fill(#000000);
  textSize(25);
  String modeText = "Modus: " + modesTexts[currentMode];
  text(modeText, 150, 483);
  // Help message
  fill(#000000);
  textSize(25);
  String helpNotifi = "Für Hilfe 'h' drücken.";
  text(helpNotifi, 400, 483);
}

void keyReleased() {
  // Change color
  if (key == 'c'){
    if (currentColorIndex == colors.length - 1) {
      currentColorIndex = 0;
    } else {
      currentColorIndex++;
    }
  }

  // Change modes
  if (key == 'p') {
    currentMode = 0;  // Pen
  }
  if (key == 'b') {
    currentMode = 1;  // Box
  }
  if (key == 'e') {
    currentMode = 2;  // Eraser
  }
}

void keyPressed() {
  // Erase everything
  if (key == 'x') {
    background(255);
  }

  // Change stroke thickness
  if (keyCode == KeyEvent.VK_UP) {  // Increase thickness
    if (strokeThickness == 100) {  // Maxmimal 100
      return;
    } else {
      strokeThickness++;
    }
  }
  if (keyCode == KeyEvent.VK_DOWN) {  // Decrease thickness
    if (strokeThickness == 1) {  // Minimal thickness 1
      return;
    } else {
      strokeThickness--;
    }
  }

  // Show help
  if (key == 'h') {
    fill(#000000);
    textSize(13);
    String helpText = "Stift = 'p'\nBox = 'b'\nRadierer = 'e'\nFarbe wechseln = 'c'\nStiftgröße ändern = Pfeiltasten (hoch/runter)\nAlles löschen = 'x'\nHilfe = 'h' (Um die Hilfe zu entfernen einfach übermalen/ausradieren)";
    text(helpText, 10, 10);
  }
}

void mouseDragged() {
  if (currentMode == 0){  // Pen painting
    strokeWeight(strokeThickness);
    stroke(colors[currentColorIndex]);
    line(pmouseX, pmouseY, mouseX, mouseY);
  } else if (currentMode == 2){  // Eraser
    strokeWeight(strokeThickness);
    stroke(#ffffff);
    line(pmouseX, pmouseY, mouseX, mouseY);
  } else {
    return;
  }
}

void mousePressed() {
  // Capture start point of box
  if (currentMode == 1){
    boxBeginX = mouseX;
    boxBeginY = mouseY;
  } else {
    return;
  }
}

void mouseReleased() {
  // Draw box
  if (currentMode == 1){
    boxEndX = mouseX;
    boxEndY = mouseY;
    int boxH = boxEndY - boxBeginY;
    int boxB = boxEndX - boxBeginX;
    noStroke();
    fill(colors[currentColorIndex]);
    rect(boxBeginX, boxBeginY, boxB, boxH);
  } else {
    return;
  }
}
//screenshot
//soft/box coloring
//register price
//8th place register
//add axis
//play button (use mills()?)
//full screen button
//x-y range optimize

import controlP5.*;
ControlP5 cp5;
ControlP5 cp5a;
ControlP5 cp5b; //for Drop Down List
DropdownList d1, d2; //d1 for x-axis, d2 for y-axis
CheckBox checkbox;

int xaxis = 1;
int yaxis = 2;

int[] brandcheck = {0,0,0,0,0,0,0,0,0,0,0,0,0};
int checksum = 0; //0 means all the checkbox are blank
String[] brandname = {
"MSSL", "MSL", "MS", "SS", "CTM",
"CBM", "MS1-s", "MSEX", "WAK", "MRLM",
"FRON", "LARM", "ECHO"
};
int[] colorbrand = {1,2,3,4,5,6,7,8,9,10,11,12,13};

int yearcheck[] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}; //1 means that brand is checked
int checkyear = 1999;
int i, j, k;
int year = 1998;
int opacity = 35;
float r = 0;
int x = 0; int y = 0;
int red, green, blue;
int checkall = 0; //1 means all the checkbox are checked

Table table;
int mssl[][] = new int[17][4];
int msl[][] = new int[17][4];
int ms[][] = new int[17][4];
int ss[][] = new int[17][4];
int csm[][] = new int[17][4];
int cam[][] = new int[17][4];
int ms100[][] = new int[17][4];
int msex[][] = new int[17][4];
int wak[][] = new int[17][4];
int mrlm[][] = new int[17][4];
int fron[][] = new int[17][4];
int larm[][] = new int[17][4];
int echo[][] = new int[17][4];
int[][][] hairetu = {mssl, msl, ms, ss, csm, cam, ms100, msex, wak, mrlm, fron, larm, echo};

void setup() {
  size(800, 410);
  //Smooth();
  background(122);
  
  cp5 = new ControlP5(this);
  cp5.setControlFont(new ControlFont(createFont("Arial", 20), 13));
  cp5.addSlider("year")
     .setPosition(260, 360)
     .setSize(150, 18)
     .setRange(1998, 2014);

  cp5a = new ControlP5(this);
  cp5a.setControlFont(new ControlFont(createFont("Arial", 20), 13));
  cp5a.addSlider("opacity")
     .setPosition(610, 235)
     .setSize(100, 18)
     .setRange(0, 100);

  cp5b = new ControlP5(this);
  // create a Dropdownlist
  d1 = cp5.addDropdownList("x-axis")
          .setPosition(590, 340)
          .setSize(70, 200)
          ;
  customize(d1); //customize x-axis list
  d1.setIndex(0);
  // create a second Dropdownlist
  d2 = cp5.addDropdownList("y-axis")
          .setPosition(7, 28)
          .setSize(70, 200)
          ;
  customize(d2); //customize x-axis list
  d2.setIndex(1);

  checkbox = cp5.addCheckBox("checkbox")
                .setPosition(610, 50)
                .setColorForeground(color(120))
                .setColorActive(color(255))
                .setColorLabel(color(255))
                .setSize(16, 16)
                .setItemsPerRow(2)
                .setSpacingColumn(60)
                .setSpacingRow(10)
                .addItem("MSSL", 1)
                .addItem("MSL", 2)
                .addItem("MS", 3)
                .addItem("SS", 4)
                .addItem("CTM", 5)
                .addItem("CBM", 6)
                .addItem("MS1-s", 7)
                .addItem("MSEX", 8)
                .addItem("WAK", 9)
                .addItem("MRLM", 10)
                .addItem("FRON", 11)
                .addItem("LARM", 12)
                .addItem("ECHO", 13)
                ;

  for (k=0; k<13; k++){
    table = loadTable("mssl.csv", "header");
    for (i = 0; i<17; i++){
      for (j = 0; j<4; j++){
        hairetu[k][i][j] = table.getInt(i,j+4*k);
      }
    }
  }
}

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(20);
  ddl.captionLabel().set("x-axis");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.addItem("Share", 1);
  ddl.addItem("Tar", 2);
  ddl.addItem("Price", 3);
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  }
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }

  if(theEvent.isFrom(d1)){
    xaxis = int(theEvent.getGroup().getValue());
  }
  if(theEvent.isFrom(d2)){
    yaxis = int(theEvent.getGroup().getValue());
  }

  if(theEvent.isFrom(checkbox)){
    println(checkbox.getArrayValue());
    for (i=0; i<13; i++) {
      brandcheck[i] = int(checkbox.getArrayValue()[i]);
    }
    checksum = 0;
    for(j=0; j<13; j++){
      checksum += brandcheck[j];
    }
    print(checksum);
    if (checksum > 0){
      checksum = 1;
    }else{
      checksum = 0;
    }
    print(checksum);
  }
}

void draw() {
  background(102);
  fill(255);
  text("*You can press right/left,", 685, 365);
  text("or space on your keyboard.", 695, 382);
  text("(of Non-Selected)", 720, 260);
  
  fill(255, 40);
  stroke(255, 40);
  rect(40, 30, 545, 300);
  fill(255);
  stroke(255);

  //xaxis tick mark
  stroke(255);
  line(40, 30, 585, 30);
  stroke(255);
  arrow(40, 330, 585, 330);
  fill(255);
  textAlign(CENTER, CENTER);
  switch(xaxis){
    case 1: //share
      for (i = 100; i >= 0; i -= 20){
        stroke(255);
        j = i*5+40; line(j, 330, j, 315); text(i/10+"%", j, 340);
        stroke(150);
        j = i*5+40; line(j, 315, j, 30);
      }
      break;
    case 2: //tar
      for (i = 20; i >= 0; i -= 4){
        stroke(255);
        j = i*23+60; line(j, 330, j, 315); text(i+"mg", j, 340);
        stroke(150);
        j = i*23+60; line(j, 315, j, 30);
      }
      break;
    case 3: //price
      for (i = 500; i > 0; i -= 100){
        stroke(255);
        j = int(i*1.3-90); line(j, 330, j, 315); text("¥"+i, j, 340);
        stroke(150);
        j = int(i*1.3-90); line(j, 315, j, 30);
      }
    default:
      break;
  }
  stroke(255);

  //yaxis tick mark
  stroke(255);
  line(585, 330, 585, 30);
  stroke(255);
  arrow(40, 330, 40, 30);
  switch(yaxis){
    case 1: //share
      for (i = 12; i >= 0; i -= 2){
        stroke(255);
        j = 300-(i*20); line(40, j, 55, j); text(i+"%", 25, j);
        stroke(150);
        j = 300-(i*20); line(55, j, 585, j);
      }
      break;
    case 2: //tar
      for (i = 20; i >= 0; i -= 4){
        stroke(255);
        j = 315-(i*13); line(40, j, 55, j); text(i+"mg", 20, j);
        stroke(150);
        j = 315-(i*13); line(55, j, 585, j);
      }
      break;
    case 3: //price
      for (i = 500; i > 100; i -= 100){
        stroke(255);
        j = int(450-(i*0.8)); line(40, j, 55, j); text("¥"+i, 20, j);
        stroke(150);
        j = int(450-(i*0.8)); line(55, j, 585, j);
      }
      break;
    default:
      break;
  }
  stroke(255);

  if (checksum == 0){
    for(i=0; i<17; i++){
      yearcheck[i] = 0;
    }
  }

  for (int j = 0; j < 13; j++) {
    if(brandcheck[j] == 1){//if brancheck[j] was checked
      yearcheck[year-1998] = 1; //flag current year
      for (i = 0; i <= year-1998; i++){
        if (yearcheck[i] == 1){
          Coloring(colorbrand[j]);
          drawLine(hairetu[j], red, green, blue);
          checkyear = 1998+i;
          fill(red, green, blue, 220);
          drawEllipse(hairetu[j], brandcheck[j], brandname[j]);
        }
      }
    }else{
    Coloring(colorbrand[j]);
      //fill(red, green, blue, 128-(78*checksum));
      fill(red, green, blue, int((1-checksum)*128+checksum*(2.2*(opacity))));
      drawEllipse(hairetu[j], brandcheck[j], brandname[j]);
    }
  }

  //background text
  fill(255, 70);
  textSize(100);
  text(year, 310, 170);
  textSize(12);
}

void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix(); 
}

void keyPressed() {
  if (key==' '){
    if (checkall == 0){
      checkbox.activateAll();
      checkall = 1;
    } else if (checkall == 1){
      checkbox.deactivateAll();
      checkall = 0;
    }
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (year < 2014) {
          year++;
          cp5.getController("year").setValue(year);
      }
    } else if (keyCode == LEFT) {
      if (year > 1998) {
          year--;
          cp5.getController("year").setValue(year);
      }
    }
  }
}

int xaxis(int a, int b) {
  switch(b){
    case 1: //share
      return a*5+40;
    case 2: //tar
      return a*23+60;
    case 3: //price
      return int(a*1.3-90);
    default:
      return 9999;
  }
}

int yaxis(int a, int b) {
  switch(b){
    case 1: //share
      return 300-(a*2);
    case 2: //tar
      return 315-(a*13);
    case 3: //price
      return int(450-a*0.8);
    default:
      return 9999;
  }
}

void drawEllipse(int[][] brand, int check, String test){
  if (check == 0){ //no checks
    r = sqrt(brand[year-1998][0]);
    x = xaxis(brand[year-1998][xaxis], xaxis);
    y = yaxis(brand[year-1998][yaxis], yaxis);
    int op = int((1-checksum)*255+checksum*(2.2*(opacity)));
    if(x>40 && y<330){
      stroke(255, op);
      ellipse(x, y, r/2, r/2);
      fill(0, op);
      text(test, x, y);
    }
  }else{ //checked
    r = sqrt(brand[checkyear-1998][0]);
    x = xaxis(brand[checkyear-1998][xaxis], xaxis);
    y = yaxis(brand[checkyear-1998][yaxis], yaxis);
    if(x>40 && y<330){
      stroke(255);
      ellipse(x, y, r/2, r/2);
      fill(0);
      if (i == year-1998){
      text(test, x, y);
      }
    }
  }
}

void drawLine(int[][] brand, int red, int green, int blue){
  if(i>0 && yearcheck[i-1]>0){
    int startx = xaxis(brand[checkyear-1998][xaxis], xaxis);
    int starty = yaxis(brand[checkyear-1998][yaxis], yaxis);
    int endx = xaxis(brand[checkyear-1997][xaxis], xaxis);
    int endy = yaxis(brand[checkyear-1997][yaxis], yaxis);
    strokeWeight(5);
    stroke(red, green, blue);
    if (startx > 40 && endx > 40 && starty < 330 && endy < 330){
      line(startx, starty, endx, endy);
    }
  }
  strokeWeight(1);
}

void Coloring(int colorbrand){
  switch(colorbrand){
    case 1: case 2: case 3: case 7: case 8://MSSL, MSL, MS, MS100, MSEX
      red = 0; green = 153; blue = 255; break;
    case 4://"SS"
      red = 50; green = 50; blue = 50; break;
    case 5: case 11://CTM, FRON
      red = 200; green = 200; blue = 200; break;
    case 6://"CBM"
      red = 153; green = 0; blue = 0; break;
    case 9://"WAK"
      red = 153; green = 204; blue = 51; break;
    case 10://"MRLM"
      red = 51; green = 153; blue = 0; break;
    case 12://"LARM"
      red = 255; green = 51; blue = 0; break;
    case 13://"ECHO"
      red = 255; green = 153; blue = 0; break;
  }
}

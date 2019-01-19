PImage map;
Table data; //<>//
String found = "Found";
int choice = 1;
int smallestYear = 1890;
int currentYear = 2019;
ArrayList<String> mClass = new ArrayList<String>(); 
//Define map params
int imgW;
int imgH;
int centerX;
int centerY;
//Define the zoom vars
int zoom = 1;
int maxZoom = 5;
final static float zoomFactor = .2;

void setup() {
  size(1200, 600);
  map = loadImage("data/worldmap.jpg");
  data = loadTable("data/meteorite.csv", "header");
  
  imgW = map.width;
  imgH = map.height;
 
  centerX = imgW / 2;
  centerY = imgH / 2;
}

void draw() {
  background(DataColors.GREY.getARGB());
  imageMode(CENTER);
  image(map, centerX, centerY, imgW, imgH);
  smooth();
  
  drawData();
}

void drawData(){
  if( choice == 2 || choice == 3){
    smallestYear = currentYear == smallestYear ? 1890 : smallestYear + 1;
    String textYear = "Year: "+smallestYear;
    drawYear(textYear);
  }
  extractData();
  drawLegend();
}

void drawLegend(){
  fill(DataColors.GREY.getARGB());
  noStroke();
  rect(0, (height-100), 150, 100, 7);
  fill(DataColors.FOUND.getARGB());
  rect(5, (height-90), 10,10);
  fill(DataColors.TEXTCOLOR.getARGB());
  text("- Found meteors", 22, (height-82));
  fill(DataColors.FALL.getARGB());
  rect(5, (height-70),10,10);
  fill(DataColors.TEXTCOLOR.getARGB());
  text("- Fall meteors", 22, (height-62));
  stroke(DataColors.MASSCOLOR.getARGB());
  strokeWeight(2);
  noFill();
  ellipse(10, (height-45),10,10);
  fill(DataColors.TEXTCOLOR.getARGB());
  text("- Mass of meteors", 22, (height-42));
}

void drawYear(String year){
  fill(DataColors.GREY.getARGB());
  noStroke();
  rect((width/2 -20), 1, 100, 20, 7);
  fill(DataColors.TEXTCOLOR.getARGB());
  text(year, (width/2), 15);
}

void extractData(){
   //From the data set extract the rows.
  for (TableRow row : data.rows()) {
    //Extracting the values from the rows
    String meteorName = row.getString("name");
    float meteorMass = row.getFloat("mass");
    int meteorYear = row.getInt("year");
    String meteorFound = row.getString("fall");
    String meteorClass = row.getString("class");
    float latitude = row.getFloat("lat"); //this is the height and goes from -90 to 90
    float longitude = row.getFloat("long"); //this is the width and goes from -180 to 180
    println("Meteor name is : "+ meteorName + " and its mass is : "+ meteorMass);

    //Get the map x, y positions.
    float posX = map(longitude, -180, 180, -40, (imgW-40));
    float posY = map(latitude, 90, -90, 0, imgH); 
    // because processing has  0 at top and we must revert the values.
    
    //Get the mass and show it to the map.
    float mass = map(meteorMass, 0, 5000000, 1.0, 5.0);
    
    //Add a unique class name
    if(mClass.size() > 0){
      if(!mClass.contains(meteorClass)){
        mClass.add(meteorClass);
      }
    }else{
      mClass.add(meteorClass);
    }
    
   //The stroke color depends of whatever the meteor is found by humans or not.
   int strokeColor = (meteorFound.equals(found)) ? DataColors.FOUND.getARGB() : DataColors.FALL.getARGB();
   stroke(strokeColor);
   
    proccessData(posX, posY, mass, meteorYear);
  } 
}

void proccessYear(float posX, float posY, float year) {
 if (smallestYear == year) {
      strokeWeight(3);
      point(posX, posY);
    } 
}
void proccessMass(float posX, float posY, float mass){
  if (mass < 3 ) {
      strokeWeight(1);
      point(posX, posY);
    } else {
      stroke(DataColors.MASSCOLOR.getARGB());
      strokeWeight(1.5);
      noFill();
      ellipse(posX, posY, mass, mass);
    }
}

void proccessAll(float posX, float posY, float mass, float year) {
 if (smallestYear == year) {
   if (mass < 3 ) { 
     strokeWeight(3);
     point(posX, posY);
    } else {
      stroke(DataColors.MASSCOLOR.getARGB());
      strokeWeight(1.7);
      noFill();
      ellipse(posX, posY, mass, mass);
    }
  } 
}

//Depending on the choice show the right visualization
void proccessData(float posX, float posY, float mass, float year){
  switch(choice){
    case 1:
      proccessMass(posX, posY, mass);
      break;
    case 2:
      proccessAll(posX, posY, mass, year);
      break;
    //case 3:
    //  proccessYear(posX, posY, year);
    //  break;
    default:
      println("No such choice");
      break;
  }
}

void mousePressed() {
  choice = choice == 2 ? 1 : choice + 1;
  if(choice == 1){
    drawData();
  }
  redraw();
}

//Zoom function
/*void mouseWheel(MouseEvent event) {
  float e = event.getAmount();
 
  //Zoom in
  if(e == -1){
    if(zoom < maxZoom){
      zoom++;
      imgW = int(imgW * (1+zoomFactor));
      imgH = int(imgH * (1+zoomFactor));
 
      //int oldCenterX = centerX;
      //int oldCenterY = centerY;
 
      centerX = centerX - int(zoomFactor * (mouseX - centerX));
      centerY = centerY - int(zoomFactor * (mouseY - centerY));
    }
  }
  //Zoom out
  if(e == 1){
    if(zoom < 1){
      zoom = 1;
      imgW = map.width;
      imgH = map.height;
    }
 
    if(zoom > 1){
      zoom--;
      imgH = int(imgH/(1+zoomFactor));
      imgW = int(imgW/(1+zoomFactor));
 
      //int oldCenterX = centerX;
      //int oldCenterY = centerY;
 
      centerX = centerX + int((mouseX - centerX)
      * (zoomFactor/(zoomFactor + 1)));
      centerY = centerY + int((mouseY - centerY)
      * (zoomFactor/(zoomFactor + 1)));
 
      if(centerX - imgW / 2 > 0){
        centerX = imgW / 2;
      }
 
      if(centerX + imgW / 2 < width){
        centerX = width - imgW / 2;
      }
 
      if(centerY - imgH / 2 > 0){
        centerY = imgH / 2;
      }
 
      if(centerY + imgH / 2 < height){
        centerY = height - imgH / 2;
      }
    }
  }
}*/

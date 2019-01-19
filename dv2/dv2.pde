Table data; //<>//
int smallestYear = 1890;
int currentYear = 2019;
ArrayList<String> mClass = new ArrayList<String>();
ArrayList<String> allClass = new ArrayList<String>();
ArrayList<Integer> yearArray = new ArrayList<Integer>();
ArrayList<Integer> allYear = new ArrayList<Integer>();
int numberOfRows = 0;
int numberOfFound;
String found = "Found";
static int chartDiameter = 250;
int classPieX, classPieY;  // Position of circle button
boolean circleOver = false;

void setup() {
  size(950, 700);
  data = loadTable("data/meteorite.csv", "header");
  classPieX = int(4.5*150);
  classPieY = 150;
  extractData();
  drawData();
}

void drawData(){
  background(DataColors.GREY.getARGB());
  smooth();
  
  int[] data = {numberOfFound, (numberOfRows - numberOfFound)};
  pieChartType(chartDiameter, data, numberOfRows, 150);
  pieTypeLegend();
  
  pieChartClass(chartDiameter, mClass.toArray(new String[0]), allClass.toArray(new String[0]), 150);
  println("Diferent classes found "+mClass.size());
  println("Diferent years found "+yearArray.size());
  
  barChart(allYear.toArray(new Integer[0]), yearArray.toArray(new Integer[0]), 650);

}

void draw() {
  if(overClassPie(classPieX, classPieY, chartDiameter) ) {
    circleOver = true;
    //pieClassLegend();
  } else {
    circleOver = false;
  }
  
}
boolean overClassPie(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}
void pieTypeLegend(){
  fill(DataColors.GREY.getARGB());
  rect(70, 300, 150, 90, 7);
  fill(DataColors.CHARTFOUND.getARGB());
  rect(75, 310, 10,10);
  fill(DataColors.TEXTCOLOR.getARGB());
  text("- Found "+numberOfFound, 92, 320);
  fill(DataColors.CHARTFALL.getARGB());
  rect(75, 330,10,10);
  fill(DataColors.TEXTCOLOR.getARGB());
  text("- Fall "+(numberOfRows - numberOfFound), 92, 340);
  text("Total number of instances", 80, 360);
  text(""+numberOfRows, 125, 375);
}

void pieClassLegend(){
  fill(DataColors.GREY.getARGB());
  rect(mouseX, mouseY, 100, 50, 7);
  fill(DataColors.TEXTCOLOR.getARGB());
  text("Test 1 ", mouseX+2, mouseY+10);
  
}

void extractData(){
   //From the data set extract the rows.
  for (TableRow row : data.rows()) {
    numberOfRows ++;
    //Extracting the values from the rows
    String meteorName = row.getString("name");
    float meteorMass = row.getFloat("mass");
    int meteorYear = row.getInt("year");
    String meteorFound = row.getString("fall");
    String meteorClass = row.getString("class");
    println("Meteor name is : "+ meteorName + " and its mass is : "+ meteorMass);
    
    numberOfFound = (meteorFound.equals(found)) ? numberOfFound +1  : numberOfFound;
    allClass.add(meteorClass);
    allYear.add(meteorYear);

   if(yearArray.size() > 0){
      if(!yearArray.contains(meteorYear)){
        yearArray.add(meteorYear);
      }
    }else{
      yearArray.add(meteorYear);
    }
    
    //Add a unique class name
    if(mClass.size() > 0){
      if(!mClass.contains(meteorClass)){
        mClass.add(meteorClass);
      }
    }else{
      mClass.add(meteorClass);
    }
  } 
}

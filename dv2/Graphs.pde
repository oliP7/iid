void pieChartType(float diameter, int[] data, int total, int startPos) {
  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    float endAngle = (float(data[i])/total)*360;
    fill(getColor(i));
    arc(startPos, startPos, diameter, diameter, lastAngle, lastAngle+radians(endAngle));
    println("Data "+ data[i]+ " angle is "+endAngle);
    lastAngle += radians(endAngle);
  }
}
color getColor(int i){
  if(i == 0){
    print("enter here "+ i);
    return DataColors.CHARTFOUND.getARGB();
  }else {
    print("enter else "+ i);
    return DataColors.CHARTFALL.getARGB();
  }
}

void pieChartClass(float diameter, String[] classNames, String[] data, int startPos){
  float lastAngle = 0;
  for(String name : classNames){
    println("Class name is "+name);
    int classCount = 0;
    for(String d : data){
      if(d.equals(name)){classCount++;}
    }
    float endAngle = (float(classCount)/data.length)*360;
    colorMode(HSB);
    fill(random(200), 255, 255);
    arc(4.5*startPos, startPos, diameter, diameter, lastAngle, lastAngle+radians(endAngle));
    lastAngle+=radians(endAngle);
    //clickableLegend();
  }
}

void barChart(Integer[] data, Integer[] year, int endPos){
  int x = 5;
  float maxH = -200;
  for(int y : year){
    int yearCount = 0;
    for (int d : data) {
      if(d == y){yearCount++;}
    }
   colorMode(HSB);
   fill(random(112)*2, 255, 255);
   float h = -yearCount * 2;
   h = h < maxH ? maxH : h;
   rect(x, endPos, 2, h);
   x+=4;
  }
  
}

void drawText(int year, int posX, int posY){
  fill(DataColors.TEXTCOLOR.getARGB());
  rotate(-45);
  text(""+year, posX, posY);
}

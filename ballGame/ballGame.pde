//import com.getflourish.stt.*;
//import ddf.minim.*;

//STT stt;
//String result;

int numOfBalls = int(random(10, 20));
ArrayList<Ball> balls = new ArrayList<Ball>();
int nextId = balls.size();
color c;
boolean play = true;

void setup(){
  fullScreen(P3D);
  //stt = new STT(this);
  //stt.enableDebug();
  //stt.setLanguage("en");
  //stt.enableAutoRecord();
  
  startGame(); //<>//
}

void startGame(){
  randomColor();
  for(int i = 0; i < numOfBalls; i++){
    balls.add(new Ball(random(width), random(height), i, random(40, 90), balls, c));
    randomColor();
  }
  nextId = balls.size();
}

void draw(){
  background(0);
  if(play){
    for(int i = 0; i < balls.size(); i++){ //<>//
      Ball ball = balls.get(i);
      ball.move();
      ball.display();
      ball.boundaryCollision();
      ball.ballCollision();
    }
    //if(result.equals("Create")){
      //createRandomBall();
    //}else if(result.equals("Delete")){ 
     //deleteRandomBall();
    //}else if(result.equals("Start")){ 
     //startGame();
    //}else if(result.equals("Exit")){ 
     //exit();
    //}
    if(balls.size() == 0){
      textFont(createFont("Arial", 30));
      text("Game Over", width/3, height/2);
      play = !play;
    }
  }
}

void randomColor() {
  colorMode(HSB, 100);
  c=color(random(100), 100, 100);
}

void deleteBall(Ball b){
  for(int i = 0; i < balls.size(); i++){
    Ball ball = balls.get(i);
    if(ball.id == b.id){
      balls.remove(i);
    }
  }
}

void createBall(){
  int rand = int(random(0, 20));
  if(rand % 3 == 0){
    balls.add(new Ball(random(width), random(height), nextId,random(40, 90), balls, c));
    nextId +=1;
    randomColor();
  }
}

void deleteRandomBall(){
  if(play){
    int rand = int(random(0, balls.size() -1));
    balls.remove(rand);
  }
}

void createRandomBall(){
  if(play){
    balls.add(new Ball(random(width), random(height), nextId,random(40, 90), balls, c));
    nextId +=1;
    randomColor();
  }
}

void mousePressed() {
  numOfBalls = int(random(10, 20));
  balls = new ArrayList<Ball>();
  nextId = balls.size();
  startGame();
}

public void keyPressed() {
  //check which key is pressed
  print(keyCode);
 if(keyCode == 6727){   //create on c
   print("c clicked");
   createRandomBall();
 }else if(keyCode == 6827){  //delete on d
   print("c clicked");
   deleteRandomBall();
 }
}

// Method is called if transcription was successfull 
/*void transcribe (String utterance, float confidence) 
{
  println(utterance);
  result = utterance;
}*/

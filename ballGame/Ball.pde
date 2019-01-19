class Ball{
  PVector position;
  PVector velocity;
  float size, m;
  int numberOfColisions = 0;
  int id;
  ArrayList<Ball> neighbours;
  color c;
  
  Ball(float x, float y, int eid, float esize, ArrayList<Ball> neig, color ec){
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(3);
    id = eid;
    size = esize;
    m = size*.1;
    neighbours = neig;
    c = ec;
  }
  void move(){
    position.add(velocity);
  }
  
  void boundaryCollision(){
    if (position.x > width-(size/2)){
      position.x = width-(size/2);
      velocity.x *= -1; //change the direction of movement
    }else if(position.y > height-(size/2)){
      position.y = height-(size/2);
      velocity.y *= -1;
    }else if(position.x < (size/2)){
      position.x = (size/2);
      velocity.x *= -1;
    }else if(position.y < (size/2)){
      position.y = (size/2);
      velocity.y *= -1;
    }
  }
  
  void ballCollision(){
    for (int i = 0; i<neighbours.size(); i++){
      Ball b = neighbours.get(i);
      if(b.id != id){
        colide(b);
      }
    }
  }
  
  void colide(Ball ball){
    float radius = size/2;
    // Get distances between the balls
    PVector distance = PVector.sub(ball.position, position);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distance.mag();

    // Minimum distance before they are touching
    float minDistance =  radius + (ball.size /2);

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distance.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      ball.position.add(correctionVector);
      position.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distance.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      bTemp[1].x  = cosine * distance.x + sine * distance.y;
      bTemp[1].y  = cosine * distance.y - sine * distance.x;

      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * ball.velocity.x + sine * ball.velocity.y;
      vTemp[1].y  = cosine * ball.velocity.y - sine * ball.velocity.x;

      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      vFinal[0].x = ((m - ball.m) * vTemp[0].x + 2 * ball.m * vTemp[1].x) / (m + ball.m);
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[1].x = ((ball.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + ball.m);
      vFinal[1].y = vTemp[1].y;

      // hack to avoid clumping
      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      ball.position.x = position.x + bFinal[1].x;
      ball.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);

      // update velocities
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      ball.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      ball.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      //check current ball
      if(numberOfColisions < 4){
        size = random(size-5, size-15);
        numberOfColisions +=1;
      }else if(numberOfColisions == 4){
        deleteBall(this);
      }
      checkBallCondition(ball);
    }
  }
  
  private void checkBallCondition(Ball b){
    if(b.numberOfColisions < 3){
      b.size = random(size-5, size-15);
      b.numberOfColisions +=1;
      createBall();
    }else if(b.numberOfColisions == 3){
      deleteBall(b);
    }
  }
  
  void display(){
    noStroke();
    fill(c);
    ellipse(position.x, position.y, size, size);
  }
}

class Element1{
  //Element 1
  ////Form 1 : Circle
  ////Behavior 1 : Move in a straight line
  ////Behavior 2 : Constrain to Surface
  ////Behavior 3 : Change direction while touching another Element
  ////Behavior 4 : Move away from an overlapping Element
  
  PVector pos;
  PVector vel;
  float size;

  Process6 processBelongTo;
  
  Element1(){
    this.vel = PVector.random2D().mult(random(_elementSpeed[0], _elementSpeed[1]));
    this.size = random(_elementSize[0], _elementSize[1]);
    this.pos = new PVector(random(size, width-size), random(size, height-size));
  }
  
  Element1(Process6 p){
    //this.vel = PVector.random2D().mult(random(_elementSpeed[0], _elementSpeed[1]));
    this.vel = new PVector(1,0).mult(random(_elementSpeed[0], _elementSpeed[1])).rotate(radians(40*int(random(0, 9))));
    if(random(100) < 100){
      this.size = random(_elementSize[0], _elementSize[1]);
    }else{
      this.size = random(_elementSize2[0], _elementSize2[1]);
    }
    processBelongTo = p;
    this.pos = p.centerPos.copy();
  }
  
  void update(Element1[] others){
    Behavior3andBehavior4(others);
    vel.limit(_elementMaxSpeed);
    Behavior2andUpdatePos();
  }
  
  void Behavior3andBehavior4(Element1[] others){
    Boolean touchAnother = false;
    PVector moveAwayVel = new PVector();

    for(int i=0; i<others.length; i++){
      Element1 other = others[i];
      if(this == other) continue;
      //中心の距離 < 半径の和 => 接触
      float dist = PVector.dist(other.pos, this.pos);
      float radSum = other.size + this.size;
      if(dist < radSum){
        PVector[] ver = {other.pos.copy(), this.pos.copy()};
        int gray = (int) map(dist, 0, radSum, _processColor[0], _processColor[1]);
        int[] col = {gray, gray, gray};
        if(this.processBelongTo == other.processBelongTo){
          _vertex.add(ver);
          _col.add(col);
        }

        touchAnother = true;
        moveAwayVel.add(PVector.sub(this.pos, other.pos).setMag(_elementMoveAwaySpeed));
      }
    }

    if(_stop) moveAwayVel.add(PVector.sub(this.pos, processBelongTo.centerPos).setMag(_elementMoveAwaySpeed));
    
    if(touchAnother){
      if(!_stop) {
        vel.rotate(radians(_elementRotateSpeed));
      }
      vel.add(moveAwayVel);
    }
  }
  
  void Behavior2andUpdatePos(){
    PVector futurePos = PVector.add(pos, vel);
    if(PVector.dist(futurePos, processBelongTo.centerPos) > processBelongTo.size){
      if(_stop){
        pos = new PVector(-10000, -10000);
        vel = new PVector(0, 0);
      }else{
        pos = processBelongTo.centerPos.copy();
        vel = new PVector(1,0).mult(random(_elementSpeed[0], _elementSpeed[1])).rotate(radians(40*int(random(0, 9))));
      } 
    }else{
      pos.add(vel);
    }
    
    /*
    Boolean willOutX = futurePos.x < size || width-size < futurePos.x;
    Boolean willOutY = futurePos.y < size || height-size < futurePos.y;
    if(!willOutX){
      pos.x += vel.x;
    }
    if(!willOutY){
      pos.y += vel.y;
    }
    */
  }
  
  void show(){
    push();
      translate(pos.x, pos.y);
      strokeWeight(1);
      randomSeed((int)processBelongTo.centerPos.x*100);
      stroke(random(255),random(255),random(255));
      //noFill();
      randomSeed((int)processBelongTo.centerPos.x*100);
      fill(random(255),random(255),random(255), 10);
      circle(0, 0, size*2);
      rotate(vel.heading()); 
      line(0, 0, size, 0);
      line(size, 0, size*0.8, size*0.2);
      line(size, 0, size*0.8, -size*0.2);
    pop();
  }
  
  void p(){
    strokeWeight(3);
    stroke(0);
    point(pos.x, pos.y);
  }
}

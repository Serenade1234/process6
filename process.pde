class Process6{
  //Process6
  ////three large circles on a rectangular surface.
  ////set the center of each circle as the origin for a large group of Element1.
  ////when an Element moces beyond the edge of its circle, return to the origin.
  ////Draw a line from the centers of Elements that are touching.
  ////the shortest possible line to black and the longest to white.

  PVector centerPos;
  float size;
  Element1[] elements;
  
  Process6(){
    centerPos = new PVector(random(width), random(height));
    size = random(_processCircleSize[0], _processCircleSize[1]);
    elements = new Element1[_processElementNum];
    
    for(int i=0; i<elements.length; i++){
      elements[i] = new Element1(this);
    }
    
  }
  
  void update(){
    for(int i=0; i<this.elements.length; i++){
      for(int j=0; j<processes.length; j++){
        elements[i].Behavior3andBehavior4(processes[j].elements);
      }
      elements[i].vel.limit(_elementMaxSpeed);
    }

    for(int i=0; i<this.elements.length; i++){
      elements[i].Behavior2andUpdatePos();
    }
    
  }
  
  void show(){
    if(_debug){
      for(int i=0; i<this.elements.length; i++){
        elements[i].show();
      }
    }
    
    push();
    translate(centerPos.x, centerPos.y);
    strokeWeight(3);
    stroke(0);
    point(0, 0);
    strokeWeight(1);
    noFill();
    circle(0, 0, size*2);
    pop();
  }
}

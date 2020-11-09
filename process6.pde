//Element : simple machine that is comprised of a form and one or more Behavior.
//Process : defines an environment for Elements and determines how ther relationships Elements and visualized.

float[] _elementSpeed = {4.0, 4.0};
float[] _elementSize = {40.0, 60.0};
//float[] _elementSize = {21.0, 45.0};
float[] _elementSize2 = {100.0, 130.0};
float _elementMaxSpeed = 3.5;
float _elementMoveAwaySpeed  = 0.5;
float _elementRotateSpeed = 0.5; //degree

int     processCircleNum = 3;
//int     _processElementNum = 160;
//float[] _processCircleSize = {1300, 1500}; 
int     _processElementNum = 150;
float[] _processCircleSize = {1000, 1200}; 

float[] _processColor = {0, 255};
float[] _processAlpha = {100, 5};

Boolean _stop = false;
int stopFrameCount;

ArrayList<PVector[]> _vertex = new ArrayList<PVector[]>();
ArrayList<int[]>     _col = new ArrayList<int[]>();

Process6[] processes = new Process6[processCircleNum];

Boolean _debug = false;
int cnt = 0;

void setup(){
  size(1000, 1000);
  //size(2000, 2000);
  smooth();
  //blendMode(REPLACE);
  for(int i=0; i<processes.length; i++){
    processes[i] = new Process6();
  }

  strokeCap(ROUND);
  background(0);

  cnt = 0;
  stopFrameCount = 0;
}

void draw(){
  if(_debug) background(255);
  for(int i=0; i<processes.length; i++){
    processes[i].update();
    if(_debug){
      processes[i].show();
    }
  }

  if(cnt < 160){
    //prevent lag in beginning
    _vertex.clear();
    _col.clear();
  }else{
    displayLine();
  }

  cnt++;
}

void displayLine(){
  for(int i=0; i<_vertex.size(); i++){
    int[] col = _col.get(i);
    PVector[] vertex = _vertex.get(i);

    if(vertex[0] == vertex[1]) continue;

    float alpha = map(col[0], _processColor[0], _processColor[1], _processAlpha[0], _processAlpha[1]);

    if(stopFrameCount > 0){
      alpha *= map(frameCount - stopFrameCount, 0, 200, 0.8, 0.0);
    }
    if(_debug){
      alpha += 100;
    }
    /*if(col[0] < 50){
      alpha = 200;
    }else{
      alpha = map(col[0], 50, 255, 60, 10);
    }*/
    strokeWeight(1);
    stroke(col[0], col[1], col[2], alpha);
    line(vertex[0].x, vertex[0].y, vertex[1].x, vertex[1].y);
  } 
  _vertex.clear();
  _col.clear();
}



void keyPressed(){
  switch(key){
    case ' ':
      setup();
      _stop = false;
      break;
    case 's':
      saveFrame("frame/#######.png");
      break;
    case '1':
       _stop = true;
       stopFrameCount = frameCount;
       break;
    case '2':
      background(0);
      _debug = !_debug;
      break;
  }
}

import http.requests.*;

//PShape drown;

float x, y, z;

int rollAngle=0,pitchAngle=0,yawAngle=0;
int throttle, rollIn, pitchIn, yawIn;
int esc1, esc2, esc3, esc4;
int armed, killed, crashed;

void setup(){
    size(700, 700, P3D);
  x = width/2;
  y = height/2;
  z = 0;
  background(0);
  //drown=loadShape("drone_costum.obj");
}

void draw(){
  print(".");
  //shape(drown);
  background(0);
  GetRequest g = new GetRequest("http://192.168.4.1:80");
  g.send();
  String res = g.getContent();
  println(res);
  if(res!=null && res.indexOf(">")==0){
    String[] parts = split(res, ';');
    parts[0] = parts[0].substring(1);
    rollAngle = int(parts[0]);
    pitchAngle = int(parts[1]);
    yawAngle = int(parts[2]);
    throttle = int(parts[3]);
    rollIn = int(parts[4]);
    pitchIn = int(parts[5]);
    yawIn = int(parts[6]);
    esc1 = int(parts[7]);
    esc2 = int(parts[8]);
    esc3 = int(parts[9]);
    esc4 = int(parts[10]);
    armed = int(parts[11]);
    killed = int(parts[12]);
    crashed = int(parts[13]);
    
    int thrPerc = throttle*100/128;
    int rollPerc = rollIn*100/40;
    int pitchPerc = pitchIn*100/40;
    int yawPerc = yawIn*100/40;
    
    String status = "";
    if(armed==1) status = "ARMED";
    else status = "UNARMED";
    if(killed==1) status = "KILLED";
    if(crashed==1) status = "CRASHED";
    
    //println(rollAngle+" "+pitchAngle+" "+yawAngle);
    
    rectMode(CORNER);
    textSize(20);
    text("Roll: "+rollAngle+"   Pitch: "+pitchAngle+"   Yaw: "+yawAngle+
         "\n\nThrottle: "+thrPerc+"%\nYaw: "+yawPerc+"%\nPitch: "+pitchPerc+"%\nRoll: "+rollPerc+"%\n\n"+status+
         "\n\nM3: "+esc3+"  M1: "+esc1+"\nM2: "+esc2+"  M4: "+esc4
         , 10, 20);
    translate(x, y, z);
    rectMode(CENTER);
    rotateX(radians(-pitchAngle));
    rotateY(radians(-rollAngle));
    rotateZ(radians(yawAngle));
    box(100, 200, 50);
  }
  delay(50);
}

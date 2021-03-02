 import processing.video.*;

Capture cam;

ArrayList <PImage> past_frames = new ArrayList<PImage>();
PImage logo;
float blueoffset;
PImage forest;

void setup() {
  size(640, 960);
   logo = loadImage("Stranger.png");
   forest = loadImage("forest.png");

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this , 640, 480);
  } if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);

    cam.start();
  }
}

void draw() {
  PImage frame;
  int happened = 0;
  int index = 0;
  if (cam.available() == true) {
    cam.read();
  }
  pushMatrix();
  scale(1,-1);
  float prob = random(0,100);
  if(prob<20 && past_frames.size()>0){
    index = int(random(0,past_frames.size()));
    frame = past_frames.get(index);
    happened = 1;
  }
  else{
    image(cam,0,-height+100,width,height/2);
    happened = 0;
  } 
  popMatrix();
  
  if(happened==1){
    frame = past_frames.get(index);
    image(frame,0, height/2-100, width, height);
  }
  
  frame = get(0,height/2-100,width,height);
  
  if(past_frames.size()>250){
    past_frames.remove(0);
    past_frames.add(frame);
  }
  else{
    past_frames.add(frame);
  }
  
  //Render you
  image(cam, 0, -100, width, height/2);
  //Remder forest
  image(forest,0,-50,width,height/2);
  //Render filters
  fill(255,100,20,40);
  rect(0, -100, width, height/2);
  fill(29,45,80,100);
  rect(0, height/2-100, width, height/2);
  //Render inverted forest
  pushMatrix();
  scale(1,-1);
  image(forest,0,-height+150, width, height/2);
  popMatrix();
  //Render logo
  image(logo, width/2 - 100, height/2 - 140, width/3, height/12);
  saveFrame();
}

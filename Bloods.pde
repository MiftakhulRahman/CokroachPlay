class Blood {
  PImage img;
  float x, y;
  float opacity = 255;
  int spawnTime;

  Blood(PImage _img, float _x, float _y) {
    img = _img;
    x = _x;
    y = _y;
    spawnTime = millis();  
  }

  void display() {
    int elapsedTime = millis() - spawnTime;

    
    opacity = map(elapsedTime, 0, 3000, 255, 0);
    opacity = constrain(opacity, 0, 255); 

    
    pushMatrix();      
    imageMode(CENTER);  
    tint(255, opacity); 
    image(img, x, y);
    popMatrix();      


    noTint();
  }


  boolean isFaded() {
    return opacity <= 0;
  }
}

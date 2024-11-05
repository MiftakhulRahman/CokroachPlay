import processing.sound.*;
ArrayList<Cokroach> coks;
ArrayList<Blood> bloods;  
PImage img, bloodImg;
SoundFile bgMusic, hitSound, spawnSound;
int spawnInterval = 5000;
int lastSpawnTime, killedCount = 0;

void setup() {
  size(800, 800);
  coks = new ArrayList<Cokroach>();
  bloods = new ArrayList<Blood>();  
  img = loadImage("kecoa.png");
  bloodImg = loadImage("blood.png"); 
  
  hitSound = new SoundFile(this, "hit.wav");
  bgMusic = new SoundFile(this, "In-the-Dead-of-Night.mp3");
  spawnSound = new SoundFile(this, "spawn.wav");

  lastSpawnTime = millis();
  bgMusic.loop();
}

void draw() {
  background(255);

  
  fill(51);  
  textSize(16); 
  textAlign(LEFT, TOP);  
  text("Nama : Miftakhul Rahman\n" +
       "NIM : 24.66.1012\n" +
       "Kelas : Pertukaran Mahasiswa\n" +
       "Mata Kuliah : Media Interaktif", 50, 10);

 
  if (millis() - lastSpawnTime > spawnInterval) {
    addRandomCokroach();
    lastSpawnTime = millis();
  }


  for (int i = coks.size() - 1; i >= 0; i--) {
    coks.get(i).live();
  }


  for (int i = bloods.size() - 1; i >= 0; i--) {
    Blood b = bloods.get(i);
    b.display();
    if (b.isFaded()) {  // Hapus darah jika sudah memudar
      bloods.remove(i);
    }
  }


  fill(51);
  textSize(16);
  textAlign(LEFT);
  text("Cockroach: " + coks.size(), 50, 750);
  text("Killed: " + killedCount, 50, 770);
}


void addRandomCokroach() {
  float x = random(width);
  float y = random(height);
  coks.add(new Cokroach(img, x, y));
  spawnSound.play();
}


void mouseClicked() {
  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    if (c.isHit(mouseX, mouseY)) {
      coks.remove(i);
      killedCount++;
      hitSound.play();


      bloods.add(new Blood(bloodImg, c.pos.x, c.pos.y));
    }
  }
}

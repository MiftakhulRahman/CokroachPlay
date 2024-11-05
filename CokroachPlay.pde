import processing.sound.*;
ArrayList<Cokroach> coks;
ArrayList<Blood> bloods;  // List untuk objek darah
PImage img, bloodImg;
SoundFile bgMusic, hitSound, spawnSound;
int spawnInterval = 5000;
int lastSpawnTime, killedCount = 0;

void setup() {
  size(800, 800);
  coks = new ArrayList<Cokroach>();
  bloods = new ArrayList<Blood>();  // Inisialisasi list darah
  img = loadImage("kecoa.png");
  bloodImg = loadImage("blood.png");  // Gambar darah
  
  hitSound = new SoundFile(this, "hit.wav");
  bgMusic = new SoundFile(this, "In-the-Dead-of-Night.mp3");
  spawnSound = new SoundFile(this, "spawn.wav");

  lastSpawnTime = millis();
  bgMusic.loop();
}

void draw() {
  background(255);

  // Tampilkan informasi tetap di pojok kiri atas
  fill(51);  // Warna teks hitam
  textSize(16);  // Ukuran teks
  textAlign(LEFT, TOP);  // Rata kiri atas
  text("Nama : Miftakhul Rahman\n" +
       "NIM : 24.66.1012\n" +
       "Kelas : Pertukaran Mahasiswa\n" +
       "Mata Kuliah : Media Interaktif", 50, 10);

  // Tambah kecoak otomatis tiap 5 detik
  if (millis() - lastSpawnTime > spawnInterval) {
    addRandomCokroach();
    lastSpawnTime = millis();
  }

  // Tampilkan semua kecoak
  for (int i = coks.size() - 1; i >= 0; i--) {
    coks.get(i).live();
  }

  // Tampilkan semua darah
  for (int i = bloods.size() - 1; i >= 0; i--) {
    Blood b = bloods.get(i);
    b.display();
    if (b.isFaded()) {  // Hapus darah jika sudah memudar
      bloods.remove(i);
    }
  }

  // Tampilkan jumlah kecoak aktif dan terbunuh
  fill(51);
  textSize(16);
  textAlign(LEFT);
  text("Cockroach: " + coks.size(), 50, 750);
  text("Killed: " + killedCount, 50, 770);
}

// Menambahkan kecoak di posisi acak dengan sound effect
void addRandomCokroach() {
  float x = random(width);
  float y = random(height);
  coks.add(new Cokroach(img, x, y));
  spawnSound.play();
}

// Cek apakah kecoak terkena klik mouse
void mouseClicked() {
  for (int i = coks.size() - 1; i >= 0; i--) {
    Cokroach c = coks.get(i);
    if (c.isHit(mouseX, mouseY)) {
      coks.remove(i);
      killedCount++;
      hitSound.play();

      // Tambahkan darah di posisi kecoa yang terbunuh
      bloods.add(new Blood(bloodImg, c.pos.x, c.pos.y));
    }
  }
}

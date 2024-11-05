class Blood {
  PImage img;
  float x, y;
  float opacity = 255;  // Opasitas awal
  int spawnTime;

  Blood(PImage _img, float _x, float _y) {
    img = _img;
    x = _x;
    y = _y;
    spawnTime = millis();  // Catat waktu muncul darah
  }

  void display() {
    int elapsedTime = millis() - spawnTime;

    // Hitung opasitas berdasarkan waktu (3 detik = 3000 ms)
    opacity = map(elapsedTime, 0, 3000, 255, 0);
    opacity = constrain(opacity, 0, 255);  // Batasi nilai 0-255

    // Tampilkan gambar darah dengan opasitas
    pushMatrix();       // Simpan state transformasi
    imageMode(CENTER);  
    tint(255, opacity); // Terapkan transparansi hanya untuk darah
    image(img, x, y);
    popMatrix();        // Kembalikan state agar tidak mempengaruhi kecoak

    // Reset tint ke default setelah menampilkan gambar
    noTint();
  }

  // Periksa apakah darah sudah memudar sepenuhnya
  boolean isFaded() {
    return opacity <= 0;
  }
}

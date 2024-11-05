class Cokroach {
  PVector pos, vel;
  PImage img;
  float heading;
  float size = 50;  // Ukuran kecoak untuk deteksi hit

  Cokroach(PImage _img, float _x, float _y) {
    pos = new PVector(_x, _y);
    vel = PVector.random2D().mult(2);  // Tambahkan kecepatan
    heading = 0;
    img = _img;
  }

  void live() {
    pos.add(vel);

    // Pantul jika mencapai tepi layar
    if (pos.x <= 0 || pos.x >= width) vel.x *= -1;
    if (pos.y <= 0 || pos.y >= height) vel.y *= -1;

    // Atur arah rotasi berdasarkan kecepatan
    heading = atan2(vel.y, vel.x);

    pushMatrix();
    imageMode(CENTER);
    translate(pos.x, pos.y);
    rotate(heading + 0.5 * PI);
    image(img, 0, 0);
    popMatrix();
  }

  // Cek apakah mouse klik mengenai kecoak
  boolean isHit(float mx, float my) {
    return dist(mx, my, pos.x, pos.y) < size / 2;
  }
}

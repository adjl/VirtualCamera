class Camera {

  float eyeX;
  float eyeY;
  float eyeZ;

  float centreX;
  float centreY;
  float centreZ;

  float upX;
  float upY;
  float upZ;

  float angle;

  Camera(int width, int height) {
    eyeX = 0;
    eyeY = 0;
    eyeZ = 0;

    centreX = 0;
    centreY = 0;
    centreZ = -1;

    upX = 0;
    upY = 1;
    upZ = 0;

    angle = 0;

    perspective(PI * 3 / 8, 4 / 3.075, 0.1, 1000);
  }

  float getEyeX() {
    return eyeX;
  }

  float getEyeY() {
    return eyeY;
  }

  float getEyeZ() {
    return eyeZ;
  }

  void moveForward() {
    eyeX += sin(angle);
    centreX += sin(angle);
    eyeZ -= cos(angle);
    centreZ -= cos(angle);
  }

  void moveLeft() {
    angle -= PI / 180;
  }

  void moveBackward() {
    eyeX -= sin(angle);
    centreX -= sin(angle);
    eyeZ += cos(angle);
    centreZ += cos(angle);
  }

  void moveRight() {
    angle += PI / 180;
  }

  void set() {
    beginCamera();
    camera(eyeX, eyeY, eyeZ, centreX, centreY, centreZ, upX, upY, upZ);
    translate(eyeX, eyeY, eyeZ);
    rotateY(angle);
    translate(-centreX, -centreY, -centreZ);
    endCamera();
  }
}
import java.awt.AWTException;
import java.awt.Robot;

class Camera {

  Mouse mouse;
  PVector eye;
  PVector centre;
  PVector up;
  PVector angle;
  float fovy;
  float aspect;
  float zNear;
  float zFar;
  float speed;

  Camera(float height) {
    mouse = new Mouse();
    eye = new PVector(0, height, 0);
    centre = new PVector(0, height, -1);
    up = new PVector(0, 1, 0);
    angle = new PVector();
    fovy = HALF_PI * 3 / 4;
    aspect = 4 / 3.075;
    zNear = 0.1;
    zFar = 1000;
    speed = 2.0;
    perspective(fovy, aspect, zNear, zFar);
  }

  PVector forwardPosition() {
    PVector distance = new PVector(-sin(angle.x) * speed, 0, cos(angle.x) * speed);
    PVector position = eye.get();
    position.add(distance);
    return position;
  }

  PVector backwardPosition() {
    PVector distance = new PVector(sin(angle.x) * speed, 0, -cos(angle.x) * speed);
    PVector position = eye.get();
    position.add(distance);
    return position;
  }

  PVector leftPosition() {
    PVector distance = new PVector(sin(angle.x + HALF_PI) * speed, 0, -cos(angle.x + HALF_PI) * speed);
    PVector position = eye.get();
    position.add(distance);
    return position;
  }

  PVector rightPosition() {
    PVector distance = new PVector(-sin(angle.x + HALF_PI) * speed, 0, cos(angle.x + HALF_PI) * speed);
    PVector position = eye.get();
    position.add(distance);
    return position;
  }

  void moveForward() {
    PVector distance = new PVector(-sin(angle.x) * speed, 0, cos(angle.x) * speed);
    eye.add(distance);
    centre.add(distance);
  }

  void moveBackward() {
    PVector distance = new PVector(sin(angle.x) * speed, 0, -cos(angle.x) * speed);
    eye.add(distance);
    centre.add(distance);
  }

  void strafeLeft() {
    PVector distance = new PVector(sin(angle.x + HALF_PI) * speed, 0, -cos(angle.x + HALF_PI) * speed);
    eye.add(distance);
    centre.add(distance);
  }

  void strafeRight() {
    PVector distance = new PVector(-sin(angle.x + HALF_PI) * speed, 0, cos(angle.x + HALF_PI) * speed);
    eye.add(distance);
    centre.add(distance);
  }

  void set() {
    if (mouse.centred()) mouse.move();
    else mouse.centre();
    angle.x = mouse.x() * TAU / (width - 1);
    angle.y = mouse.y() * QUARTER_PI * 3 / (height - 1);
    beginCamera();
    camera(eye.x, eye.y, eye.z, centre.x, centre.y, centre.z, up.x, up.y, up.z);
    translate(eye.x, eye.y, eye.z);
    rotateX(angle.y);
    rotateY(angle.x);
    translate(centre.x, centre.y, centre.z);
    endCamera();
  }

  class Mouse {

    Robot robot;
    boolean centred;
    int attempt;

    Mouse() {
      try {
        robot = new Robot();
      } catch (AWTException e) {
        e.printStackTrace();
        exit();
      }
      centred = false;
      attempt = 3;
    }

    boolean centred() {
      return centred;
    }

    int x() {
      return mouseX;
    }

    int y() {
      return (height / 2) - mouseY;
    }

    void centre() {
      robot.mouseMove(width / 2, height / 2);
      // Cursor centering works only on the third draw() call
      if (--attempt == 0) centred = true;
    }

    void move() {
      if (mouseX == 0) { // Wrap cursor horizontally
        robot.mouseMove(width - 1, mouseY);
      } else if (mouseX == width - 1) {
        robot.mouseMove(0, mouseY);
      }
    }
  }
}
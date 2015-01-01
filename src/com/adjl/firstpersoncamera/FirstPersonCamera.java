package com.adjl.firstpersoncamera;

import processing.core.PApplet;
import processing.core.PConstants;

/**
 * FirstPersonCamera Processing sketch.
 *
 * Processing demonstration of a first-person camera.
 *
 * @author adjl
 */
public class FirstPersonCamera extends PApplet {

    private final int mBackground;
    private final int mStroke;
    private final int mStrokeWeight;

    private World mWorld;
    private Camera mCamera;

    /**
     * Constructs the FirstPersonCamera sketch.
     */
    public FirstPersonCamera() {
        mBackground = color(0, 0, 0);
        mStroke = color(255, 255, 255);
        mStrokeWeight = 2;
    }

    @Override
    public void setup() {
        size(displayWidth, displayHeight, PConstants.P3D);
        noCursor();
        noFill();
        stroke(mStroke);
        strokeWeight(mStrokeWeight);
        mWorld = new Room(this);
        mCamera = new Camera(this, mWorld);
    }

    @Override
    public void draw() {
        background(mBackground);
        mWorld.draw();
        mCamera.set();
    }

    @Override
    public void keyPressed() {
        mCamera.move(key);
    }

    public static void main(String[] args) {
        PApplet.main(new String[] { "--present",
            com.adjl.firstpersoncamera.FirstPersonCamera.class.getName() });
    }
}
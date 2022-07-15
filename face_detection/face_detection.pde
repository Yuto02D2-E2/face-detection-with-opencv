/*
- 顔の周りを緑の線で囲む
- 犯罪者みたいに黒の目線を入れる
*/


import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;


Capture video;
OpenCV opencv;


void setup() {
    //size(1024, 720); // ノートPCのGPUだと，処理が追い付かなくてカクカクになる
    size(720, 480); // これくらいが限界かな
    colorMode(RGB, 255, 255, 255, 100);

    video = new Capture(this, width, height);
    opencv = new OpenCV(this, width, height);
    video.start();
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    //opencv.loadCascade(OpenCV.CASCADE_EYE);
}

void draw() {
    opencv.loadImage(video);
    image(video, 0, 0); // カメラの映像をProcessingのウィンドウに表示
    Rectangle[] faces = opencv.detect();
    strokeWeight(5);
    for (int i = 0; i < faces.length; i++) {
        //目線
        fill(0);
        noStroke();
        rect(faces[i].x, faces[i].y + faces[i].height/3, faces[i].width, faces[i].height/10);

        //顔の周りの枠
        noFill();
        stroke(0, 255, 0);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
}

void captureEvent(Capture video) {
    video.read();
}

// TO Do,  Prevent the PDF version from drawing multiple times
// Otherwise LightBurn will trace over the patters multiple times
// cutting deeper than desired

// Code from: https://gist.github.com/sambrenner/1308163
// sambrenner/spirograph.pde
// https://www.samjbrenner.com

// Adapted by Rupert Russell for createing Redbubble artworks
// and LightBurn PDF files.
// December 8, 2019

// Based on Code by Sam Brenner
// https://samjbrenner.com/notes/processing-spirograph/

// Keys Cursor Keys Up, Down, Left & Right
// Keys < >
// Key S to Save Spirograph


import processing.pdf.*;
import processing.opengl.*;

float a, b, h, xpos, ypos, oxpos, oypos, t, ot, d, od, s;
int frameSize = 800, counter;
void setup()
{
  size(800, 800);
  //  colorMode(HSB,360);
  counter = 0;
  frameRate(1);

  background(255);
  stroke (0);
  beginRecord(PDF, "spiro_237_110_112.pdf"); // Saves to a PDF uncomment endrecord at bottom of code as wells

  a= 237;
  b= 110;
  h = 112;
}

void draw()

{  
  // Use Cursor & <> keys to modify not mouse movement
  // a=mouseX;
  // b=60;
  // h=mouseY;

  for (float i=1; i<361; i+=1)
  {
    t=radians(i);
    ot=radians(i-1);
    d=(a-b/b)*t;
    od=(a-b/b)*ot;

    oxpos=(a-b)*cos(ot)+h*cos(od);
    oypos=(a-b)*sin(ot)+h*sin(od);    

    xpos=(a-b)*cos(t)+h*cos(d);
    ypos=(a-b)*sin(t)+h*sin(d);

    line(frameSize/2+oxpos, frameSize/2+oypos, frameSize/2+xpos, frameSize/2+ypos);
    counter ++;
    if (counter > 360) {
      endRecord();  // Save the PDF file
      save("spirograph_"+round(a)+"_"+round(b)+"_"+round(h)+".png");
      noLoop();
      exit();
      println("Saved" + counter);
      counter = counter + 1;
    }
  }
}
void mousePressed()
{
  save("spirograph_"+a+"_"+b+"_"+h+".png");
  exit();
}

void keyPressed() {
  if (key == CODED) {
    println("a = " + a);
    if (keyCode == UP) {
      a = a + 1;
    } else if (keyCode == DOWN) {
      a = a - 1;
    } else if (keyCode == LEFT) {
      h = h + 0.5;
    } else if (keyCode == RIGHT) {
      h = h - 0.5;
    }
  }

  if (key == 's' || key == 'S') {
    save("spirograph_"+a+"_"+b+"_"+h+".png");
    println("spirograph_"+a+"_"+b+"_"+h+".png");
  }

  if (key == '<' || key == ',') {
    b = b - 0.5;
  }

  if (key == '>' || key == '.') {
    b = b + 0.5;
  }
}

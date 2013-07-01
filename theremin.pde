import lmu.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.effects.*;
 
Minim minim;
AudioOutput out;
SineWave    sine;

int lmu_left;
int lmu_right;
float multi;
 
void setup()
{
  size(800,800);
  frameRate(80);
   
  // Sound Stuff  
  minim         = new Minim(this);
  int baseNote  = 44100;
  sine          = new SineWave(440, 1, 44100);
  out           = minim.getLineOut(Minim.STEREO, 512);
  out.addSignal(sine);
  
  // initial sensor values
  int[] lmu_start = LmuTracker.getLMUArray();
  lmu_left        = lmu_start[0];
  lmu_right       = lmu_start[1];
  multi           = 255.0 / (lmu_left);
} 
 
void draw()
{
  // get current sensor values
  int[] vals = LmuTracker.getLMUArray();
  int li = (int)(vals[0] * multi);
  int re = (int)(vals[1] * multi);
 
  background(255);
 
  // left sensor
  fill(li);
  rect(0, 0, width/2, height);
 
  // right sensor
  fill(re);
  rect(width/2, 0, width/2, height);
  println(li);

  SineWave new_signal = (SineWave) out.getSignal(0);
  new_signal.setFreq(185+li);
}

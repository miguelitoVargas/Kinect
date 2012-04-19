
Cuerda[] c1;

float friction = 0.5;
boolean pluck=false;
float t = 0;
float fX,fY;
void setup()
{
   size(400,500, P3D);
   smooth();
   c1 = new Cuerda[height/10];
   for (int i = 0; i < c1.length; i++)
   {
     c1[i] = new Cuerda(width/2, 0,2,2);
     fX = c1[0].x;
     fY = c1[0].y;
   }
   for(int i = 1; i < c1.length; i++)
   {
     c1[i].target = c1[i-1];
   }
   
    
   
}

void draw()
{
  
  noStroke();
  fill(0,2);
  rect(0,0,width,height);
  
   if(pluck)
   {
     c1[0].update(c1[0].x + 1000 ,c1[0].y + 350);
     //delay(500);
     c1[0].update(c1[0].x - 1000,c1[0].y - 350);
   }else
   {
      c1[0].update(fX,fY);
   }
  c1[0].draw( width/2,0);//c1[0].x, c1[0].y);
 
 
//beginShape(POLYGON);
  for (int i = 1; i < c1.length; i++)
  {
    c1[i].update();
    c1[i].draw();
    //curveVertex(c1[i].x,c1[i].y);
    
  }
 //endShape();
 
}

void mousePressed()
{
  pluck = true; 
  //c1[0].update(c1[0].x + 150,c1[0].y );
  
}
void mouseReleased()
{
  pluck = false;
}



class Cuerda
{
  float vx, vy; // velocidades x y
  float x,y; // coordenadas
  float grav, masa;
  float stiff= 0.2;
  float damp = 0.7;
 PVector center;
  float radius = 5;
  Cuerda target;
    Cuerda(float xpos, float ypos, float m, float g)
    {
      x = xpos;
      y = ypos;
      masa = m;
      grav = g;
      
      center = new PVector(x,y); //almcenamos la psicion en un vector
      
    }
    Cuerda(float xpos, float ypos, float m, float g, Cuerda t)
    {
        target = t;
         x = xpos;
      y = ypos;
      masa = m;
      grav = g;
    }
    void update(float targetX, float targetY)
    {
       float forceX = (targetX - x) * stiff;
       float ax = forceX / masa;
       vx = damp * (vx + ax);
       x += vx;
       float forceY = (targetY - y) * stiff;
       forceY += grav;
       float ay = forceY / masa;
       vy = damp * (vy + ay);
       y += vy;
    }
    void update()
    {
      float forceX = (target.x -x) * stiff;
      float ax = forceX/masa;
      
      if( y > height - 1 || y < 1)
      {
        if(vx > 0) vx-=friction;
        if(vx < 0) vx += friction;
      }
      if ( x > width || x < 1)
      {
        if(vy > 0) vx-=friction;
        if(vy < 0) vx += friction;
      }
      vx = damp * (vx + ax);
      x+=vx;
      float forceY = (target.y - y) * stiff;
      forceY += grav;
      float ay = forceY/masa;
      vy = damp * (vy + ay);
      y += vy;
       
       if(x > width || x < 0) {
      x += -vx;
    }
    if(y > height || y < 0) {
      y += -vy;
    }
      
    }
    void draw(float nx, float ny)
    {
      pushStyle();
      pushMatrix();
      colorMode(HSB);
      smooth();
     // fill(0);
      noStroke();
      ellipse(x,y,radius*2,radius*2);
      stroke(255,0,255);
      strokeWeight(3);
      line(x,y,nx,ny);
      popMatrix();
      popStyle();
    }
     void draw()
    {
      pushStyle();
      pushMatrix();
      colorMode(HSB);
      smooth();
      //fill(255);
      noStroke();
      ellipse(x,y,radius*2,radius*2);
     
      stroke(255, 0,255);
      strokeWeight(3);
      line(x,y,target.x,target.y);
      popMatrix();
      popStyle();
    }
  
}

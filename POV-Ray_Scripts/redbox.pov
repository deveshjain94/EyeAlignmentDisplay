#version 3.7;
global_settings { assumed_gamma 1 } 

#include "colors.inc"
 
#declare a=-0+0.08*mod(clock,5);
#declare b=0.08*floor(clock/5);
                         
camera {right x*256/144
   location <1+8*sin(a),1+8*sin(b), 8*cos(a)>  
   //location <1,1, 5>
   look_at <1,1,0>
}                      

// create a regular point light source
light_source {
  0*x                  
  color rgb <1,1,1>   
  translate <10,10,0>
}


plane { <0,1,0>, 0  hollow

        texture{ pigment{ color rgb<0.5,0.5, 0.50> }
               }
        scale<10,10,10>  rotate<0,0,0>  translate<0,0,0>
      }                     
      
plane { <0,0,1>, 0  hollow

        texture{ pigment{ color rgb<0.5,0.5, 0.50> }
               }
        scale<10,10,10>  rotate<0,0,0>  translate<0,0,-20>
      }
      

box { <0,0,0>,< 1.00, 1.00, 1.00>   

      texture { pigment{ color rgb<1.00, 0.00, 0.00>*1.1}  
                finish { phong 1 reflection{ 0.00 metallic 0.00} } 
              }

      scale <2,2,2> rotate<0,0,0> translate<0,0,0> 
    } 


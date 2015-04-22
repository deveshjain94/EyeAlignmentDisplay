#version 3.7
global_settings {assumed_gamma 1.0}

#declare a=-0.6+0.3*mod(clock,5);
#declare b=0.6-0.3*floor(clock/5);

#declare Dark_Texture  = texture {
                               pigment{ color rgb<0,0,1>}
                               finish { phong 1}
                             }
#declare Light_Texture = texture { 
                               pigment{ color rgb<1,0,0>}
                               finish { phong 1} 
                              }

// create a regular point light source
light_source {
  0*x                  // light's position (translated below)
  color rgb <1,1,1>    // light's color
  translate <0, 0, 20>
}


#include "shapes3.inc"  
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"

camera {
right x*198/130
   location  <a,b,1.8> 
   look_at   <0,0,-20>}                          
   
plane { <0,1,0>, 0  hollow 
        texture{ pigment{ color rgb<0.35,0.60, 0.00> }
                 //finish { phong 1 }
               }
        scale < 1, 1, 1>
        rotate< 90,0,0> rotate<0,0,0>
        translate<0,0.0,-20>
      }  
#macro sight()     
union{      
/*cylinder { <0,0,-2.00>,<0,0,0>,0.20             //cylinder
           texture{checker texture{Dark_Texture } 
                               texture{Light_Texture} 
                   }
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         }*/ 
                                                    
cylinder { <-0.8,0,-2.00>,<0.8,0,-2.00>,0.05  no_shadow
      //Back Cross
          texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                   }
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         }
         
cylinder { <0,0.8,-2.00>,<0,-0.8,-2.00>,0.050   no_shadow       //back Cross
           texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                   }
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } 
         
cylinder { <-0.5,0,0.00>,<0.5,0,0.00>,0.05        no_shadow        //Front Cross
          texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                   }
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         }
         
cylinder { <0,0.5,0.00>,<0,-0.5,0.00>,0.05       no_shadow
          texture{checker texture{Dark_Texture }                //Front Cross
                               texture{Light_Texture}
                   }
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         }
         scale<0.7,0.7,0.7>     
 }
#end  

union{
object{sight() rotate<0,-13,0> translate<0.4,0,0> }       
object{sight() rotate<0,13,0> translate<-0.4,0,0> }  

}
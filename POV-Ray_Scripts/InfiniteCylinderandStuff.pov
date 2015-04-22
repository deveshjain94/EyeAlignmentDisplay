                                                                        #version 3.7;
global_settings { assumed_gamma 1 } 

#include "colors.inc"   
#include "shapes3.inc"    
 
#declare a=-0.06+0.03*mod(clock,5);
#declare b=-0.03*floor(clock/5);
                         
camera {right x*232/130
   location <5*sin(a),1-5*sin(b), 5*cos(a)>  
   //location <1,1, 5>
   look_at <0,2,0>
}                      

// create a regular point light source
light_source {
  0*x                  
  color rgb <1,1,1>   
  translate <0,10,5>
}


plane { <0,1,0>, 0  hollow

        texture{ pigment{ color rgb<0.1,0.1, 0.1> }
               }
        scale<10,10,10>  rotate<0,0,0>  translate<0,0,0>
      } 
      
plane { <0,0,1>, 0  hollow

        texture{ pigment{ color rgb<0.1,0.1, 0.1> }
               }
        scale<10,10,10>  rotate<0,0,0>  translate<0,0,-20>
      }                     
                          

object{ Round_Cylinder_Tube( <0,0,0>, // starting point
                             <0,0.0,-20>, // end point
                             0.85, // major radius
                             0.12, // minor radius (borders)
                             1,  //  1 = filled; 0 = open tube 
                             1 // 0 = union, 1 = merge for transparent materials 
                           ) //-------------------------------------------------
        texture{ pigment{ color rgb<1,1,1> } 
              // normal { bumps 0.5 scale 0.005 } 
                 finish { phong 1}                               
               } // end texture
        scale <0.03,0.03,0.03> 
        rotate<0,0,0> 
        translate<0,2,0>
      } // end of object ------------------------------------------------------- 
//------------------------------------------------------------------------------

sphere { <0,0,0>, 0.5 

        texture { pigment{ color rgb<1.00, 0.55, 0.00>}
                  finish { phong 1.0 reflection 0.00}
                } // end of texture

          scale<1,1,1>  rotate<0,0,0>  translate<0,0.5,0>  
       }  // end of sphere -----------------------------------  
       
sphere { <0,0,0>, 0.5 

        texture { pigment{ color rgb<1.00, 0, 0.00>}
                  finish { phong 1.0 reflection 0.00}
                } // end of texture

          scale<1,1,1>  rotate<0,0,0>  translate<-3,0.5,-2>  
       }  // end of sphere -----------------------------------  
       
sphere { <0,0,0>, 0.5 

        texture { pigment{ color rgb<0, 0, 1.00>}
                  finish { phong 1.0 reflection 0.00}
                } // end of texture

          scale<1,1,1>  rotate<0,0,0>  translate<5,0.5,-5>  
       }  // end of sphere -----------------------------------     
       

box { <-1.00, 0.00, -1.00>,< 1.00, 2.00, 1.00>   

      texture { pigment{ color rgb<0.00, 0.50, 0.50>}  
                finish { phong 1 reflection{ 0.00 metallic 0.00} } 
              } // end of texture

      scale <0.5,0.5,0.5> rotate<0,0,0> translate<2,2,-3> 
    } // end of box --------------------------------------

julia_fractal{ <-0.083,0.0,-0.83,-0.025>
   quaternion // quaternion hypercomplex
   cube             // Types: sqr  cube
   max_iteration 8
   precision 20     // 10...500

   texture{
     pigment{ color rgb<0.1,1,0.1>}
     finish { phong 1}
   } // end of texture
   scale<1,1,1>
   rotate<0,0,0>
   translate<2,0,0>
} // end of julia_fractal -------- 

intersection{ //----------------------------------------------------------------
// linear prism in x-direction: from ... to ..., number of points (first = last)
prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, // first point
        < 1.00, 0.00>, 
        < 0.00, 1.50>,
        <-1.00, 0.00>  // last point = first point!!!
        rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
      } // end of prism --------------------------------------------------------

// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -1.00 ,1.00 , 4
       <-1.00, 0.00>,  // first point
       < 1.00, 0.00>, 
       < 0.00, 1.50>, 
       <-1.00, 0.00>   // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction!  
      } // end of prism --------------------------------------------------------

  texture { pigment{ color rgb<0.9,0.9,0.9>} 
            finish { phong 0.2}
          } // end of texture

  scale <1.00, 1.00, 1.00>*1.05
  rotate<0,0,0> 
  translate<-5, 0.00, -15> 
}// ------------------------------------------------------- end of intersection

//      Pyramid_N(  N, Radius1, Radius2, Height )
object{ Pyramid_N( 11,    1.30,    0.70,   1.00 ) 
        texture{ pigment{ color rgb<0.05,0.1,0.5> } 
                 normal { bumps 0.25 scale 0.0025 } 
                 finish { phong 1}
               } // end of texture
        scale <1,1,1> rotate<0,0,0> translate<-3,3,-7>
      } // end of object -----------------------------------------------------
//----------------------------------------------------------------------------
 
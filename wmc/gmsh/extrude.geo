
/* MESH PARAMS */

Nc  = 15;            // # points on cube side
No  = 10;            // # points on line from cube to outer box
Ny  = 20;            // # points (y-dir)
Ne  =  5;            // # points in entrance (x-dir)
Nw  = 15;            // # points in wake     (x-dir)
bfc = 1.2;           // expansion from cube surface
Py  = 1.2;           // expansion from ground (y-dir)
Pc  = 0.05;          // edge refinement on cube "Nc Using Bump Pc;"
Nsmooth = 9;         // # mesh smoothing iterations

/* DOMAIN SIZE */

h        = 1.0; // cube height
span     = 10.0;
len      = 10.0;
wake     = 20.0 + 0.5*span;
height   = 5.0;
entrance = -(5.0 + 0.5*span);

lc = 1e-2;

// fixed due to geom
Nb = 0.5*(Nc+1);  // # points on side of small quads
Nz = 2*Nc-1;  // # points (z-dir)

/* CREATE DOMAIN AND MESH */

/******************** POINTS ********************/

// cube lower
Point(1) = {0         ,0,-h/Sqrt(2),lc};
Point(2) = {-h/Sqrt(2),0,0         ,lc};
Point(3) = {0         ,0,h/Sqrt(2) ,lc};
Point(4) = {h/Sqrt(2) ,0,0         ,lc};
       
// cube upper
Point(5) = {0         ,height,-h/Sqrt(2),lc};
Point(6) = {-h/Sqrt(2),height,0         ,lc};
Point(7) = {0         ,height,h/Sqrt(2) ,lc};
Point(8) = {h/Sqrt(2) ,height,0         ,lc};
       
// cube between
//Point(5) = {0         ,h,-h/Sqrt(2),lc};
//Point(6) = {-h/Sqrt(2),h,0         ,lc};
//Point(7) = {0         ,h,h/Sqrt(2) ,lc};
//Point(8) = {h/Sqrt(2) ,h,0         ,lc};
       
// outer lower
Point(9)  = {     0,0,-span/2,lc};
Point(10) = {-len/2,0,-span/2,lc};
Point(11) = {-len/2,0,0      ,lc};
Point(12) = {-len/2,0, span/2,lc};
Point(13) = {     0,0, span/2,lc};
Point(14) = { len/2,0, span/2,lc};
Point(15) = { len/2,0,      0,lc};
Point(16) = { len/2,0,-span/2,lc};

// outer upper
Point(17) = {     0,height,-span/2,lc};
Point(18) = {-len/2,height,-span/2,lc};
Point(19) = {-len/2,height,0      ,lc};
Point(20) = {-len/2,height, span/2,lc};
Point(21) = {     0,height, span/2,lc};
Point(22) = { len/2,height, span/2,lc};
Point(23) = { len/2,height,      0,lc};
Point(24) = { len/2,height,-span/2,lc};

// entrance
Point(57) = {entrance,0     ,-span/2,lc};
Point(58) = {entrance,0     , span/2,lc};
Point(59) = {entrance,height,-span/2,lc};
Point(60) = {entrance,height, span/2,lc};

// Wake
Point(61) = {wake,0     ,-span/2,lc};
Point(62) = {wake,0     , span/2,lc};
Point(63) = {wake,height,-span/2,lc};
Point(64) = {wake,height, span/2,lc};

/******************** LINES ********************/

// cube lower
Line(1) = {1,2}; Transfinite Curve {1} = Nc Using Bump Pc;
Line(2) = {2,3}; Transfinite Curve {2} = Nc Using Bump Pc;
Line(3) = {3,4}; Transfinite Curve {3} = Nc Using Bump Pc;
Line(4) = {4,1}; Transfinite Curve {4} = Nc Using Bump Pc;

// cube upper
Line(5) = {5,6}; Transfinite Curve {5} = Nc Using Bump Pc;
Line(6) = {6,7}; Transfinite Curve {6} = Nc Using Bump Pc;
Line(7) = {7,8}; Transfinite Curve {7} = Nc Using Bump Pc;
Line(8) = {8,5}; Transfinite Curve {8} = Nc Using Bump Pc;

// cube vert		   									             ^
Line(9 ) = {1,5}; Transfinite Curve {9 } = Ny;// Using Bump Pc; //  /|\
Line(10) = {2,6}; Transfinite Curve {10} = Ny;// Using Bump Pc; //   |  
Line(11) = {3,7}; Transfinite Curve {11} = Ny;// Using Bump Pc; //   |
Line(12) = {4,8}; Transfinite Curve {12} = Ny;// Using Bump Pc; //   |  

// outer lower
Line(13) = {9 ,10}; Transfinite Curve {13} = Nb Using Progression 1;
Line(14) = {10,11}; Transfinite Curve {14} = Nb Using Progression 1;
Line(15) = {11,12}; Transfinite Curve {15} = Nb Using Progression 1;
Line(16) = {12,13}; Transfinite Curve {16} = Nb Using Progression 1;
Line(17) = {13,14}; Transfinite Curve {17} = Nb Using Progression 1;
Line(18) = {14,15}; Transfinite Curve {18} = Nb Using Progression 1;
Line(19) = {15,16}; Transfinite Curve {19} = Nb Using Progression 1;
Line(20) = {16,9 }; Transfinite Curve {20} = Nb Using Progression 1;
                                         
// outer upper                         
Line(21) = {17,18}; Transfinite Curve {21} = Nb Using Progression 1;
Line(22) = {18,19}; Transfinite Curve {22} = Nb Using Progression 1;
Line(23) = {19,20}; Transfinite Curve {23} = Nb Using Progression 1;
Line(24) = {20,21}; Transfinite Curve {24} = Nb Using Progression 1;
Line(25) = {21,22}; Transfinite Curve {25} = Nb Using Progression 1;
Line(26) = {22,23}; Transfinite Curve {26} = Nb Using Progression 1;
Line(27) = {23,24}; Transfinite Curve {27} = Nb Using Progression 1;
Line(28) = {24,17}; Transfinite Curve {28} = Nb Using Progression 1;

// outer vert                                                              ^
Line(29) = {9 ,17}; Transfinite Curve {29} = Ny Using Progression Py; //  /|\
Line(30) = {10,18}; Transfinite Curve {30} = Ny Using Progression Py; //   |  
Line(31) = {11,19}; Transfinite Curve {31} = Ny Using Progression Py; //   |
Line(32) = {12,20}; Transfinite Curve {32} = Ny Using Progression Py; //   |  
Line(33) = {13,21}; Transfinite Curve {33} = Ny Using Progression Py;
Line(34) = {14,22}; Transfinite Curve {34} = Ny Using Progression Py;
Line(35) = {15,23}; Transfinite Curve {35} = Ny Using Progression Py;
Line(36) = {16,24}; Transfinite Curve {36} = Ny Using Progression Py;

// connecting lower (inner -> outer)
Line(37) = {1,9 }; Transfinite Curve {37} = No Using Progression bfc;
Line(38) = {2,11}; Transfinite Curve {38} = No Using Progression bfc;
Line(39) = {3,13}; Transfinite Curve {39} = No Using Progression bfc;
Line(40) = {4,15}; Transfinite Curve {40} = No Using Progression bfc;
                                        
// connecting upper (inner -> outer)
Line(41) = {5,17}; Transfinite Curve {41} = No Using Progression bfc;
Line(42) = {6,19}; Transfinite Curve {42} = No Using Progression bfc;
Line(43) = {7,21}; Transfinite Curve {43} = No Using Progression bfc;
Line(44) = {8,23}; Transfinite Curve {44} = No Using Progression bfc;

// entrance
Line(141) = {57,10}; Transfinite Curve {141} = Ne Using Progression 1;
Line(142) = {58,12}; Transfinite Curve {142} = Ne Using Progression 1;
Line(143) = {59,18}; Transfinite Curve {143} = Ne Using Progression 1;
Line(144) = {60,20}; Transfinite Curve {144} = Ne Using Progression 1;


Line(145) = {57,58}; Transfinite Curve {145} = Nz;
Line(146) = {59,60}; Transfinite Curve {146} = Nz;

Line(147) = {58,60}; Transfinite Curve {147} = Ny Using Progression Py;
Line(148) = {57,59}; Transfinite Curve {148} = Ny Using Progression Py;

// wake
Line(149) = {14,62}; Transfinite Curve {149} = Nw Using Progression 1;
Line(150) = {16,61}; Transfinite Curve {150} = Nw Using Progression 1;
Line(151) = {22,64}; Transfinite Curve {151} = Nw Using Progression 1;
Line(152) = {24,63}; Transfinite Curve {152} = Nw Using Progression 1;
                                           
Line(153) = {61,62}; Transfinite Curve {153} = Nz;
Line(154) = {63,64}; Transfinite Curve {154} = Nz;

Line(155) = {61,63}; Transfinite Curve {155} = Ny Using Progression Py;
Line(156) = {62,64}; Transfinite Curve {156} = Ny Using Progression Py;

/******************** SURFACES ********************/

// AC -- anti-clockwise when looking from inside the domain
// CL --      clockwise when looking from inside the domain   

// inner vert
Line Loop(1) = {1,10,-5,-9 }; Plane Surface(1) = {1}; // AC
Line Loop(2) = {2,11,-6,-10}; Plane Surface(2) = {2};
Line Loop(3) = {3,12,-7,-11}; Plane Surface(3) = {3};
Line Loop(4) = {4,9 ,-8,-12}; Plane Surface(4) = {4};

Transfinite Surface {1}; Recombine Surface {1};
Transfinite Surface {2}; Recombine Surface {2};
Transfinite Surface {3}; Recombine Surface {3};
Transfinite Surface {4}; Recombine Surface {4};

// inner top
Line Loop(5) = {5,6,7,8}; Plane Surface(5) = {5}; // AC

Transfinite Surface {5}; Recombine Surface {5};

// quadrant bottom - AC from top
//Line Loop(6) = {37,45,-38,-1}; Plane Surface(6) = {6};
//Line Loop(7) = {38,46,-39,-2}; Plane Surface(7) = {7};
//Line Loop(8) = {39,47,-40,-3}; Plane Surface(8) = {8};
//Line Loop(9) = {40,48,-37,-4}; Plane Surface(9) = {9};
//
//Transfinite Surface {6}; Recombine Surface {6};
//Transfinite Surface {7}; Recombine Surface {7};
//Transfinite Surface {8}; Recombine Surface {8};
//Transfinite Surface {9}; Recombine Surface {9};

// diag connecting vert  (intra-domain surface)
// AC when viewed from volume in AC direction (when viewed from top)
Line Loop(15) = {9 ,41,-29,-37}; Plane Surface(15) = {15};
Line Loop(16) = {10,42,-31,-38}; Plane Surface(16) = {16};
Line Loop(17) = {11,43,-33,-39}; Plane Surface(17) = {17};
Line Loop(18) = {12,44,-35,-40}; Plane Surface(18) = {18};

Transfinite Surface {15}; Recombine Surface {15};
Transfinite Surface {16}; Recombine Surface {16};
Transfinite Surface {17}; Recombine Surface {17};
Transfinite Surface {18}; Recombine Surface {18};

// outer vert - AC from inside
Line Loop(23) = {29,21,-30,-13}; Plane Surface(23) = {23};
Line Loop(24) = {30,22,-31,-14}; Plane Surface(24) = {24};
Line Loop(25) = {31,23,-32,-15}; Plane Surface(25) = {25};
Line Loop(26) = {32,24,-33,-16}; Plane Surface(26) = {26};
Line Loop(27) = {33,25,-34,-17}; Plane Surface(27) = {27};
Line Loop(28) = {34,26,-35,-18}; Plane Surface(28) = {28};
Line Loop(29) = {35,27,-36,-19}; Plane Surface(29) = {29};
Line Loop(30) = {36,28,-29,-20}; Plane Surface(30) = {30};

Transfinite Surface {23}; Recombine Surface {23};
Transfinite Surface {24}; Recombine Surface {24};
Transfinite Surface {25}; Recombine Surface {25};
Transfinite Surface {26}; Recombine Surface {26};
Transfinite Surface {27}; Recombine Surface {27};
Transfinite Surface {28}; Recombine Surface {28};
Transfinite Surface {29}; Recombine Surface {29};
Transfinite Surface {30}; Recombine Surface {30};

// entrance  -- AC from inside entrance volume

Line Loop(91)={-141,145,142,-63,-62,-56,-55}; Plane Surface(91) = {91};
Line Loop(92)={143,91,92,98,99,-144,-146}; Plane Surface(92) = {92};

Transfinite Surface {91} = {57,58,12,10}; Recombine Surface {91};
Transfinite Surface {92} = {59,60,20,18}; Recombine Surface {92};

Line Loop(93) = {141,30,-143,-148};  Plane Surface(93) = {93};
Line Loop(94) = {147,144,-32,-142};  Plane Surface(94) = {94};
Line Loop(95) = {-145,148,146,-147}; Plane Surface(95) = {95};

Transfinite Surface {93}; Recombine Surface {93};
Transfinite Surface {94}; Recombine Surface {94};
Transfinite Surface {95}; Recombine Surface {95};

// wake  -- AC from inside wake volume

Line Loop(96)={-81,-80,-74,-73,149,-153,-150}; Plane Surface(96) = {96};
Line Loop(97)={109,110,116,117,152,154,-151}; Plane Surface(97) = {97};

Transfinite Surface {96} = {14,16,61,62}; Recombine Surface {96};
Transfinite Surface {97} = {22,24,63,64}; Recombine Surface {97};

Line Loop(98 ) = {34,151,-156,-149};  Plane Surface(98 ) = {98 };
Line Loop(99 ) = {150,155,-152,-36};  Plane Surface(99 ) = {99 };
Line Loop(100) = {153,156,-154,-155}; Plane Surface(100) = {100};

Transfinite Surface {98 }; Recombine Surface {98 };
Transfinite Surface {99 }; Recombine Surface {99 };
Transfinite Surface {100}; Recombine Surface {100};


//Mesh.Smoothing = Nsmooth;

/******************** VOLUMES ********************/

// surfaces are oriented anti-clockwise when looking from inside the volume

// diag box - sides
Surface Loop(1) = {6,1,15,19,-16,-10}; Volume(1) = {1};
Surface Loop(2) = {7,2,16,20,-17,-11}; Volume(2) = {2};
Surface Loop(3) = {8,3,17,21,-18,-12}; Volume(3) = {3};
Surface Loop(4) = {9,4,18,22,-15,-13}; Volume(4) = {4};

Transfinite Volume {1}; Recombine Volume {1};
Transfinite Volume {2}; Recombine Volume {2};
Transfinite Volume {3}; Recombine Volume {3};
Transfinite Volume {4}; Recombine Volume {4};

// diag box - top
Surface Loop(5) = {5,10,11,12,13,-14}; Volume(5) = {5};
Transfinite Volume {5}; Recombine Volume {5};


// entrance and wake
//Surface Loop(18)={}; Volume(18)={18};
//Surface Loop(19)={}; Volume(19)={19};
//
//Transfinite Volume {18}={57,58,12,10,18,59,60,20}; Recombine Volume {18};
//Transfinite Volume {19}={14,62,61,16,24,22,64,63}; Recombine Volume {19};


/******************** BOUNDARY CONDITIONS ********************/
//Physical Surface("inlet") = {32};
//Physical Surface("outlet") = {24};
//Physical Surface("sym") = {8, 27, 28};
//Physical Surface("pm") = {19, 25, 30};
//Physical Surface("pp") = {6, 23, 31};
//Physical Surface("wall") = {1,2,3,4,5,};
//Physical Volume("fluid") = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19};

// mesh order
Mesh.ElementOrder = 2;
Mesh.SecondOrderLinear = 0;


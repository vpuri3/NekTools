
/* MESH PARAMS */

Nc  = 19;            // # of points on cube side
No  = 15;            // # of points on connecting line
bfc = 1.0;           // expansion from cube surface
Pw  = 1.0;           // expansion from ground
Pc  = 1.0;           // edge refinement on cube "Nc Using Bump Pc;"
Nsmooth = 0;         // # of mesh smoothing iterations

Nb  = 0.5*(Nc+1); // fixed due to geom

/* DOMAIN SIZE */

// dim
h = 1.0;       // cube height
span = 10.0;
len = 10.0;
wake = 20.0 + 0.5*span;
height = 5.0;
entrance = -(5.0 + 0.5*span);


/* CREATE DOMAIN AND MESH */

/******************** POINTS ********************/

// cube lower
Point(1) = {0         ,0,-h/Sqrt(2)};
Point(2) = {-h/Sqrt(2),0,0         };
Point(3) = {0         ,0,h/Sqrt(2) };
Point(4) = {h/Sqrt(2) ,0,0         };
       
// cube upper
Point(5) = {0         ,h,-h/Sqrt(2)};
Point(6) = {-h/Sqrt(2),h,0         };
Point(7) = {0         ,h,h/Sqrt(2) };
Point(8) = {h/Sqrt(2) ,h,0         };
       
// outer lower
Point(9)  = {     0,0,-span/2};
Point(10) = {-len/2,0,-span/2};
Point(11) = {-len/2,0,0      };
Point(12) = {-len/2,0, span/2};
Point(13) = {     0,0, span/2};
Point(14) = { len/2,0, span/2};
Point(15) = { len/2,0,      0};
Point(16) = { len/2,0,-span/2};

// outer upper
Point(17) = {     0,height,-span/2};
Point(18) = {-len/2,height,-span/2};
Point(19) = {-len/2,height,0      };
Point(20) = {-len/2,height, span/2};
Point(21) = {     0,height, span/2};
Point(22) = { len/2,height, span/2};
Point(23) = { len/2,height,      0};
Point(24) = { len/2,height,-span/2};

// outer lower mid-pts
Point(25) = {-len/4,0,-span/2};
Point(26) = {-len/2,0,-span/4};
Point(27) = {-len/2,0, span/4};
Point(28) = {-len/4,0, span/2};
Point(29) = { len/4,0, span/2};
Point(30) = { len/2,0, span/4};
Point(31) = { len/2,0,-span/4};
Point(32) = { len/4,0,-span/2};

// outer upper mid-pts
Point(33) = {-len/4,height,-span/2};
Point(34) = {-len/2,height,-span/4};
Point(35) = {-len/2,height, span/4};
Point(36) = {-len/4,height, span/2};
Point(37) = { len/4,height, span/2};
Point(38) = { len/2,height, span/4};
Point(39) = { len/2,height,-span/4};
Point(40) = { len/4,height,-span/2};

// diag lower mid-pots
Point(41) = {-len/4,0,-span/4};
Point(42) = {-len/4,0, span/4};
Point(43) = { len/4,0, span/4};
Point(44) = { len/4,0,-span/4};

// diag upper mid-pots
Point(45) = {-len/4,height,-span/4};
Point(46) = {-len/4,height, span/4};
Point(47) = { len/4,height, span/4};
Point(48) = { len/4,height,-span/4};

// outer triangle mid-points lower
Point(49) = {-len/3,0,-span/3};
Point(50) = {-len/3,0, span/3};
Point(51) = { len/3,0, span/3};
Point(52) = { len/3,0,-span/3};

// outer triangle mid-points upper
Point(53) = {-len/3,height,-span/3};
Point(54) = {-len/3,height, span/3};
Point(55) = { len/3,height, span/3};
Point(56) = { len/3,height,-span/3};


/******************** LINES ********************/

// cube lower
Line(1) = {1,2}; Transfinite Curve {1} = Nc;
Line(2) = {2,3}; Transfinite Curve {2} = Nc;
Line(3) = {3,4}; Transfinite Curve {3} = Nc;
Line(4) = {4,1}; Transfinite Curve {4} = Nc;

// cube upper
Line(5) = {5,6}; Transfinite Curve {5} = Nc;
Line(6) = {6,7}; Transfinite Curve {6} = Nc;
Line(7) = {7,8}; Transfinite Curve {7} = Nc;
Line(8) = {8,5}; Transfinite Curve {8} = Nc;

// cube vert                                        ^
Line(9 ) = {1,5}; Transfinite Curve {9 } = Nc; //  /|\
Line(10) = {2,6}; Transfinite Curve {10} = Nc; //   |  
Line(11) = {3,7}; Transfinite Curve {11} = Nc; //   |
Line(12) = {4,8}; Transfinite Curve {12} = Nc; //   |  

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

// outer vert                                                             ^
Line(29) = {9 ,17}; Transfinite Curve {29} = Nc Using Progression 1; //  /|\
Line(30) = {10,18}; Transfinite Curve {30} = Nc Using Progression 1; //   |  
Line(31) = {11,19}; Transfinite Curve {31} = Nc Using Progression 1; //   |
Line(32) = {12,20}; Transfinite Curve {32} = Nc Using Progression 1; //   |  
Line(33) = {13,21}; Transfinite Curve {33} = Nc Using Progression 1;
Line(34) = {14,22}; Transfinite Curve {34} = Nc Using Progression 1;
Line(35) = {15,23}; Transfinite Curve {35} = Nc Using Progression 1;
Line(36) = {16,24}; Transfinite Curve {36} = Nc Using Progression 1;

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

// diag lower
Line(45) = {9 ,11}; Transfinite Curve {45} = Nc Using Progression bfc;
Line(46) = {11,13}; Transfinite Curve {46} = Nc Using Progression bfc;
Line(47) = {13,15}; Transfinite Curve {47} = Nc Using Progression bfc;
Line(48) = {15,9 }; Transfinite Curve {48} = Nc Using Progression bfc;

// diag upper
Line(49) = {17,19}; Transfinite Curve {49} = Nc Using Progression bfc;
Line(50) = {19,21}; Transfinite Curve {50} = Nc Using Progression bfc;
Line(51) = {21,23}; Transfinite Curve {51} = Nc Using Progression bfc;
Line(52) = {23,17}; Transfinite Curve {52} = Nc Using Progression bfc;

// splitting triangles lower
c = 0;
For i In {0:3}
	i1 = 1*i;
	i2 = 2*i;
	i3 = 2*i;
	If(i==3)
		i3 = -2;
	EndIf
	Line(53+c) = {9 +i2,25+i2}; Transfinite Curve {53+c} = Nb;
	Line(54+c) = {25+i2,10+i2}; Transfinite Curve {54+c} = Nb;
	Line(55+c) = {10+i2,26+i2}; Transfinite Curve {55+c} = Nb;
	Line(56+c) = {26+i2,11+i3}; Transfinite Curve {56+c} = Nb;
	Line(57+c) = {11+i3,41+i1}; Transfinite Curve {57+c} = Nb;
	Line(58+c) = {41+i1,9 +i2}; Transfinite Curve {58+c} = Nb;
	Line(59+c) = {49+i1,25+i2}; Transfinite Curve {59+c} = Nb;
	Line(60+c) = {49+i1,26+i2}; Transfinite Curve {60+c} = Nb;
	Line(61+c) = {49+i1,41+i1}; Transfinite Curve {61+c} = Nb;

	c = c + 9;
EndFor

// splitting triangles upper
c = 0;
For i In {0:3}
	i1 = 1*i;
	i2 = 2*i;
	i3 = 2*i;
	If(i==3)
		i3 = -2;
	EndIf
	Line(89+c) = {17+i2,33+i2}; Transfinite Curve {89+c} = Nb;
	Line(90+c) = {33+i2,18+i2}; Transfinite Curve {90+c} = Nb;
	Line(91+c) = {18+i2,34+i2}; Transfinite Curve {91+c} = Nb;
	Line(92+c) = {34+i2,19+i3}; Transfinite Curve {92+c} = Nb;
	Line(93+c) = {19+i3,45+i1}; Transfinite Curve {93+c} = Nb;
	Line(94+c) = {45+i1,17+i2}; Transfinite Curve {94+c} = Nb;
	Line(95+c) = {53+i1,33+i2}; Transfinite Curve {95+c} = Nb;
	Line(96+c) = {53+i1,34+i2}; Transfinite Curve {96+c} = Nb;
	Line(97+c) = {53+i1,45+i1}; Transfinite Curve {97+c} = Nb;

	c = c + 9;
EndFor

// splitting triangles upper
c = 0;
For i In {0:3}
	i1 = 1*i;
	i2 = 2*i;
	i3 = 2*i;
	If(i==3)
		i3 = -2;
	EndIf
																 //   ^
	Line(125+c) = {49+i1,53+i1}; Transfinite Curve {125+c} = Nc; //  /|\
	Line(126+c) = {25+i2,33+i2}; Transfinite Curve {126+c} = Nc; //   | 
	Line(127+c) = {26+i2,34+i2}; Transfinite Curve {127+c} = Nc; //   |
	Line(128+c) = {41+i1,45+i1}; Transfinite Curve {128+c} = Nc; //   | 

	c = c + 4;
EndFor

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

// diag bottom - AC from top
Line Loop(6) = {37,45,-38,-1}; Plane Surface(6) = {6};
Line Loop(7) = {38,46,-39,-2}; Plane Surface(7) = {7};
Line Loop(8) = {39,47,-40,-3}; Plane Surface(8) = {8};
Line Loop(9) = {40,48,-37,-4}; Plane Surface(9) = {9};

Transfinite Surface {6}; Recombine Surface {6};
Transfinite Surface {7}; Recombine Surface {7};
Transfinite Surface {8}; Recombine Surface {8};
Transfinite Surface {9}; Recombine Surface {9};

// diag upper (intra-domain surface) - AC from top
Line Loop(10) = {41,49,-42,-5}; Plane Surface(10) = {10};
Line Loop(11) = {42,50,-43,-6}; Plane Surface(11) = {11};
Line Loop(12) = {43,51,-44,-7}; Plane Surface(12) = {12};
Line Loop(13) = {44,52,-41,-8}; Plane Surface(13) = {13};

Transfinite Surface {10}; Recombine Surface {10};
Transfinite Surface {11}; Recombine Surface {11};
Transfinite Surface {12}; Recombine Surface {12};
Transfinite Surface {13}; Recombine Surface {13};

// diag top - AC from top (CL from bottom)
Line Loop(14) = {49,50,51,52}; Plane Surface(14) = {14};
Transfinite Surface {14}; Recombine Surface {14};

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

// diag box vert  (intra-domain surface) - AC when viewed from inside
Line Loop(19) = {-31,-45,29,49}; Plane Surface(19) = {19};
Line Loop(20) = {-33,-46,31,50}; Plane Surface(20) = {20};
Line Loop(21) = {-35,-47,33,51}; Plane Surface(21) = {21};
Line Loop(22) = {-29,-48,35,52}; Plane Surface(22) = {22};

Transfinite Surface {19}; Recombine Surface {19};
Transfinite Surface {20}; Recombine Surface {20};
Transfinite Surface {21}; Recombine Surface {21};
Transfinite Surface {22}; Recombine Surface {22};

// outer vert - AC from inside
Line Loop(23) = {29,21,-30,-13}; Plane Surface(23) = {23};
Line Loop(24) = {30,22,-31,-14}; Plane Surface(24) = {24};
Line Loop(25) = {31,23,-32,-15}; Plane Surface(25) = {25};
Line Loop(26) = {32,24,-33,-16}; Plane Surface(26) = {26};
Line Loop(27) = {33,25,-34,-17}; Plane Surface(27) = {27};
Line Loop(28) = {34,26,-35,-18}; Plane Surface(29) = {28};
Line Loop(29) = {35,27,-36,-19}; Plane Surface(28) = {29};
Line Loop(30) = {36,28,-29,-20}; Plane Surface(30) = {30};

Transfinite Surface {23}; Recombine Surface {23};
Transfinite Surface {24}; Recombine Surface {24};
Transfinite Surface {25}; Recombine Surface {25};
Transfinite Surface {26}; Recombine Surface {26};
Transfinite Surface {27}; Recombine Surface {27};
Transfinite Surface {29}; Recombine Surface {29};
Transfinite Surface {29}; Recombine Surface {29};
Transfinite Surface {30}; Recombine Surface {30};


// triangles bottom - AC from top
c = 0;
For i In {0:3}
	i9 = i * 9;

	Line Loop(31+c)={59+i9,54+i9,55+i9,-(60+i9)}; Plane Surface(31+c)={31+c};
	Line Loop(32+c)={60+i9,56+i9,57+i9,-(61+i9)}; Plane Surface(32+c)={32+c};
	Line Loop(33+c)={61+i9,58+i9,53+i9,-(59+i9)}; Plane Surface(33+c)={33+c};

	Transfinite Surface {31+c}; Recombine Surface {31+c};
	Transfinite Surface {32+c}; Recombine Surface {32+c};
	Transfinite Surface {33+c}; Recombine Surface {33+c};
	
	c = c + 3;
EndFor

// triangles top - AC from top
c = 0;
For i In {0:3}
	i9 = i*9;

	Line Loop(43+c)={95+i9,90+i9,91+i9,-(96+i9)}; Plane Surface(43+c)={43+c};
	Line Loop(44+c)={96+i9,92+i9,93+i9,-(97+i9)}; Plane Surface(44+c)={44+c};
	Line Loop(45+c)={97+i9,94+i9,89+i9,-(95+i9)}; Plane Surface(45+c)={45+c};

	Transfinite Surface {43+c}; Recombine Surface {43+c};
	Transfinite Surface {44+c}; Recombine Surface {44+c};
	Transfinite Surface {45+c}; Recombine Surface {45+c};
	
	c = c + 3;
EndFor

// triangles vert
// Domain boundary surface - AC from inside
// Intra-domain    surface - AC when viewed from volume in AC direction
//                           (when viewed from top)
c = 0;
For i In {0:3}
	i1 = i * 1;
	i2 = i * 2;
	i4 = i * 4;
	i9 = i * 9;
	ii = i * 2;

	If(i==3)
		ii = -2;
	EndIf

	Line Loop(55+c)={-(53+i9),29 +i2,89+i9,-(126+i4)};Plane Surface(55+c)={55+c};
	Line Loop(56+c)={-(54+i9),126+i4,90+i9,-( 30+i2)};Plane Surface(56+c)={56+c};
	Line Loop(57+c)={-(55+i9), 30+i2,91+i9,-(127+i4)};Plane Surface(57+c)={57+c};
	Line Loop(58+c)={-(56+i9),127+i4,92+i9,-( 31+ii)};Plane Surface(58+c)={58+c};
	Line Loop(59+c)={-(57+i9), 31+ii,93+i9,-(128+i4)};Plane Surface(59+c)={59+c};
	Line Loop(60+c)={-(58+i9),128+i4,94+i9,-( 29+i2)};Plane Surface(60+c)={60+c};

	Line Loop(61+c)={-(59+i9),125+i4,95+i9,-(126+i4)};Plane Surface(61+c)={61+c};
	Line Loop(62+c)={-(60+i9),125+i4,96+i9,-(127+i4)};Plane Surface(62+c)={62+c};
	Line Loop(63+c)={-(61+i9),125+i4,97+i9,-(128+i4)};Plane Surface(63+c)={63+c};

	Transfinite Surface {55+c}; Recombine Surface {55+c};
	Transfinite Surface {56+c}; Recombine Surface {56+c};
	Transfinite Surface {57+c}; Recombine Surface {57+c};
	Transfinite Surface {58+c}; Recombine Surface {58+c};
	Transfinite Surface {59+c}; Recombine Surface {59+c};
	Transfinite Surface {60+c}; Recombine Surface {60+c};
	Transfinite Surface {61+c}; Recombine Surface {61+c};
	Transfinite Surface {62+c}; Recombine Surface {62+c};
	Transfinite Surface {63+c}; Recombine Surface {63+c};
	
	c = c + 9;
EndFor

//Smoother Surface {6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22} = Nsmooth;

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


// outer triangular prisms
c = 0;
For i In {0:3}
	i3 = i * 3;
	i9 = i * 9;

Surface Loop(6+c)={31+i3,61+i9,56+i9,57+i9,-(62+i9),-(43+i3)}; Volume(6+c)={6+c};
Surface Loop(7+c)={32+i3,62+i9,58+i9,59+i9,-(63+i9),-(44+i3)}; Volume(7+c)={7+c};
Surface Loop(8+c)={33+i3,63+i9,60+i9,55+i9,-(61+i9),-(45+i3)}; Volume(8+c)={8+c};

	Transfinite Volume {6+c}; Recombine Volume {6+c};
	Transfinite Volume {7+c}; Recombine Volume {7+c};
	Transfinite Volume {8+c}; Recombine Volume {8+c};
	
	c = c + 3;
EndFor


/******************** BOUNDARY CONDITIONS ********************/
//Physical Surface("interface") = {5,6,7,8,19};
//Physical Surface("wall") = {1,2,3,4,15,9,10,11,16};
//Physical Volume("fluid") = {4, 3, 1, 2, 5};

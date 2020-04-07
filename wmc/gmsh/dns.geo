
/* MESH PARAMS */

// honest dns (d99=2h)
/**/
Ny = 33;
Nz = 44;
Nout = 24;
Nwake = 50;
Nfor = 8;
bfc = 1.05;
Pw = 1.1;
/**/


Nsmooth = 1.0;
// old, keep but doesnt change anything
din = 0.1;
dout = 2.0;



/* DOMAIN SIZE */

// cube size
h = 1.0;
ar_wh = 1.0;
ar_wl = 1.0;
w = ar_wh*h;
l = ar_wl*h;

// dimension size
span = 3.0;
len = 3.0;
wake = 3.5 + 0.5*span;
height = 2.0;
entrance = -(1.0 + 0.5*span);



/* CREATE DOMAIN AND MESH */

// inner box points
Point(1) = {-h/2,0,-h/2,din};
Point(2) = {-h/2,0,h/2,din};
Point(3) = {h/2,0,h/2,din};
Point(4) = {h/2,0,-h/2,din};

Point(5) = {-h/2,h,-h/2,din};
Point(6) = {-h/2,h,h/2,din};
Point(7) = {h/2,h,h/2,din};
Point(8) = {h/2,h,-h/2,din};

// forward outer box points
Point(9) = {-len/2,0,-span/2,dout};
Point(10) = {-len/2,0,span/2,dout};
Point(11) = {len/2,0,span/2,dout};
Point(12) = {len/2,0,-span/2,dout};

Point(13) = {-len/2,height,-span/2,dout};
Point(14) = {-len/2,height,span/2,dout};
Point(15) = {len/2,height,span/2,dout};
Point(16) = {len/2,height,-span/2,dout};


// define inner box lines
Line(1) = {1,2}; Transfinite Curve {1} = Nz Using Progression 1;
Line(2) = {2,3}; Transfinite Curve {2} = Nz Using Progression 1;
Line(3) = {3,4}; Transfinite Curve {3} = Nz Using Progression 1;
Line(4) = {5,6}; Transfinite Curve {4} = Nz Using Progression 1;
Line(5) = {6,7}; Transfinite Curve {5} = Nz Using Progression 1;
Line(6) = {7,8}; Transfinite Curve {6} = Nz Using Progression 1;
Line(7) = {1,5}; Transfinite Curve {7} = Ny Using Progression 1;
Line(8) = {2,6}; Transfinite Curve {8} = Ny Using Progression 1;
Line(9) = {3,7}; Transfinite Curve {9} = Ny Using Progression 1;
Line(10) = {4,8}; Transfinite Curve {10} = Ny Using Progression 1;

// define outer box lines
Line(11) = {9,10}; Transfinite Curve {11} = Nz Using Progression 1;
Line(12) = {10,11}; Transfinite Curve {12} = Nz Using Progression 1;
Line(13) = {11,12}; Transfinite Curve {13} = Nz Using Progression 1;
Line(14) = {13,14}; Transfinite Curve {14} = Nz Using Progression 1;
Line(15) = {14,15}; Transfinite Curve {15} = Nz Using Progression 1;
Line(16) = {15,16}; Transfinite Curve {16} = Nz Using Progression 1;
Line(17) = {9,13}; Transfinite Curve {17} = Ny Using Progression Pw;
Line(18) = {10,14}; Transfinite Curve {18} = Ny Using Progression Pw;
Line(19) = {11,15}; Transfinite Curve {19} = Ny Using Progression Pw;
Line(20) = {12,16}; Transfinite Curve {20} = Ny Using Progression Pw;

// connect inner and outer box
Line(21) = {1,9}; Transfinite Curve {21} = Nout Using Progression bfc;
Line(22) = {2,10}; Transfinite Curve {22} = Nout Using Progression bfc;
Line(23) = {3,11}; Transfinite Curve {23} = Nout Using Progression bfc;
Line(24) = {4,12}; Transfinite Curve {24} = Nout Using Progression bfc;

Line(25) = {5,13}; Transfinite Curve {25} = Nout Using Progression bfc;
Line(26) = {6,14}; Transfinite Curve {26} = Nout Using Progression bfc;
Line(27) = {7,15}; Transfinite Curve {27} = Nout Using Progression bfc;
Line(28) = {8,16}; Transfinite Curve {28} = Nout Using Progression bfc;

Line(29) = {13,16}; Transfinite Curve {29} = Nz Using Progression 1;
Line(30) = {5,8}; Transfinite Curve {30} = Nz Using Progression 1;
Line(31) = {9,12}; Transfinite Curve {31} = Nz Using Progression 1;
Line(32) = {1,4}; Transfinite Curve {32} = Nz Using Progression 1;


//define box surface
Line Loop(1) = {1,8,-4,-7}; Plane Surface(1) = {1};
Line Loop(2) = {2,9,-5,-8}; Plane Surface(2) = {2};
Line Loop(3) = {3,10,-6,-9}; Plane Surface(3) = {3};
Line Loop(4) = {4,5,6,-30}; Plane Surface(4) = {4};

Transfinite Surface {1}; Recombine Surface {1};
Transfinite Surface {2}; Recombine Surface {2};
Transfinite Surface {3}; Recombine Surface {3};
Transfinite Surface {4}; Recombine Surface {4};

//define outer surface: squares
Line Loop(5) = {-11,-18,14,17}; Plane Surface(5) = {5};
Line Loop(6) = {-12,-19,15,18}; Plane Surface(6) = {6};
Line Loop(7) = {-13,-20,16,19}; Plane Surface(7) = {7};
Line Loop(8) = {-14,29,-16,-15}; Plane Surface(8) = {8};

Transfinite Surface {5}; Recombine Surface {5};
Transfinite Surface {6}; Recombine Surface {6};
Transfinite Surface {7}; Recombine Surface {7};
Transfinite Surface {8}; Recombine Surface {8};

//define outer surface: traps
Line Loop(9) = {-1,21,11,-22}; Plane Surface(9) = {9};
Line Loop(10) = {-2,22,12,-23}; Plane Surface(10) = {10};
Line Loop(11) = {-3,23,13,-24}; Plane Surface(11) = {11};
Line Loop(12) = {7,25,-17,-21}; Plane Surface(12) = {12};
Line Loop(13) = {30,28,-29,-25}; Plane Surface(13) = {13};
Line Loop(14) = {-10,24,20,-28}; Plane Surface(14) = {14};

Transfinite Surface {9}; Recombine Surface {9};
Transfinite Surface {10}; Recombine Surface {10};
Transfinite Surface {11}; Recombine Surface {11};
Transfinite Surface {12}; Recombine Surface {12};
Transfinite Surface {13}; Recombine Surface {13};
Transfinite Surface {14}; Recombine Surface {14};

Line Loop(15) = {32,10,-30,-7}; Plane Surface(15) = {15};
Line Loop(16) = {31,-24,-32,21}; Plane Surface(16) = {16};
Line Loop(17) = {-9,23,19,-27}; Plane Surface(17) = {17};
Line Loop(18) = {-8,22,18,-26}; Plane Surface(18) = {18};

Transfinite Surface {15}; Recombine Surface {15};
Transfinite Surface {16}; Recombine Surface {16};
Transfinite Surface {17}; Recombine Surface {17};
Transfinite Surface {18}; Recombine Surface {18};

Line Loop(19) = {31,20,-29,-17}; Plane Surface(19) = {19};
Transfinite Surface {19}; Recombine Surface {19};
Line Loop(20) = {4,26,-14,-25}; Plane Surface(20) = {20};
Transfinite Surface {20}; Recombine Surface {20};
Line Loop(21) = {6,28,-16,-27}; Plane Surface(21) = {21};
Transfinite Surface {21}; Recombine Surface {21};
Line Loop(22) = {5,27,-15,-26}; Plane Surface(22) = {22};
Transfinite Surface {22}; Recombine Surface {22};

Smoother Surface {6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22} = Nsmooth;

// Blocks
Surface Loop(1) = {19, 16, 15, 14, 12, 13}; Volume(1) = {1};
Transfinite Volume {1}; Recombine Volume {1};
Surface Loop(2) = {7, 11, 3, 21, 17, 14}; Volume(2) = {2};
Transfinite Volume {2}; Recombine Volume {2};
Surface Loop(3) = {6, 10, 2, 17, 18, 22}; Volume(3) = {3};
Transfinite Volume {3}; Recombine Volume {3};
Surface Loop(4) = {5, 9, 1, 18, 12, 20}; Volume(4) = {4};
Transfinite Volume {4}; Recombine Volume {4};
Surface Loop(5) = {4, 22, 21, 13, 20, 8}; Volume(5) = {5};
Transfinite Volume {5}; Recombine Volume {5};


// add trailing box
Point(17) = {wake,0,span/2,dout};
Point(18) = {wake,0,-span/2,dout};
Point(19) = {wake,height,span/2,dout};
Point(20) = {wake,height,-span/2,dout};

Line(33) = {11,17}; Transfinite Curve {33} = Nwake Using Progression 1;
Line(34) = {17,18}; Transfinite Curve {34} = Nz Using Progression 1;
Line(35) = {18,12}; Transfinite Curve {35} = Nwake Using Progression 1;

Line(36) = {15,19}; Transfinite Curve {36} = Nwake Using Progression 1;
Line(37) = {19,20}; Transfinite Curve {37} = Nz Using Progression 1;
Line(38) = {20,16}; Transfinite Curve {38} = Nwake Using Progression 1;

Line(39) = {17,19}; Transfinite Curve {39} = Ny Using Progression Pw;
Line(40) = {18,20}; Transfinite Curve {40} = Ny Using Progression Pw;

Line Loop(23) = {-19,33,39,-36}; Plane Surface(23) = {23};
Line Loop(24) = {-39,34,40,-37}; Plane Surface(24) = {24};
Line Loop(25) = {40,38,-20,-35}; Plane Surface(25) = {25};
Line Loop(26) = {-13,33,34,35}; Plane Surface(26) = {26};
Line Loop(27) = {-16,36,37,38}; Plane Surface(27) = {27};

Transfinite Surface {23}; Recombine Surface {23};
Transfinite Surface {24}; Recombine Surface {24};
Transfinite Surface {25}; Recombine Surface {25};
Transfinite Surface {26}; Recombine Surface {26};
Transfinite Surface {27}; Recombine Surface {27};

Surface Loop(6) = {24, 23, 26, 25, 27, 7}; Volume(6) = {6};
Transfinite Volume {6}; Recombine Volume {6};


// add leading box
Point(21) = {entrance,0,span/2,dout};
Point(22) = {entrance,0,-span/2,dout};
Point(23) = {entrance,height,span/2,dout};
Point(24) = {entrance,height,-span/2,dout};

Line(41) = {13,24}; Transfinite Curve {41} = Nfor Using Progression 1;
Line(42) = {24,23}; Transfinite Curve {42} = Nz Using Progression 1;
Line(43) = {23,14}; Transfinite Curve {43} = Nfor Using Progression 1;

Line(44) = {9,22}; Transfinite Curve {44} = Nfor Using Progression 1;
Line(45) = {22,21}; Transfinite Curve {45} = Nz Using Progression 1;
Line(46) = {21,10}; Transfinite Curve {46} = Nfor Using Progression 1;

Line(47) = {22,24}; Transfinite Curve {47} = Ny Using Progression Pw;
Line(48) = {21,23}; Transfinite Curve {48} = Ny Using Progression Pw;

Line Loop(28) = {41,42,43,-14}; Plane Surface(28) = {28};
Line Loop(29) = {44,45,46,-11}; Plane Surface(29) = {29};
Line Loop(30) = {41,-47,-44,17}; Plane Surface(30) = {30};
Line Loop(31) = {-43,-48,46,18}; Plane Surface(31) = {31};
Line Loop(32) = {-47,45,48,-42}; Plane Surface(32) = {32};

Transfinite Surface {28}; Recombine Surface {28};
Transfinite Surface {29}; Recombine Surface {29};
Transfinite Surface {30}; Recombine Surface {30};
Transfinite Surface {31}; Recombine Surface {31};
Transfinite Surface {32}; Recombine Surface {32};

Surface Loop(7) = {28, 29, 30, 31, 32, 5}; Volume(7) = {7};
Transfinite Volume {7}; Recombine Volume {7};



/* BOUNDARY CONDITIONS */
Physical Surface("inlet") = {32};
Physical Surface("outlet") = {24};
Physical Surface("sym") = {8, 27, 28};
Physical Surface("pm") = {19, 25, 30};
Physical Surface("pp") = {6, 23, 31};
Physical Surface("wall") = {26, 10, 9, 2, 3, 11, 16, 4, 1, 15, 29};
Physical Volume("fluid") = {4, 3, 1, 2, 5, 6, 7};

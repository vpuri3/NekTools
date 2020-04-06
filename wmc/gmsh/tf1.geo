
/* MESH PARAMS */

Nc = 25;         // # points on cube side
No = 20;         // # points on line from cube to outer box
Nb = 0.5*(Nc+1); // # points on side of small quads

hc = 0.5;
ho = 1.0;
ho = hc;

lc=1e-2;

/******************** POINTS ********************/

Point(0) = {0  ,0  ,0,lc};
Point(1) = {0.2,0  ,0,lc};
Point(2) = {0  ,0.2,0,lc};
Point(3) = {1  ,0  ,0,lc};
Point(4) = {1  ,1  ,0,lc};
Point(5) = {0  ,1  ,0,lc};

Point(6 ) = {0.2,0  ,hc,lc};
Point(7 ) = {0  ,0.2,hc,lc};
Point(8 ) = {1  ,0  ,ho,lc};
Point(9 ) = {1  ,1  ,ho,lc};
Point(10) = {0  ,1  ,ho,lc};


/******************** LINES ********************/

// bottom
Line(1) = {1,2}; Transfinite Curve {1} = Nc;
Line(2) = {1,3}; Transfinite Curve {2} = No;
Line(3) = {2,5}; Transfinite Curve {3} = No;
Line(4) = {3,4}; Transfinite Curve {4} = Nb;
Line(5) = {4,5}; Transfinite Curve {5} = Nb;

// top
Line(6 ) = {6,7 }; Transfinite Curve {6 } = Nc;
Line(7 ) = {6,8 }; Transfinite Curve {7 } = No;
Line(8 ) = {7,10}; Transfinite Curve {8 } = No;
Line(9 ) = {8,9 }; Transfinite Curve {9 } = Nb;
Line(10) = {9,10}; Transfinite Curve {10} = Nb;

// vert (+ve Z-dir)
Line(11) = {1,1+5}; Transfinite Curve {11} = Nb;
Line(12) = {2,2+5}; Transfinite Curve {12} = Nb;
Line(13) = {3,3+5}; Transfinite Curve {13} = Nb;
Line(14) = {4,4+5}; Transfinite Curve {14} = Nb;
Line(15) = {5,5+5}; Transfinite Curve {15} = Nb;

/******************** SURFACES ********************/

Line Loop(1) = {-1,2,4,5 ,-3}; Plane Surface(1) = {1};
Line Loop(2) = {-6,7,9,10,-8}; Plane Surface(2) = {2};
Line Loop(3) = {1,12,-6 ,-11}; Plane Surface(3) = {3};
Line Loop(4) = {2,13,-7 ,-11}; Plane Surface(4) = {4};
Line Loop(5) = {3,15,-8 ,-12}; Plane Surface(5) = {5};
Line Loop(6) = {4,14,-9 ,-13}; Plane Surface(6) = {6};
Line Loop(7) = {5,15,-10,-14}; Plane Surface(7) = {7};

Transfinite Surface {1} = {1,2,3,5 }; Recombine Surface {1};
Transfinite Surface {2} = {6,7,8,10}; Recombine Surface {2};
Transfinite Surface {3}; Recombine Surface {3};
Transfinite Surface {4}; Recombine Surface {4};
Transfinite Surface {5}; Recombine Surface {5};
Transfinite Surface {6}; Recombine Surface {6};
Transfinite Surface {7}; Recombine Surface {7};

Mesh.Smoothing = 10;

/******************** VOLUMES ********************/

Surface Loop(1) = {1,2,3,4,5,6,7}; Volume(1) = {1};

Transfinite Volume {1}={1,2,3,5,6,7,8,10}; Recombine Volume {1};


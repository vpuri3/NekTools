
/* MESH PARAMS */

Nc = 25;         // # points on cube side
No = 20;         // # points on line from cube to outer box
Nb = 0.5*(Nc+1); // # points on side of small quads

hc = 0.5;
ho = 1.0;
ho = hc;

Nz =10;

lc=1e-2;

/******************** POINTS ********************/

Point(0 ) = {0  ,0  ,0 ,lc};
Point(1 ) = {0.2,0  ,0 ,lc};
Point(2 ) = {0  ,0.2,0 ,lc};
Point(3 ) = {1  ,0  ,0 ,lc};
Point(4 ) = {1  ,1  ,0 ,lc};
Point(5 ) = {0  ,1  ,0 ,lc};

/******************** LINES ********************/

// bottom
Line(1) = {1,2}; Transfinite Curve {1} = Nc;
Line(2) = {1,3}; Transfinite Curve {2} = No;
Line(3) = {2,5}; Transfinite Curve {3} = No;
Line(4) = {3,4}; Transfinite Curve {4} = Nb;
Line(5) = {4,5}; Transfinite Curve {5} = Nb;

/******************** SURFACES ********************/

Line Loop(1) = {-1,2,4,5 ,-3}; Plane Surface(1) = {1};
Transfinite Surface {1} = {1,2,3,5}; Recombine Surface {1};

/* out[0]=volume, out[1]=top surf, out[2...]=lateral surf */

out[] = Extrude {0,0,hc} {
	//Surface{1}; Layers{ {8,2}, {0.5,1} }; Recombine;
	//Surface{1}; Layers{1}; Recombine;
	Surface{1};
};

Transfinite Curve {7 } = Nc;
Transfinite Curve {8 } = No;
Transfinite Curve {9 } = Nb;
Transfinite Curve {10} = Nb;
Transfinite Curve {11} = No;

Transfinite Surface {32} = {6,7,11,19}; Recombine Surface {32};

Transfinite Curve {13,14}    = Nz Using Bump 0.05;
Transfinite Curve {18,22,26} = Nz Using Progression 1.1;

Transfinite Surface {15,19,23,27,31};
Recombine   Surface {15,19,23,27,31};

//Geometry.PointNumbers = 1;
//Geometry.Color.Points = Orange;
//General.Color.Text = Black;
//Mesh.Color.Points = {0,0,0};
//Geometry.Color.Surfaces = Geometry.Color.Points;


r = 0.4;

/* MESH PARAMS */

Nc = 25;         // # points on cube side
No = 20;         // # points on line from cube to outer box
Nd = 5;
Nb = 0.5*(Nc+1); // # points on side of small quads

r2 = r/Sqrt(2);
rr = r2*(1+Tan(Pi/12));

/******************** POINTS ********************/

Point(1 ) = {0  ,0  ,0};
Point(2 ) = {1  ,0  ,0};
Point(3 ) = {0  ,1  ,0};
Point(4 ) = {1  ,1  ,0};
Point(5 ) = {1  ,0.8,0};
Point(6 ) = {0.8,1  ,0};
Point(7 ) = {r2 ,r2 ,0};
Point(8 ) = {0  ,rr ,0};
Point(9 ) = {rr ,0  ,0};
Point(10) = {0.5,0.5,0};


/******************** LINES ********************/

Line(1 ) = {3 ,8 }; Transfinite Curve {1 } = Nd;
Line(2 ) = {8 ,1 }; Transfinite Curve {2 } = Nb;
Line(3 ) = {1 ,9 }; Transfinite Curve {3 } = Nb;
Line(4 ) = {9 ,2 }; Transfinite Curve {4 } = Nd;
Line(5 ) = {2 ,10}; Transfinite Curve {5 } = Nb;
Line(6 ) = {10,3 }; Transfinite Curve {6 } = Nb;
Line(7 ) = {7 ,8 }; Transfinite Curve {7 } = Nb;
Line(8 ) = {7 ,9 }; Transfinite Curve {8 } = Nb;
Line(9 ) = {7 ,10}; Transfinite Curve {9 } = Nd;
Line(10) = {6 ,5 }; Transfinite Curve {10} = Nc;
Line(11) = {6 ,3 }; Transfinite Curve {11} = No;
Line(12) = {5 ,2 }; Transfinite Curve {12} = No;


/******************** SURFACES ********************/

Line Loop(1) = {7,2,3,-8}; Plane Surface(1) = {1};
Line Loop(2) = {8,4,5,-9}; Plane Surface(2) = {2};
Line Loop(3) = {9,6,1,-7}; Plane Surface(3) = {3};

Line Loop(4) = {10,12,5,6,-11}; Plane Surface(4) = {4};

Transfinite Surface {1}; Recombine Surface {1};
Transfinite Surface {2}; Recombine Surface {2};
Transfinite Surface {3}; Recombine Surface {3};
Transfinite Surface {4} = {2,3,6,5}; Recombine Surface {4};


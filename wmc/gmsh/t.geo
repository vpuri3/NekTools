Point(1) = {0, 0, 0};
Point(2) = {1, 0, 0};
Point(3) = {1, 1, 0};
Point(4) = {0, 1, 0};

Line(1) = {1, 2};
Line(2) = {4, 3};
Line(3) = {1, 4};
Line(4) = {2, 3};
Line Loop(5) = {3, 2, -4, -1};
Plane Surface(6) = {5};

Extrude {0, 0, 1} {
	Surface{6};
}

Transfinite Line {1, 2, 3, 4} = 11;

// New lines due to extrusion in the new surface
Transfinite Line {8, 9, 10, 11} = 11;

// New vertical lines due to extrusion
Transfinite Line {13, 14} = 51 Using Bump 0.1;
Transfinite Line {18, 22} = 51 Using Progression 1.1;

Transfinite Surface "*";
Recombine Surface "*";

Transfinite Volume "*";
Recombine Volume "*";

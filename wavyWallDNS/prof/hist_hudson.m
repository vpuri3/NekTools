% history points for smoothWavyWall
%
%-----------------------------------------------------%
% points
nx=10;  % nx=number of x-points
ny=100; % ny=number of y points per x-location
h=0.60; % height to go up to in Y
casename='smoothWavyWall';
%-----------------------------------------------------%
% get x locations from hudson
%
xH = 0:0.1:0.9;
x  = xH + 2;
%-----------------------------------------------------%
% geometry
[x,y]=meshgrid(x,linspace(0,h,ny));
[x,y,xw,yw] = wavyWall(x,y,casename);

x = reshape(x,[nx*ny,1]);
y = reshape(y,[nx*ny,1]);
z = 0*x;

%-----------------------------------------------------%
% create file casename.his
format long
A = [x,y,z];
casename=[casename,'.his'];
fID = fopen(casename,'w');
fprintf(fID, [num2str(nx*ny) ' !=number of monitoring points\n']);
dlmwrite(casename,A,'delimiter',' ','-append');
type(casename)

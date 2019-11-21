% history points for smoothWavyWall
%
%-----------------------------------------------------%
% points
nx=10;  % nx=number of x-points
ny=100; % ny=number of y points per x-location
h=0.60; % height to go up to in Y
casename='smoothWavyWall';
%-----------------------------------------------------%
% get x locations from maass
%
fil = 'maass/dat';
xM  =  zeros(1,nx);
for i=1:nx
	nameM = [fil,num2str(i,'%0.2d')];
	xM(i) = dlmread(nameM,'',[0 3 0  3]);
end
xM(end) = xM(end)-1;

x = xM + 2;
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

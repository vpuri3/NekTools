%
% history points for wavy wall cases
% in X-Y plane going up to Y=0.5
%

%-----------------------------------------------------%
casename='roughWavyWall';
%-----------------------------------------------------%

lx1=8;
xlen=1;
ylen=0.5;
if(strcmp(casename,'smoothWavyWall'))
	nelx=64*0.25;
	nely=16*0.5;
elseif(strcmp(casename,'roughWavyWall'))
	nelx=128*0.25;
	nely=32*0.5;
end

x=sem1dmesh(lx1,nelx,0); % \in [0,1]
y=sem1dmesh(lx1,nely,1);
nx=length(x);
ny=length(y);
x=ones(ny,1)*x'; % vectors of size (ny,nx)
y=y*ones(1,nx);

[x,y,xw,yw] = wavyWall(x,y,casename);

x = reshape(x,[ny*nx,1]);
y = reshape(y,[ny*nx,1]);
z = 0*x;

%-----------------------------------------------------%
% create file casename.his
format long
A = [x,y,z];
casename=[casename,'.his'];
fID = fopen(casename,'w');
fprintf(fID, [num2str(nx*ny) ' !=',num2str(nx),'x',num2str(ny),' monitoring points\n']);
dlmwrite(casename,A,'delimiter',' ','-append');
type(casename)

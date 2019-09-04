% history points for smoothWavyWall parallel to Y dir
%
% unscaled geometry: x \in [0  ,4*lam  ]
%                    y \in [yw ,del+lam]
%                    z \in [0  ,2*lam  ] uniform in z

%lx1=8;
%if(strcmp(casename,'smoothWavyWall'))
%	nelx=64;
%	nely=16;
%elseif(strcmp(casename,'roughWavyWall'))
%	nelx=128;
%	nely=32;
%end
% create mesh
%xmesh=sem1dmesh(lx1,nelx,0); % \in [0,1]
%ymesh=sem1dmesh(lx1,nely,1);
%nxmesh=length(xmesh);
%nymesh=length(ymesh);
%xmesh=ones(nymesh,1)*xmesh';
%ymesh=ymesh*ones(1,nxmesh);

%-----------------------------------------------------%
% points
nx=151; % nx=number of x-points
ny=150; % ny=number of y points per x-location
h=0.40; % height to go up to in Y
casename='roughWavyWall';
%-----------------------------------------------------%
% geometry
[x,y]=meshgrid(0:nx:1,0:ny:h);
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
fprintf(fID, [num2str(nx*ny) ' !=',num2str(nx),'x',num2str(ny),' monitoring points\n']);
dlmwrite(casename,A,'delimiter',' ','-append');
type(casename)

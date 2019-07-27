% history points for smoothWavyWall parallel to Y dir
%
% unscaled geometry: x \in [0  ,4*lam  ]
%                    y \in [yw ,del+lam]
%                    z \in [0  ,2*lam  ] uniform in z
% % yw = del * cos(2*pi*x/lam) % 
% scale by 1/lam in X and Z.
% scale such that Y \in [0,lam+del]

%-----------------------------------------------------%
% points
nx=1; % nx=number of x-points
ny=1000; % ny=number of y points per x-location
h=1.05; % height to go up to in Y
casename='smoothWavyWall';
%-----------------------------------------------------%
% geometry
d =2.54;
l =20*d;
f =5;
d2=0.4*d;
if(strcmp(casename,'smoothWavyWall'))
	d2=0;
end
x0=linspace(2,3,nx); 
x0=x0*l;
z0=zeros(size(x0))*l;
y0=   d *cos(2*pi*x0/l); % bottom wall
y0=y0+d2*cos(2*pi*x0/l*f);
% scale domain
sx=1/l;
sy=(l+d)/(l+2*d+d2);
x0=x0*sx;z0=z0*sx; 
y0=(y0+d+d2)*sy;
y0=y0*sx;
%-----------------------------------------------------% 
% select points
x=zeros(nx*ny,1);
y=x;z=x;
for i=1:nx
	n0=(i-1)*ny;
	x(n0+1:n0+ny)=x0(i);
	y(n0+1:n0+ny)=linspace(y0(i),h*l*sx,ny);
end
%-----------------------------------------------------%
% create file casename.his
format long
A = [x,y,z];
casename=[casename,'.his'];
fID = fopen(casename,'w');
fprintf(fID, [num2str(nx*ny) ' !=',num2str(nx),'x',num2str(ny),' monitoring points\n']);
dlmwrite(casename,A,'delimiter',' ','-append');
type(casename)

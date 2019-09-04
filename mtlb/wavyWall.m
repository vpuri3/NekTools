%
% Apply geometric deformation to vectors
% x,y,z of size (ny,nx) and return
% deformed xd,yd of same size
%
function [xd,yd,xw,yw] = wavyWall(x,y,casename)

xd=x;

d =2.54;
l =20*d;
f =5;

if(strcmp(casename,'smoothWavyWall'))
	d2=0;
elseif(strcmp(casename,'roughWavyWall'))
	d2=0.4*d;
end

% bottom wall
xw=x(1,:);
xw=xw*l;
yw=d*cos(2*pi*xw/l);
ys=yw; % sww just for reference
yw=yw+d2*cos(2*pi*xw/l*f);
H=l+d; %H=l+d+d2; % should be but isn't
sx=1/l;
xw=xw*sx;
sy=H/(H+d+d2);
H =H*sx;
yw=(yw+d+d2)*sy*sx;
ys=(ys+d+d2)*sy*sx; % smooth wall just for reference

yd=(1-yw/H).*y+yw;

%figure;plot(xw,yw);

end

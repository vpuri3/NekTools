function z = sem1dmesh(lx1,e,ifcheby)
%
% creates 1 D sem mesh of poly. order lx1-1
% and e elements.
% z \in [0,1].
%

[z0,w0]=zwgll(lx1-1);
z0= 0.5*(z0+1);

% get element mesh
if(ifcheby)
	dtheta=(0:e')*pi/e;
	ze=(1-cos(dtheta))*0.5;
else
	ze=0:1/e:1'; % size e+1
end

z=ze(1);
for i=1:e
	zelm=ze(i)+z0(2:end)*(ze(i+1)-ze(i));
	z=[z;zelm];
end

%figure;plot(z,z*0,'kx');gird on;

end

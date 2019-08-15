function deltay = deltay(lx1,nely,ylen,ifcheby)

% get dist of first point from wall

% lx1=8;
% nely=16;
% ylen=1;
% ifcheby=1;

if(ifcheby)
	dtheta=pi/nely;
	el1=ylen*(1-cos(dtheta))*0.5;
else
	el1=ylen/nely;
end

[z,w]=zwgll(lx1-1); % z\in[-1,1]
z=0.5*(z+1)*el1;
deltay=z(2);

end

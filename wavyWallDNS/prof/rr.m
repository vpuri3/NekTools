%=============================================================
clear; clf;
format compact; format shorte;

uScale  = 0.08;
uvScale = 2.0;

%=============================================================
% reading SWW velocity
casename='smoothWavyWall';
nx = 10;
ny = 100;

N0=1;
N1=nx*ny;

dir = 'sww-h/';
c0  = [dir,casename,'.his'];
u0  = [dir,'ave.dat'];
tk  = [dir,'var.dat'];
co  = [dir,'cov.dat'];

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr
tk=dlmread(tk,'' ,[N0 1 N1 4]); % <uu>,<vv>,<ww>,<pp>
co=dlmread(co,'' ,[N0 1 N1 4]); % <uv>,<vw>,<wu>,<p>

xS=C (:,1);
yS=C (:,2);
zS=C (:,3);
uS=U1(:,1);
vS=U1(:,2);
wS=U1(:,3);
pS=U1(:,4);

uuS=tk(:,1);
vvS=tk(:,2);
wwS=tk(:,3);
ppS=tk(:,3);
uvS=-co(:,1);
vwS=co(:,2);
wuS=co(:,3);

xS=reshape(xS,[ny,nx]);
yS=reshape(yS,[ny,nx]);
zS=reshape(zS,[ny,nx]);
uS=reshape(uS,[ny,nx]);
vS=reshape(vS,[ny,nx]);
wS=reshape(wS,[ny,nx]);
pS=reshape(pS,[ny,nx]);

uuS=reshape(uuS,[ny,nx]);
vvS=reshape(vvS,[ny,nx]);
wwS=reshape(wwS,[ny,nx]);
ppS=reshape(ppS,[ny,nx]);
uvS=reshape(uvS,[ny,nx]);
vwS=reshape(vwS,[ny,nx]);
wuS=reshape(wuS,[ny,nx]);

xS  = xS - 2;

 xuS = xS +  uScale* uS;
xuuS = xS + uvScale*uuS;
xvvS = xS + uvScale*vvS;
xwwS = xS + uvScale*wwS;
xppS = xS + uvScale*ppS;
xuvS = xS + uvScale*uvS;
xvwS = xS + uvScale*vwS;
xwuS = xS + uvScale*wuS;

%=============================================================
% reading SWW pressure

casename = 'smoothWavyWall';
nx = 200;
ny = 200;

N0=1;
N1=nx*ny;

dir = '../sww/';
u0  = [dir,'ave.dat'];
c0  = [dir,casename,'.his'];

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr

xSp=C (:,1);
pSp=U1(:,4);

xSp=reshape(xSp,[ny,nx]);
pSp=reshape(pSp,[ny,nx]);

xSp = xSp - 2;

%=============================================================
% reading RWW pressure

casename = 'roughWavyWall';
nx = 200;
ny = 200;

N0=1;
N1=nx*ny;

dir = '../rww/';
u0  = [dir,'ave.dat'];
c0  = [dir,casename,'.his'];

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr

xRp=C (:,1);
pRp=U1(:,4);

xRp=reshape(xRp,[ny,nx]);
pRp=reshape(pRp,[ny,nx]);

xRp = xRp - 2;

%=============================================================
% reading RWW velocity
casename='roughWavyWall';
nx = 10;
ny = 100;

N0=1;
N1=nx*ny;

dir = 'rww/';
c0  = [dir,casename,'.his'];
u0  = [dir,'ave.dat'];
tk  = [dir,'var.dat'];
co  = [dir,'cov.dat'];

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr
tk=dlmread(tk,'' ,[N0 1 N1 4]); % <uu>,<vv>,<ww>,<pp>
co=dlmread(co,'' ,[N0 1 N1 4]); % <uv>,<vw>,<wu>,<p>

xR=C (:,1);
yR=C (:,2);
zR=C (:,3);
uR=U1(:,1);
vR=U1(:,2);
wR=U1(:,3);
pR=U1(:,4);

uuR=tk(:,1);
vvR=tk(:,2);
wwR=tk(:,3);
ppR=tk(:,3);
uvR=-co(:,1);
vwR=co(:,2);
wuR=co(:,3);

xR=reshape(xR,[ny,nx]);
yR=reshape(yR,[ny,nx]);
zR=reshape(zR,[ny,nx]);
uR=reshape(uR,[ny,nx]);
vR=reshape(vR,[ny,nx]);
wR=reshape(wR,[ny,nx]);
pR=reshape(pR,[ny,nx]);

uuR=reshape(uuR,[ny,nx]);
vvR=reshape(vvR,[ny,nx]);
wwR=reshape(wwR,[ny,nx]);
ppR=reshape(ppR,[ny,nx]);
uvR=reshape(uvR,[ny,nx]);
vwR=reshape(vwR,[ny,nx]);
wuR=reshape(wuR,[ny,nx]);

xR  = xR - 2;

 xuR = xR +  uScale* uR;
xuuR = xR + uvScale*uuR;
xvvR = xR + uvScale*vvR;
xwwR = xR + uvScale*wwR;
xppR = xR + uvScale*ppR;
xuvR = xR + uvScale*uvR;
xvwR = xR + uvScale*vwR;
xwuR = xR + uvScale*wuR;

%=============================================================
% bottom wall

x = linspace(0,1,100);
y = 0*x;

[x,y,xsw,ysw] = wavyWall(x,y,'smoothWavyWall');
[x,y,xrw,yrw] = wavyWall(x,y,'roughWavyWall');

%=============================================================
if(1) % u
%------------------------------
clf;
fig=gcf;ax=gca; hold on;grid on;
% title
title(['Wavy Wall Streamwise Velocity Profiles'],'fontsize',14);
% ax
xlim([0 1]);
ylim([0 0.5]);
ax.XScale='linear';
ax.YScale='linear';
xlabel('$$x/\lambda$$');
ylabel('$$y/H$$');

daspect([1,1,1]);
set(fig,'position',[585,1e3,1000,500])

% legend
lgd=legend('location','southeast');lgd.FontSize=14;

% bottom wall
p=plot(xsw,ysw,'k-.','linewidth',1.5);
p.HandleVisibility='off';

p=plot(xrw,yrw,'k--','linewidth',1.5);
p.HandleVisibility='off';

% RWW
for i=1:10
	p=plot(xuR(:,i),yR(:,i),'k-','linewidth',2.0);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='RWW';

% SWW
for i=1:10
	p=plot(xuS(:,i),yS(:,i),'r-','linewidth',2.0);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='SWW';

%------------------------------
figname=['rww','-','u_profile'];
saveas(fig,figname,'jpeg');
%------------------------------
end
%=============================================================
pause
%=============================================================
if(1) % surface pressure
%------------------------------
clf;
fig=gcf;ax=gca;
hold on;grid on;
% title
title(['Wavy Wall Surface Pressures'],'fontsize',14)
% pos
set(fig,'position',[585,1e3,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([0,1]);
xlabel('$$x/\lambda$$');
ylabel('$$\frac{p-p_\mathrm{ref}}{\rho U^2}$$');
%lgd
lgd=legend('location','northwest');lgd.FontSize=14;

plot(xRp(1,:),pRp(1,:)-min(pRp(1,:)),'k-','linewidth',1.50,'displayname','RWW');
plot(xSp(1,:),pSp(1,:)-min(pSp(1,:)),'r-','linewidth',1.50,'displayname','SWW');

% bottom wall
plot(xrw,0.5*(yrw-max(yrw)),'k--','linewidth',1.50,'HandleVisibility','off');
plot(xsw,0.5*(ysw-max(ysw)),'k-.','linewidth',1.50,'HandleVisibility','off');
%------------------------------
figname=['rww','-','surf_pres'];
saveas(fig,figname,'jpeg');
end
%=============================================================
pause
%=============================================================
if(1) % reynolds stresses
%------------------------------
clf;
fig=gcf;ax=gca; hold on;grid on;
% title
title(['Wavy Wall Reynolds Stresses $$-\eta_{12}$$'],'fontsize',14);
% ax
xlim([-0.01 1]);
ylim([0 0.5]);
ax.XScale='linear';
ax.YScale='linear';
xlabel('$$x/\lambda$$');
ylabel('$$y/H$$');

%daspect([1,1,1]);
set(fig,'position',[585,1e3,1000,500])

% legend
lgd=legend('location','southeast');lgd.FontSize=14;

% bottom wall
p=plot(xsw,ysw,'k-.','linewidth',1.5);
p.HandleVisibility='off';

p=plot(xrw,yrw,'k--','linewidth',1.5);
p.HandleVisibility='off';

% RWW
for i=1:10
	p=plot(xuvR(:,i),yR(:,i),'k-','linewidth',2.0);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='RWW';

% SWW
for i=1:10
	p=plot(xuvS(:,i),yS(:,i),'r-','linewidth',2.0);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='SWW';

%------------------------------
figname=['rww','-','eta_12'];
saveas(fig,figname,'jpeg');
%------------------------------
end
%=============================================================


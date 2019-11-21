%=============================================================
clear; clf;
format compact; format shorte;

uScale  = 0.08;
uvScale = 2.0;

%=============================================================
% reading hudson

N0 = 4;   	  % first row
L  = 49;  	  % number of points in y
N1 = N0+L-1;  % last row

fil = 'hudson/xlam';

xH = 0:0.1:0.9;
xH = reshape(xH,[1,10]);

yH = zeros(L,10);
uH = zeros(L,10);

for i=1:10
	nameH = [fil,num2str(i-1,'%0.2d')];
	datH  = dlmread(nameH,'',[N0 0 N1 1]); % z u
	%
	yH(:,i) = datH(:,1);
	uH(:,i) = datH(:,2);
end

yH = yH / 5.08;
uH = uH / 8.64;

uH = uH/sqrt(2);

xH = ones(L,1) * xH;
casename='smoothWavyWall';
[xH,yH,xw,yw] = wavyWall(xH,yH,casename);

xuH = xH + uScale*uH;
%=============================================================
% reading maass

N0 = 3;      % first row
L  = 96;     % number of entries
N1 = N0+L-1; % last row
n0 = 101;
n1 = n0+L-1;

fil = 'maass/dat';

xM =  zeros(1,10);

yM = zeros(96,10);
uM = zeros(96,10);
vM = zeros(96,10);
wM = zeros(96,10);
pM = zeros(96,10);

uuM = zeros(96,10);
wwM = zeros(96,10);
vvM = zeros(96,10);
uvM = zeros(96,10);
ppM = zeros(96,10);

for i=1:10
	nameM = [fil,num2str(i,'%0.2d')];
	xM(i) = dlmread(nameM,'',[0  3 0  3]);
	d0M   = dlmread(nameM,'',[N0 1 N1 5]); % z u v w p
	d1M   = dlmread(nameM,'',[n0 1 n1 6]); % z u v w p
	%
	yM(:,i) = d0M(:,1);
	uM(:,i) = d0M(:,2);
	vM(:,i) = d0M(:,3);
	wM(:,i) = d0M(:,4);
	pM(:,i) = d0M(:,5);
	%
	uuM(:,i) = d1M(:,2);
	wwM(:,i) = d1M(:,3);
	vvM(:,i) = d1M(:,4);
	uvM(:,i) = d1M(:,5); % -<u'v'>
	ppM(:,i) = d1M(:,6);

end

yM = yM + 0.05;

xM(10) = xM(10)-1;

xuM  = xM + uScale*uM;

xuuM = xM + uvScale*uuM;
xvvM = xM + uvScale*vvM;
xwwM = xM + uvScale*wwM;
xppM = xM + uvScale*ppM;
xuvM = xM + uvScale*uvM;

%=============================================================
% reading Nek (velocity plots)
casename='smoothWavyWall';
nx = 10;
ny = 100;

N0=1;
N1=nx*ny;

dir = 'sww-m/';
c0  = [dir,casename,'.his'];
u0  = [dir,'ave.dat'];
tk  = [dir,'var.dat'];
co  = [dir,'cov.dat'];

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr
tk=dlmread(tk,'' ,[N0 1 N1 4]); % <uu>,<vv>,<ww>,<pp>
co=dlmread(co,'' ,[N0 1 N1 4]); % <uv>,<vw>,<wu>,<p>

xN=C (:,1);
yN=C (:,2);
zN=C (:,3);
uN=U1(:,1);
vN=U1(:,2);
wN=U1(:,3);
pN=U1(:,4);

uuN=tk(:,1);
vvN=tk(:,2);
wwN=tk(:,3);
ppN=tk(:,3);
uvN=-co(:,1);
vwN=co(:,2);
wuN=co(:,3);

xN=reshape(xN,[ny,nx]);
yN=reshape(yN,[ny,nx]);
zN=reshape(zN,[ny,nx]);
uN=reshape(uN,[ny,nx]);
vN=reshape(vN,[ny,nx]);
wN=reshape(wN,[ny,nx]);
pN=reshape(pN,[ny,nx]);

uuN=reshape(uuN,[ny,nx]);
vvN=reshape(vvN,[ny,nx]);
wwN=reshape(wwN,[ny,nx]);
ppN=reshape(ppN,[ny,nx]);
uvN=reshape(uvN,[ny,nx]);
vwN=reshape(vwN,[ny,nx]);
wuN=reshape(wuN,[ny,nx]);

xN  = xN - 2;

xuN  = xN +  uScale*uN;
xuuN = xN + uvScale*uuN;
xvvN = xN + uvScale*vvN;
xwwN = xN + uvScale*wwN;
xppN = xN + uvScale*ppN;
xuvN = xN + uvScale*uvN;
xvwN = xN + uvScale*vwN;
xwuN = xN + uvScale*wuN;

%=============================================================
% reading Nek (pressure plot)

nx = 200;
ny = 200;

N0=1;
N1=nx*ny;

dir = '../sww/';
u0  = [dir,'ave.dat'];
c0  = [dir,casename,'.his'];

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr

xNp=C (:,1);
pNp=U1(:,4);

xNp=reshape(xNp,[ny,nx]);
pNp=reshape(pNp,[ny,nx]);

xNp = xNp - 2;

%=============================================================
% bottom wall
casename='smoothWavyWall';

x = linspace(0,1,100);
y = 0*x;

[x,y,xw,yw] = wavyWall(x,y,casename);

%=============================================================
if(1) % u
%------------------------------
clf;
fig=gcf;ax=gca; hold on;grid on;
% title
title(['Smooth Wavy Wall Streamwise Velocity Profile'],'fontsize',14);
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
p=plot(xw,yw,'k--','linewidth',1.5);
p.HandleVisibility='off';

% Nek
for i=1:10
	p=plot(xuN(:,i),yN(:,i),'k-','linewidth',1.5);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='SWW';

% hudson
%for i=1:10
%	p=plot(xuH(:,i),yH(:,i),'k+','linewidth',1.5);
%	p.MarkerIndices=1:2:size(yH,1);
%	p.HandleVisibility='off';
%end
%p.HandleVisibility='on';
%p.DisplayName='Hudson 1993';

% maass
for i=1:10
	p=plot(xuM(:,i),yM(:,i),'ro','linewidth',1.5);
	p.MarkerIndices=1:2:size(yM,1);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='Maass 1994';

%------------------------------
figname=['sww','-','u_profile'];
saveas(fig,figname,'jpeg');
%------------------------------
end
%=============================================================
if(1) % surface pressure
%------------------------------
xM(1,end)=xM(1,end)+1;
%------------------------------
clf;
fig=gcf;ax=gca;
hold on;grid on;
% title
title(['Smooth Wavy Wall Surface Pressure'],'fontsize',14)
% pos
set(fig,'position',[585,1e3,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([0,1]);
xlabel('$$x/\lambda$$');
ylabel('$$\frac{p-p_\mathrm{ref}}{\rho U^2}$$');
%lgd
lgd=legend('location','northwest');lgd.FontSize=14;

plot(xNp(1,:),pNp(1,:)-min(pNp(1,:)),'k-','linewidth',1.50,'displayname','SWW');
plot(xw,0.5*(yw-max(yw)),'k--'  ,'linewidth',1.50,'HandleVisibility','off');
plot(xM(1,:),pM(1,:)-min(pM(1,:)),'ro','linewidth',1.5,'displayname','Maass 1994');

%------------------------------
figname=['sww','-','surf_pres'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % reynolds stresses
%------------------------------
clf;
fig=gcf;ax=gca; hold on;grid on;
% title
title(['Smooth Wavy Wall Reynolds Stress $$-\eta_{12}$$'],'fontsize',14);
% ax
xlim([-0.02 1]);
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
p=plot(xw,yw,'k--','linewidth',1.5);
p.HandleVisibility='off';

ls = ["o","+",".","x","s","d","^","v",">","<"]; % linespec

% Nek
for i=1:10
	%p=plot(xuuN(:,i),yN(:,i),['k',char(ls(i))],'linewidth',1.5);
	p=plot(xuvN(:,i),yN(:,i),'k-','linewidth',1.5);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='SWW';

% maass
for i=1:10
	%p=plot(xuuM(:,i),yM(:,i),['r',char(ls(i))],'linewidth',1.5);
	p=plot(xuvM(:,i),yM(:,i),'ro','linewidth',1.5);
	p.MarkerIndices=1:2:size(yM,1);
	p.HandleVisibility='off';
end
p.HandleVisibility='on';
p.DisplayName='Maass 1994';

%------------------------------
figname=['sww','-','eta_12'];
saveas(fig,figname,'jpeg');
%------------------------------
end
%=============================================================


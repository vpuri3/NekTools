function vf(nx,ny,casename,visc)

% nx --> number of x-points
% ny --> number of y-points per x-point
%
% example: vf(200,200,'smoothWavyWall',1/4780) 
%          vf(200,200,'roughWavyWall',1/4780) 
%

%=============================================================
% reading data
%=============================================================
c0=[casename,'.his'];
N0=1;
N1=nx*ny;

% parsing logfile
logfile=textread('logfile','%s','delimiter','\n');
% avgtime
at=find(~cellfun(@isempty,strfind(logfile,'atime:')));
at=logfile(at(end));
at=cell2mat(at);
at=str2num(at(7:end));
% Tmavg - shear force magnitude
Tmavg=find(~cellfun(@isempty,strfind(logfile,'Tmavg:')));
Tmavg=logfile(Tmavg(end));
Tmavg=cell2mat(Tmavg);
Tmavg=str2num(Tmavg(7:end));
% area
area=find(~cellfun(@isempty,strfind(logfile,'area:')));
area=logfile(area(end));
area=cell2mat(area);
area=str2num(area(6:end));
% % Ufavg - average friction velocity
%ufavg=find(~cellfun(@isempty,strfind(logfile,'Ufavg:')));
%ufavg=logfile(ufavg(end));
%ufavg=cell2mat(ufavg);
%ufavg=str2num(ufavg(7:end));

dsty=1;
ufavg=sqrt(Tmavg/dsty);

['Tmavg=',num2str(Tmavg)];
['area=' ,num2str(area) ];
['ufavg=',num2str(ufavg)];

u0='ave.dat';
u1='upl.dat';

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr
U2=dlmread(u1,'' ,[N0 1 N1 3]); % uplus,yplus

at=dlmread(u1,'' ,[1 0 1 0]);
x=C (:,1);
y=C (:,2);
z=C (:,3);
u=U1(:,1);
v=U1(:,2);
w=U1(:,3);
p=U1(:,4);

up=U2(:,1);
yp=U2(:,2);
Tm=U2(:,3);

uf=sqrt(Tm/1.0); % friction velocity
%delta=0.5;      % half height
%Re_tau = ufriction*delta/visc;

tk=dlmread('var.dat','',[N0 1 N1 3]); % < u' * u' >
cn=dlmread('cn1.dat','',[N0 1 N1 3]); % convective term
pr=dlmread('pr1.dat','',[N0 1 N1 3]); % production
pt=dlmread('pt1.dat','',[N0 1 N1 3]); % pressure transport
pd=dlmread('pd1.dat','',[N0 1 N1 3]); % pressure diffusion
ps=dlmread('ps1.dat','',[N0 1 N1 3]); % pressure strain
td=dlmread('td1.dat','',[N0 1 N1 3]); % turbulent diffusion
ep=dlmread('ep1.dat','',[N0 1 N1 3]); % dissipation
vd=dlmread('vd1.dat','',[N0 1 N1 3]); % viscous diffusion

% imbalance in reynolds stresse1s
im= - cn + pr + pt + td + ep + vd;

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

% cnK == 0.5 * sum(cn')';
cnK=dlmread(t1,'',[N0 1 N1 1]);
prK=dlmread(t1,'',[N0 2 N1 2]);
ptK=dlmread(t1,'',[N0 3 N1 3]);
pdK=dlmread(t1,'',[N0 4 N1 4]);
psK=dlmread(t2,'',[N0 1 N1 1]);
tdK=dlmread(t2,'',[N0 2 N1 2]);
epK=dlmread(t2,'',[N0 3 N1 3]);
vdK=dlmread(t2,'',[N0 4 N1 4]);
tkK=dlmread(t3,'',[N0 1 N1 1]);
imK=dlmread(t3,'',[N0 2 N1 2]);
div=dlmread(t3,'',[N0 3 N1 3]);
%=============================================================
% reshape
%=============================================================
%--------------------
budgets = [cnK;prK;ptK;tdK;vdK;epK];
budgetsmin = min(budgets);
budgetsmax = max(budgets);
cb=0;
%--------------------
x=reshape(x,[ny,nx]);
y=reshape(y,[ny,nx]);
z=reshape(z,[ny,nx]);
u=reshape(u,[ny,nx]);
v=reshape(v,[ny,nx]);
w=reshape(w,[ny,nx]);
p=reshape(p,[ny,nx]);

uvar=reshape(tk(:,1),[ny,nx]);
vvar=reshape(tk(:,2),[ny,nx]);
wvar=reshape(tk(:,3),[ny,nx]);

up=reshape(up,[ny,nx]);
yp=reshape(yp,[ny,nx]);
Tm=reshape(Tm,[ny,nx]);
uf=reshape(uf,[ny,nx]);

cn=reshape(cn,[ny,nx,3]);
pr=reshape(pr,[ny,nx,3]);
pt=reshape(pt,[ny,nx,3]);
pd=reshape(pd,[ny,nx,3]);
ps=reshape(ps,[ny,nx,3]);
td=reshape(td,[ny,nx,3]);
ep=reshape(ep,[ny,nx,3]);
vd=reshape(vd,[ny,nx,3]);
tk=reshape(tk,[ny,nx,3]);
im=reshape(im,[ny,nx,3]);

cnK=reshape(cnK,[ny,nx]);
prK=reshape(prK,[ny,nx]);
ptK=reshape(ptK,[ny,nx]);
pdK=reshape(pdK,[ny,nx]);
psK=reshape(psK,[ny,nx]);
tdK=reshape(tdK,[ny,nx]);
epK=reshape(epK,[ny,nx]);
vdK=reshape(vdK,[ny,nx]);
tkK=reshape(tkK,[ny,nx]);
imK=reshape(imK,[ny,nx]);
div=reshape(div,[ny,nx]);

%=============================================================
% geometry
%=============================================================
x=x-floor(min(min(x))); % x \in [0,1]

xlen=4;
lx1=8;
if(strcmp(casename,'smoothWavyWall'))
	nelx=64;
	nely=16;
elseif(strcmp(casename,'roughWavyWall'))
	nelx=128;
	nely=32;
end

% create mesh
xmesh=sem1dmesh(lx1,nelx,0)*xlen; % \in [0,1]
ymesh=sem1dmesh(lx1,nely,1);
nxmesh=length(xmesh);
nymesh=length(ymesh);
xmesh=ones(nymesh,1)*xmesh';
ymesh=ymesh*ones(1,nxmesh);

[xmesh,ymesh,xw,yw] = wavyWall(xmesh,ymesh,casename);

%=============================================================
% plotting
if(strcmp(casename,'smoothWavyWall'))
	cname='sww';
	casename ='Smooth Wavy Wall';
elseif(strcmp(casename,'roughWavyWall'))
	cname='rww';
	casename ='Rough Wavy Wall';
end

%=============================================================
if(0) % mesh
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' Mesh'],'fontsize',14);
% pos
daspect([1,1,1]);
set(fig,'position',[585,1e3,1000,250])
% ax
ax.FontSize=14;
xlabel('$$x$$');
ylabel('$$y$$');
xlim([min(min(xmesh)),max(max(xmesh))]);
ylim([min(min(ymesh)),max(max(ymesh))]);

mesh(xmesh,ymesh,0*xmesh)
% color
colormap([0,0,0])
%------------------------------
figname=[cname,'-','mesh'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % quiver plot
%------------------------------
Ix=1:10:nx;
Iy=1:10:ny;
xq=x(Iy,Ix);
yq=y(Iy,Ix);
uq=u(Iy,Ix);
vq=v(Iy,Ix);

% reference quiver
sy=length(Iy);
sx=length(Ix);
xq=[xq,nan*ones(sy,1)];xq(end,end)=xq(end,2);
yq=[yq,nan*ones(sy,1)];yq(end,end)=y (end,1)+5e-3;
uq=[uq,nan*ones(sy,1)];uq(end,end)=1.0;
vq=[vq,nan*ones(sy,1)];vq(end,end)=0.0;
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on; % title
title([casename,' Mean Flow Field'],'fontsize',14)
% pos
daspect([1,1,1]);
set(fig,'position',[585,1e3,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))+0.02]);
xlabel('$$x/\lambda$$');
ylabel('$$y$$');
% lgd
%lgd=legend('location','southeast');lgd.FontSize=14;

quiver(xq,yq,uq,vq,'k','linewidth',1,'displayname','Velocity')
text(xq(end,end),yq(end,end),'U','verticalalignment','bottom','fontsize',14);
plot(xw,yw,'k--','linewidth',1.50,'displayname','Bottom Wall');
%------------------------------
figname=[cname,'-','vel'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % streamlines
%------------------------------
Ix=1:10:nx;
Iy=1:10:ny;
xq=x(Iy,Ix);
yq=y(Iy,Ix);
uq=u(Iy,Ix);
vq=v(Iy,Ix);

% reference quiver
sy=length(Iy);
sx=length(Ix);
xq=[xq,nan*ones(sy,1)];xq(end,end)=xq(end,2);
yq=[yq,nan*ones(sy,1)];yq(end,end)=y (end,1)+5e-3;
uq=[uq,nan*ones(sy,1)];uq(end,end)=1.0;
vq=[vq,nan*ones(sy,1)];vq(end,end)=0.0;

strtx = x(Iy,1);
strty = y(Iy,1);
%------------------------------

figure;
fig=gcf;ax=gca;
hold on;grid on;
title([casename,' '],'fontsize',14)
% pos
daspect([1,1,1]);
set(fig,'position',[585,1e3,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))+0.02]);
xlabel('$$x/\lambda$$');
ylabel('$$y$$');

% wall
plot(xw,yw,'k','linewidth',1.50,'displayname','Bottom Wall');
% quiver
quiver(xq,yq,uq,vq,'k','displayname','Velocity')
text(xq(end,end),yq(end,end),'U','verticalalignment','bottom','fontsize',14);
% streamline
streamline(x,y,u,v,strtx,strty,[1e-1,1e4]);
plot(strtx,strty,'kx','linewidth',0.5)
%------------------------------
figname=[cname,'-','streamline'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % surface stresses
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' Surface Stress Profiles '],'fontsize',14)
% pos
set(fig,'position',[585,1e3,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([0,1]);
xlabel('$$x/\lambda$$');
ylabel('$$\frac{p-p_\mathrm{ref}}{\rho U^2}$$');
%lgd
lgd=legend('location','northwest');lgd.FontSize=14;

plot(x(1,:),p(1,:)-min(p(1,:)),'r-','linewidth',1.50,'displayname','Surface Pressure');
plot(x(1,:),Tm(1,:),'b-','linewidth',1.50,'displayname','Shear Stress');
plot(xw,yw-max(yw),'k--'  ,'linewidth',1.50,'displayname','Bottom Wall');
%------------------------------
figname=[cname,'-','stress'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % attachment/reattachment point
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' Velocity off the all '],'fontsize',14)
% pos
%daspect([1,2,1]);
set(fig,'position',[585,1e3,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([0,1]);
xlabel('$$x/\lambda$$');
ylabel('$$ u $$');
%lgd
lgd=legend('location','northwest');lgd.FontSize=14;

plot(x(2,:),u(2,:),'b-','linewidth',1.50,'displayname','$$u$$ right off the wall');
plot(xw,yw-max(yw),'k--'  ,'linewidth',1.50,'displayname','Bottom Wall');
%------------------------------
figname=[cname,'-','separation'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % RS, TK Budgets
%-------------------------------------------------------------
bplt(x,y,tkK,tk(:,:,1),tk(:,:,2),tk(:,:,3),Tmavg,visc,cname,'Reynolds Stresses','rs');
bplt(x,y,cnK,cn(:,:,1),cn(:,:,2),cn(:,:,3),Tmavg,visc,cname,'Convection','cn');
bplt(x,y,prK,pr(:,:,1),pr(:,:,2),pr(:,:,3),Tmavg,visc,cname,'Production','pr');
bplt(x,y,ptK,pt(:,:,1),pt(:,:,2),pt(:,:,3),Tmavg,visc,cname,'Pressure Transport','pt');
bplt(x,y,tdK,td(:,:,1),td(:,:,2),td(:,:,3),Tmavg,visc,cname,'Turbulent Diffusion','td');
bplt(x,y,vdK,vd(:,:,1),vd(:,:,2),vd(:,:,3),Tmavg,visc,cname,'Viscous Diffusion','vd');
bplt(x,y,epK,ep(:,:,1),ep(:,:,2),ep(:,:,3),Tmavg,visc,cname,'Dissipation','ep');
bplt(x,y,imK,im(:,:,1),im(:,:,2),im(:,:,3),Tmavg,visc,cname,'Imbalance','im');
%-------------------------------------------------------------
end
%=============================================================
if(0) % scalar fields
%-------------------------------------------------------------
cplt(x,y,xw,yw,uvar,1,cname,'Streamwise Velocity Variance','uvar','$$U^2$$');
%=============================================================
end
%-------------------------------------------------------------
if(0) % line plots
%------------------------------
ixx    =[1            ceil(0.5*nx)               ceil(0.7*nx)];
ixxmesh=[(1+(0)*lx1) (1+(0.25*nelx*0.5)*(lx1-1)) 0           ];

% scale
s = 1/Tmavg; % RS
s = 1/(Tmavg*Tmavg/visc);

for i=1:length(ixx)
	ix    =ixx(i);
	ixmesh=ixxmesh(i);

	strx = num2str(x(1,ix));
	ymw  = y(:,ix) - y(1,ix);

	figure;
	fig=gcf;ax=gca;
	hold on;grid on;
	% title
	title([casename,' TKE Budgets at $$x/\lambda$$=',strx],'fontsize',14);
	% ax
	ax.FontSize=14;
	xlabel('$$\bar{y}/H$$');
	ylabel('$$\frac{\dot{\eta_{ij}}}{u_\tau^4/\nu}$$');
	%lgd
	lgd=legend('location','southeast');lgd.FontSize=12;
	
	plot(ymw,cnK(:,ix)*s,'-','linewidth' ,1.50,'DisplayName',['Convection'])
	plot(ymw,prK(:,ix)*s,'-','linewidth' ,1.50,'DisplayName',['Production'])
	plot(ymw,ptK(:,ix)*s,'-','linewidth' ,1.50,'DisplayName',['Pres Transp'])
	plot(ymw,tdK(:,ix)*s,'-','linewidth' ,1.50,'DisplayName',['Turbulent Diff'])
	plot(ymw,vdK(:,ix)*s,'-','linewidth' ,1.50,'DisplayName',['Viscous Diff'])
	plot(ymw,epK(:,ix)*s,'-','linewidth' ,1.50,'DisplayName',['Dissipation'])
	plot(ymw,imK(:,ix)*s,'k-','linewidth',1.50,'DisplayName',['Imbalance'])
	% mesh
	%plot(ymesh(:,ixmesh),0*ymesh(:,ixmesh),'kx','linewidth',1.00,'DisplayName',['Mesh'])
	%------------------------------
	figname=[cname,'-','tke-budgets-x=',strx];
	saveas(fig,figname,'jpeg');
end
end
%=============================================================
end
%=============================================================

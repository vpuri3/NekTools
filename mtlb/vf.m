function vf(nx,ny,casename,miscstr,visc)

% nx --> number of x-points
% ny --> number of y-points per x-point
%
% example: vf(200,200,'smoothWavyWall','',1/4780) 
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

visc;dsty=1;
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
% offsettign x
x=x-floor(min(min(x))); % x \in [0,1]

% case specifics
d=2.54;
l=20*d;
f=5;
if(strcmp(casename,'smoothWavyWall'))
	lx1=8;
	nelx=64;
	nely=16;

	d2=0;
elseif(strcmp(casename,'roughWavyWall'))
	lx1=8;
	nelx=128;
	nely=32;

	d2=0.4*d;
end
xlen=4;

% mesh
xmesh=sem1dmesh(lx1,nelx,0)*xlen; % \in [0,1]
ymesh=sem1dmesh(lx1,nely,1);
nxmesh=length(xmesh);
nymesh=length(ymesh);
xmesh=ones(nymesh,1)*xmesh';
ymesh=ymesh*ones(1,nxmesh);

% bottom wall
xw=xmesh(1,:);
xw=xw*l;
yw=   d *cos(2*pi*xw/l);
ys=yw; % sww just for reference
yw=yw+d2*cos(2*pi*xw/l*f);
H =l+d;
%H=l+d+d2; % should be but isn't
sx=1/l;
xw=xw*sx;
sy=H/(H+d+d2);
H =H*sx;
yw=(yw+d+d2)*sy*sx;
ys=(ys+d+d2)*sy*sx; % smooth wall just for reference

% zeta
ze=(y-y(1,:))./(H-y(1,:)); % == ze/H

% deform mesh
ymesh=(1-yw/H).*ymesh+yw;
zemesh=(ymesh-ymesh(1,:))./(H-ymesh(1,:)); % == ze/H

%=============================================================
% plotting
cname='rww';
if(strcmp(casename,'smoothWavyWall'))
	cname='sww';
end
%=============================================================
c = char(39);
if(nx>1) % plot vector fields
%=============================================================
if(1) % mesh
%[xmesh,ymesh] = meshgrid(0:0.05:1);
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' Mesh'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,250])
% ax
xlabel('x');
ylabel('y');
xlim([min(min(xmesh)),max(max(xmesh))]);
ylim([min(min(ymesh)),max(max(ymesh))]);

mesh(xmesh,ymesh,0*xmesh)
%mesh(xmesh,zemesh,0*xmesh)
% color
colormap([0,0,0])
%------------------------------
figname=[cname,'-','mesh'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % quiver plot
%
Ix=1:10:nx;
Iy=1:10:ny;
xx=x(Iy,Ix);
yy=y(Iy,Ix);
uu=u(Iy,Ix);
vv=v(Iy,Ix);

% reference quiver
sy=length(Iy);
sx=length(Ix);
xx=[xx,xx(:,2)];
yy=[yy,y(end,1)*ones(sx,1)+5e-3];
uu=[uu,nan*ones(sx,1)];uu(end,end)=1.0;
vv=[vv,nan*ones(sx,1)];vv(end,end)=0.0;
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on; % title
title([casename,' ','atime:',num2str(at),'s'],'fontsize',14)
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1e3,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))+0.02]);
xlabel('x/\lambda_1');
ylabel('y');
% lgd
lgd=legend('location','southeast');lgd.FontSize=14;

quiver(xx,yy,uu,vv,'k','displayname','Velocity')
text(xx(end,end),yy(end,end),'U','verticalalignment','bottom','fontsize',14);
plot(xw,yw,'k'  ,'linewidth',1.00,'displayname','Bottom Wall');
%plot(xw,yw,'k--','linewidth',1.00,'displayname','Smooth Wall');
%------------------------------
figname=[cname,'-','vel'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % quiver plot zoomed in
%------------------------------
I=find(y>0.20);
xx=x;yy=y;uu=u;vv=v;
xx(I)=0;yy(I)=0;uu(I)=0;vv(I)=0;
Ix=1:10:nx;
Iy=1:10:ny;
xx=xx(Iy,Ix);
yy=yy(Iy,Ix);
uu=uu(Iy,Ix);
vv=vv(Iy,Ix);

% reference quiver
%sy=length(Iy);
%sx=length(Ix);
%xx=[xx,xx(:,2)];
%yy=[yy,y(end,1)*ones(sx,1)+5e-3];
%uu=[uu,nan*ones(sx,1)];uu(end,end)=1.0;
%vv=[vv,nan*ones(sx,1)];vv(end,end)=0.0;
%
figure;
fig=gcf;ax=gca;
hold on;grid on; % title
title([casename,' ','atime:',num2str(at),'s'],'fontsize',14)
% pos
daspect([2,1,1]);set(fig,'position',[0,0,1e3,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([min(min(xx)),max(max(xx))]);
ylim([min(min(yy)),max(max(yy))-0.02]);
xlabel('x/\lambda_1');
ylabel('y');
% lgd
lgd=legend('location','southeast');lgd.FontSize=14;

quiver(xx,yy,uu,vv,'k','displayname','Velocity')
text(xx(end,end),yy(end,end),'U','verticalalignment','bottom','fontsize',14);
plot(x0,y0,'k'  ,'linewidth',1.00,'displayname','Bottom Wall');
%plot(x0,ys,'k--','linewidth',1.00,'displayname','Smooth Wall');
%------------------------------
figname=[cname,'-','vel-zoom'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' Surface Stress Profiles ','atime:',num2str(at),'s'],'fontsize',14)
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlabel('x/\lambda_1');
ylabel('(p-p_{ref})/\rhoU^2, \tau/\rhoU^2');
%lgd
lgd=legend('location','northwest');lgd.FontSize=14;

plot(x(1,:),p(1,:)-min(p(1,:)),'r-','linewidth',2.00,'displayname','Surface Pressure');
plot(x(1,:),Tm(1,:),'b-','linewidth',2.00,'displayname','Shear Stress');
plot(x0,y0-2*(d+d2)/l,'k--'  ,'linewidth',1.00,'displayname','Bottom Wall');
%------------------------------
figname=[cname,'-','stress'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE ','atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,tkK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Convection',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,cnK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-cn'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Production',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,prK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-pr'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Turbulent Diffusion',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,tdK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-td'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Pressure Transport',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,ptK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-pt'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Viscous Diffusion',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,vdK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-vd'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Viscous Dissipation',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,epK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-ep'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % imbalance
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Imbalance',' atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,imK);
% color
shading interp;colormap jet;
hcb=colorbar;title(hcb,['\eta_{ij}/U^2'],'fontsize',14);
if(cb) caxis([budgetsmin,budgetsmax]);end;
%------------------------------
figname=[cname,'-','tke-im'];
saveas(fig,figname,'jpeg');
end



%=============================================================
end % end plotting vector fields
%=============================================================



% line plots
%=============================================================
if(0) % crest
%------------------------------
ix=floor(0.0*nx)+1;
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Budgets at x/\lambda=',num2str(x(1,ix)),' atime:',num2str(at),'s'],'fontsize',14);
% pos
%daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('\zeta/H');
ylabel('\eta_{ij}/U^2');
%lgd
lgd=legend('location','southeast');lgd.FontSize=14;

plot(ze(:,ix),tkK(:,ix),'-','linewidth',2.00,'DisplayName',['TKE'])
plot(ze(:,ix),cnK(:,ix),'-','linewidth',2.00,'DisplayName',['Convection'])
plot(ze(:,ix),prK(:,ix),'-','linewidth',2.00,'DisplayName',['Production'])
plot(ze(:,ix),ptK(:,ix),'-','linewidth',2.00,'DisplayName',['Pres Transp'])
plot(ze(:,ix),tdK(:,ix),'-','linewidth',2.00,'DisplayName',['Turbulent Diff'])
plot(ze(:,ix),vdK(:,ix),'-','linewidth',2.00,'DisplayName',['Viscous Diff'])
plot(ze(:,ix),epK(:,ix),'-','linewidth',2.00,'DisplayName',['Dissipation'])
plot(ze(:,ix),imK(:,ix),'k-','linewidth',1.00,'DisplayName',['Imbalance'])
%------------------------------
figname=[cname,'-','tke-budgets-crest'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % trough
%------------------------------
ix=floor(0.5*nx)+1;
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Budgets at x/\lambda=',num2str(x(1,ix)),' atime:',num2str(at),'s'],'fontsize',14);
% pos
%daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('\zeta/H');
ylabel('\eta_{ij}/U^2');
%lgd
lgd=legend('location','southeast');lgd.FontSize=14;

plot(ze(:,ix),tkK(:,ix),'-','linewidth',2.00,'DisplayName',['TKE'])
plot(ze(:,ix),cnK(:,ix),'-','linewidth',2.00,'DisplayName',['Convection'])
plot(ze(:,ix),prK(:,ix),'-','linewidth',2.00,'DisplayName',['Production'])
plot(ze(:,ix),ptK(:,ix),'-','linewidth',2.00,'DisplayName',['Pres Transp'])
plot(ze(:,ix),tdK(:,ix),'-','linewidth',2.00,'DisplayName',['Turbulent Diff'])
plot(ze(:,ix),vdK(:,ix),'-','linewidth',2.00,'DisplayName',['Viscous Diff'])
plot(ze(:,ix),epK(:,ix),'-','linewidth',2.00,'DisplayName',['Dissipation'])
plot(ze(:,ix),imK(:,ix),'k-','linewidth',1.00,'DisplayName',['Imbalance'])
%------------------------------
figname=[cname,'-','tke-budgets-trough'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % reattachment point
%------------------------------
ix=floor(0.7*nx)+1;
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Budgets at x/\lambda=',num2str(x(1,ix)),' atime:',num2str(at),'s'],'fontsize',14);
% pos
%daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('\zeta/H');
ylabel('\eta_{ij}/U^2');
%lgd
lgd=legend('location','southeast');lgd.FontSize=14;

plot(ze(:,ix),tkK(:,ix),'-','linewidth',2.00,'DisplayName',['TKE'])
plot(ze(:,ix),cnK(:,ix),'-','linewidth',2.00,'DisplayName',['Convection'])
plot(ze(:,ix),prK(:,ix),'-','linewidth',2.00,'DisplayName',['Production'])
plot(ze(:,ix),ptK(:,ix),'-','linewidth',2.00,'DisplayName',['Pres Transp'])
plot(ze(:,ix),tdK(:,ix),'-','linewidth',2.00,'DisplayName',['Turbulent Diff'])
plot(ze(:,ix),vdK(:,ix),'-','linewidth',2.00,'DisplayName',['Viscous Diff'])
plot(ze(:,ix),epK(:,ix),'-','linewidth',2.00,'DisplayName',['Dissipation'])
plot(ze(:,ix),imK(:,ix),'k-','linewidth',1.00,'DisplayName',['Imbalance'])
%------------------------------
figname=[cname,'-','tke-budgets-reattach'];
saveas(fig,figname,'jpeg');
end
%=============================================================
end

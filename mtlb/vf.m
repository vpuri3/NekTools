function vf(nx,ny,casename,miscstr,visc)
% nx --> number of x-points
% N1 --> number of y-points per x-point
%
% example: vf(100,100,'smoothWavyWall','',1/4780) 
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
% Tmavg - shear magnitude
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
x=reshape(x,[nx,ny]);
y=reshape(y,[nx,ny]);
z=reshape(z,[nx,ny]);
u=reshape(u,[nx,ny]);
v=reshape(v,[nx,ny]);
w=reshape(w,[nx,ny]);
p=reshape(p,[nx,ny]);

up=reshape(up,[nx,ny]);
yp=reshape(yp,[nx,ny]);
Tm=reshape(Tm,[nx,ny]);

uf=reshape(uf,[nx,ny]);

cn=reshape(cn,[nx,ny,3]);
pr=reshape(pr,[nx,ny,3]);
pt=reshape(pt,[nx,ny,3]);
pd=reshape(pd,[nx,ny,3]);
ps=reshape(ps,[nx,ny,3]);
td=reshape(td,[nx,ny,3]);
ep=reshape(ep,[nx,ny,3]);
vd=reshape(vd,[nx,ny,3]);
tk=reshape(tk,[nx,ny,3]);
im=reshape(im,[nx,ny,3]);

cnK=reshape(cnK,[nx,ny]);
prK=reshape(prK,[nx,ny]);
ptK=reshape(ptK,[nx,ny]);
pdK=reshape(pdK,[nx,ny]);
psK=reshape(psK,[nx,ny]);
tdK=reshape(tdK,[nx,ny]);
epK=reshape(epK,[nx,ny]);
vdK=reshape(vdK,[nx,ny]);
tkK=reshape(tkK,[nx,ny]);
imK=reshape(imK,[nx,ny]);
div=reshape(div,[nx,ny]);
%=============================================================
% geometry
%=============================================================
% offsettign x
x = x - floor(min(x'))';
% bottom wall
x0 = linspace(min(min(x)),max(max(x)),1e3);
d =2.54;
l =20*d;
f =5;
d2=0.4*d;
if(strcmp(casename,'smoothWavyWall'))
	d2=0;
end
x0=x0*l;
y0=   d *cos(2*pi*x0/l); % bottom wall
ys=y0;
y0=y0+d2*cos(2*pi*x0/l*f);
sx=1/l;
x0=x0*sx;
sy=(l+d)/(l+2*d+d2);
%sy=(l+d+d2)/(l+d+d2); % should be but isn't
y0=(y0+d+d2)*sy*sx;
ys=(ys+d+d2)*sy*sx;
%=============================================================
% plotting
%=============================================================
c = char(39);
if(nx>1) % plot vector fields
%=============================================================
if(1)
%------------------------------
Ix=1:5:nx;
Iy=1:5:ny;
xx=x(Ix,Iy);
yy=y(Ix,Iy);
uu=u(Ix,Iy);
vv=v(Ix,Iy);

% reference quiver
sx=length(Ix);
sy=length(Iy);
xx=[xx,xx(:,2)];
yy=[yy,y(end,1)*ones(sx,1)+0.01];
uu=[uu,nan*ones(sx,1)];uu(end,end)=1.0;
vv=[vv,nan*ones(sx,1)];vv(end,end)=0.0;

figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' ','atime:',num2str(at),'s'],'fontsize',14)
% pos
daspect([2,1,1]);set(fig,'position',[0,0,1000,500])
% ax
ax.XScale='linear';ax.YScale='linear';ax.FontSize=14;
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))+0.02]);
xlabel('x/\lambda_1');
ylabel('y');
% lgd
lgd=legend('location','southeast');lgd.FontSize=12;

quiver(xx,yy,uu,vv,'k','displayname','Velocity')
text(xx(end,end),yy(end,end),'U','verticalalignment','bottom','fontsize',12);
plot(x0,y0,'k'  ,'linewidth',1.00,'displayname','Bottom Wall');
%plot(x0,ys,'k--','linewidth',1.00,'displayname','Smooth Wall');
%------------------------------
end
%=============================================================
if(1)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE ','atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([2,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,tkK/ufavg);
% color
shading interp;colormap gray;
hcb=colorbar;title(hcb,['<v',c,'_iv',c,'_j>'],'fontsize',12);
%------------------------------
end
%=============================================================
if(1)
%------------------------------
figure;
fig=gcf;ax=gca;
hold on;grid on;
% title
title([casename,' TKE Production','atime:',num2str(at),'s'],'fontsize',14);
% pos
daspect([2,1,1]);set(fig,'position',[0,0,1000,500])
% ax
xlabel('x/\lambda_1');
ylabel('y');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

pcolor(x,y,prK/ufavg);
% color
shading interp;colormap gray;
hcb=colorbar;title(hcb,['<v',c,'_iv',c,'_j>'],'fontsize',12);
%------------------------------
end
%=============================================================
end % end plotting vector fields
%=============================================================




%=============================================================
% line plots
if(nx == 1)
y0=y0(1);
eta=(y-y0)/(1.05-y0);
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
lgd=legend('location','southeast');lgd.FontSize=10;
hold on; grid on; axis square;

title([casename,' Reynolds Stresses ','atime:',num2str(at),'s'],'fontsize',14);
xlabel(['<u',c,'u',c,'>/U_m^2']);
ylabel('\eta/H');
ylim([0,1]);
plot(tk(:,:,1)/ufavg,eta,'linewidth',2.00,'DisplayName',['<u',c,'u',c,'>'])
plot(tk(:,:,2)/ufavg,eta,'linewidth',2.00,'DisplayName',['<v',c,'v',c,'>'])
plot(tk(:,:,3)/ufavg,eta,'linewidth',2.00,'DisplayName',['<w',c,'w',c,'>'])
plot(tkK      /ufavg,eta,'linewidth',2.00,'DisplayName',['TKE=0.5<u_j',c,'u_j',c,'>'])
%------------------------------
end
%=============================================================
end

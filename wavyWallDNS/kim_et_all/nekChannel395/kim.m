%=============================================================
% raeding nek

casename='channel';
N0=1;
N1=129;
nunek=1/13650;

c0=[casename,'.his'];

u0='ave.dat';
u1='upl.dat';

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr
U2=dlmread(u1,'' ,[N0 1 N1 3]); % uplus,yplus

at=dlmread(u1,'' ,[1 0 1 0]);
xnek=C (:,1);
ynek=C (:,2);
znek=C (:,3);
unek=U1(:,1);
vnek=U1(:,2);
wnek=U1(:,3);
pnek=U1(:,4);

upnek=U2(:,1);
ypnek=U2(:,2);
Tmnek=U2(:,3);

Tmnek=Tmnek(1);                 % shear magnitude
utaunek=sqrt(Tmnek/1.0);        % friction velocity
delnek=0.5;                     % half height
Re_taunek=utaunek*delnek/nunek;

tknek=dlmread('var.dat','',[N0 1 N1 3]); % < u' * u' >
cnnek=dlmread('cn1.dat','',[N0 1 N1 3]); % convective term
prnek=dlmread('pr1.dat','',[N0 1 N1 3]); % production
ptnek=dlmread('pt1.dat','',[N0 1 N1 3]); % pressure transport
pdnek=dlmread('pd1.dat','',[N0 1 N1 3]); % pressure diffusion
psnek=dlmread('ps1.dat','',[N0 1 N1 3]); % pressure strain
tdnek=dlmread('td1.dat','',[N0 1 N1 3]); % turbulent diffusion
epnek=dlmread('ep1.dat','',[N0 1 N1 3]); % dissipation
vdnek=dlmread('vd1.dat','',[N0 1 N1 3]); % viscous diffusion

% imbalance in reynolds stresse1s
%im= - cn + pr + pt + td + ep + vd;

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

% cnK == 0.5 * sum(cn')';
cnKnek=dlmread(t1,'',[N0 1 N1 1]);
prKnek=dlmread(t1,'',[N0 2 N1 2]);
ptKnek=dlmread(t1,'',[N0 3 N1 3]);
pdKnek=dlmread(t1,'',[N0 4 N1 4]);
psKnek=dlmread(t2,'',[N0 1 N1 1]);
tdKnek=dlmread(t2,'',[N0 2 N1 2]);
epKnek=dlmread(t2,'',[N0 3 N1 3]);
vdKnek=dlmread(t2,'',[N0 4 N1 4]);
tkKnek=dlmread(t3,'',[N0 1 N1 1]);
imKnek=dlmread(t3,'',[N0 2 N1 2]);
divnek=dlmread(t3,'',[N0 3 N1 3]);

% computing \Delta y^+_{min}
deltayplusminnek=0.000616119283407*utaunek/nunek;
format long
['Delta y plus min ', num2str(deltayplusminnek)]

%=============================================================
% reading kim

kbal=dlmread('chan395.kbal','',[25 0 153 8]); % Normalization: U_tau, nu/U_tau 
 ykim=kbal(:,1);
ypkim=kbal(:,2);
epkim=kbal(:,3);
prkim=kbal(:,4);
pskim=kbal(:,5);
pdkim=kbal(:,6);
tdkim=kbal(:,7);
vdkim=kbal(:,8);
imkim=kbal(:,9);
%
umean=dlmread('chan395.means','',[25 0 153 6]); % Normalization: U_tau, h 
upkim=umean(:,3);
utaukim=1/trapz(ykim,upkim);
ukim=upkim*utaukim;
ukim=ukim*utaukim;

Re_taukim=392.25;
delkim=1;
Tmkim=utaukim^2;
nukim=utaukim/(ypkim(end)/ykim(end));

rstr=dlmread('chan395.reystress','',[25 0 153 7]); % Normalization: U_tau, h 
tkkim=0.5*sum(rstr(:,3:5)')';
%
%=============================================================
% plotting
cname='channel';
n=length(ykim);
I=1:5:n;
ttl = ['Channel Flow, $$Re_\tau=$$',num2str(Re_taunek)];
%=============================================================
if(1) % vel
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$y^+$$');
ylabel('$$u^+$$');

% nek
plot(ypnek,upnek,'k-' ,'linewidth',2.00,'displayname','$$u^+$$');
% kim
plot(ypkim(I),upkim(I),'kx','linewidth',2.00,'displayname','kim $$u^+$$');
%------------------------------
figname=[cname,'-','vel'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % budgets
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$y^+$$');
ylabel('$$\frac{\eta_{ij}}{u_\tau^4/\nu}$$');
scale= 1 / (utaunek^4/nunek);
% nek
%plot(ypnek,cnKnek/utaunek,'m-','linewidth',2.00,'displayname','convection TKE');
plot(ypnek,prKnek*scale,'r-','linewidth',2.00,'displayname','production TKE');
plot(ypnek,pdKnek*scale,'g-','linewidth',2.00,'displayname','pres diff TKE');
plot(ypnek,tdKnek*scale,'c-','linewidth',2.00,'displayname','turb diff TKE');
plot(ypnek,vdKnek*scale,'k-','linewidth',2.00,'displayname','visc diff TKE');
plot(ypnek,epKnek*scale,'b-','linewidth',2.00,'displayname','dissipation TKE');
% kim
plot(ypkim(I),prkim(I),'rx','linewidth',2.00,'displayname','kim production TKE');
plot(ypkim(I),pdkim(I),'gx','linewidth',2.00,'displayname','kim pres diff TKE');
plot(ypkim(I),tdkim(I),'cx','linewidth',2.00,'displayname','kim turb diff TKE');
plot(ypkim(I),vdkim(I),'kx','linewidth',2.00,'displayname','kim visc diff TKE');
plot(ypkim(I),epkim(I),'bx','linewidth',2.00,'displayname','kim dissipation TKE');
%------------------------------
figname=[cname,'-','tke-budgets'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % rs
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$y^+               $$');
ylabel('$$\eta_{ij}/u_\tau^2$$');

% nek
plot(ypnek,tkKnek     /Tmnek,'k-' ,'linewidth',2.00,'displayname',['TKE          ']);
plot(ypnek, tknek(:,1)/Tmnek,'r-' ,'linewidth',2.00,'displayname',['$$\eta_{11}$$']);
plot(ypnek, tknek(:,2)/Tmnek,'g-' ,'linewidth',2.00,'displayname',['$$\eta_{22}$$']);
plot(ypnek, tknek(:,3)/Tmnek,'b-' ,'linewidth',2.00,'displayname',['$$\eta_{33}$$']);
% kim
plot(ypkim(I),tkkim(I)  ,'kx','linewidth',2.00,'displayname','kim TKE          ');
plot(ypkim(I),rstr (I,3),'rx','linewidth',2.00,'displayname','kim $$\eta_{11}$$');
plot(ypkim(I),rstr (I,4),'gx','linewidth',2.00,'displayname','kim $$\eta_{22}$$');
plot(ypkim(I),rstr (I,5),'bx','linewidth',2.00,'displayname','kim $$\eta_{33}$$');
%------------------------------
figname=[cname,'-','rs'];
saveas(fig,figname,'jpeg');
end
%=============================================================

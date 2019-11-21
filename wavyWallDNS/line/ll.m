%=============================================================
N0=1;
N1=129;
%=============================================================
% reading channel

dir = 'channel/';
casename='channel';
nuchan=1/13650;
c0=[casename,'.his'];

u0='ave.dat';
u1='upl.dat';

C =dlmread([dir,c0],' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread([dir,u0],'' ,[N0 1 N1 4]); % vx,vy,vz,pr
U2=dlmread([dir,u1],'' ,[N0 1 N1 3]); % uplus,yplus

xchan=C (:,1);
ychan=C (:,2);
zchan=C (:,3);
uchan=U1(:,1);
vchan=U1(:,2);
wchan=U1(:,3);
pchan=U1(:,4);

upchan=U2(:,1);
ypchan=U2(:,2);
Tmchan=U2(:,3);

Tmchan=Tmchan(1);                 % shear magnitude
utauchan=sqrt(Tmchan/1.0);        % friction velocity
delchan=0.5;                      % half height
Re_tauchan=utauchan*delchan/nuchan;

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

tkchan=dlmread([dir,'var.dat'],'',[N0 1 N1 3]); % < u' * u' >
cnchan=dlmread([dir,'cn1.dat'],'',[N0 1 N1 3]); % convective term
prchan=dlmread([dir,'pr1.dat'],'',[N0 1 N1 3]); % production
ptchan=dlmread([dir,'pt1.dat'],'',[N0 1 N1 3]); % pressure transport
pdchan=dlmread([dir,'pd1.dat'],'',[N0 1 N1 3]); % pressure diffusion
pschan=dlmread([dir,'ps1.dat'],'',[N0 1 N1 3]); % pressure strain
tdchan=dlmread([dir,'td1.dat'],'',[N0 1 N1 3]); % turbulent diffusion
epchan=dlmread([dir,'ep1.dat'],'',[N0 1 N1 3]); % dissipation
vdchan=dlmread([dir,'vd1.dat'],'',[N0 1 N1 3]); % viscous diffusion

cnKchan=dlmread([dir,t1],'',[N0 1 N1 1]);
prKchan=dlmread([dir,t1],'',[N0 2 N1 2]);
ptKchan=dlmread([dir,t1],'',[N0 3 N1 3]);
pdKchan=dlmread([dir,t1],'',[N0 4 N1 4]);
psKchan=dlmread([dir,t2],'',[N0 1 N1 1]);
tdKchan=dlmread([dir,t2],'',[N0 2 N1 2]);
epKchan=dlmread([dir,t2],'',[N0 3 N1 3]);
vdKchan=dlmread([dir,t2],'',[N0 4 N1 4]);
tkKchan=dlmread([dir,t3],'',[N0 1 N1 1]);
imKchan=dlmread([dir,t3],'',[N0 2 N1 2]);
divchan=dlmread([dir,t3],'',[N0 3 N1 3]);

imchan = -cnchan + prchan + ptchan + tdchan + epchan + vdchan;

%=============================================================
% reading sww

dir = 'sww-line/';
casename='smoothWavyWall';
nusww=1/4780;
c0=[casename,'.his'];

u0='ave.dat';
u1='upl.dat';

C =dlmread([dir,c0],' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread([dir,u0],'' ,[N0 1 N1 4]); % vx,vy,vz,pr
U2=dlmread([dir,u1],'' ,[N0 1 N1 3]); % uplus,yplus

xsww=C (:,1);
ysww=C (:,2);
zsww=C (:,3);
usww=U1(:,1);
vsww=U1(:,2);
wsww=U1(:,3);
psww=U1(:,4);

upsww=U2(:,1);
ypsww=U2(:,2);
Tmsww=U2(:,3);

Tmsww=Tmsww(1);                 % shear magnitude
utausww=sqrt(Tmsww/1.0);        % friction velocity
delsww=0.5;                      % half height
Re_tausww=utausww*delsww/nusww;

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

tksww=dlmread([dir,'var.dat'],'',[N0 1 N1 3]); % < u' * u' >
cnsww=dlmread([dir,'cn1.dat'],'',[N0 1 N1 3]); % convective term
prsww=dlmread([dir,'pr1.dat'],'',[N0 1 N1 3]); % production
ptsww=dlmread([dir,'pt1.dat'],'',[N0 1 N1 3]); % pressure transport
pdsww=dlmread([dir,'pd1.dat'],'',[N0 1 N1 3]); % pressure diffusion
pssww=dlmread([dir,'ps1.dat'],'',[N0 1 N1 3]); % pressure strain
tdsww=dlmread([dir,'td1.dat'],'',[N0 1 N1 3]); % turbulent diffusion
epsww=dlmread([dir,'ep1.dat'],'',[N0 1 N1 3]); % dissipation
vdsww=dlmread([dir,'vd1.dat'],'',[N0 1 N1 3]); % viscous diffusion

cnKsww=dlmread([dir,t1],'',[N0 1 N1 1]);
prKsww=dlmread([dir,t1],'',[N0 2 N1 2]);
ptKsww=dlmread([dir,t1],'',[N0 3 N1 3]);
pdKsww=dlmread([dir,t1],'',[N0 4 N1 4]);
psKsww=dlmread([dir,t2],'',[N0 1 N1 1]);
tdKsww=dlmread([dir,t2],'',[N0 2 N1 2]);
epKsww=dlmread([dir,t2],'',[N0 3 N1 3]);
vdKsww=dlmread([dir,t2],'',[N0 4 N1 4]);
tkKsww=dlmread([dir,t3],'',[N0 1 N1 1]);
imKsww=dlmread([dir,t3],'',[N0 2 N1 2]);
divsww=dlmread([dir,t3],'',[N0 3 N1 3]);

imsww = -cnsww + prsww + ptsww + tdsww + epsww + vdsww;

%=============================================================
% reading rww

dir = 'rww-line/';
casename='roughWavyWall';
nurww=1/4780;
c0=[casename,'.his'];

u0='ave.dat';
u1='upl.dat';

C =dlmread([dir,c0],' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread([dir,u0],'' ,[N0 1 N1 4]); % vx,vy,vz,pr
U2=dlmread([dir,u1],'' ,[N0 1 N1 3]); % uplus,yplus

xrww=C (:,1);
yrww=C (:,2);
zrww=C (:,3);
urww=U1(:,1);
vrww=U1(:,2);
wrww=U1(:,3);
prww=U1(:,4);

uprww=U2(:,1);
yprww=U2(:,2);
Tmrww=U2(:,3);

Tmrww=Tmrww(1);                 % shear magnitude
utaurww=sqrt(Tmrww/1.0);        % friction velocity
delrww=0.5;                      % half height
Re_taurww=utaurww*delrww/nurww;

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

tkrww=dlmread([dir,'var.dat'],'',[N0 1 N1 3]); % < u' * u' >
cnrww=dlmread([dir,'cn1.dat'],'',[N0 1 N1 3]); % convective term
prrww=dlmread([dir,'pr1.dat'],'',[N0 1 N1 3]); % production
ptrww=dlmread([dir,'pt1.dat'],'',[N0 1 N1 3]); % pressure transport
pdrww=dlmread([dir,'pd1.dat'],'',[N0 1 N1 3]); % pressure diffusion
psrww=dlmread([dir,'ps1.dat'],'',[N0 1 N1 3]); % pressure strain
tdrww=dlmread([dir,'td1.dat'],'',[N0 1 N1 3]); % turbulent diffusion
eprww=dlmread([dir,'ep1.dat'],'',[N0 1 N1 3]); % dissipation
vdrww=dlmread([dir,'vd1.dat'],'',[N0 1 N1 3]); % viscous diffusion

cnKrww=dlmread([dir,t1],'',[N0 1 N1 1]);
prKrww=dlmread([dir,t1],'',[N0 2 N1 2]);
ptKrww=dlmread([dir,t1],'',[N0 3 N1 3]);
pdKrww=dlmread([dir,t1],'',[N0 4 N1 4]);
psKrww=dlmread([dir,t2],'',[N0 1 N1 1]);
tdKrww=dlmread([dir,t2],'',[N0 2 N1 2]);
epKrww=dlmread([dir,t2],'',[N0 3 N1 3]);
vdKrww=dlmread([dir,t2],'',[N0 4 N1 4]);
tkKrww=dlmread([dir,t3],'',[N0 1 N1 1]);
imKrww=dlmread([dir,t3],'',[N0 2 N1 2]);
divrww=dlmread([dir,t3],'',[N0 3 N1 3]);

imrww = -cnrww + prrww + ptrww + tdrww + eprww + vdrww;

%=============================================================
% reading kim

dir = 'channel/';
kbal=dlmread([dir,'chan395.kbal'],'',[25 0 153 8]); % Normalization: U_tau, nu/U_tau 
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
umean=dlmread([dir,'chan395.means'],'',[25 0 153 6]); % Normalization: U_tau, h 
upkim=umean(:,3);
utaukim=1/trapz(ykim,upkim);
ukim=upkim*utaukim;
ukim=ukim*utaukim;

Re_taukim=392.25;
delkim=1;
Tmkim=utaukim^2;
nukim=utaukim/(ypkim(end)/ykim(end));

rstr=dlmread([dir,'chan395.reystress'],'',[25 0 153 7]); % Normalization: U_tau, h 
tkkim=0.5*sum(rstr(:,3:5)')';
%
%=============================================================
% plotting
cname='line';
n=length(ykim);
I=1:5:n;
tkim  = ['Kim  $$\mathrm{Re}_\tau=$$',num2str(Re_taukim)];
tchan = ['Channel $$\mathrm{Re}_\tau=$$',num2str(Re_tauchan)];
tsww  = ['Smooth Wavy Wall $$\mathrm{Re}_\tau=$$',num2str(Re_tausww)];
trww  = ['Rough Wavy Wall $$\mathrm{Re}_\tau=$$',num2str(Re_taurww)];

sswwrs = 1 / utausww^2;
srwwrs = 1 / utaurww^2;

sswwb  = 1 / (utausww^4/nusww);
srwwb  = 1 / (utaurww^4/nurww);

%=============================================================
if(0) % vel
ttl   = ['Mean Streamwise Velocity'];
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='log'; ax.YScale='linear';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$\frac{\bar{y}/H}{\nu/u_\tau}$$');
ylabel('$$u^+$$');

plot(ypchan,upchan,'k-','linewidth',2.00,'displayname',tchan);
plot(ypsww ,upsww ,'r-','linewidth',2.00,'displayname',tsww );
plot(yprww ,uprww ,'b-','linewidth',2.00,'displayname',trww );

%------------------------------
figname=[cname,'-','vel'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % budgets
ttl = ['Turbulent Kinetic Energy Budgets'];
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$\frac{\bar{y}/H}{\nu/u_\tau}$$');
ylabel('$$\frac{\dot{\eta_{ij}}}{u_\tau^4/\nu}$$');

plot(ypsww,cnKsww*sswwb,'m-' ,'linewidth',2.00,'displayname','SWW convection');
plot(ypsww,prKsww*sswwb,'r-' ,'linewidth',2.00,'displayname','SWW production');
plot(ypsww,pdKsww*sswwb,'g-' ,'linewidth',2.00,'displayname','SWW pres diff');
plot(ypsww,tdKsww*sswwb,'c-' ,'linewidth',2.00,'displayname','SWW turb diff');
plot(ypsww,vdKsww*sswwb,'k-' ,'linewidth',2.00,'displayname','SWW visc diff');
plot(ypsww,epKsww*sswwb,'b-' ,'linewidth',2.00,'displayname','SWW dissipation');
%
plot(yprww,cnKrww*srwwb,'m--','linewidth',2.00,'displayname','RWW convection');
plot(yprww,prKrww*srwwb,'r--','linewidth',2.00,'displayname','RWW production');
plot(yprww,pdKrww*srwwb,'g--','linewidth',2.00,'displayname','RWW pres diff');
plot(yprww,tdKrww*srwwb,'c--','linewidth',2.00,'displayname','RWW turb diff');
plot(yprww,vdKrww*srwwb,'k--','linewidth',2.00,'displayname','RWW visc diff');
plot(yprww,epKrww*srwwb,'b--','linewidth',2.00,'displayname','RWW dissipation');
%------------------------------
figname=[cname,'-','tke-budgets'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(0) % rs
ttl = ['Reynolds Stresses'];
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$\frac{\bar{y}/H}{\nu/u_\tau}$$');
ylabel('$$\eta_{ij}/u_\tau^2$$');

plot(ypsww,tkKsww     *sswwrs,'k-' ,'linewidth',2.00,'displayname',['SWW $$0.5\eta_{ii}$$']);
plot(ypsww, tksww(:,1)*sswwrs,'r-' ,'linewidth',2.00,'displayname',['SWW $$\eta_{11}$$']);
plot(ypsww, tksww(:,2)*sswwrs,'g-' ,'linewidth',2.00,'displayname',['SWW $$\eta_{22}$$']);
plot(ypsww, tksww(:,3)*sswwrs,'b-' ,'linewidth',2.00,'displayname',['SWW $$\eta_{33}$$']);
%
plot(yprww,tkKrww     *srwwrs,'k--' ,'linewidth',2.00,'displayname',['RWW $$0.5\eta_{ii}$$']);
plot(yprww, tkrww(:,1)*srwwrs,'r--' ,'linewidth',2.00,'displayname',['RWW $$\eta_{11}$$']);
plot(yprww, tkrww(:,2)*srwwrs,'g--' ,'linewidth',2.00,'displayname',['RWW $$\eta_{22}$$']);
plot(yprww, tkrww(:,3)*srwwrs,'b--' ,'linewidth',2.00,'displayname',['RWW $$\eta_{33}$$']);
%------------------------------
figname=[cname,'-','rs'];
saveas(fig,figname,'jpeg');
end
%=============================================================
if(1) % imbalance
imsww = abs(imsww); imKsww = abs(imKsww);
imrww = abs(imrww); imKrww = abs(imKrww);

ttl = ['Turbulent Kinetic Energy Imbalances'];
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='log';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('$$\frac{\bar{y}/H}{\nu/u_\tau}$$');
ylabel('Normalized RS, budgets');

plot(ypsww,tkKsww*sswwrs,'k-' ,'linewidth',2.00,'displayname','SWW TKE');
plot(ypsww,imKsww*sswwb ,'r-' ,'linewidth',2.00,'displayname','SWW TKE Imb');
%
%pause;
plot(yprww,tkKrww*srwwrs,'k--','linewidth',2.00,'displayname','RWW TKE');
plot(yprww,imKrww*srwwb ,'r--','linewidth',2.00,'displayname','RWW TKE Imb');
%------------------------------
figname=[cname,'-','tke-imbal'];
saveas(fig,figname,'jpeg');
end
%=============================================================

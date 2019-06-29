clear; close all;

N=2000; % number of points

Re = 12e3; % based on channel height
visc =1/Re;

c0='channel.his';

u0='ave.dat';
u1='upl.dat';

C =dlmread(c0,' ',[1 0 N 2]); % X,Y,Z
at=dlmread(u1,'' ,[1 0 1 0]);
U1=dlmread(u0,'' ,[1 1 N 4]); % vx,vy,vz,pr
U2=dlmread(u1,'' ,[1 1 N 4]); % uplus,yplus

u=U1(:,1);
v=U1(:,2);
w=U1(:,3);
p=U1(:,4);

up =U2(:,1);
yp =U2(:,2);
%Tma=U1(:,3);
%d2f=U1(:,4);

%shear_mag= Tma(1)
%ufriction=sqrt(shear_mag/1.0)
%delta=0.01;
%Re_tau = ufriction*delta/visc

tk=dlmread('var.dat','',[1 1 N 3]); % < u' * u' >
cn=dlmread('cn1.dat','',[1 1 N 3]); % convective term
pr=dlmread('pr1.dat','',[1 1 N 3]); % production
pt=dlmread('pt1.dat','',[1 1 N 3]); % pressure transport
pd=dlmread('pd1.dat','',[1 1 N 3]); % pressure diffusion
ps=dlmread('ps1.dat','',[1 1 N 3]); % pressure strain
td=dlmread('td1.dat','',[1 1 N 3]); % turbulent diffusion
ep=dlmread('ep1.dat','',[1 1 N 3]); % dissipation
vd=dlmread('vd1.dat','',[1 1 N 3]); % viscous diffusion

% imbalance in reynolds stresses
im= - cn + pr + pt + td + ep + vd;

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

% cnK == 0.5 * sum(cn')';
cnK=dlmread(t1,'',[1 1 N 1]);
prK=dlmread(t1,'',[1 2 N 2]);
ptK=dlmread(t1,'',[1 3 N 3]);
pdK=dlmread(t1,'',[1 4 N 4]);
psK=dlmread(t2,'',[1 1 N 1]);
tdK=dlmread(t2,'',[1 2 N 2]);
epK=dlmread(t2,'',[1 3 N 3]);
vdK=dlmread(t2,'',[1 4 N 4]);
tkK=dlmread(t3,'',[1 1 N 1]);
imK=dlmread(t3,'',[1 2 N 2]);
div=dlmread(t3,'',[1 3 N 3]);

%------------------------------%------------------------------
%
% plotting
%
%------------------------------%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('u-plus');

plot(up,yp,'ro-','linewidth',1.00,'displayname','uplus');

legend('location','southeast');

%------------------------------%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cnK,'m-','linewidth',2.00,'displayname','cn');
plot(yp,prK,'r-','linewidth',2.00,'displayname','pr');
plot(yp,ptK,'c-','linewidth',2.00,'displayname','pt');
plot(yp,pdK,'-' ,'linewidth',2.00,'displayname','pd');
plot(yp,psK,'-' ,'linewidth',3.00,'displayname','ps');
plot(yp,tdK,'g-','linewidth',2.00,'displayname','td');
plot(yp,epK,'b-','linewidth',2.00,'displayname','ep');
plot(yp,vdK,'k-','linewidth',2.00,'displayname','vd');
plot(yp,tkK,'-' ,'linewidth',2.00,'displayname','tk');
plot(yp,imK,'-' ,'linewidth',2.00,'displayname','im');
plot(yp,div,'-' ,'linewidth',2.00,'displayname','di');

legend('location','northeast');

%------------------------------%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cn(:,1),'m-','linewidth',2.00,'displayname','cn uu');
plot(yp,pr(:,1),'r-','linewidth',2.00,'displayname','pr uu');
plot(yp,pt(:,1),'c-','linewidth',2.00,'displayname','pt uu');
plot(yp,pd(:,1),'-' ,'linewidth',2.00,'displayname','pd uu');
plot(yp,ps(:,1),'-' ,'linewidth',3.00,'displayname','ps uu');
plot(yp,td(:,1),'g-','linewidth',2.00,'displayname','td uu');
plot(yp,ep(:,1),'b-','linewidth',2.00,'displayname','ep uu');
plot(yp,vd(:,1),'k-','linewidth',2.00,'displayname','vd uu');
plot(yp,tk(:,1),'-' ,'linewidth',2.00,'displayname','tk uu');
plot(yp,im(:,1),'-' ,'linewidth',2.00,'displayname','im uu');

legend('location','northeast');

%------------------------------%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cn(:,2),'m-','linewidth',2.00,'displayname','cn vv');
plot(yp,pr(:,2),'r-','linewidth',2.00,'displayname','pr vv');
plot(yp,pt(:,2),'c-','linewidth',2.00,'displayname','pt vv');
plot(yp,pd(:,2),'-' ,'linewidth',2.00,'displayname','pd vv');
plot(yp,ps(:,2),'-' ,'linewidth',3.00,'displayname','ps vv');
plot(yp,td(:,2),'g-','linewidth',2.00,'displayname','td vv');
plot(yp,ep(:,2),'b-','linewidth',2.00,'displayname','ep vv');
plot(yp,vd(:,2),'k-','linewidth',2.00,'displayname','vd vv');
plot(yp,tk(:,2),'-' ,'linewidth',2.00,'displayname','tk vv');
plot(yp,im(:,2),'-' ,'linewidth',2.00,'displayname','im vv');

legend('location','northeast');

%------------------------------%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cn(:,3),'m-','linewidth',2.00,'displayname','cn ww');
plot(yp,pr(:,3),'r-','linewidth',2.00,'displayname','pr ww');
plot(yp,pt(:,3),'c-','linewidth',2.00,'displayname','pt ww');
plot(yp,pd(:,3),'-' ,'linewidth',2.00,'displayname','pd ww');
plot(yp,ps(:,3),'-' ,'linewidth',3.00,'displayname','ps ww');
plot(yp,td(:,3),'g-','linewidth',2.00,'displayname','td ww');
plot(yp,ep(:,3),'b-','linewidth',2.00,'displayname','ep ww');
plot(yp,vd(:,3),'k-','linewidth',2.00,'displayname','vd ww');
plot(yp,tk(:,3),'-' ,'linewidth',2.00,'displayname','tk ww');
plot(yp,im(:,3),'-' ,'linewidth',2.00,'displayname','im ww');

legend('location','northeast');

%------------------------------%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cnK,'m-','linewidth',2.00,'displayname','cn');
%plot(yp,prK,'r-','linewidth',2.00,'displayname','pr');
%plot(yp,ptK,'c-','linewidth',2.00,'displayname','pt');
%plot(yp,pdK,'-' ,'linewidth',2.00,'displayname','pd');
%plot(yp,psK,'-' ,'linewidth',3.00,'displayname','ps');
%plot(yp,tdK,'g-','linewidth',2.00,'displayname','td');
%plot(yp,epK,'b-','linewidth',2.00,'displayname','ep');
%plot(yp,vdK,'k-','linewidth',2.00,'displayname','vd');
plot(yp,tkK,'-' ,'linewidth',2.00,'displayname','tk');
plot(yp,imK,'-' ,'linewidth',2.00,'displayname','im');
%plot(yp,div,'-' ,'linewidth',2.00,'displayname','di');

legend('location','northeast');

%------------------------------%------------------------------

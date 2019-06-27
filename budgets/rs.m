clear; close all;
% number of points
N=2000;

c0='channel.his';

u0='avg.dat';
u1='upl.dat';

f1='cn1.dat';
f2='pr1.dat';
f3='pt1.dat';
f4='pd1.dat';
f5='ps1.dat';
f6='td1.dat';
f7='ep1.dat';
f8='vd1.dat';

t1='tk1.dat';
t2='tk2.dat';
t3='tk3.dat';

p0='ppp.dat';

C =dlmread(c0,' ',[1 0 N 2]);
U0=dlmread(u0,'' ,[1 1 N 4]);
U1=dlmread(u1,'' ,[1 1 N 4]);
at=dlmread(f1,'' ,[1 0 1 0]);

cn=dlmread(f1,'',[1 1 N 3]);
pr=dlmread(f3,'',[1 1 N 3]);
pt=dlmread(f3,'',[1 1 N 3]);
pd=dlmread(f4,'',[1 1 N 3]);
ps=dlmread(f5,'',[1 1 N 3]);
td=dlmread(f6,'',[1 1 N 3]);
ep=dlmread(f7,'',[1 1 N 3]);
vd=dlmread(f8,'',[1 1 N 3]);

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

pudx=dlmread(p0,'',[1 2 N 2]);
pvdy=dlmread(p0,'',[1 3 N 3]);
pwdz=dlmread(p0,'',[1 4 N 4]);

tk= - cn + pr + pt + td + ep + vd;

u=U0(:,1);
v=U0(:,2);
w=U0(:,3);
p=U0(:,4);

up  =U1(:,1);
yp  =U1(:,2);
%Tma=U1(:,3);
%d2f=U1(:,4);

%shear_mag= Tma(1)
%ufriction=sqrt(shear_mag/1.0)
%delta=0.01;
Re = 12e3;
visc =1/Re;
%Re_tau = ufriction*delta/visc

%------------------------------
% plotting
%------------------------------
%figure; fig=gcf; ax=gca; ax.FontSize=14;
%ax.XScale='log'; ax.YScale='linear';
%hold on; grid on; axis square;
%
%title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
%xlabel('y-plus'); ylabel('u-plus');
%
%plot(yp,up,'ro-','linewidth',1.00,'displayname','uplus');
%
%legend('location','northwest');
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,pudx,'c-','linewidth',2.00,'displayname','pudx');
plot(yp,pvdy,'k-','linewidth',2.00,'displayname','pvdy');
plot(yp,pwdz,'m-','linewidth',2.00,'displayname','pwdz');
plot(yp,p,   'r-','linewidth',2.00,'displayname','p');

legend('location','northeast');

%------------------------------
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
%figure; fig=gcf; ax=gca; ax.FontSize=14;
%ax.XScale='linear'; ax.YScale='linear';
%hold on; grid on; axis square;
%
%title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
%xlabel('y-plus'); ylabel('TKE');
%
%plot(yp,cn(:,1),'m-','linewidth',2.00,'displayname','cn uu');
%plot(yp,pr(:,1),'r-','linewidth',2.00,'displayname','pr uu');
%plot(yp,pt(:,1),'c-','linewidth',2.00,'displayname','pt uu');
%plot(yp,pd(:,1),'-','linewidth',2.00,'displayname','pd uu');
%plot(yp,ps(:,1),'-','linewidth',2.00,'displayname','ps uu');
%plot(yp,td(:,1),'g-','linewidth',2.00,'displayname','td uu');
%plot(yp,ep(:,1),'b-','linewidth',2.00,'displayname','ep uu');
%plot(yp,vd(:,1),'k-','linewidth',2.00,'displayname','vd uu');
%plot(yp,tk(:,1),'-','linewidth',2.00,'displayname','re uu');
%
%legend('location','northeast');
%
%%------------------------------
%figure; fig=gcf; ax=gca; ax.FontSize=14;
%ax.XScale='linear'; ax.YScale='linear';
%hold on; grid on; axis square;
%
%title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
%xlabel('y-plus'); ylabel('TKE');
%
%plot(yp,cn(:,2),'m-','linewidth',2.00,'displayname','cn vv');
%plot(yp,pr(:,2),'r-','linewidth',2.00,'displayname','pr vv');
%plot(yp,pt(:,2),'c-','linewidth',2.00,'displayname','pt vv');
%plot(yp,pd(:,2),'-','linewidth',2.00,'displayname','pd vv');
%plot(yp,ps(:,2),'-','linewidth',2.00,'displayname','ps vv');
%plot(yp,td(:,2),'g-','linewidth',2.00,'displayname','td vv');
%plot(yp,ep(:,2),'b-','linewidth',2.00,'displayname','ep vv');
%plot(yp,vd(:,2),'k-','linewidth',2.00,'displayname','vd vv');
%plot(yp,tk(:,2),'-','linewidth',2.00,'displayname','re vv');
%
%legend('location','northeast');
%
%%------------------------------
%figure; fig=gcf; ax=gca; ax.FontSize=14;
%ax.XScale='linear'; ax.YScale='linear';
%hold on; grid on; axis square;
%
%title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
%xlabel('y-plus'); ylabel('TKE');
%
%plot(yp,cn(:,3),'m-','linewidth',2.00,'displayname','cn ww');
%plot(yp,pr(:,3),'r-','linewidth',2.00,'displayname','pr ww');
%plot(yp,pt(:,3),'c-','linewidth',2.00,'displayname','pt ww');
%plot(yp,pd(:,3),'-','linewidth',2.00,'displayname','pd ww');
%plot(yp,ps(:,3),'-','linewidth',2.00,'displayname','ps ww');
%plot(yp,td(:,3),'g-','linewidth',2.00,'displayname','td ww');
%plot(yp,ep(:,3),'b-','linewidth',2.00,'displayname','ep ww');
%plot(yp,vd(:,3),'k-','linewidth',2.00,'displayname','vd ww');
%plot(yp,tk(:,3),'-','linewidth',2.00,'displayname','re ww');
%
%legend('location','northeast');
%
%%------------------------------
%figure; fig=gcf; ax=gca;
%ax.XScale='linear';
%ax.YScale='linear';
%ax.FontSize=14;
%hold on; grid on; axis square;
%
%title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
%xlabel('y-plus')
%ylabel('TKE')
%plot(yp,tk(:,1),'-','linewidth',2.00,'displayname','residual uu');
%plot(yp,tk(:,2),'-','linewidth',2.00,'displayname','residual vv');
%plot(yp,tk(:,3),'-','linewidth',2.00,'displayname','residual ww');
%
%legend('location','northeast');


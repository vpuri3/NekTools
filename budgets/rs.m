clear;
% number of points
N=2000;

file0='smoothWavyWall.his';
file00='upl.dat';

file1='cn1.dat';
file2='pr1.dat';
file3='pt1.dat';
file4='pd1.dat';
file5='ps1.dat';
file6='td1.dat';
file7='ep1.dat';
file8='vd1.dat';

C =dlmread(file0,' ',[1 0 N 2]);
U =dlmread(file00,'',[1 1 N 4]);
at=dlmread(file1,'' ,[1 0 1 0]);

cn=dlmread(file1,'' ,[1 1 N 3]);
pr=dlmread(file2,'' ,[1 1 N 3]);
pt=dlmread(file3,'' ,[1 1 N 3]);
pd=dlmread(file4,'' ,[1 1 N 3]);
ps=dlmread(file5,'' ,[1 1 N 3]);
td=dlmread(file6,'' ,[1 1 N 3]);
ep=dlmread(file7,'' ,[1 1 N 3]);
vd=dlmread(file8,'' ,[1 1 N 3]);

x=C(:,1);
y=C(:,2);
z=C(:,3);

up =U(:,1);
yp =U(:,2);
Tma=U(:,3);
d2f=U(:,4);

tk= - cn + pr + pt + td + ep + vd;

shear_mag= Tma(1)
ufriction=sqrt(shear_mag/1.0)
delta=0.095454545454545;
visc =1/4780;
Re_tau = ufriction*delta/visc
Re = 4780;
% plotting
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='log'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('u-plus');

plot(yp,up,'ro-','linewidth',1.00,'displayname','uplus');

legend('location','northwest');
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cn(:,1),'m-','linewidth',2.00,'displayname','cn uu');
plot(yp,pr(:,1),'r-','linewidth',2.00,'displayname','pr uu');
plot(yp,pt(:,1),'c-','linewidth',2.00,'displayname','pt uu');
%plot(yp,pd(:,1),'-','linewidth',2.00,'displayname','pd uu');
%plot(yp,ps(:,1),'-','linewidth',2.00,'displayname','ps uu');
plot(yp,td(:,1),'g-','linewidth',2.00,'displayname','td uu');
plot(yp,ep(:,1),'b-','linewidth',2.00,'displayname','ep uu');
plot(yp,vd(:,1),'k-','linewidth',2.00,'displayname','vd uu');
%plot(yp,tk(:,1),'-','linewidth',2.00,'displayname','re uu');

legend('location','northeast');

%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cn(:,2),'m-','linewidth',2.00,'displayname','cn vv');
plot(yp,pr(:,2),'r-','linewidth',2.00,'displayname','pr vv');
plot(yp,pt(:,2),'c-','linewidth',2.00,'displayname','pt vv');
%plot(yp,pd(:,2),'-','linewidth',2.00,'displayname','pd vv');
%plot(yp,ps(:,2),'-','linewidth',2.00,'displayname','ps vv');
plot(yp,td(:,2),'g-','linewidth',2.00,'displayname','td vv');
plot(yp,ep(:,2),'b-','linewidth',2.00,'displayname','ep vv');
plot(yp,vd(:,2),'k-','linewidth',2.00,'displayname','vd vv');
%plot(yp,tk(:,2),'-','linewidth',2.00,'displayname','re vv');

legend('location','northeast');

%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus'); ylabel('TKE');

plot(yp,cn(:,3),'m-','linewidth',2.00,'displayname','cn ww');
plot(yp,pr(:,3),'r-','linewidth',2.00,'displayname','pr ww');
plot(yp,pt(:,3),'c-','linewidth',2.00,'displayname','pt ww');
%plot(yp,pd(:,3),'-','linewidth',2.00,'displayname','pd ww');
%plot(yp,ps(:,3),'-','linewidth',2.00,'displayname','ps ww');
plot(yp,td(:,3),'g-','linewidth',2.00,'displayname','td ww');
plot(yp,ep(:,3),'b-','linewidth',2.00,'displayname','ep ww');
plot(yp,vd(:,3),'k-','linewidth',2.00,'displayname','vd ww');
%plot(yp,tk(:,3),'-','linewidth',2.00,'displayname','re ww');

legend('location','northeast');

%------------------------------
figure; fig=gcf; ax=gca;
ax.XScale='linear';
ax.YScale='linear';
ax.FontSize=14;
hold on; grid on; axis square;

title(['Channel Flow, avgtime:' num2str(at) 's, Re: ' num2str(Re)],'fontsize',14)
xlabel('y-plus')
ylabel('TKE')
plot(yp,tk(:,1),'-','linewidth',2.00,'displayname','residual uu');
plot(yp,tk(:,2),'-','linewidth',2.00,'displayname','residual vv');
plot(yp,tk(:,3),'-','linewidth',2.00,'displayname','residual ww');

legend('location','northeast');

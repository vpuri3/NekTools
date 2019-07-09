function rs(N1,N1,casename,miscstr,visc)
% N0 --> first history point
% N1 --> last  history point
%
% example: rs(201,400,'smoothWavyWall','peak',1/4780)
%

c0=[casename,'.his'];

u0='ave.dat';
u1='upl.dat';

C =dlmread(c0,' ',[N0 0 N1 2]); % X,Y,Z
U1=dlmread(u0,'' ,[N0 1 N1 4]); % vx,vy,vz,pr
U2=dlmread(u1,'' ,[N0 1 N1 3]); % uplus,yplus

at=dlmread(u1,'' ,[1 0 1 0]);
u=U1(:,1);
v=U1(:,2);
w=U1(:,3);
p=U1(:,4);

up=U2(:,1);
yp=U2(:,2);
Tm=U2(:,3);

Tm = Tm(1)                     % shear magnitude
ufriction=sqrt(Tm/1.0);        % friction velocity
delta=0.5;                     % half height
Re_tau = ufriction*delta/visc;

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

c = char(39);
%=============================================================
if(1)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='log'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel('u-plus');

plot(yp,up,'ro','linewidth',1.00,'displayname','uplus');

legend('location','northwest');
%------------------------------
end
%=============================================================
if(1)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel(['<u_j',c,'u_j',c,'>/u_\tau^2']);

plot(yp,cnK/Tm,'m-','linewidth',2.00,'displayname','convection TKE');
plot(yp,prK/Tm,'r-','linewidth',2.00,'displayname','production TKE');
plot(yp,ptK/Tm,'c-','linewidth',2.00,'displayname','pres transport TKE');
plot(yp,pdK/Tm,'-' ,'linewidth',2.00,'displayname','pres diffusion TKE');
plot(yp,psK/Tm,'-' ,'linewidth',3.00,'displayname','pres strain TKE');
plot(yp,tdK/Tm,'g-','linewidth',2.00,'displayname','turb diffusion TKE');
plot(yp,epK/Tm,'b-','linewidth',2.00,'displayname','dissipation TKE');
plot(yp,vdK/Tm,'k-','linewidth',2.00,'displayname','visc diffusion TKE');
plot(yp,tkK/Tm,'-' ,'linewidth',2.00,'displayname',['TKE=0.5<u_j',c,'u_j',c,'>']);
plot(yp,imK/Tm,'-' ,'linewidth',2.00,'displayname','imbalance TKE');

legend('location','northeast');
%------------------------------
end
%=============================================================
if(0)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel(['<u_i',c,'u_j',c,'>/u_\tau^2']);

plot(yp,cn(:,1)/Tm,'m-','linewidth',2.00,'displayname','convection uu');
plot(yp,pr(:,1)/Tm,'r-','linewidth',2.00,'displayname','production uu');
plot(yp,pt(:,1)/Tm,'c-','linewidth',2.00,'displayname','pres transport uu');
plot(yp,pd(:,1)/Tm,'-' ,'linewidth',2.00,'displayname','pres diffusion uu');
plot(yp,ps(:,1)/Tm,'-' ,'linewidth',3.00,'displayname','pres strain uu');
plot(yp,td(:,1)/Tm,'g-','linewidth',2.00,'displayname','turb diffusion uu');
plot(yp,ep(:,1)/Tm,'b-','linewidth',2.00,'displayname','dissipation uu');
plot(yp,vd(:,1)/Tm,'k-','linewidth',2.00,'displayname','visc diffusion uu');
plot(yp,tk(:,1)/Tm,'-' ,'linewidth',2.00,'displayname',['<vx',c,'vx',c,'>']);
plot(yp,im(:,1)/Tm,'-' ,'linewidth',2.00,'displayname','imbalance uu');

legend('location','northeast');
%------------------------------
end
%=============================================================
if(0)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel(['<u_i',c,'u_j',c,'>/u_\tau^2']);

plot(yp,cn(:,2)/Tm,'m-','linewidth',2.00,'displayname','convection vv');
plot(yp,pr(:,2)/Tm,'r-','linewidth',2.00,'displayname','production vv');
plot(yp,pt(:,2)/Tm,'c-','linewidth',2.00,'displayname','pres transport vv');
plot(yp,pd(:,2)/Tm,'-' ,'linewidth',2.00,'displayname','pres diffusion vv');
plot(yp,ps(:,2)/Tm,'-' ,'linewidth',3.00,'displayname','pres strain vv');
plot(yp,td(:,2)/Tm,'g-','linewidth',2.00,'displayname','turb diffusion vv');
plot(yp,ep(:,2)/Tm,'b-','linewidth',2.00,'displayname','dissipation vv');
plot(yp,vd(:,2)/Tm,'k-','linewidth',2.00,'displayname','visc diffusion vv');
plot(yp,tk(:,2)/Tm,'-' ,'linewidth',2.00,'displayname',['<vy',c,'vy',c,'>']);
plot(yp,im(:,2)/Tm,'-' ,'linewidth',2.00,'displayname','imbalance vv');

legend('location','northeast');
%------------------------------
end
%=============================================================
if(0)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel(['<u_i',c,'u_j',c,'>/u_\tau^2']);

plot(yp,cn(:,3)/Tm,'m-','linewidth',2.00,'displayname','convection ww');
plot(yp,pr(:,3)/Tm,'r-','linewidth',2.00,'displayname','production ww');
plot(yp,pt(:,3)/Tm,'c-','linewidth',2.00,'displayname','pres transport ww');
plot(yp,pd(:,3)/Tm,'-' ,'linewidth',2.00,'displayname','pres diffusion ww');
plot(yp,ps(:,3)/Tm,'-' ,'linewidth',3.00,'displayname','pres strain ww');
plot(yp,td(:,3)/Tm,'g-','linewidth',2.00,'displayname','turb diffusion ww');
plot(yp,ep(:,3)/Tm,'b-','linewidth',2.00,'displayname','dissipation ww');
plot(yp,vd(:,3)/Tm,'k-','linewidth',2.00,'displayname','visc diffusion ww');
plot(yp,tk(:,3)/Tm,'-' ,'linewidth',2.00,'displayname',['<vz',c,'vz',c,'>']);
plot(yp,im(:,3)/Tm,'-' ,'linewidth',2.00,'displayname','imbalance ww');

legend('location','northeast');
%------------------------------
end
%=============================================================
if(1)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel(['<u_i',c,'u_j',c,'>/u_\tau^2']);

%plot(yp,cnK/Tm,'m-','linewidth',2.00,'displayname','convection     ');
%plot(yp,prK/Tm,'r-','linewidth',2.00,'displayname','production     ');
%plot(yp,ptK/Tm,'c-','linewidth',2.00,'displayname','pres transport ');
%plot(yp,pdK/Tm,'-' ,'linewidth',2.00,'displayname','pres diffusion ');
%plot(yp,psK/Tm,'-' ,'linewidth',3.00,'displayname','pres strain    ');
%plot(yp,tdK/Tm,'g-','linewidth',2.00,'displayname','turb diffusion ');
%plot(yp,epK/Tm,'b-','linewidth',2.00,'displayname','dissipation    ');
%plot(yp,vdK/Tm,'k-','linewidth',2.00,'displayname','visc diffusion ');
plot(yp,tkK/Tm,'-' ,'linewidth',2.00,'displayname','TKE            ');
plot(yp,imK/Tm,'-' ,'linewidth',2.00,'displayname','imbalance      ');

legend('location','northeast');
%------------------------------
end
%=============================================================
if(1)
%------------------------------
figure; fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='linear';
hold on; grid on; axis square;

title([casename,' ',miscstr,', atime:',num2str(at),'s, Re_\tau: ',num2str(Re_tau)],'fontsize',14)
xlabel('y-plus');
ylabel(['<u_i',c,'u_j',c,'>/u_\tau^2']);

plot(yp,tk(:,1)/Tm,'-' ,'linewidth',2.00,'displayname',['<vx',c,'vx',c,'>']);
plot(yp,tk(:,2)/Tm,'-' ,'linewidth',2.00,'displayname',['<vy',c,'vy',c,'>']);
plot(yp,tk(:,3)/Tm,'-' ,'linewidth',2.00,'displayname',['<vz',c,'vz',c,'>']);
plot(yp,tkK    /Tm,'-' ,'linewidth',3.00,'displayname',['TKE=0.5<u_j',c,'u_j',c,'>']);

legend('location','northeast');
%------------------------------
end
%=============================================================

end

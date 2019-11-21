%
function bplt(x,y,u,ux,uy,uz,Tm,visc,cname,bgtname,bgt)

if(strcmp(cname,'sww'))
	casename = 'Smooth Wavy Wall';
elseif(strcmp(cname,'rww'))
	casename = 'Rough Wavy Wall';
end

if(strcmp(bgt,'rs'))
	s = 1/(Tm);
	ttl = ['$$\frac{\eta_{ij}}{u_\tau^2}$$'];
else
	s = 1/(Tm*Tm/visc);
	ttl = ['$$\frac{\dot{\eta_{ij}}}{u_\tau^4/\nu}$$'];
end

ifcb = 0; % same colorbar for all fields
m = min(min([u,ux,uy,uz]*s));
M = max(max([u,ux,uy,uz]*s));
%=============================================================
figure;
fig=gcf;ax=gca;
set(fig,'position',[0,0,750,2500])
%------------------------------
subplot(4,1,1); grid on;
pcolor(x,y,u*s); shading interp; colormap jet; colorbar;
if(ifcb); caxis([m,M]); end;
title([casename,' ',bgtname,' $$\frac{1}{2}\eta_{ii}$$'],'fontsize',14);
hcb=colorbar; title(hcb,ttl,'interpreter','latex','fontsize',14);
xlabel('$$x/\lambda$$');
ylabel('$$y$$');
%------
subplot(4,1,2); grid on;
pcolor(x,y,ux*s); shading interp; colormap jet; colorbar;
if(ifcb); caxis([m,M]); end;
title([casename,' ',bgtname,' $$\eta_{11}$$'],'fontsize',14);
hcb=colorbar; title(hcb,ttl,'interpreter','latex','fontsize',14);
xlabel('$$x/\lambda$$');
ylabel('$$y$$');
%------
subplot(4,1,3); grid on;
pcolor(x,y,uy*s); shading interp; colormap jet; colorbar;
if(ifcb); caxis([m,M]); end;
title([casename,' ',bgtname,' $$\eta_{22}$$'],'fontsize',14);
hcb=colorbar; title(hcb,ttl,'interpreter','latex','fontsize',14);
xlabel('$$x/\lambda$$');
ylabel('$$y$$');
%------
subplot(4,1,4); grid on;
pcolor(x,y,uz*s); shading interp; colormap jet; colorbar;
if(ifcb); caxis([m,M]); end;
title([casename,' ',bgtname,' $$\eta_{33}$$'],'fontsize',14);
hcb=colorbar; title(hcb,ttl,'interpreter','latex','fontsize',14);
xlabel('$$x/\lambda$$');
ylabel('$$y$$');
%------------------------------
figname=[cname,'-',bgt];
saveas(fig,figname,'jpeg');
%=============================================================

end


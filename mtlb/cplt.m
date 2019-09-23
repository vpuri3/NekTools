%
function cplt(x,y,xw,yw,u,Tm,visc,casename,cname,bgtname,bgt)

if(strcmp(bgt,'tkK'))
	s = 1/(Tm);
	ttl = ['$$\frac{\eta_{ij}}{u_\tau^2}$$'];
else
	s = 1/(Tm*Tm/visc);
	ttl = ['$$\frac{\eta_{ij}}{u_\tau^4/\nu}$$'];
end

%=============================================================
figure;
fig=gcf;ax=gca;
%------------------------------
hold on;grid on;
% title
title([casename,' ',bgtname],'fontsize',14);
% pos
daspect([1,1,1]);set(fig,'position',[0,0,1000,500])
% ax
ax.FontSize=14;
xlabel('$$x/\lambda_1$$');
ylabel('$$y$$');
xlim([min(min(x)),max(max(x))]);
ylim([min(min(y)),max(max(y))]);

plot(xw,yw,'k-','linewidth',2.0);
pcolor(x,y,u*s);
% color
shading interp;colormap jet;
hcb=colorbar;
title(hcb,ttl,'interpreter','latex','fontsize',14);
%------------------------------
figname=[cname,'-',bgt];
saveas(fig,figname,'jpeg');
%=============================================================

end


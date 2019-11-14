%
function cplt(x,y,xw,yw,u,s,casename,cname,qtyname,qty,units)

%=============================================================
figure;
fig=gcf;ax=gca;
%------------------------------
hold on;grid on;
% title
title([casename,' ',qtyname],'fontsize',14);
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
title(hcb,units,'interpreter','latex','fontsize',14);
%------------------------------
figname=[cname,'-',qty];
saveas(fig,figname,'jpeg');
%=============================================================

end


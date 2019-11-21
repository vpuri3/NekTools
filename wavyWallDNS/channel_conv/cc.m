%=============================================================
% channel flow convergence
%=============================================================
%-------------------------------------------------------------
clear;clf;
%-------------------------------------------------------------
visc = 1/12e3;

tkL2 = zeros(4,1);
imL2 = zeros(4,1);
immx = zeros(4,1);

tmag = zeros(4,1);
ufrc = zeros(4,1);

lx = [6;8;10;12];
po = lx+1;

%-------------------------------------------------------------
% reading data

dirs = ["lx06","lx08","lx10","lx12"];

for i=1:4

	dir = convertStringsToChars(dirs(i));
	dir = [dir,'/'];

	% logfile
	logfile=textread([dir,'logfile'],'%s','delimiter','\n');
	
	% tk_L2
	tk_L2=find(~cellfun(@isempty,strfind(logfile,'tk_L2:')));
	tk_L2=logfile(tk_L2(end));
	tk_L2=cell2mat(tk_L2);
	tk_L2=str2num(tk_L2(7:end));
	
	% im_L2
	im_L2=find(~cellfun(@isempty,strfind(logfile,'im_L2:')));
	im_L2=logfile(im_L2(end));
	im_L2=cell2mat(im_L2);
	im_L2=str2num(im_L2(7:end));
	
	% immax
	immax=find(~cellfun(@isempty,strfind(logfile,'immax:')));
	immax=logfile(immax(end));
	immax=cell2mat(immax);
	immax=str2num(immax(7:end));
	
	% Tmavg
	Tmavg=find(~cellfun(@isempty,strfind(logfile,'Tmavg:')));
	Tmavg=logfile(Tmavg(end));
	Tmavg=cell2mat(Tmavg);
	Tmavg=str2num(Tmavg(7:end));
	
	% Ufavg
	Ufavg=find(~cellfun(@isempty,strfind(logfile,'Ufavg:')));
	Ufavg=logfile(Ufavg(end));
	Ufavg=cell2mat(Ufavg);
	Ufavg=str2num(Ufavg(7:end));

	tkL2(i) = tk_L2;
	imL2(i) = im_L2;
	immx(i) = immax;
	
	tmag(i) = Tmavg;
	ufrc(i) = Ufavg;

end
%-------------------------------------------------------------

tmg = 0.25 * sum(tmag);
ufr = 0.25 * sum(ufrc);

sr  = 1 ./ ( ufrc.^2);
sb  = 1 ./ ( ufrc.^4/visc);
s   = sb ./ sr;

iL2 = imL2 ./ tkL2;
imx = immx ./ tkL2;

%=============================================================
if(1)
ttl=['Imbalance Channel Flow Re 6000'];
order_x = po([1;end]); rto=po(1)/po(end);
order_6 = (iL2(1)*1)*[1 rto^(6)];
order_7 = (iL2(1)*1)*[1 rto^(7)];
%------------------------------
%figure;
fig=gcf; ax=gca; ax.FontSize=14;
ax.XScale='linear'; ax.YScale='log';
lgd=legend('location','northeast');lgd.FontSize=10;
hold on; grid on; axis square;

title(ttl,'fontsize',14);
xlabel('Polynomial Order');
ylabel('imbalance / tke in wall units');

plot(po,iL2,'ro-','linewidth',2.00,'displayname','L2');
plot(po,imx,'go-','linewidth',2.00,'displayname','max');

p=plot(order_x,order_6,'k--','linewidth',2.0);
p.DisplayName=['Sixth Order Line'];

p=plot(order_x,order_7,'b--','linewidth',2.0);
p.DisplayName=['Seventh Order Line'];
%------------------------------
cname = 'channel';
figname=[cname,'-','conv'];
saveas(fig,figname,'jpeg');
end
%=============================================================


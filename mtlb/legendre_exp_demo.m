
kmax=1000; 
M=2+kmax/2; [z,w]=zwgll(M); x=.5*(1+z); rho=.5*w; 

f=x.^3;                 %% f(x) on [0,1]
Lk=legendre(x,kmax);    %% All Legendre polynomials up to N=kmax.
fk = 2*Lk'*(rho.*f);    %% 2X for contributions from x<0 and x>0.
k=0:2:kmax;             %% Take only even wavenumbers
fk=abs(fk(1:2:end));

%% PLOT HERE %%
loglog(k,fk,'r.-',k,10*(k.^-4),'g-',k,10*(k.^-5),'b-','linewidth',1.2)
title('Legendre Expansion Coefficients for $f=|x|^3$',...
      'interpreter','latex','fontsize',18);
xlabel('$k$','interpreter','latex','fontsize',18);
ylabel('${\hat f}_k$','interpreter','latex','fontsize',18)
leg1=legend('${\hat f}_k$','$10k^{-4}$','$10k^{-5}$');
set(leg1,'Interpreter','latex'); set(leg1,'FontSize',16);
axis square;

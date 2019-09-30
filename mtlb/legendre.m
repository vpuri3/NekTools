
      function[l] =  legend(x,N)
%
%     Compute the Legendre polynomials up to degree N evaluated at points x
%
      m=length(x);
      l=ones(m,N+1);
      l(:,2)=x;
%
      for k=2:N;
         i=k+1;
         l(:,i) = ( (2*k-1)*x.*l(:,i-1)-(k-1)*l(:,i-2) )/k;
      end;

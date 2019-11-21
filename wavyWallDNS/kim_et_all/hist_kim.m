% history points for smoothWavyWall parallel to Y dir
%
% unscaled geometry: x \in [0  ,4*lam  ]
%                    y \in [yw ,del+lam]
%                    z \in [0  ,2*lam  ] uniform in z
% % yw = del * cos(2*pi*x/lam) % 
% scale by 1/lam in X and Z.
% scale such that Y \in [0,lam+del]

%-----------------------------------------------------%
% get y from kim
%
kbal=dlmread('chan395.kbal','',[25 0 153 8]); % Normalization: U_tau, nu/U_tau 
y=0.5*kbal(:,1);
x=0*y+1;
z=x;
N = length(y);
%-----------------------------------------------------%
% create file casename.his
casename='channel';
format long
A = [x,y,z];
casename=[casename,'.his'];
fID = fopen(casename,'w');
fprintf(fID, [num2str(N) ' !=number of monitoring points\n']);
dlmwrite(casename,A,'delimiter',' ','-append');
type(casename)

%%% 1D STABILITY CODE %%%
% COMPUTES ORR SOMMERFELD OPERATOR 
% OF LAMINAR 1D BASE FLOWS AND ITS 
% EIGEN-DECOMPOSITION 

% building block to full FD transient growth
% code for incomp flows...

clearvars; clc; close all;
set(0,'defaultFigureRenderer','painters')
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesTickLabelInterpreter','latex');
beep off
%% Plotting
nfg=0;
m1pos=[800 75 700 600];

%% Parameters
jl = 201;
Re = 5772.22;
Rei= 1/Re;
alpha = 1.0;
beta  = 0;     % spanwise wavenumber (IMPORTANT)
k2 = alpha^2 + beta^2;

%% Grid
y=linspace(-1,1,jl);
h=y(2)-y(1); % <-- const spacing
hsq=h*h;

%% Differentiation Operators
% [D1,D2] = FD2(h,jl);     % <-- 2nd order explicit
% [D1,D2] = FDCOMP4(h,jl); % <-- 4th order compact
[D1,D2] = FDCOMP6(h,jl);   % <-- 6th order compact



%% Base flow

% Plane Poiseuille flow
U   = (1 - y.^2);
Upe  = (-2*y);
Uppe = (-2*ones(size(y)));

% Couette flow
% U = (1+y)/2;
% Upe = 1/2;
% Uppe = 0;

% Numerical differentiation (useful for future TBL profiles)
Up = diag(D1*U');
Upp= diag(D2*U');
U = diag(U); % <-- re-inflate profile


icheckdiff=0; % <-- flag for checking if numerical differentiation works
if icheckdiff==1
  nfg=nfg+1;
  f=figure(nfg);
  plot(y,Upe,'k-',y,diag(Up),'r--','LineWidth',2)
  xlabel('$y/h$');
  ylabel('$\partial_x u$')
  FORMATFIG(f,m1pos,0,0,0)

  nfg=nfg+1;
  f=figure(nfg);
  plot(y,Uppe,'k-',y,diag(Upp),'r--','LineWidth',2)
  xlabel('$y/h$');
  ylabel('$\partial_{xx} u$')
  ylim([-2.01 -1.99])
  FORMATFIG(f,m1pos,0,0,0)
end


%% BC MODIFIERS
int=3:jl-2; % <-- eliminate rows 
% ^ essentially treats v(j=1) = v(j=2) = 0 
% as 'ghost nodes' in calculation, implicitly
% removing their effect on interior 
% differentiation stencils. appropriately enforces BCs
% and gives well-conditioned stability matrices for inversion.

%% Build common operators
I = eye(jl);

Delta = D2 - k2*I;
KMD = k2*I - D2;

%% BUILD A,B MATRICES
AOS = alpha*U*Delta - alpha*Upp - (1/(1i*Re))*(Delta*(Delta));
BOS = Delta;



%% Orr–Sommerfeld operator
LOS = BOS(int,int)\AOS(int,int);
% LOS = B\A;

%% Compute spectrum
spec=eig(LOS);

% Separate real, imag components
lami=imag(spec);
lamr=real(spec);

%% CHECKING
[lami,idx]=sort(lami,'descend');
lamr=lamr(idx);
EIGCHECK = [lamr(1:10) lami(1:10)]; % <-- array for comparison to Schmid and Henningson Appendix A Table

imax=find(lami==max(lami));
lim=lami(imax);
lrm=lamr(imax);

% Scaling of eigenvalues using phase relation w=ca
if alpha>0
  lami=lami/alpha;
  lamr=lamr/alpha;
  xstr='$c_r$';
  ystr='$c_i$';
elseif beta>0 && alpha==0
  lami=lami/1;
  lamr=lamr/1;
  xstr='$\omega_r$';
  ystr='$\omega_i$';
end


  
% Plot spectrum
nfg=nfg+1;
f=figure(nfg);
plot(lamr(2:end),lami(2:end),'ko','LineWidth',2,'MarkerFaceColor','w')
hold on
% Highlight least stable mode
plot(lrm(1),lim(1),'ko','LineWidth',2,'MarkerFaceColor','r')
hold off
xlabel(xstr); 
ylabel(ystr);
yline(0,'k--')
xline(0,'k--')
xline(2/3,'k--')
ylim([-1 .1])
xlim([0 1])
FORMATFIG(f,m1pos,0,0,0)


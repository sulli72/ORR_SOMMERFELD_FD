function [D1,D2] = FDCOMP6(h,jl)
% Computes second order first and second differentiation operators
hi=1/h;
hi2=hi^2;

% Declare arrays
D1 = zeros(jl,jl);
A  = zeros(jl,jl);
B  = zeros(jl,jl);
D2 = zeros(jl,jl);


% COMPACT SCHEME
% Af' = Bf
% f' = inv(A)*B*f

% ============================
% FIRST DERIVATIVE OPERATOR
% Compact C6 interior
% C4-AC5 boundaries
% ============================

% Scheme coeffs for first deriv
% C6 interior
alpha=1/3; a=14/9; b=1/9; 

% C4 i=1, i=jl
alpha1=3;
a1=-17/6; b1=3/2; c1=3/2;
d1=-1/6; e1=0;

% AC5 i=2,i=jl-1
alpha21=3/14; alpha22=3/14;
a2=-19/28; b2=-5/42; c2=6/7;
d2=-1/14; e2=1/84;

% i=1 point - C4 scheme
jj=1;
A(jj,jj) = 1;
A(jj,jj+1) = alpha1;

B(jj,jj)  =a1;
B(jj,jj+1)=b1;
B(jj,jj+2)=c1;
B(jj,jj+3)=d1;
B(jj,jj+4)=e1;


% i=2 point -  AC5 scheme
jj=2;
A(jj,jj-1)=alpha21;
A(jj,jj)=1;
A(jj,jj+1)=alpha22;

B(jj,jj-1)=a2;
B(jj,jj)  =b2;
B(jj,jj+1)=c2;
B(jj,jj+2)=d2;
B(jj,jj+3)=e2;


% Build tri-diag vectors
for jj=3:jl-2
  A(jj,jj-1)=alpha;
  A(jj,jj)=1;
  A(jj,jj+1)=alpha;
  
  B(jj,jj-2) = -b/4;
  B(jj,jj-1) = -a/2;
  B(jj,jj)   = 0;
  B(jj,jj+1) = a/2;
  B(jj,jj+2) = b/4;
end


% i=jl-1 point -  AC5 scheme
jj=jl-1;
A(jj,jj-1)=alpha22;
A(jj,jj)=1;
A(jj,jj+1)=alpha21;

B(jj,jj+1)=-a2;
B(jj,jj)  =-b2;
B(jj,jj-1)=-c2;
B(jj,jj-2)=-d2;
B(jj,jj-3)=-e2;

% i=jl point - C4 scheme
jj=jl;
A(jj,jj) = 1;
A(jj,jj-1) = alpha1;

B(jj,jj)  =-a1;
B(jj,jj-1)=-b1;
B(jj,jj-2)=-c1;
B(jj,jj-3)=-d1;
B(jj,jj-4)=-e1;


B = hi*B; % <-- normalize by grid spacing

D1 = A\B; % <-- compute derivative operator

% ============================
% SECOND DERIVATIVE OPERATOR
% Compact C6 interior
% Explicit 4th-order boundaries
% ============================

A(:,:) = 0;
B(:,:) = 0;


% % Interior scheme
% alpha=1/10; % <-- 4th order
alpha=2/11; % <-- 6th order

a=4*(1-alpha)/3; b=(-1 + 10*alpha)/3; 

%% ---- Explicit 4th-order boundary closures ----

% j = 1
A(1,1) = 1;
B(1,1) =  35/12;
B(1,2) = -26/3;
B(1,3) =  19/2;
B(1,4) = -14/3;
B(1,5) =  11/12;

% j = 2
A(2,2) = 1;
B(2,1) =  11/12;
B(2,2) = -5/3;
B(2,3) =  1/2;
B(2,4) =  1/3;
B(2,5) = -1/12;

% j = jl-1
A(jl-1,jl-1) = 1;
B(jl-1,jl)   =  11/12;
B(jl-1,jl-1) = -5/3;
B(jl-1,jl-2) =  1/2;
B(jl-1,jl-3) =  1/3;
B(jl-1,jl-4) = -1/12;

% j = jl
A(jl,jl) = 1;
B(jl,jl)   =  35/12;
B(jl,jl-1) = -26/3;
B(jl,jl-2) =  19/2;
B(jl,jl-3) = -14/3;
B(jl,jl-4) =  11/12;

%% ---- Compact interior stencil ----
for jj=3:jl-2
  A(jj,jj-1)=alpha;
  A(jj,jj)=1;
  A(jj,jj+1)=alpha;

  B(jj,jj-2) = b/4;
  B(jj,jj-1) = a;
  B(jj,jj)   = -2*a - 2*b/4;
  B(jj,jj+1) = a;
  B(jj,jj+2) = b/4;
end

%% ---- Normalize and build operator ----
B  = hi2 * B;
D2 = A \ B;

end
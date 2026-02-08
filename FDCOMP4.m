function [D1,D2] = FDCOMP4(h,jl)
% Computes second order first and second differentiation operators
hi=1/h;
hi2=1/h^2;

% Declare arrays
D1 = zeros(jl,jl);
A  = zeros(jl,jl);
B  = zeros(jl,jl);
D2 = zeros(jl,jl);


% COMPACT SCHEME
% Af' = Bf
% f' = inv(A)*B*f

% Scheme coeffs for first deriv
% C4 interior
alpha=1/3; a=14/9; b=1/9; 
alpha=1/4; a=3/2;  b=0; 

% C4 i=1, i=jl
alpha1=3;
a1=-17/6; b1=3/2; c1=3/2;
d1=-1/6; e1=0;

% i=1 point - C4 scheme
jj=1;
A(jj,jj) = 1;
A(jj,jj+1) = alpha1;

B(jj,jj)  =a1;
B(jj,jj+1)=b1;
B(jj,jj+2)=c1;
B(jj,jj+3)=d1;
B(jj,jj+4)=e1;


% Build A,B differentiation matrices
for jj=2:jl-1
  A(jj,jj-1)=alpha;
  A(jj,jj)=1;
  A(jj,jj+1)=alpha;
  
  B(jj,jj-1) = -a/2;
  B(jj,jj)   = 0;
  B(jj,jj+1) = a/2;
end
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

%% SECOND DERIVATIVE

% % Zero matrices
A(:,:)=0;
B(:,:)=0;

% Scheme coeffs for second derivative

% % Interior scheme
% alpha=1/10; % <-- 4th order
% alpha=2/11; % <-- 6th order
% 
% a=4*(1-alpha)/3; b=(-1 + 10*alpha)/3; 
% 
% % C3 i=1,2 i=jl-1,jl
% alpha1=alpha;
% a1=13; b1=-27; c1=15; d1=-1;
% a1=(11*alpha+35)/12;
% b1=-(5*alpha+26)/3;
% c1=(alpha+19)/2;
% d1=(alpha-14)/3;
% e1=(11-alpha)/12;
% 
% % i=1,2 point - C3 scheme
% 
% for jj=1:2
%   A(jj,jj) = 1;
%   A(jj,jj+1) = alpha1;
% 
%   B(jj,jj)  =a1;
%   B(jj,jj+1)=b1;
%   B(jj,jj+2)=c1;
%   B(jj,jj+3)=d1;
%   B(jj,jj+4)=e1;
% end
% 
% % Build tri-diag vectors
% for jj=3:jl-2
%   A(jj,jj-1)=alpha;
%   A(jj,jj)=1;
%   A(jj,jj+1)=alpha;
% 
%   B(jj,jj-2) = b/4;
%   B(jj,jj-1) = a;
%   B(jj,jj)   = -2*a - 2*b/4;
%   B(jj,jj+1) = a;
%   B(jj,jj+2) = b/4;
% end
% 
% for jj=jl-1:jl
%   A(jj,jj) = 1;
%   A(jj,jj-1) = alpha1;
% 
%   B(jj,jj)  =-a1;
%   B(jj,jj-1)=-b1;
%   B(jj,jj-2)=-c1;
%   B(jj,jj-3)=-d1;
%   B(jj,jj-4)=-e1;
% end
% 
% 
% 
% B = hi2*B; % <-- normalize by grid spacing
% 
% D2 = A\B; % <-- compute derivative operator

% ============================
% SECOND DERIVATIVE OPERATOR
% Compact C4 interior
% Explicit 4th-order boundaries
% ============================

A(:,:) = 0;
B(:,:) = 0;

alpha = 1/10;
rhs   = 6/5;

% % Interior scheme
alpha=1/10; % <-- 4th order
% alpha=2/11; % <-- 6th order

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

% for jj = 3:jl-2
%     A(jj,jj-1) = alpha;
%     A(jj,jj)   = 1;
%     A(jj,jj+1) = alpha;
% 
%     B(jj,jj-1) =  rhs;
%     B(jj,jj)   = -2*rhs;
%     B(jj,jj+1) =  rhs;
% end

% % Build tri-diag vectors
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


db1=1;

end
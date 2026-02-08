function [D1,D2] = FD2(h,jl)
% Computes second order first and second differentiation operators
hsq=h*h;

% Declare arrays
D1 = zeros(jl,jl);
D2 = zeros(jl,jl);

% FIRST DERIVATIVE
jj=1;
D1(jj,jj)=-3/(2*h);
D1(jj,jj+1)=2/h;
D1(jj,jj+2)=-1/(2*h);

for jj=2:jl-1
  D1(jj,jj-1) = -.5/h;
  D1(jj,jj) = 0;
  D1(jj,jj+1) = .5/h;
end

jj=jl;
D1(jj,jj-2)=1/(2*h);
D1(jj,jj-1)=-2/h;
D1(jj,jj)=3/(2*h);

% SECOND DERIVATIVE
jj=1;
D2(jj,jj)=2/(hsq);
D2(jj,jj+1)=-5/hsq;
D2(jj,jj+2)=4/(hsq);
D2(jj,jj+3)=-1/(hsq);

for jj=2:jl-1
  D2(jj,jj-1) = 1/hsq;
  D2(jj,jj) = -2/hsq;
  D2(jj,jj+1) = 1/hsq;
end

jj=jl;
D2(jj,jj-3)=-1/hsq;
D2(jj,jj-2)=4/hsq;
D2(jj,jj-1)=-5/hsq;
D2(jj,jj)=2/hsq;
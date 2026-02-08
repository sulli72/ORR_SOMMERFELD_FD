function [D1,D2] = FD4(h,jl)
% Fourth-order finite-difference differentiation matrices
% Uniform grid, general-purpose (BC handling done elsewhere)

D1  = zeros(jl,jl);
D2  = zeros(jl,jl);
hsq = h*h;

%% ---------- First derivative ----------

% Left boundary (one-sided, 4th order)
D1(1,1:5) = [-25 48 -36 16 -3] / (12*h);
D1(2,1:5) = [-3 -10 18 -6 1] / (12*h);   % also 4th order

% Interior (central)
for j = 3:jl-2
    D1(j,j-2) =  1/(12*h);
    D1(j,j-1) = -8/(12*h);
    D1(j,j+1) =  8/(12*h);
    D1(j,j+2) = -1/(12*h);
end

% Right boundary (mirror of left)
D1(jl-1,jl-4:jl) = [-1 6 -18 10 3] / (12*h);
D1(jl,  jl-4:jl) = [ 3 -16 36 -48 25] / (12*h);

%% ---------- Second derivative ----------

% Left boundary (one-sided, 4th order)
D2(1,1:6) = [45 -154 214 -156 61 -10] / (12*hsq);
D2(2,1:6) = [10 -15 -4 14 -6 1]     / (12*hsq);

% Interior (central)
for j = 3:jl-2
    D2(j,j-2) = -1/(12*hsq);
    D2(j,j-1) = 16/(12*hsq);
    D2(j,j)   = -30/(12*hsq);
    D2(j,j+1) = 16/(12*hsq);
    D2(j,j+2) = -1/(12*hsq);
end

% Right boundary (mirror)
D2(jl-1,jl-5:jl) = [1 -6 14 -4 -15 10]   / (12*hsq);
D2(jl,  jl-5:jl) = [-10 61 -156 214 -154 45] / (12*hsq);

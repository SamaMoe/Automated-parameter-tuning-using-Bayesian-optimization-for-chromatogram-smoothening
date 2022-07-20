% L-Curve 
% y, z
% Computation of error term and smoothness term given lambda value (smooth
% series z)
function [E,D] = Lcurve(z,y,d)
E = sum((y'-z).^2);
D = sum(diff(z,d).^2);
end
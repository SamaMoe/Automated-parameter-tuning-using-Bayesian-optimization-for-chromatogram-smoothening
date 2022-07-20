function [distance] = VcurveEvaluation(y,x)
% function to find lambda for which L-curve distance between two points
% (lambda + and - delta lambda) is smallest
% degree is defined as 2
z1= TVRM2fun(y,x.lambda-x.lambda/5,2);
[E1,D1] = Lcurve(z1,y);
z2= TVRM2fun(y,x.lambda + x.lambda/5,2);
[E2,D2] = Lcurve(z2,y);
% Compute V curve 
distance = (log10(D1)-log10(D2)).^2 + (log10(E1)-log10(E2)).^2;
end
function [distance] = VcurveEvaluation2(y,x)
% finding the 2 lambdas for which L-curve distance is smallest 
% Compute L-Curve
z1= TVRM2fun(y,x.lambda1,2);
[E1,D1] = Lcurve(z1,y);
z2= TVRM2fun(y,x.lambda2,2);
[E2,D2] = Lcurve(z2,y);
% Compute V curve 
distance = (log10(D1)-log10(D2)).^2 + (log10(E1)-log10(E2)).^2;
end
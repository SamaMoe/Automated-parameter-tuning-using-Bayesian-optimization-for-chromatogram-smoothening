% evaluation function for V-Curve with degree as hyperparameter
% find lambda for which euclidean distance between L-curve value for lambda + and - delta lambda is smallest 
function [distance] = VcurveEvaluation3(y,x)
z1= TVRM2fun(y,x.lambda-x.lambda/2,x.d);
[E1,D1] = Lcurve(z1,y,x.d);
z2= TVRM2fun(y,x.lambda + x.lambda/2,x.d);
[E2,D2] = Lcurve(z2,y,x.d);
% Compute V curve 
distance = (log10(D1)-log10(D2)).^2 + (log10(E1)-log10(E2)).^2;
end
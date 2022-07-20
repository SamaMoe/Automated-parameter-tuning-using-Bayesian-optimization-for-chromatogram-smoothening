function [err] = erPLSrmse(y,lambda,ratio,n)
% automated erPLS baseline correction function derived from paper "An Automatic Baseline Correction Method Based on
% the Penalized Least Squares Method"

N = length(y);
om = round(N/50);
W = round(N/25);
H = max(y);

p = polyfit(linspace(1,om,om),y(end-om+1:end),1); 
ye=polyval(p,linspace(1,om+W,om+W));
yext = ye(end-W+1:end);

yg = (H-yext(end))*gauss(linspace(1,W,W),W/2,W/10);

ynew = yext+yg;
yadd = [y ynew];

[z,w] = baseline_arPLS(yadd',lambda,ratio,n);
err=rmse(yext,z(end-W+1:end));
end
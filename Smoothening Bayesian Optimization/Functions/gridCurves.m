function [z_grid_curves] = gridCurves(y,lambdas,degrees)
% function to smooth signal using whittaker smoother and L- and V-curves in
% combination with grid search as hyperparameter smoothing
% Compute L-Curve
distMat = zeros(length(degrees), length(lambdas)-1);
Es = zeros([1 length(lambdas)]);
Ds = zeros([1 length(lambdas)]);
for j = 1:length(degrees)
    for i = 1:length(lambdas)
        z= TVRM2fun(y,lambdas(i),j);
        [E,D] = Lcurve(z,y,j);
        Es(i) = E;
        Ds(i) = D;
    end

% 3D matrix Es, Ds, lambdas
    d3Mat = [Es ; Ds ; lambdas]';
    d3MatB = sortrows(d3Mat,2);

% Compute V curve 
    distance = zeros([1 length(lambdas)-1]);
    lam = zeros([1 length(lambdas)-1]);
    for i = 1:length(lambdas)-1
        distance(i) = (log10(d3MatB(i+1,2))-log10(d3MatB(i,2))).^2 + (log10(d3MatB(i+1,1))-log10(d3MatB(i,1))).^2;
        lam(i) = (d3MatB(i+1,3) + d3MatB(i,3))/2;
    end 
    distMat(j,:) = distance;
end

[M1,I] = min(distMat');
[M2,CI] = min(M1);
z_grid_curves = TVRM2fun(y,lam(I(CI)),degrees(CI));

end
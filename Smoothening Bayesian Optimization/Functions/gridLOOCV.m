function [z_grid_LOOCV] = gridLOOCV(y,lambdas,degrees)
% function to smooth signal using Whittaker smoother and LOO-CV combined
% with Grid search as hyperparameter tuning approach
error = zeros([length(lambdas) length(degrees)]);
for k = 1:length(lambdas)
    for j = 1:length(degrees)
        error(k,j) = minfun(y,lambdas(k),degrees(j));
    end 
end
[M1,I] = min(error);
[M2,CI] = min(M1);
z_grid_LOOCV = TVRM2fun(y,lambdas(I(CI)),degrees(CI));
end
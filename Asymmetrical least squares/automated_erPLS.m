function [z] = automated_erPLS(y)
[nrow,ncol] = size(y);
if nrow > ncol 
    y = y';
end
lambdas = logspace(2,12,10);
ratio = power(10,-6);
n = 50;
err = zeros([1 length(lambdas)]);
for i = 1:length(lambdas)
    lambda = lambdas(i);
    err(i) = erPLSrmse(y,lambda,ratio,n);
end
[m,ind] = min(err);
[z,w] = baseline_arPLS(y',lambdas(ind),ratio,n);
z = y'-z;
end
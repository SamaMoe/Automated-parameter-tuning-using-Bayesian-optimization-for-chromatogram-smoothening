function [z,w] = baseline_arPLS(y,lambda,ratio,n)
% Estimate baseline with arPLS following paper "Baseline correction using asymmetrically
% reweighted penalized least squares smoothing"

% Whittaker smoother 
N = length(y);
% Difference degree 2
D = diff(speye(N),2);
H = lambda*(D'*D);
%vector of weights
w = ones(N,1);
i = 0;
while true
    i = i + 1;
    W = spdiags(w,0,N,N);
    % Cholesky decomposition
    C = chol(W+H);
    z = C \ (C'\(w.*y));
    d = y - z;
    % make d-, and get w^t with m and s
    dn = d(d<0);
    m = mean(dn);
    s = std(dn);
    wt = 1./(1+exp(2*(d-(2*s-m))/s));
    % check exit condition and backup
    if norm(w-wt)/norm(w) < ratio || i >= n, break;end
    w = wt;
end
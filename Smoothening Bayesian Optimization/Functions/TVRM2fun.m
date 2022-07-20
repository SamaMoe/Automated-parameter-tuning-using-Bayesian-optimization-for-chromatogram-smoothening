function z = TVRM2fun(y, lambda,d)
%TVRM2fun : computes PLS/TVR of noisy signal using second method (with
%use of sparsity
m = length(y);
E = speye(m);
D = diff(E,d);
C = chol(E + lambda * (D' * D));
z = C\(C'\y');
end
function H = hatMatrix(y,lambda,d)
% function to compute hat matrix (see paper "A perfect smoother" from
% Eilers)
m = length(y);
E = speye(m);
D = diff(E,d);
H = (E + lambda * (D' * D))\E;
end
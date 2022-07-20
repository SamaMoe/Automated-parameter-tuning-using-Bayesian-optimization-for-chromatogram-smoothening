function [g] = gauss(x,mu,sig)
g = exp(-(((x-mu).^2)/(2*sig.^2)));
end
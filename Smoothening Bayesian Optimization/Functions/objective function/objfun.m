function objective = objfun(x,y)
if length(y) > 15000
    i = int16(length(y)/15000);
    b = mod(length(y),15000);
    y = y(1,double(i):double(i):end-b);
end
m = length(y);
E = speye(m);
D = diff(E,x.d);
s = (E + x.lambda * (D' * D));
H = s\E;
z = H*y';
difference = y' - z/1-diag(H);
hhat = sum(diag(H))/length(diag(H));
objective = sqrt(sum(power(difference/1-hhat,2))/length(diag(H)));
end

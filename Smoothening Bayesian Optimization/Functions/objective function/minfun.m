function err = minfun(y,lambda,d)
if length(y) > 15000
    i = int16(length(y)/15000);
    b = mod(length(y),15000);
    y = y(1,double(i):double(i):end-b);
end
m = length(y);
E = speye(m);
D = diff(E,d);
s = (E + lambda * (D' * D));
H = s\E;
z = H*y';
difference = y' - z/1-diag(H);
hhat = sum(diag(H))/length(diag(H));
err = sqrt(sum(power(difference/1-hhat,2))/length(diag(H)));
end

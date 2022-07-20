function sCV = standardErrorCV(H,y,z)
difference = y' - z/1-diag(H);
hhat = sum(diag(H))/length(diag(H));
sCV = sqrt(sum(power(difference/1-hhat,2))/length(diag(H)));
end
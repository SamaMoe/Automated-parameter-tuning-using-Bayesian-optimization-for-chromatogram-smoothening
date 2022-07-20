function mse = meanSquaredError(Xtrain,Xtest)
l = length(Xtrain);
Se = power(Xtrain-Xtest,2);
sumSe = sum(Se);
mse = sumSe/l;
end
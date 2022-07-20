function [sd] = staDev(y)
m = mean(y);
sum = 0;
for i = 1:length(y)
    sum = sum + (m - y(i))^2;
end
sd = sqrt(sum/length(y));
end
function [base] = baseline(signal)
%computing basline value of a given signal
l = zeros([1 length(signal)-2]);
for i = 2:length(signal)-1
    m = (abs(signal(i)-signal(i-1))+abs(signal(i)-signal(i+1)))/2;
    l(i-1) = m;
end
base = median(l);
end
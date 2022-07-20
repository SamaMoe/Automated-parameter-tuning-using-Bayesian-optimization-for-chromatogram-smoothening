function [apex_loc] = findMin(deriv2,y,thresh,thresh2)
% function to find peak apex based on minima in second derivative
max_deriv2 = max(abs(deriv2));
deriv2 = deriv2/max_deriv2;
max_y_noise = max(y([1:25 length(y)-25:length(y)]));
max_y = max(y);
ind = 0;
for i = 4:length(deriv2)-3
    if deriv2(i-1) > deriv2(i) && deriv2(i-2) > deriv2(i) && deriv2(i-3) > deriv2(i) && deriv2(i+1) > deriv2(i) && deriv2(i+2) > deriv2(i) && deriv2(i+3) > deriv2(i) && y(i)> max(thresh*max_y_noise,max_y/thresh2) 
        ind = ind + 1;
        apex_loc(ind) = i;
    end
end
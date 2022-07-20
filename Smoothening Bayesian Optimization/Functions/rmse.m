function [err] = rmse(y,z)
    sum = 0;
    for i = 1:length(y)
        diff = (y(i) - z(i))^2;
        sum = sum + diff;
        err = sqrt(sum);
    end
end
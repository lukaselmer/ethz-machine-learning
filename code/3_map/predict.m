function [ y ] = predict( X, classesWithCountries, p, P )
%PREDICT Summary of this function goes here
%   Detailed explanation goes here

y = zeros(size(X,1), 2);
for l=1:size(X,1)
    next = X(l,:);
   
    p_L6 = P;%[P_c1; P_c2];
    for k = 1:size(next,2)
        if next(k) == 1
            p_L6 = p_L6.* p(:,k, 1);
        else
            p_L6 = p_L6.* p(:,k, 2);%(1-p(:1,k));
        end
    end
    
    [maxVal, maxIdx] = max(p_L6);
    
    y(l,:) = classesWithCountries(maxIdx, :);
end


end


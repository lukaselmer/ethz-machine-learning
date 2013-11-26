function [ y ] = predict( SVMstruct, x )
%PREDICT Summary of this function goes here
%   Detailed explanation goes here
    y = svmclassify(SVMstruct, x);
    
    %y(x(:,1) < 0.5) = 1;
end


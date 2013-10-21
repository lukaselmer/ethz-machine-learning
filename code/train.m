function [ w ] = train(x, y, l)

    % linear regression
    w = inv(x'*x)*x'*y;
    
    % ridge regression
    % w = inv(x'*x+l*eye())*x'*y;
end


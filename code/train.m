function [ w ] = train(x, y, hyper_parameter)

    % linear regression
    % w = inv(x'*x)*x'*y;
    
    % ridge regression
    w = inv(x'*x+hyper_parameter*eye(size(x,2)))*x'*y;
end


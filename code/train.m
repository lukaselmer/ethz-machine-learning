function [ w ] = train(X, y, hyper_parameter)

    % linear regression
    % w = inv(x'*x)*x'*y;
    
    % ridge regression
    w = inv(X'*X + hyper_parameter*eye(size(X,2)))* X'*y;
end


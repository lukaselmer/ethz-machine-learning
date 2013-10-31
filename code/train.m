function [ w ] = train(X, y, hyper_parameter)

    %w = inv(X'*X)*X'*y;
    %w = inv(X'*X)* X'*y;

    % linear regression
    % w = inv(x'*x)*x'*y;
    
    % ridge regression
    w = (X'*X + hyper_parameter*eye(size(X,2)))\(X'*y);
end


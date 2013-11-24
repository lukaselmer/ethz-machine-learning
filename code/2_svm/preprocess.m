function [ Xpre ] = preprocess( X )
    %Xpre(:, 1:3:27) = log(5.*log(X(:, 1:3:27)+2.00001) + 1.1);
    Xpre = X;
    Xpre(:, 1:3:end) = log(log(X(:, 1:3:end)+2.00001) + 0.22);
    Xpre(:, 2:3:end) = log(log(X(:, 2:3:end)+2.00001) + 0.22);
    Xpre(:, 3:3:end) = log(log(X(:, 3:3:end)+1000.0));
    %Xpre = [ones(size(X,1),10000.0) Xpre];
end

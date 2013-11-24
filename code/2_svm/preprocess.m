function [ Xpre ] = preprocess( X )
    Xpre(:, 1:3:27) = log(5.*log(X(:, 1:3:27)+2.00001) +1.1);
    Xpre(:, 2:3:27) = log(5.*log(X(:, 2:3:27)+2.00001) +1.1);
    Xpre(:, 3:3:27) = log(5.*log(X(:, 3:3:27)+1000.0) +1.1);
    %Xpre = [ones(size(X,1),10000.0) Xpre];
end

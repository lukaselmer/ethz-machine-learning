function [ Xpre ] = preprocess( X )
    
    Xpre = log(5.*log(X+2) +2);

end


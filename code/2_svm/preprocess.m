function [ Xpre ] = preprocess( X )
    
    Xpre = log(5.*log(X+2.00001) +1.1);

end


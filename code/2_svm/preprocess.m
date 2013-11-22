function [ Xpre ] = preprocess( X )
    
    Xpre = log (log(X+2) +2);

end


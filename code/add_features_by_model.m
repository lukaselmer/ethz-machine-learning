function [ X_n ] = add_features_by_model( X, model, inputColumns, featureFunctions, multiFeatures  )
   [m,n] = size(model);
   X_n = zeros(size(X,1),1);
   for j=1:m %m=14
    for k=1:n
        
        if(k==1 && model(j,k) == 1)% log regression
            X_n = [X_n log(X(:, j))];
        end
        if(k==2 && model(j,k) == 1)% square
            X_n = [X_n X(:, j).^2];
        end
        if(k==3 && model(j,k) == 1)% cube
            X_n = [X_n X(:, j).^3];
        end
        if(k==4 && model(j,k) == 1)% linear
            X_n = [X_n X(:, j)];
        end
        if(k==5 && model(j,k) == 1) % loglog
            X_n = [X_n log(log(X(:, j)))];
        end
        if(k==6 && model(j,k) == 1) % e^
            X_n = [X_n exp(X(:, j))];
        end
        if(k==7 && model(j,k) == 1) % square & cube
            X_n = [X_n X(:, j).^2];
            X_n = [X_n X(:, j).^3];
        end
        if(k==8 && model(j,k) == 1) % just 1
            X_n = [X_n X(:, j)];
            X_n = [X_n X(:, j).^2];
            X_n = [X_n X(:, j).^3];
        end
        if(k==9 && model(j,k) == 1) % 1/x
            X_n = [X_n 1./X(:, j)];
        end
        if(k==10 && model(j,k) == 1) % sqrt
            X_n = [X_n X(:, j).^(1/2)];
        end
        if(k==11 && model(j,k) == 1) % 3rdroot
            X_n = [X_n X(:, j).^(1/3)];
        end
        
        begin = featureFunctions;
        next = begin + inputColumns;
        if(k>begin && k <=next && model(j,k) == 1)
            X_n = [X_n X(:, j).*X(:, k-begin)];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n X(:, j)./X(:, k-begin)];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n X(:, j).*X(:, k-begin).^2];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n X(:, j).*X(:, k-begin).^3];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n X(:, j).*X(:, k-begin).^1/2];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n (X(:, j).^2).*X(:, k-begin).^1/2];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n (X(:, j).^3).*X(:, k-begin).^1/2];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n (log(X(:, j))).*X(:, k-begin)];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n (log(X(:, j))).*log(X(:, k-begin))];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n ((X(:, j)) + log(X(:, k-begin))).^2];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n ((X(:, j)) + log(X(:, k-begin))).^(1/2)];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n log((X(:, j)) + log(X(:, k-begin)))];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n ((X(:, j)) - log(X(:, k-begin))).^2];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n ((X(:, j)) - log(X(:, k-begin))).^(1/2)];
        end
        
        begin = next;
        next = begin + inputColumns;
        if(k>begin && k <= next && model(j,k) == 1)
            X_n = [X_n log((X(:, j)) - log(X(:, k-begin)))];
        end
        
       % if(k>32 && model(j,k) == 1)% log regression
       %     X = [X X(:, j).*X(:, k-32).^3];
       % end
        %if(model(i) == 4) % quad regression
        %    x = [x x(:, i).^2];
        %    x = [x x(:, i).^3];
        %    x = [x x(:, i).^4];
        %end
    end
   end
    
end


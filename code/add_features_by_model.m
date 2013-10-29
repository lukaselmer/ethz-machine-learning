function [ X ] = add_features_by_model( X, model )
   [m,n] = size(model);
   for j=1:m %m=14
    for k=1:n
        
        if(k==1 && model(j,k) == 1)% log regression
            X = [X log(X(:, j))];
        end
        if(k==2 && model(j,k) == 1)% square regression
            X = [X X(:, j).^2];
        end
        if(k==3 && model(j,k) == 1)% cube regression
            X = [X X(:, j).^2];
            X = [X X(:, j).^3];
        end
        if(k==4 && model(j,k) == 1)% sqrt regression
            X = [X sqrt(X(:, j))];
        end
        if(k>=5 && model(j,k) == 1)% log regression
            X = [X X(:, j).*X(:, k-4)];
        end
        
        %if(model(i) == 4) % quad regression
        %    x = [x x(:, i).^2];
        %    x = [x x(:, i).^3];
        %    x = [x x(:, i).^4];
        %end
    end
   end
    
end


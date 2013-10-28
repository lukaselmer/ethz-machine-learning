function [ x ] = add_features_by_model( x, model )
for i=1:14
    %0 = linear regression
    if(model(i) == 1) % log regression
        x(:, i) = log(x(:, i));
    end
    if(model(i) == 2) % square regression
        x = [x x(:, i).^2];
    end
    if(model(i) == 3) % cube regression
        x = [x x(:, i).^2];
        x = [x x(:, i).^3];
    end
    if(model(i) == 4) % cube regression
         x(:, i) = sqrt(x(:, i));
    end
    if(model(i) == 4) % quad regression
        x = [x x(:, i).^2];
        x = [x x(:, i).^3];
        x = [x x(:, i).^4];
    end
end
 %   x(:, 8) = log2(x(:, 8));
 %   x(:, 9) = log2(x(:, 9));
 %   x(:, 11) = log2(x(:, 11));
 %   x(:, 12) = log2(x(:, 12));
 %   x(:, 13) = log2(x(:, 13));
    
end


function [ error ] = calc_error( x, y, w )
    mean_square_error = sum((y - predict(x, w)).^2) / size(x);
    root_mean_square_error = sum(abs(y - predict(x, w))) / size(x);
    
    error = mean_square_error;
end

function [ real ] = predict(x,w)
    real = x * w;
end

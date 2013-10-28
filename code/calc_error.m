function [ error ] = calc_error( x, y, w, lambda )
    sqaure_loss_error = (y - (w'*x')').^2;
    sum_square_loss_error = sum(sqaure_loss_error);
    %sum_square_loss_error = sum_square_loss_error + lambda * norm(w)^2;
    root_loss_error = sqrt(sum_square_loss_error);
    
    error = root_loss_error / size(y,1);

    % mean_square_error = sum((y - predict(x, w)).^2) / size(x);
    % root_mean_square_error = sum(abs(y - predict(x, w))) / size(x);
    
    % error = mean_square_error;
end

function [ real ] = predict(x,w)
    real = x * w;
end

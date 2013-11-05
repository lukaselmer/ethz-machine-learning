function [ x ] = add_features( x )

    x(:, 8) = log2(x(:, 8));
    x(:, 9) = log2(x(:, 9));
    x(:, 11) = log2(x(:, 11));
    x(:, 12) = log2(x(:, 12));
    x(:, 13) = log2(x(:, 13));
    
end


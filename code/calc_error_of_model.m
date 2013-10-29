function [ cv_rsme ] = calc_error_of_model( model, X_in, y )
%CALC_ERROR_WITH_MODEL Summary of this function goes here
%   Detailed explanation goes here

X = add_features_by_model(X_in, model);
y_std = 1;
y_mean = 0;
%[min_error, min_idx] = min(errors);
%best_parameter = parameters(min_idx);
%min_idx
%min_error
best_parameter = 1;

% train with best parameter with all training data
w = train(X, y, best_parameter);

%calculate error
y_cmp = y;% M(:,15); % y values to calcuate the prediction error
y_pred = (w' * X')';
y_pred = (y_pred.*y_std) + y_mean';

y_avg = mean(y_cmp);
cv_rsme = sqrt(sum((y_pred - y_cmp).^2) / size(y_cmp, 1)) / y_avg;

end


function [ cv_rsme ] = calc_error_of_model( model, X_in, y_in, hyper_parameter, inputColumns,featureFunctions, multiFeatures )
%CALC_ERROR_WITH_MODEL Summary of this function goes here
%   Detailed explanation goes here

X = add_features_by_model(X_in, model, inputColumns, featureFunctions, multiFeatures);

%[X, ~, ~] = normalize(X);
%[y, y_mean, y_std] = normalize(y_in);

% add column with ones (for offset)
%X = [ones(size(X,1),1),X];
            
y=y_in;
%y_std = 1;
%y_mean = 0;
%[min_error, min_idx] = min(errors);
%best_parameter = parameters(min_idx);
%min_idx
%min_error

% train with best parameter with all training data
w = train(X, y, hyper_parameter);

%calculate error
y_cmp = y_in;% M(:,15); % y values to calcuate the prediction error
y_pred = (w' * X')';
%y_pred = (y_pred.*y_std) + y_mean';
y_pred(y_pred < 0) = -1;
y_pred(y_pred >= 0) = 1;

%y_avg = mean(y_cmp);
%cv_rsme = sqrt(sum((y_pred - y_cmp).^2) / size(y_cmp, 1)) / y_avg;

% false negative: y_cmp(i) = 1, y_pred(i) = -1
%  => (y_cmp(i) - y_pred(i)) ./2 = 1
% false positive: y_cmp(i) = -1, y_pred(i) = 1
%  => (y_cmp(i) - y_pred(i)) ./2 = -1
%  here: false positive *= C, C=5
c_false_negative = 1;
c_false_positive = 5;
cv_rsme = (y_cmp - y_pred)./2;
cv_rsme(cv_rsme < 0) = -c_false_positive;
cv_rsme(cv_rsme >= 0) = c_false_negative;
cv_rsme = abs(cv_rsme);
cv_rsme = sum(cv_rsme);
%./ size(y_pred)

%cv_rsme = sum(abs(y_pred - y_cmp)./2);

end


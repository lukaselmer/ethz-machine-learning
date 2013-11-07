function [ cv_rsme ] = calc_cost2( y_pred, y_cmp )
%CALC_COST2 Summary of this function goes here
%   Detailed explanation goes here

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



% read data
validation_data = csvread('../../data/2/validation.csv');

% split data in features / labels
x_validation = validation_data(:,1:end);

% predict
%y_validation = (w'*x_validation')';
y_validation = manual_predict(x_validation);

csvwrite ('../../data/2/validation.out', y_validation);

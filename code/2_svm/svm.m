%% data preparation
% read data
training_data = csvread('../../data/2/training.csv');
[m, ~] = size(training_data);

% split data in train / test data
% M_train = training_data(1:1200,:);
% M_test  = training_data(1201:1447,:);
train_data       = training_data;
train_test_data  = training_data;

% split data in features / labels
x_train = train_data(:,1:27);
y_train = train_data(:,28);

x_train_test = train_test_data(:,1:27);
y_train_test = train_test_data(:,28);

%% cross validation
%% random cross validation
min_error = 0.112610;
best_sigma = 0.539343;
best_c = 1.032748;
for i = 1:0  
    sigma = rand()*0.1+0.5;
    c = rand()*0.2+1;
    error = cross_validation (x_train, y_train, sigma, c);
    if (error < min_error) 
       min_error = error;
       best_sigma = sigma;
       best_c = c;
       fprintf('error: %1.6f sigma: %1.6f c: %1.6f\n', error, sigma, c);
    end
end

%% grid search cross validation
% c_parameters = (0.01:0.01:2)';
% sigma_parameters = (0.5:0.01:0.6)';
%c_parameters = (1:1:11)';
%c_parameters = 2.^c_parameters;
%sigma_parameters = (-3.5:1:1.5)';
%sigma_parameters = 2.^sigma_parameters;

% errors = zeros(size(sigma_parameters,1), size(c_parameters,1));
% 
% for sigma_idx = 1:size(sigma_parameters)
%     for c_idx = 1:size(c_parameters)
%         error = cross_validation (x_train, y_train, sigma_parameters(sigma_idx), c_parameters(c_idx));
%         errors(sigma_idx, c_idx) = error;
%         fprintf('error: %1.6f sigma: %1.6f c: %1.6f\n', error, c_parameters(c_idx), sigma_parameters(sigma_idx));
%     end
% end
% 
% [min_error,min_ind] = min(errors(:));
% [min_sigma_idx,min_c_idx] = ind2sub([size(errors,1) size(errors,2)],min_ind);
% best_sigma = sigma_parameters(min_sigma_idx)
% best_c = c_parameters(min_c_idx)
%best_sigma = 2^-1;
%best_c = 2^13;


%% training
% train with best parameter with all training data
SVMstruct = svmtrain(x_train, y_train, 'Kernel_Function', 'rbf', 'rbf_sigma', best_sigma, 'boxconstraint', best_c);

%% prediction
% predict label of unused training_data
predicted__train_data_label = svmclassify(SVMstruct,x_train_test);
train_data_error = calc_error (predicted__train_data_label, y_train_test);
% calc_grade (train_data_error)

% predict label of validation data
x_validation = csvread('../../data/2/validation.csv');
predicted_validation_label = svmclassify(SVMstruct, x_validation);
csvwrite ('../../data/2/validation_svm.out', predicted_validation_label);

% predict label of test data
x_test = csvread('../../data/2/testing.csv');
predicted_test_label = svmclassify(SVMstruct,x_test);
csvwrite ('../../data/2/testing_svm.out', predicted_test_label);


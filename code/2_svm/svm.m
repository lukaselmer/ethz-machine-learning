%% data preparation
clear all
clc

% read data
training_data = csvread('../../data/2/training.csv');
[m, ~] = size(training_data);

% split data in features / labels
x_train = preprocess(training_data(:,1:(end-1)));
y_train = training_data(:,end);

% visualize data
visualize (x_train, y_train);

%% train
% cross validation
best_sigma = 0.556201641;
best_c = 1.316157273;
% [best_sigma, best_c] = train_random(x_train, y_train);
% [best_sigma, best_c] = train_grid(x_train, y_train);


%% estimate error
% estimate error with training over subset and testing over subset
% predict label of unused training_data
estimated_error = estimate_error (training_data, best_sigma, best_c)


%% training / prediction
% train with best parameter with all training data
SVMstruct = svmtrain(x_train, y_train, 'Kernel_Function', 'rbf', 'rbf_sigma', best_sigma, 'boxconstraint', best_c);

csvwrite ('../../data/2/best_sigma_svm.out', best_sigma);
csvwrite ('../../data/2/best_c_svm.out', best_c);

% prediction
% predict label of validation data
x_validation = preprocess(csvread('../../data/2/validation.csv'));
predicted_validation_label = svmclassify(SVMstruct, x_validation);
csvwrite ('../../data/2/validation_svm.out', predicted_validation_label);

% predict label of test data
x_test = preprocess(csvread('../../data/2/testing.csv'));
predicted_test_label = svmclassify(SVMstruct,x_test);
csvwrite ('../../data/2/testing_svm.out', predicted_test_label);


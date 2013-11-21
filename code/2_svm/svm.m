%% data preparation

clear all
clc

% read data
training_data = csvread('../../data/2/training.csv');
[m, ~] = size(training_data);

% split data in features / labels
x_train = preprocess(training_data(:,1:(end-1)));
y_train = training_data(:,end);

% cross validation
% random cross validation
out_error = 0.12;
% min_error = 0.110651;
min_error = 0.115;
best_sigma = 0.556201641;
best_c = 1.316157273;


sigma = best_sigma;
c = best_c;
%min_error = cross_validation (x_train, y_train, sigma, c);


%% Train

for i = 1:50
    if(rand() < 0.2)
        sigma = best_sigma;
    end
    if(rand() < 0.2)
        c = best_c;
    end
    if(rand() < 0.2)
        sigma = best_sigma;
        c = best_c;
    end
    
    r = rand();
    
    if(rand() < 0.5)
        sigma = sigma + ((r - 0.5) * 1);
    else
        c = abs(c + ((r - 0.5) * 20));
    end
    
    
    %sigma = rand() * 0.4 + 0.5;
    %c     = 2^(rand() * 16 - 7);
    
    try 
        error = cross_validation (x_train, y_train, sigma, c);
        if (error < min_error) 
           min_error = error;
           best_sigma = sigma;
           best_c = c;
           fprintf('--- error: %1.6f sigma: %1.9f c: %1.9f, r: %1.9f ---\n', error, sigma, c, r);
        end
        if (error < out_error)
           fprintf('error: %1.6f sigma: %1.9f c: %1.9f\n', error, sigma, c);
        end
    catch
        fprintf('warning: error: %1.6f sigma: %1.9f c: %1.9f\n', error, sigma, c);
    end
    
end

%% grid search cross validation / gen output
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


% estimate error with training over subset and testing over subset
% predict label of unused training_data
estimate_train_data = training_data(1:1200,:);
estimate_test_data  = training_data(1201:1447,:);
estimate_train_x = estimate_train_data(:,1:27);
estimate_train_y = estimate_train_data(:,end);
estimate_test_x  = estimate_test_data(:,1:27);
estimate_test_y  = estimate_test_data(:,end);
SVMstruct = svmtrain(estimate_train_x, estimate_train_y, 'Kernel_Function', 'rbf', 'rbf_sigma', best_sigma, 'boxconstraint', best_c);
predicted__train_data_label = svmclassify(SVMstruct, estimate_test_x);
train_data_error = calc_error (predicted__train_data_label, estimate_test_y)
calc_grade (train_data_error);


% training / prediction
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


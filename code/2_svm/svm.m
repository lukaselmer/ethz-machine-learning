%% data preparation
% read data
training_data = csvread('../../data/2/training.csv');
[m, ~] = size(training_data);

% split data in features / labels
x_train = training_data(:,1:27);
y_train = training_data(:,28);

%% cross validation
%% random cross validation
out_error = 0.12;
% min_error = 0.110651;
min_error = 1;
best_sigma = 0.539343;
sigma = best_sigma;
best_c = 1.162347;
c = best_c;


% error: 0.110000 sigma: 0.741561491 c: 9.820265117
% valid: 0.15272978576364893 error: 0.112610 sigma: 0.539343    c: 1.162347
% error: 0.116188 sigma: 0.809714762 c: 5.609376671
% error: 0.116830 sigma: 0.713188289 c: 21.681477620
% error: 0.117462 sigma: 0.837775254 c: 94.774819336
% error: 0.117510 sigma: 0.534608    c: 1.833623
% error: 0.117548 sigma: 0.660176016 c: 200.472571424
% valid: 0.15134761575673808 error: 0.118166 sigma: 0.556201641 c: 1.316157273
% error: 0.118190 sigma: 0.548186    c: 1.070160
% error: 0.118760 sigma: 0.792902199 c: 256.804165103
% error: 0.118942 sigma: 0.665753253 c: 57.866211899
% error: 0.119550 sigma: 0.528402    c: 1.594627
% error: 0.119559 sigma: 0.672394589 c: 5.477502294
% 
% error: 0.119521 sigma: 0.591590830 c: 1.224117540
% error: 0.119555 sigma: 0.560523922 c: 1.390024599
% error: 0.118855 sigma: 0.561340400 c: 1.386480247
% error: 0.116724 sigma: 0.542125355 c: 1.124139940
% error: 0.116839 sigma: 0.524691191 c: 1.180194827
% error: 0.118812 sigma: 0.554472701 c: 1.260923921
% error: 0.116786 sigma: 0.533973557 c: 1.328833169
% error: 0.116078 sigma: 0.546222230 c: 1.236622461
% valid: 0.14858327574291638 error: 0.110651 sigma: 0.562775896 c: 1.058211034

%% Train

for i = 1:20 
    if(rand() < 0.5)
        sigma = sigma + ((rand() - 0.5) * 2);
    else
        c     = abs(c + ((rand() - 0.5) * 6));
    end
    
    if(rand() < 0.15)
        sigma = best_sigma;
    end
    if(rand() < 0.15)
        c = best_c;
    end
    if(rand() < 0.05)
        sigma = best_sigma;
        c = best_c;
    end
    
    
    %sigma = rand() * 0.4 + 0.5;
    %c     = 2^(rand() * 16 - 7);
    
    try 
        error = cross_validation (x_train, y_train, sigma, c);
        error
        if (error < min_error) 
           min_error = error;
           best_sigma = sigma;
           best_c = c;
           fprintf('--- error: %1.6f sigma: %1.9f c: %1.9f ---\n', error, sigma, c);
        end
        if (error < out_error)
           fprintf('error: %1.6f sigma: %1.9f c: %1.9f\n', error, sigma, c);
        end
    catch
        fprintf('warning: error: %1.6f sigma: %1.9f c: %1.9f\n', error, sigma, c);
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


%% estimate error with training over subset and testing over subset
% predict label of unused training_data
estimate_train_data = training_data(1:1200,:);
estimate_test_data  = training_data(1201:1447,:);
estimate_train_x = estimate_train_data(:,1:27);
estimate_train_y = estimate_train_data(:,28);
estimate_test_x  = estimate_test_data(:,1:27);
estimate_test_y  = estimate_test_data(:,28);
SVMstruct = svmtrain(estimate_train_x, estimate_train_y, 'Kernel_Function', 'rbf', 'rbf_sigma', best_sigma, 'boxconstraint', best_c);
predicted__train_data_label = svmclassify(SVMstruct, estimate_test_x);
train_data_error = calc_error (predicted__train_data_label, estimate_test_y)
calc_grade (train_data_error);


%% training
% train with best parameter with all training data
SVMstruct = svmtrain(x_train, y_train, 'Kernel_Function', 'rbf', 'rbf_sigma', best_sigma, 'boxconstraint', best_c);

%% prediction
% predict label of validation data
x_validation = csvread('../../data/2/validation.csv');
predicted_validation_label = svmclassify(SVMstruct, x_validation);
csvwrite ('../../data/2/validation_svm.out', predicted_validation_label);

% predict label of test data
x_test = csvread('../../data/2/testing.csv');
predicted_test_label = svmclassify(SVMstruct,x_test);
csvwrite ('../../data/2/testing_svm.out', predicted_test_label);


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
out_error = 0.12;
min_error = 0.110000;
best_sigma = 0.556201641;
best_c = 1.316157273;

% error: 0.110000 sigma: 0.741561491 c: 9.820265117
% error: 0.112610 sigma: 0.539343    c: 1.162347
% error: 0.116188 sigma: 0.809714762 c: 5.609376671
% error: 0.116830 sigma: 0.713188289 c: 21.681477620
% error: 0.117462 sigma: 0.837775254 c: 94.774819336
% error: 0.117510 sigma: 0.534608    c: 1.833623
% error: 0.117548 sigma: 0.660176016 c: 200.472571424
% error: 0.118166 sigma: 0.556201641 c: 1.316157273
% error: 0.118190 sigma: 0.548186    c: 1.070160
% error: 0.118760 sigma: 0.792902199 c: 256.804165103
% error: 0.118942 sigma: 0.665753253 c: 57.866211899
% error: 0.119550 sigma: 0.528402    c: 1.594627
% error: 0.119559 sigma: 0.672394589 c: 5.477502294

for i = 1:0  
    
    sigma = rand() * 0.1 + 0.5;
    c     = rand() * 0.4   + 1;
    
    %sigma = rand() * 0.4 + 0.5;
    %c     = 2^(rand() * 16 - 7);
    
    try 
        error = cross_validation (x_train, y_train, sigma, c);
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


%% training
% train with best parameter with all training data
SVMstruct = svmtrain(x_train, y_train, 'Kernel_Function', 'rbf', 'rbf_sigma', best_sigma, 'boxconstraint', best_c);

%% prediction
% predict label of unused training_data
predicted__train_data_label = svmclassify(SVMstruct,x_train_test);
train_data_error = calc_error (predicted__train_data_label, y_train_test)
calc_grade (train_data_error);

% predict label of validation data
x_validation = csvread('../../data/2/validation.csv');
predicted_validation_label = svmclassify(SVMstruct, x_validation);
csvwrite ('../../data/2/validation_svm.out', predicted_validation_label);

% predict label of test data
x_test = csvread('../../data/2/testing.csv');
predicted_test_label = svmclassify(SVMstruct,x_test);
csvwrite ('../../data/2/testing_svm.out', predicted_test_label);


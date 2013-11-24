function [ train_data_error ] = estimate_error( training_data, sigma, c )
    
    % prepare data
    estimate_train_data = training_data(1:1200,:);
    estimate_test_data  = training_data(1201:end,:);
    estimate_train_x = preprocess(estimate_train_data(:,1:end-1));
    estimate_train_y = estimate_train_data(:,end);
    estimate_test_x  = preprocess(estimate_test_data(:,1:end-1));
    estimate_test_y  = estimate_test_data(:,end);
    
    % train
    SVMstruct = svmtrain(estimate_train_x, estimate_train_y, 'Kernel_Function', 'rbf', 'rbf_sigma', sigma, 'boxconstraint', c);
    
    % predict
    predicted__train_data_label = predict(SVMstruct, estimate_test_x);
    
    % calc error
    train_data_error = calc_error (predicted__train_data_label, estimate_test_y);
    % calc_grade (train_data_error);
end


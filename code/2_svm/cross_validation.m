function [ error ] = cross_validation(x, y, sigma, c)
    
    m = size(x,1);

    K = 10;
    indices = crossvalind('Kfold', m, K);

    errors = zeros(K,1);
    for i = 1:K
        % get indices
        test_idx = (indices == i);
        train_idx = ~test_idx;

        % get training data
        x_train = x(train_idx,:);
        y_train = y(train_idx,:);

        % train
        SVMstruct = svmtrain(x_train, y_train, 'Kernel_Function', 'rbf', 'rbf_sigma', sigma, 'boxconstraint', c);

        % get test data
        x_test = x(test_idx,:);
        y_test = y(test_idx,:);
        
        % calculate error
        predicted_label = svmclassify (SVMstruct, x_test);
        errors(i) = calc_error(predicted_label, y_test); %calc_error 
    end
    
    error = mean(errors);
end


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
        SVMstruct = svmtrain2(x_train, y_train, sigma, c);

        % get test data
        x_test = x(test_idx,:);
        y_test = y(test_idx,:);
        
        % calculate error
        predicted_label = predict (SVMstruct, x_test);
        errors(i) = calc_error(predicted_label, y_test); %calc_error 
    end
    
    error = mean(errors);
    fprintf('max=%f, median=%f, mean=%f, min=%f\n', max(errors), median(errors), mean(errors), min(errors));
end


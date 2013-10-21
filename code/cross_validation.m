function [ w ] = cross_validation(x,y)
    
    [num_data, num_features] = size(x);

    K = 5;
    indices = crossvalind('Kfold', num_data, K);

    for i = 1:K
        % get indices
        test_idx = (indices == i);
        train_idx = ~test_idx;

        % get training data
        x_train = x(train_idx,:);
        y_train = y(train_idx,:);

        % train
        hyper_parameter = 1;
        w = train(x_train, y_train, hyper_parameter);

        % get test data
        x_test = x(test_idx,:);
        y_test = y(test_idx,:);

        % test

        
        % calculate error
        error = calc_error(x_test, y_test, w);
    end


end


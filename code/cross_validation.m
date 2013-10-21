function [ output_args ] = cross_validation(x,y)
    
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
        w = train(x_train, y_train);

        % get test data
        x_test = x(test_idx,:);
        y_test = y(test_idx,:);

        % test

        
        % calculate error
        error = calc_error();
    end


end


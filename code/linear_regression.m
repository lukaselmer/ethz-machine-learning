% read data
M = csvread('handout/training.csv');

% split data in features / labels
y = M(:,15);
x = M(:,1:14);

[num_data, num_features] = size(x);


% cross validation
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
    
    
    
    
    % get test data
    x_test = x(test_idx,:);
    y_test = y(test_idx,:);
    
    % test
    
end
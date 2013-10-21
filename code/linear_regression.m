% read data
M = csvread('../data/training.csv');

% split data in features / labels
y = M(:,15);
x = M(:,1:14);
[num_data, num_features] = size(x);

% add features
x = add_features(x);

% normalize data
[x,y] = normalize(x,y);

% add 1 column (for offset)


% cross validation
w = cross_validation(x,y);

% predict data


% generate output

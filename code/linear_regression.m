% read data
M = csvread('../data/training.csv');

% split data in features / labels
X = M(:,1:14);
y = M(:,15);

% add features
X = add_features(X);

% normalize data
X = normalize(X);
y = normalize(y);

% add column with ones (for offset)
X = [ones(size(X,1),1),X];

% cross validation
parameters = (0:0.01:1)';
errors = zeros(size(parameters,1), 1);

for i = 1:size(parameters)
    errors(i) = cross_validation(X,y,parameters(i));
end

[min_error, min_idx] = min(errors);
best_parameter = parameters(min_idx);
min_idx
min_error
best_parameter
% train with best parameter with all training data
w = train(X, y, best_parameter);


% generate output
generate_output (w);
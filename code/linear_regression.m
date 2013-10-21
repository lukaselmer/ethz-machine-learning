% read data
M = csvread('../data/training.csv');

% split data in features / labels
x = M(:,1:14);
y = M(:,15);

% add features
x = add_features(x);

% normalize data
x = normalize(x);
y = normalize(y);

% add column with ones (for offset)
x = [ones(size(x,1),1),x];

% cross validation
parameters = (0:0.01:1)';
errors = zeros(size(parameters,1), 1);

for i = 1:size(parameters)
    errors(i) = cross_validation(x,y,parameters(i));
end

[~, min_idx] = min(errors);
best_parameter = parameters(min_idx);

% train with best parameter with all training data
w = train(x,y,best_parameter);


% generate output
generate_output (w);
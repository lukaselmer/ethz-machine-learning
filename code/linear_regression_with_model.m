% read data
M = csvread('../data/training.csv');

% split data in features / labels
X_in = M(:,1:14);
y = M(:,15);
abs_min_error = 1000000;
best_model = 0;

for i=1:20
model = zeros(14,1);
%model(1) = 1;
% model(3) = randi(5,1)-1;
for j=1:14
    model(j) = randi(6,1)-1;
end
    
% add features
X = add_features_by_model(X_in, model);

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
%min_idx

if min_error < abs_min_error
    best_model = model;
    abs_min_error = min_error;
end

%best_parameter
end
best_model'
abs_min_error
return;
% train with best parameter with all training data
w = train(X, y, best_parameter);


% generate output
generate_output (w);
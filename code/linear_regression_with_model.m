% read data
M = csvread('../data/training.csv');

% split data in features / labels
X_in = M(:,1:14);
y = M(:,15);

hyper_parameter = 0.5;
max_features = 2;
binModel = zeros(14,32);%18+14=32
binModel

model_error = calc_error_of_model(binModel, X_in, y, hyper_parameter);
model_error

while 1
    binModel = find_next_feature(binModel, X_in, y, hyper_parameter);
    %binModel
    model_error = calc_error_of_model(binModel, X_in, y, hyper_parameter);
    model_error
    features = sum(sum(binModel));
    
    if(features >= max_features)
        break;
    end
end
%return;
% train with best parameter with all training data

X = add_features_by_model(X_in, binModel);

[X, ~, ~] = normalize(X);
[y, y_mean, y_std] = normalize(y);

% add column with ones (for offset)
X = [ones(size(X,1),1),X];

w = train(X, y, hyper_parameter);


% generate output
generate_output (w, y_mean, y_std, binModel);
% read data
M = csvread('../data/training.csv');
M = man_normalize(M);

% Disable warnings
warning('off', 'MATLAB:nearlySingularMatrix')
warning('off', 'MATLAB:singularMatrix')

% split data in features / labels
X_in = M(:,1:14);
y = M(:,15);

hyper_parameter = 0.5;
max_features = 10;
binModel = zeros(14,32);%18+14=32
%binModel

%model_error = calc_error_of_model(binModel, X_in, y, hyper_parameter);
%model_error

max = 0
bestBinModel = zeros(14,32);
bestBinModelError = 1000000;

while max < 100
    max = max + 1
    
    binModel = find_next_feature(binModel, X_in, y, hyper_parameter);
    %binModel
    model_error = calc_error_of_model(binModel, X_in, y, hyper_parameter);
    model_error
    
    
    if bestBinModelError > model_error
        bestBinModel = binModel;
        bestBinModelError = model_error;
    end
    
    %if model_error < 0.19
    %    break;
    %end
    
    features = sum(sum(binModel));
    if(features >= max_features)
        r = rand(1);
        if(r < 0.35) % 0.35
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        elseif(r < 0.65) % 0.3
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        elseif(r < 0.85) % 0.2
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        elseif(r < 0.95) % 0.1
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        else % 0.05
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        end
    elseif(rand(1) < 0.2)
        binModel = remove_random_feature(binModel);
    elseif(rand(1) < 0.1)
        binModel = remove_random_feature(binModel);
        binModel = remove_random_feature(binModel);
    end
end

binModel = bestBinModel;

%binModel
%model_error
%return;
% train with best parameter with all training data
%binModel

model_error = calc_error_of_model_single(binModel, X_in, y, hyper_parameter);
model_error

X = add_features_by_model(X_in, binModel);

%[X, ~, ~] = normalize(X);
[y, y_mean, y_std] = normalize(y);

% add column with ones (for offset)
X = [ones(size(X,1),1),X];

w = train(X, y, hyper_parameter);


% generate output
generate_output (w, y_mean, y_std, binModel);
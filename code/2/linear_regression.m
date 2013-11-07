clear all
clc

% read data
M = csvread('../../data/2/training.csv');
M = man_normalize(M);

% Disable warnings
warning('off', 'MATLAB:nearlySingularMatrix')
warning('off', 'MATLAB:singularMatrix')
warning('off', 'all')

% Define these things for the dynamic features
inputColumns = 27;
featureFunctions = 9;
multiFeatures = 4; % Warning: setting this higher will lead to a slower execution!

% split data in features / labels
X_in = M(:,1:inputColumns);
%y = M(:,15);
y = M(:,28);

hyper_parameter = 0.25;
max_features = 15;
binModel = zeros(inputColumns,featureFunctions + (multiFeatures * inputColumns));%18+14=32, 1
%binModel

%model_error = calc_error_of_model(binModel, X_in, y, hyper_parameter);
%model_error

bestBinModel = zeros(inputColumns,featureFunctions + (multiFeatures * inputColumns));
bestBinModelError = 100000000000000000000;
foundDuring = 0;

max = 0;
while max < 100
    max = max + 1
    
    [binModel, ridgeError] = find_next_feature(binModel, X_in, y, hyper_parameter, inputColumns,featureFunctions, multiFeatures);
    %binModel
    squaredError = calc_error_of_model(binModel, X_in, y, hyper_parameter, inputColumns,featureFunctions, multiFeatures);
    ridgeError = abs(ridgeError)
    squaredError
    
    if bestBinModelError > ridgeError
        bestBinModel = binModel;
        bestBinModelError = ridgeError;
        foundDuring = max;
    end
    
    if rand(1) < 0.1
        binModel = bestBinModel;
    end
    
    %if model_error < 0.19
    %    break;
    %end
    
    features = sum(sum(binModel));
    if(features >= max_features)
        r = rand(1);
        if(r < 0.475) % 0.475
            binModel = remove_random_feature(binModel);
        elseif(r < 0.775) % 0.3
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        elseif(r < 0.875) % 0.2
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        elseif(r < 0.975) % 0.1
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        else % 0.025
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
            binModel = remove_random_feature(binModel);
        end
    elseif(rand(1) < 0.05)
        binModel = remove_random_feature(binModel);
    elseif(rand(1) < 0.02)
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

squaredError = calc_error_of_model_single(binModel, X_in, y, hyper_parameter, inputColumns,featureFunctions, multiFeatures);
squaredError
foundDuring

X = add_features_by_model(X_in, binModel, inputColumns,featureFunctions, multiFeatures);

%[X, ~, ~] = normalize(X);
[y, y_mean, y_std] = normalize(y);

% add column with ones (for offset)
X = [ones(size(X,1),1),X];

w = train(X, y, hyper_parameter);


% generate output
generate_output (w, y_mean, y_std, binModel, squaredError, inputColumns,featureFunctions, multiFeatures);

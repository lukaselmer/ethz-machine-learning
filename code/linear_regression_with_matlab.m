
%% Read data

% Clean Up
clear all
clc

% Import my data
Training = dataset('xlsfile', '../data/training.xlsx');
Testing = dataset('xlsfile', '../data/testing.xlsx');
Validation = dataset('xlsfile', '../data/validation.xlsx');

Training_Y = Training.Delay;
Training_X = double(Training(:,1:end-1));


%%  Create a Delay Prediction Model

t = RegressionTree.template('Surrogate','off');

% rens = fitensemble(Training_X, Training_Y, 'LSBoost', 1000, t, ...

strategy = 'bag';

if strcmp(strategy, 'bag')
    rens_raw = fitensemble(Training_X, Training_Y, 'Bag', 100, 'Tree', ... %, t
        'PredictorNames', Training.Properties.VarNames(1:end-1), ...
        'ResponseName', Training.Properties.VarNames{end}, ... % 'holdout', 0.1, ...
        'Type', 'regression')
elseif strcmp(strategy, 'bagkfold')
    rens_raw = fitensemble(Training_X, Training_Y, 'Bag', 100, 'Tree', ... %, t
        'PredictorNames', Training.Properties.VarNames(1:end-1), ...
        'ResponseName', Training.Properties.VarNames{end}, ... % 'holdout', 0.1, ...
        'kfold', 10, ...
        'Type', 'regression')
else
    rens_raw = fitensemble(Training_X, Training_Y, 'LSBoost', 10000, 'Tree', ... %, t
        'PredictorNames', Training.Properties.VarNames(1:end-1), ...
        'LearnRate', 0.1, ...
        'ResponseName', Training.Properties.VarNames{end}, ...   %'kfold', 10, ...
        'Type', 'regression')
end

%% Error
rens = rens_raw;


%    'kfold', '10', ...
%'crossval', 'on', ...
%'CategoricalPredictors', [3],...
%cvrens = crossval(rens);


%rens = regularize(rens_raw,'lambda',[5 20], ...
%    'npass', 60, ...
%    'lambda', [0.001 logspace(log10(0.1/1000),log10(0.1),9)], 'reltol', 0.00000001); %,'lambda',[0.001 0.1]


if strcmp(strategy, 'bagkfold')
    Training_Prediction = rens_raw.kfoldPredict()
else
    Training_Prediction = predict(rens,Training_X);
end

%Training_Prediction = predict(rens,Training_X);
%Training_Prediction = predict(rens,Training_X);

%cvrens.kfoldPredict(Training_X)

y_avg = mean(Training_Y);
cv_rsme = sqrt(sum((Training_Prediction - Training_Y).^2) / size(Training_Y, 1)) / y_avg;
cv_rsme

%% Export

Validation_X = double(Validation(:,1:end));
Testing_X = double(Testing(:,1:end));

Validation_Prediction = predict(rens_raw,Validation_X);
Testing_Prediction = predict(rens_raw,Testing_X);

csvwrite ('../data/testing.experimental.out', Validation_Prediction);
csvwrite ('../data/validation.experimental.out', Validation_Prediction);


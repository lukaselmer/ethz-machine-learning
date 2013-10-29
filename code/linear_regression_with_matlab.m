
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

rens = fitensemble(Training_X, Training_Y, 'Bag', 100, 'Tree', ... %, t
    'PredictorNames', Training.Properties.VarNames(1:end-1), ...
    'ResponseName', Training.Properties.VarNames{end}, ...   %'kfold', 10, ...
    'Type', 'regression')

%% 
%    'kfold', '10', ...
%'crossval', 'on', ...
%'CategoricalPredictors', [3],...

Training_X = double(Training(:,1:end-1));
Training_Prediction = predict(rens,Training_X);
y_avg = mean(Training_Y);
cv_rsme = sqrt(sum((Training_Prediction - Training_Y).^2) / size(Training_Y, 1)) / y_avg;
cv_rsme

%% Export

Validation_X = double(Validation(:,1:end));
Testing_X = double(Testing(:,1:end));

Validation_Prediction = predict(rens,Validation_X);
Testing_Prediction = predict(rens,Testing_X);

csvwrite ('../data/testing.experimental.out', Validation_Prediction);
csvwrite ('../data/validation.experimental.out', Validation_Prediction);


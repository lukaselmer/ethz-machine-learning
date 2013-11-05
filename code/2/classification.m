clear all
clc

% read data
M = csvread('../../data/2/training.csv');
M = man_normalize(M);

% Disable warnings
warning('off', 'MATLAB:nearlySingularMatrix')
warning('off', 'MATLAB:singularMatrix')
warning('off', 'all')


% split data in features / labels
X_training = M(:,1:end-1);
Y_training = M(:,end);
N = size(X_training, 1);


nbKD = NaiveBayes.fit(X_training, Y_training, 'dist', 'mvmn');
%nbKDClass= nbKD.predict(X_training);
%bad = ~strcmp(nbKDClass,Y_training);
%nbKDResubErr = sum(bad)


% TODO: learn...



%% Output

validation_data = csvread('../../data/2/validation.csv');
testing_data = csvread('../../data/2/testing.csv');

% split data in features / labels
x_validation = validation_data(:,1:end);
x_testing = testing_data(:,1:end);


y_validation = nbKD.predict(x_validation); % TODO: execute
y_testing = nbKD.predict(x_testing); % TODO: execute


csvwrite ('../../data/2/validation.out', y_validation);
csvwrite ('../../data/2/testing.out', y_testing);





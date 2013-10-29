
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

Validation_X = double(Validation(:,1:end));
Testing_X = double(Testing(:,1:end));

%% Neural network to the rescue! :)

%net = newfit(Training_X', Training_Y', 20);
%net.performFcn = 'mae';
%net = newrb(Training_X', Training_Y', 10000, 1, 100, 1000);
%net = newrb(Training_X', Training_Y', 10000, 1, 100, 1000);
%net = newsom(Training_X', Training_Y', 20);

%net = newfit(Training_X', Training_Y', 20);
net = feedforwardnet([12 12], 'trainbr');
net.trainParam.max_fail = 2000;
net.trainParam.epochs = 50000;
%net.trainParam.min_grad = 100;


%net.trainParam.v = 1000;
%net = train(net, Training_X', Training_Y');
%net = trainbr(net, Training_X', Training_Y');
%net = trainlm(net, Training_X', Training_Y');
%net = traingdx(net, Training_X', Training_Y');
net = train(net, Training_X', Training_Y');



% Evaluate error

Training_Prediction = sim(net, Training_X')';

y_avg = mean(Training_Y);
cv_rsme = sqrt(sum((Training_Prediction - Training_Y).^2) / size(Training_Y, 1)) / y_avg;
cv_rsme

%% Write results to file

Validation_Prediction = sim(net, Validation_X')';
Testing_Prediction = sim(net, Testing_X')';

csvwrite ('../data/testing.experimental2.out', Validation_Prediction);
csvwrite ('../data/validation.experimental2.out', Validation_Prediction);

X = dlmread('preprocessing/X_training.txt');
yWithCountries = dlmread('preprocessing/y_training.txt');
classesWithCountries = dlmread('preprocessing/classes.txt');

y = yWithCountries(:,1);
classes = classesWithCountries(:,1);

%X
%y
numClasses = size(classes, 1);
c = numClasses;
p = zeros(numClasses,size(X,2));

a = ones(c,1) * 1.01; % [2;2;2]; //one is the best factor
%a(3)= rand(1,1)*2;%4;
%a= rand(c,1)*2;
%a_good= [1.28863626038738;0.757218765320537;1.62316091656495;1.06565117759891;0.701454207153767;1.87800312399977;1.75188562298597;1.10031268579684;1.24495017200246;1.17408940906283;];
%a = a_good;
p_tot = sum(a) + size(y, 1) - c;

P = zeros(numClasses, 1);
for k = 1:numClasses
    P(k) = (sum(y == classes(k)) + a(k) - 1) / p_tot;
end

for k = 1:size(p,1)
    for l = 1:size(p,2)
        X_t = X(y == classes(k), l);
        
        p_jk = (sum(X_t == 1) + a(k) - 1) / (sum(y == classes(k)) + sum(a) - c);
        p(k, l) = p_jk;
        
       % p_jk = (sum(X_t == 0) + a(k) - 1) / (sum(y == classes(k)) + sum(a) - c);
       % p(k, l, 2) = 1-p(k, l, 1) ;%p_jk;
    end 
end

overrideTraining = dlmread('preprocessing/override_training.txt');
predicted_training_label = predict(X, classesWithCountries, p, P, overrideTraining);

error = calc_error(X, yWithCountries, classesWithCountries, p, P, y, classes, predicted_training_label);
disp(sprintf('error = %4.2f', error));
disp(sprintf('TRAIN - error-ratio: %d, elements: %d', error/size(X,1), size(X,1)));


% prediction
% predict label of validation data
X_validation = dlmread('preprocessing/X_validation.txt');
overrideValidation = dlmread('preprocessing/override_validation.txt');
predicted_validation_label = predict(X_validation, classesWithCountries, p, P, overrideValidation);
dlmwrite ('../../data/3/validation_map.out', predicted_validation_label, 'precision','%3.0f');

% predict label of test data
X_testing = dlmread('preprocessing/X_testing.txt');
overrideTesting = dlmread('preprocessing/override_testing.txt');
predicted_test_label = predict(X_testing, classesWithCountries, p, P, overrideTesting);
dlmwrite ('../../data/3/testing_map.out', predicted_test_label, 'precision','%3.0f');

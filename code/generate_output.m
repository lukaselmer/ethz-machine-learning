function generate_output( w )
    
    % read data
    validation_data = csvread('../data/validation.csv');
    testing_data = csvread('../data/testing.csv');

    % split data in features / labels
    x_validation = validation_data(:,1:14);
    x_testing = testing_data(:,1:14);

    % add features
    x_validation = add_features(x_validation);
    x_testing = add_features(x_testing);

    % normalize data
    x_validation = normalize(x_validation);
    x_testing = normalize(x_testing);
    
    % add column with ones (for offset)
    x_validation = [ones(size(x_validation,1),1),x_validation];
    x_testing = [ones(size(x_testing,1),1),x_testing];

    % predict
    y_validation = (w'*x_validation')';
    y_testing = (w'*x_testing')';

    csvwrite ('../data/validation.out', y_validation);
    csvwrite ('../data/testing.out', y_testing);
end


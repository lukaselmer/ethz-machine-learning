function generate_output( w, y_mean, y_std, model, model_error, inputColumns,featureFunctions, multiFeatures )
    
    % read data
    validation_data = csvread('../../data/2/validation.csv');
    testing_data = csvread('../../data/2/testing.csv');
    %validation_data = man_normalize(validation_data);
    %testing_data = man_normalize(testing_data);

    % split data in features / labels
    x_validation = validation_data(:,1:end);
    x_testing = testing_data(:,1:end);

    % add features
    x_validation = add_features_by_model(x_validation, model, inputColumns,featureFunctions, multiFeatures);
    x_testing = add_features_by_model(x_testing, model, inputColumns,featureFunctions, multiFeatures);

    % normalize data
    x_validation = normalize(x_validation);
    x_testing = normalize(x_testing);
    
    % add column with ones (for offset)
    x_validation = [ones(size(x_validation,1),1),x_validation];
    x_testing = [ones(size(x_testing,1),1),x_testing];

    % predict
    y_validation = (w'*x_validation')';
    y_testing = (w'*x_testing')';
    
    y_validation = (y_validation.*y_std) + y_mean';
    y_testing = (y_testing.*y_std) + y_mean';

    
    csvwrite ('../../data/2/model/error.out', model_error);
    csvwrite ('../../data/2/model/w.out', w);
    csvwrite ('../../data/2/model/features.out', model);
    csvwrite ('../../data/2/validation.out', y_validation);
    csvwrite ('../../data/2/testing.out', y_testing);
end


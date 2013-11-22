function [ best_sigma, best_c ] = train_grid( x_train, y_train )

    %% grid search cross validation / gen output
    c_parameters = (0.01:0.01:2)';
    sigma_parameters = (0.5:0.01:0.6)';
    
%     c_parameters = (1:1:11)';
%     c_parameters = 2.^c_parameters;
%     sigma_parameters = (-3.5:1:1.5)';
%     sigma_parameters = 2.^sigma_parameters;

    errors = zeros(size(sigma_parameters,1), size(c_parameters,1));
    
    for sigma_idx = 1:size(sigma_parameters)
        for c_idx = 1:size(c_parameters)
            error = cross_validation (x_train, y_train, sigma_parameters(sigma_idx), c_parameters(c_idx));
            errors(sigma_idx, c_idx) = error;
            fprintf('error: %1.6f sigma: %1.6f c: %1.6f\n', error, c_parameters(c_idx), sigma_parameters(sigma_idx));
        end
    end
    
    [min_error,min_ind] = min(errors(:));
    [min_sigma_idx,min_c_idx] = ind2sub([size(errors,1) size(errors,2)],min_ind);
    best_sigma = sigma_parameters(min_sigma_idx);
    best_c = c_parameters(min_c_idx);

end


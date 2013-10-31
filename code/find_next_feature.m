function [ best_model ] = find_next_feature( model, X_in, y, hyper_parameter )
%FIND_NEXT_FEATURE Summary of this function goes here
%   Detailed explanation goes here
    [m, n] = size(model);

    best_model = model;
    best_error = 10000000000;
    
    for j=1:m
        for k=1:n
            if model(j,k)==1
                continue;
            end
            
            new_model = model;
            new_model(j,k) = 1;
            
            % add features
            X = add_features_by_model(X_in, new_model);
            
            % normalize data
            %X = normalize(X);
            %y = normalize(y);

            % add column with ones (for offset)
            X = [ones(size(X,1),1),X];

            % cross validation
       %     parameters = (0:0.01:1)';
        %    errors = zeros(size(parameters,1), 1);

            new_model_error = cross_validation(X,y, hyper_parameter); %hyper_parameter = 1
        %    new_model_error
          %  for i = 1:size(parameters)
          %      errors(i) = cross_validation(X,y,parameters(i));
          %  end

           % [min_error, min_idx] = min(errors);
           % best_parameter = parameters(min_idx);
            %min_idx

            if new_model_error < best_error
                best_model = new_model;
                best_error = new_model_error;
            end
        end
    end
    
end


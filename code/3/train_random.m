function [ best_sigma, best_c ] = train_random ( x_train, y_train, best_sigma, best_c )
    
    % random cross validation
    out_error = 0.12;
    % min_error = 0.110651;
    min_error = 0.115;
    %best_sigma = 0.556201641;
    %best_c = 1.316157273;


    sigma = best_sigma;
    c = best_c;
    %min_error = cross_validation (x_train, y_train, sigma, c);

    for i = 1:50
        if(rand() < 0.2)
            sigma = best_sigma;
        end
        if(rand() < 0.2)
            c = best_c;
        end
        if(rand() < 0.2)
            sigma = best_sigma;
            c = best_c;
        end

        r = rand();

        if(rand() < 0.5)
            sigma = sigma + ((r - 0.5) * 1);
        else
            c = abs(c + ((r - 0.5) * 20));
        end


        %sigma = rand() * 0.4 + 0.5;
        %c     = 2^(rand() * 16 - 7);

        try 
            error = cross_validation (x_train, y_train, sigma, c);
            if (error < min_error) 
               min_error = error;
               best_sigma = sigma;
               best_c = c;
               fprintf('--- error: %1.6f sigma: %1.9f c: %1.9f, r: %1.9f ---\n', error, sigma, c, r);
            end
            if (error < out_error)
               fprintf('error: %1.6f sigma: %1.9f c: %1.9f\n', error, sigma, c);
            end
        catch
            fprintf('warning: error: %1.6f sigma: %1.9f c: %1.9f\n', error, sigma, c);
        end

    end

end


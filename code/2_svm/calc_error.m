function [ error ] = calc_error(predicted_label, true_label)

    m = size (predicted_label,1);

    error = 0;
    for i = 1:m 
       
       % wrong label?
       if (predicted_label(i) ~= true_label(i)) 
           
            if (predicted_label(i) == -1) 
                % False negative
                error = error + 1;
            else
                % False positive
                error = error + 5;
            end
       end
    end
    error = error / m;
end


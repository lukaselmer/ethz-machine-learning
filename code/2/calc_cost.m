function [ cost ] = calc_cost( x, y_cmp, w, hyper_parameter )
    %square_loss_error = (y - (w'*x')').^2;
    %cost = sum(square_loss_error) + hyper_parameter * norm(w)^2;
    
    y_pred = (w'*x')';
    
    %cost = calc_cost2(y_pred, y_cmp);
    
    y_pred(y_pred < 0)=-1/sqrt(5);
    y_pred(y_pred >= 0)=1;
    
    
    
    %c_false_negative = 1;
    %c_false_positive = 5;
    %cv_rsme = (y_cmp - y_pred)./2;
    %cv_rsme(cv_rsme < 0) = -c_false_positive;
    %cv_rsme(cv_rsme >= 0) = c_false_negative;
    %cv_rsme = abs(cv_rsme);
    %cv_rsme = sum(cv_rsme);
    
    y_diff = (y_cmp - y_pred);
    %y_diff(y_diff < 0) = y_diff(y_diff < 0) ./ 5;
    
    cost = norm((y_diff))^2; % + norm(w.*hyper_parameter)^2;
end


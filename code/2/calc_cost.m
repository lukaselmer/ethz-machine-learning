function [ cost ] = calc_cost( x, y, w, hyper_parameter )
    %square_loss_error = (y - (w'*x')').^2;
    %cost = sum(square_loss_error) + hyper_parameter * norm(w)^2;
    
    y_calculated = (w'*x')';
    y_calculated(y_calculated < 0)=-1;
    y_calculated(y_calculated >= 0)=1;
    
    cost = norm((y - y_calculated))^2; % + norm(w.*hyper_parameter)^2;
end


function [  ] = visualize( x, y )

    idx_pos = find (y(:,1) == 1);
    idx_neg = find (y(:,1) == -1);

    positive_x = x (idx_pos,1:end-1);
    negative_x = x (idx_neg,1:end-1);

    positive_y = y (idx_pos,1:end-1);
    negative_y = y (idx_neg,1:end-1);

    hold on;
    plot (positive_x(:,2), positive_x(:,3), 'g.');
    plot (negative_x(:,2), negative_x(:,3), 'r.');

end


function [  ] = visualize( x, y )

    idx_pos = find (y(:,1) == 1);
    idx_neg = find (y(:,1) == -1);

    positive_x = x (idx_pos,:);
    negative_x = x (idx_neg,:);

    %positive_y = y (idx_pos,:);
    %negative_y = y (idx_neg,:);

    clf;
    close all;
    hold on;
    
    plot (positive_x(:,1), positive_x(:,7), 'gx');
    plot (negative_x(:,1), negative_x(:,7), 'r+');

end


function [ binModel ] = remove_random_feature( binModel )
    % Sets a random element to zero which is not zero
    binModel(randsample(find(binModel>0), 1)) = 0;
end


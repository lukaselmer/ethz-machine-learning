function [ error ] = calc_error( X, yWithCountries, classesWithCountries, p, P, y, classes, predicted_training_label )
%CALC_ERROR Summary of this function goes here
%   Detailed explanation goes here
error = 0;
errIdx = zeros(size(X,1),1);
for l=1:size(yWithCountries,1)
    
    if(predicted_training_label(l, 1) ~= yWithCountries(l, 1) )
        error = error + 1;
        errIdx(l)=1;
    end
    
	if (predicted_training_label(l, 2) ~= yWithCountries(l, 2) )
        error = error + 0.25;
    end
    
   %next = X(l,:); 
   % p_L6 = P;%[P_c1; P_c2];
   % for k = 1:size(next,2)
   %     if next(k) == 1
   %         p_L6 = p_L6.* p(:,k);
   %     else
   %         p_L6 = p_L6.* (1-p(:,k));%(1-p(:1,k));
   %     end
   % end
    
   % [maxVal, maxIdx] = max(p_L6);
   %  if(classes(maxIdx) ~= y(l) )
   % if(classesWithCountries(maxIdx, 1) ~= yWithCountries(l, 1) )
   %     corY = yWithCountries(l, 1);
   %     error = error + 1;
   %     [B,IX] = sort(p_L6, 'descend');
   %     IX=classesWithCountries(IX,1);
   %     %maxVal
   %     errIdx(l)=1;
   %end
    
   % if(classesWithCountries(maxIdx, 2) ~= yWithCountries(l, 2) )
   %     error = error + 0.25;
        %maxVal
   % end
end


dlmwrite ('errIdx.out', errIdx);
end


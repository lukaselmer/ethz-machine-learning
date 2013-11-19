function [ Grade ] = calc_grade( error )
    BH = 0.15825846579129232;
    BE = 0.4277816171389081;
    Grade = (1 - ((error-BH)/(BE-BH))) * 0.5 + 0.5;
end


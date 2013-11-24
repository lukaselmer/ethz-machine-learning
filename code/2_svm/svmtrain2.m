function [ SVMstruct ] = svmtrain2( x, y, sigma, c )
    % Manual rbf kernel
    %k_rbf = @(xx,yy) rbf_kernel(xx, yy, sigma);
    %SVMstruct = svmtrain(x, y, 'Kernel_Function', k_rbf, 'boxconstraint', c, 'method', 'SMO');
    
    % Polynominal kernel
    %SVMstruct = svmtrain(x, y, 'Kernel_Function', 'polynomial', 'boxconstraint', c, 'method', 'LS', 'options', optimset('MaxIter', 100000, 'Display', 'iter'), 'polyorder', 2);
    
    % Automatic
    SVMstruct = svmtrain(x, y, 'Kernel_Function', 'rbf', 'rbf_sigma', sigma, 'boxconstraint', c, ...
        'method', 'SMO');
end

%function kval = pca_kernel(u,v,rbf_sigma)
%    kval = (u'*v + 1);
%end

function kval = rbf_kernel(u,v,rbf_sigma)
%RBF_KERNEL Radial basis function kernel for SVM functions

% Copyright 2004-2012 The MathWorks, Inc.
% $Revision: 1.1.12.6 $  $Date: 2012/05/03 23:57:02 $
    kval = exp(-(1/(2*rbf_sigma^2))*(repmat(sqrt(sum(u.^2,2).^2),1,size(v,1))...
        -2*(u*v')+repmat(sqrt(sum(v.^2,2)'.^2),size(u,1),1)));
end


%function kval = rbf_kernel2(x,y,rbf_sigma)
%    a = 1;
%    b = 1;
%    xsup = x;
%	[n1 n2]=size(x);
%    [n n3]=size(xsup);
%    
%    for i=1:n
%        ps(:,i) = sum( abs((x.^a - ones(n1,1)*xsup(i,:).^a)).^b   ,2);
%    end;
%    kval = exp(-ps);
%end

%function kval = cauchy_kernel(u,v,sigma)
%    s = (2*sigma^2);
%    dot=((u-v)*(u-v)')/sigma;
%    kval = 1./(dot+1);
%end


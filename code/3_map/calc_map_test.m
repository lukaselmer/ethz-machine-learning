
X = [0 1 0 1 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0
     0 0 0 1 0 0 1 0 1 1 0 1 1 0 0 0 0 0 0 0 0
     0 1 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0 0
     0 0 0 1 0 0 0 0 1 1 0 0 1 1 1 1 0 0 0 0 0
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1
     1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1
     1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1
     1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
y = [1;1;1;1;2;3;3;3];

L6 =[1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
L6 =[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1];
L6 =[0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0];
L6 =[1 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1];
%X
%y
numClasses = 3;
c = numClasses;
p = zeros(numClasses,size(X,2),2);
a_1 = 2;
a_2 = 2;
a = [2;2;2];
P_c1 = (sum(y == 1) + a_1 - 1) / (size(y, 1) + a_1 + a_2 - 2);
P_c2 = (sum(y == 2) + a_1 - 1) / (size(y, 1) + a_1 + a_2 - 2);
P = zeros(numClasses, 1);

p_tot = sum(a) + size(y, 1) - c;
for i = 1:numClasses
    P(i) = (sum(y == i) + a_1 - 1) / p_tot;
end

for k = 1:size(p,1)
    for l = 1:size(p,2)
        X_t = X(y == k, l);
        p_jk = (sum(X_t == 1) + a(k) - 1) / (sum(y == k) + sum(a) - c);
        p(k, l, 1) = p_jk;
        
        p_jk = (sum(X_t == 0) + a(k) - 1) / (sum(y == k) + sum(a) - c);
        p(k, l, 2) = p_jk;
    end 
end

p
p_L6 = P;%[P_c1; P_c2];
for k = 1:size(L6,2)
    if L6(k) == 1
        p_L6 = p_L6.* p(:,k, 1);
    else
        p_L6 = p_L6.* p(:,k, 2);%(1-p(:1,k));
    end
end

p_L6
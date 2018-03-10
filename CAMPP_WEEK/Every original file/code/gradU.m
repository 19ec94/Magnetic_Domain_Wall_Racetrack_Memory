function [ sum ] = gradU( x, M, param)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

hes = eye(3);
hes(param.domaindir, param.domaindir) = -2;

sum = zeros(3,1);
for i = 1 : size(M,2)
    y =  (i-1) * param.deltax;
    if(x == y)
        sum = sum + 0.5*(laplN(x-y*1e-2) + laplN(x+y*1e-2))*  (hes*M(:,i));
        continue
    end
    sum = sum + laplN(x-y) * (hes*M(:,i));
    
end

sum = sum * param.deltax;

end

function [ res ] = laplN(x)
    res = 1/(4*pi*x^3);
end